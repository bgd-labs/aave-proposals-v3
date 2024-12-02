// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import 'forge-std/Test.sol';
import {TransparentUpgradeableProxy} from 'solidity-utils/contracts/transparent-proxy/TransparentUpgradeableProxy.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {GovV3Helpers} from 'aave-helpers/src/GovV3Helpers.sol';
import {AaveV3Arbitrum} from 'aave-address-book/AaveV3Arbitrum.sol';
import {MiscArbitrum} from 'aave-address-book/MiscArbitrum.sol';
import {GovernanceV3Arbitrum} from 'aave-address-book/GovernanceV3Arbitrum.sol';
import {AaveV3ArbitrumAssets} from 'aave-address-book/AaveV3Arbitrum.sol';
import {MiscEthereum} from 'aave-address-book/MiscEthereum.sol';
import {GovernanceV3Avalanche} from 'aave-address-book/GovernanceV3Avalanche.sol';
import {MiscAvalanche} from 'aave-address-book/MiscAvalanche.sol';
import {Pool} from 'ccip/libraries/Pool.sol';
import {IPoolPriorTo1_5} from 'ccip/interfaces/IPoolPriorTo1_5.sol';
import {TokenAdminRegistry} from 'ccip/tokenAdminRegistry/TokenAdminRegistry.sol';
import {UpgradeableBurnMintTokenPool} from 'ccip/pools/GHO/UpgradeableBurnMintTokenPool.sol';
import {RateLimiter} from 'ccip/libraries/RateLimiter.sol';
import {UpgradeableGhoToken} from 'gho-core/gho/UpgradeableGhoToken.sol';
import {AaveV3Arbitrum_GHOAvaxLaunch_20241106} from './AaveV3Arbitrum_GHOAvaxLaunch_20241106.sol';
import {AaveV3Avalanche_GHOAvaxLaunch_20241106} from './AaveV3Avalanche_GHOAvaxLaunch_20241106.sol';

/**
 * @dev Test for AaveV3Arbitrum_GHOAvaxLaunch_20241106
 * command: FOUNDRY_PROFILE=arbitrum forge test --match-path=src/20241106_Multi_GHOAvaxLaunch/AaveV3Arbitrum_GHOAvaxLaunch_20241106.t.sol -vv
 */
contract AaveV3Arbitrum_GHOAvaxLaunch_20241106_Test is ProtocolV3TestBase {
  AaveV3Arbitrum_GHOAvaxLaunch_20241106 internal proposal;

  address public constant GHO_TOKEN = AaveV3ArbitrumAssets.GHO_UNDERLYING;
  UpgradeableBurnMintTokenPool public constant TOKEN_POOL =
    UpgradeableBurnMintTokenPool(MiscArbitrum.GHO_CCIP_TOKEN_POOL);
  UpgradeableGhoToken public GHO = UpgradeableGhoToken(GHO_TOKEN);
  address public constant TOKEN_ADMIN_REGISTRY = 0x39AE1032cF4B334a1Ed41cdD0833bdD7c7E7751E;
  address public constant REGISTRY_ADMIN = 0x8a89770722c84B60cE02989Aedb22Ac4791F8C7f;
  address public constant AVAX_GHO_TOKEN = 0xb025950B02b9cfe851C6a4C041f9D6c0942f0eB1;
  address public constant AVAX_REGISTRY_ADMIN = 0xA3f32a07CCd8569f49cf350D4e61C016CA484644;
  address public constant AVAX_TOKEN_ADMIN_REGISTRY = 0xc8df5D618c6a59Cc6A311E96a39450381001464F;
  address public constant AVAX_RMN_PROXY = 0xcBD48A8eB077381c3c4Eb36b402d7283aB2b11Bc;
  address public constant AVAX_ROUTER = 0xF4c7E640EdA248ef95972845a62bdC74237805dB;
  address public constant ETH_TOKEN_POOL = MiscEthereum.GHO_CCIP_TOKEN_POOL;

  event Minted(address indexed sender, address indexed recipient, uint256 amount);
  event Burned(address indexed sender, uint256 amount);
  event Transfer(address indexed from, address indexed to, uint256 value);

  function setUp() public {
    // Execute Avax proposal to deploy Avax token pool
    vm.createSelectFork(vm.rpcUrl('avalanche'), 53559217);
    // TODO: Remove this deployment once we have deployed pool address
    _deployCcipTokenPool();

    // TODO: Remove this (will be done on chainlink's side)
    // Prank chainlink and set up admin role to be accepted on token registry
    vm.startPrank(AVAX_REGISTRY_ADMIN);
    TokenAdminRegistry(AVAX_TOKEN_ADMIN_REGISTRY).proposeAdministrator(
      AVAX_GHO_TOKEN,
      GovernanceV3Avalanche.EXECUTOR_LVL_1
    );
    vm.stopPrank();

    AaveV3Avalanche_GHOAvaxLaunch_20241106 avaxProposal = new AaveV3Avalanche_GHOAvaxLaunch_20241106();
    GovV3Helpers.executePayload(vm, address(avaxProposal));

    // Switch to Arbitrum and create proposal
    vm.createSelectFork(vm.rpcUrl('arbitrum'), 279521658);
    proposal = new AaveV3Arbitrum_GHOAvaxLaunch_20241106();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest('AaveV3Arbitrum_GHOAvaxLaunch_20241106', AaveV3Arbitrum.POOL, address(proposal));

    _validateCcipTokenPool();
  }

  /// @dev Test burn and mint actions, mocking CCIP calls
  function test_ccipTokenPool() public {
    GovV3Helpers.executePayload(vm, address(proposal));

    // Mock calls
    address router = TOKEN_POOL.getRouter();
    address ramp = makeAddr('ramp');
    vm.mockCall(
      router,
      abi.encodeWithSelector(bytes4(keccak256('getOnRamp(uint64)'))),
      abi.encode(ramp)
    );
    vm.mockCall(
      router,
      abi.encodeWithSelector(bytes4(keccak256('isOffRamp(uint64,address)'))),
      abi.encode(true)
    );

    // Prank user
    address user = makeAddr('user');

    // ARB <> ETH

    // Mint
    uint256 amount = 100e18;
    uint64 ethChainSelector = proposal.CCIP_ETH_CHAIN_SELECTOR();
    uint256 startingFacilitatorLevel = _getFacilitatorLevel(address(TOKEN_POOL));
    uint256 startingGhoBalance = GHO.balanceOf(address(TOKEN_POOL));

    vm.expectEmit(true, true, true, true, address(GHO));
    emit Transfer(address(0), user, amount);

    vm.expectEmit(false, true, true, true, address(TOKEN_POOL));
    emit Minted(address(0), user, amount);

    IPoolPriorTo1_5(address(TOKEN_POOL)).releaseOrMint(
      bytes(''),
      user,
      amount,
      ethChainSelector,
      bytes('')
    );

    assertEq(_getFacilitatorLevel(address(TOKEN_POOL)), startingFacilitatorLevel + amount);
    assertEq(GHO.balanceOf(address(TOKEN_POOL)), startingGhoBalance);
    assertEq(GHO.balanceOf(user), amount);

    // Burn
    // mock router transfer of funds from user to token pool
    vm.prank(user);
    GHO.transfer(address(TOKEN_POOL), amount);

    vm.expectEmit(true, true, true, true, address(GHO));
    emit Transfer(address(TOKEN_POOL), address(0), amount);

    vm.expectEmit(false, true, false, true, address(TOKEN_POOL));
    emit Burned(address(0), amount);

    vm.prank(ramp);
    IPoolPriorTo1_5(address(TOKEN_POOL)).lockOrBurn(
      user,
      bytes(''),
      amount,
      ethChainSelector,
      bytes('')
    );

    assertEq(_getFacilitatorLevel(address(TOKEN_POOL)), startingFacilitatorLevel);
    assertEq(GHO.balanceOf(address(TOKEN_POOL)), startingGhoBalance);

    // ARB <> AVAX
    /*
    // Mint
    uint64 arbChainSelector = proposal.CCIP_ARB_CHAIN_SELECTOR();
    assertEq(_getFacilitatorLevel(address(TOKEN_POOL)), 0);
    assertEq(GHO.balanceOf(address(TOKEN_POOL)), 0);

    releaseOrMintIn = Pool.ReleaseOrMintInV1({
      originalSender: bytes(''),
      remoteChainSelector: arbChainSelector,
      receiver: user,
      amount: amount,
      localToken: address(GHO),
      sourcePoolAddress: abi.encode(ARB_TOKEN_POOL),
      sourcePoolData: bytes(''),
      offchainTokenData: bytes('')
    });

    vm.expectEmit(true, true, true, true, address(GHO));
    emit Transfer(address(0), user, amount);

    vm.expectEmit(false, true, true, true, address(TOKEN_POOL));
    emit Minted(address(0), user, amount);

    TOKEN_POOL.releaseOrMint(releaseOrMintIn);

    assertEq(_getFacilitatorLevel(address(TOKEN_POOL)), amount);
    assertEq(GHO.balanceOf(address(TOKEN_POOL)), 0);
    assertEq(GHO.balanceOf(user), amount);

    // Burn
    // mock router transfer of funds from user to token pool
    vm.prank(user);
    GHO.transfer(address(TOKEN_POOL), amount);

    lockOrBurnIn = Pool.LockOrBurnInV1({
      receiver: bytes(''),
      remoteChainSelector: arbChainSelector,
      originalSender: user,
      amount: amount,
      localToken: address(GHO)
    });

    vm.expectEmit(true, true, true, true, address(GHO));
    emit Transfer(address(TOKEN_POOL), address(0), amount);

    vm.expectEmit(false, true, false, true, address(TOKEN_POOL));
    emit Burned(address(0), amount);

    vm.prank(ramp);
    TOKEN_POOL.lockOrBurn(lockOrBurnIn);

    assertEq(_getFacilitatorLevel(address(TOKEN_POOL)), 0);
    assertEq(GHO.balanceOf(address(TOKEN_POOL)), 0);
    */
  }

  function _deployCcipTokenPool() internal returns (address) {
    address imple = address(
      new UpgradeableBurnMintTokenPool(AVAX_GHO_TOKEN, AVAX_RMN_PROXY, false)
    );

    bytes memory tokenPoolInitParams = abi.encodeWithSignature(
      'initialize(address,address[],address)',
      GovernanceV3Avalanche.EXECUTOR_LVL_1, // owner
      new address[](0), // allowList
      AVAX_ROUTER // router
    );
    return
      address(
        new TransparentUpgradeableProxy(
          imple, // logic
          MiscAvalanche.PROXY_ADMIN, // proxy admin
          tokenPoolInitParams // data
        )
      );
  }

  function _validateCcipTokenPool() internal {
    // Configs
    uint64[] memory supportedChains = TOKEN_POOL.getSupportedChains();
    assertEq(supportedChains.length, 2);

    // ETH
    assertEq(supportedChains[0], proposal.CCIP_ETH_CHAIN_SELECTOR());

    // AVAX
    assertEq(supportedChains[1], proposal.CCIP_AVAX_CHAIN_SELECTOR());
    RateLimiter.TokenBucket memory outboundRateLimit = TOKEN_POOL
      .getCurrentOutboundRateLimiterState(proposal.CCIP_AVAX_CHAIN_SELECTOR());
    RateLimiter.TokenBucket memory inboundRateLimit = TOKEN_POOL.getCurrentInboundRateLimiterState(
      proposal.CCIP_AVAX_CHAIN_SELECTOR()
    );
    assertEq(outboundRateLimit.isEnabled, false);
    assertEq(inboundRateLimit.isEnabled, false);
  }

  function _getFacilitatorLevel(address f) internal view returns (uint256) {
    (, uint256 level) = GHO.getFacilitatorBucket(f);
    return level;
  }
}
