// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import 'forge-std/Test.sol';
import {TransparentUpgradeableProxy} from 'solidity-utils/contracts/transparent-proxy/TransparentUpgradeableProxy.sol';
import {GovV3Helpers} from 'aave-helpers/src/GovV3Helpers.sol';
import {AaveV3Avalanche} from 'aave-address-book/AaveV3Avalanche.sol';
import {GovernanceV3Avalanche} from 'aave-address-book/GovernanceV3Avalanche.sol';
import {MiscAvalanche} from 'aave-address-book/MiscAvalanche.sol';
import {MiscEthereum} from 'aave-address-book/MiscEthereum.sol';
import {Pool} from 'ccip/libraries/Pool.sol';
import {TokenAdminRegistry} from 'ccip/tokenAdminRegistry/TokenAdminRegistry.sol';
import {UpgradeableBurnMintTokenPool} from 'ccip/pools/GHO/UpgradeableBurnMintTokenPool.sol';
import {RateLimiter} from 'ccip/libraries/RateLimiter.sol';
import {UpgradeableGhoToken} from 'gho-core/gho/UpgradeableGhoToken.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Avalanche_GHOAvaxLaunch_20241106} from './AaveV3Avalanche_GHOAvaxLaunch_20241106.sol';

/**
 * @dev Test for AaveV3Avalanche_GHOAvaxLaunch_20241106
 * command: FOUNDRY_PROFILE=avalanche forge test --match-path=src/20241106_Multi_GHOAvaxLaunch/AaveV3Avalanche_GHOAvaxLaunch_20241106.t.sol -vv
 */
contract AaveV3Avalanche_GHOAvaxLaunch_20241106_Test is ProtocolV3TestBase {
  AaveV3Avalanche_GHOAvaxLaunch_20241106 internal proposal;

  address public constant TOKEN_ADMIN_REGISTRY = 0xc8df5D618c6a59Cc6A311E96a39450381001464F;
  address public constant REGISTRY_ADMIN = 0xA3f32a07CCd8569f49cf350D4e61C016CA484644;
  // TODO: Remove these constants once we have deployed pool address
  address public constant CCIP_RMN_PROXY = 0xcBD48A8eB077381c3c4Eb36b402d7283aB2b11Bc;
  address public constant CCIP_ROUTER = 0xF4c7E640EdA248ef95972845a62bdC74237805dB;
  address public constant ETH_TOKEN_POOL = MiscEthereum.GHO_CCIP_TOKEN_POOL;
  address public ghoToken;
  UpgradeableGhoToken public GHO;
  UpgradeableBurnMintTokenPool public TOKEN_POOL;

  event Minted(address indexed sender, address indexed recipient, uint256 amount);
  event Burned(address indexed sender, uint256 amount);
  event Transfer(address indexed from, address indexed to, uint256 value);

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('avalanche'), 53559217);

    // TODO: Remove this and put back in proposal after Chainlink sets executor as pending admin
    ghoToken = _deployGhoToken();
    GHO = UpgradeableGhoToken(ghoToken);

    // TODO: Remove this deployment once we have deployed pool address
    address tokenPool = _deployCcipTokenPool(ghoToken);
    TOKEN_POOL = UpgradeableBurnMintTokenPool(tokenPool);

    // TODO: Remove this (will be done on chainlink's side)
    // Prank chainlink and set up admin role to be accepted on token registry
    vm.startPrank(REGISTRY_ADMIN);
    TokenAdminRegistry(TOKEN_ADMIN_REGISTRY).proposeAdministrator(
      ghoToken,
      GovernanceV3Avalanche.EXECUTOR_LVL_1
    );
    vm.stopPrank();

    proposal = new AaveV3Avalanche_GHOAvaxLaunch_20241106();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest('AaveV3Avalanche_GHOAvaxLaunch_20241106', AaveV3Avalanche.POOL, address(proposal));

    _validateGhoDeployment();
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

    // Mint
    uint256 amount = 500_000e18; // 500K GHO
    uint64 ethChainSelector = proposal.CCIP_ETH_CHAIN_SELECTOR();
    assertEq(_getFacilitatorLevel(address(TOKEN_POOL)), 0);
    assertEq(GHO.balanceOf(address(TOKEN_POOL)), 0);

    Pool.ReleaseOrMintInV1 memory releaseOrMintIn = Pool.ReleaseOrMintInV1({
      originalSender: bytes(''),
      remoteChainSelector: ethChainSelector,
      receiver: user,
      amount: amount,
      localToken: address(GHO),
      sourcePoolAddress: abi.encode(ETH_TOKEN_POOL),
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

    Pool.LockOrBurnInV1 memory lockOrBurnIn = Pool.LockOrBurnInV1({
      receiver: bytes(''),
      remoteChainSelector: ethChainSelector,
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
  }

  // ---
  // Deployment
  // ---

  function _deployGhoToken() internal returns (address) {
    address imple = address(new UpgradeableGhoToken());

    bytes memory ghoTokenInitParams = abi.encodeWithSignature(
      'initialize(address)',
      GovernanceV3Avalanche.EXECUTOR_LVL_1 // owner
    );
    return
      address(
        new TransparentUpgradeableProxy(imple, MiscAvalanche.PROXY_ADMIN, ghoTokenInitParams)
      );
  }

  function _deployCcipTokenPool(address ghoToken) internal returns (address) {
    address imple = address(new UpgradeableBurnMintTokenPool(ghoToken, CCIP_RMN_PROXY, false));

    bytes memory tokenPoolInitParams = abi.encodeWithSignature(
      'initialize(address,address[],address)',
      GovernanceV3Avalanche.EXECUTOR_LVL_1, // owner
      new address[](0), // allowList
      CCIP_ROUTER // router
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

  // ---
  // Test Helpers
  // ---

  function _validateGhoDeployment() internal {
    assertEq(GHO.totalSupply(), 0);
    assertEq(GHO.getFacilitatorsList().length, 1);
    assertEq(_getProxyAdminAddress(address(GHO)), MiscAvalanche.PROXY_ADMIN);
    assertTrue(GHO.hasRole(bytes32(0), GovernanceV3Avalanche.EXECUTOR_LVL_1));
    assertTrue(GHO.hasRole(GHO.FACILITATOR_MANAGER_ROLE(), GovernanceV3Avalanche.EXECUTOR_LVL_1));
    assertTrue(GHO.hasRole(GHO.BUCKET_MANAGER_ROLE(), GovernanceV3Avalanche.EXECUTOR_LVL_1));
  }

  function _validateCcipTokenPool() internal {
    // Deployment
    assertEq(_getProxyAdminAddress(address(TOKEN_POOL)), MiscAvalanche.PROXY_ADMIN);
    assertEq(TOKEN_POOL.owner(), GovernanceV3Avalanche.EXECUTOR_LVL_1);
    assertEq(address(TOKEN_POOL.getToken()), address(GHO));
    assertEq(TOKEN_POOL.getRmnProxy(), CCIP_RMN_PROXY);
    assertEq(TOKEN_POOL.getRouter(), CCIP_ROUTER);

    // Facilitator
    (uint256 capacity, uint256 level) = GHO.getFacilitatorBucket(address(TOKEN_POOL));
    assertEq(capacity, proposal.CCIP_BUCKET_CAPACITY());
    assertEq(level, 0);

    // Configs
    uint64[] memory supportedChains = TOKEN_POOL.getSupportedChains();
    assertEq(supportedChains.length, 2);

    // ETH
    assertEq(supportedChains[0], proposal.CCIP_ETH_CHAIN_SELECTOR());
    RateLimiter.TokenBucket memory outboundRateLimit = TOKEN_POOL
      .getCurrentOutboundRateLimiterState(proposal.CCIP_ETH_CHAIN_SELECTOR());
    RateLimiter.TokenBucket memory inboundRateLimit = TOKEN_POOL.getCurrentInboundRateLimiterState(
      proposal.CCIP_ETH_CHAIN_SELECTOR()
    );
    assertEq(outboundRateLimit.isEnabled, false);
    assertEq(inboundRateLimit.isEnabled, false);

    // ARB
    assertEq(supportedChains[1], proposal.CCIP_ARB_CHAIN_SELECTOR());
    outboundRateLimit = TOKEN_POOL.getCurrentOutboundRateLimiterState(
      proposal.CCIP_ARB_CHAIN_SELECTOR()
    );
    inboundRateLimit = TOKEN_POOL.getCurrentInboundRateLimiterState(
      proposal.CCIP_ARB_CHAIN_SELECTOR()
    );
    assertEq(outboundRateLimit.isEnabled, false);
    assertEq(inboundRateLimit.isEnabled, false);
  }

  // ---
  // Utils
  // ---

  function _getProxyAdminAddress(address proxy) internal view returns (address) {
    bytes32 ERC1967_ADMIN_SLOT = 0xb53127684a568b3173ae13b9f8a6016e243e63b6e8ee1178d6a717850b5d6103;
    bytes32 adminSlot = vm.load(proxy, ERC1967_ADMIN_SLOT);
    return address(uint160(uint256(adminSlot)));
  }

  function _getFacilitatorLevel(address f) internal view returns (uint256) {
    (, uint256 level) = GHO.getFacilitatorBucket(f);
    return level;
  }
}
