// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Ethereum} from 'aave-address-book/AaveV3Ethereum.sol';

import 'forge-std/Test.sol';
import {TransparentUpgradeableProxy} from 'solidity-utils/contracts/transparent-proxy/TransparentUpgradeableProxy.sol';
import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {UpgradeableBurnMintTokenPool} from 'ccip/pools/GHO/UpgradeableBurnMintTokenPool.sol';
import {UpgradeableLockReleaseTokenPool} from 'ccip/pools/GHO/UpgradeableLockReleaseTokenPool.sol';
import {IPoolPriorTo1_5} from 'ccip/interfaces/IPoolPriorTo1_5.sol';
import {IPriceRegistry} from 'ccip/interfaces/IPriceRegistry.sol';
import {Internal} from 'ccip/libraries/Internal.sol';
import {Pool} from 'ccip/libraries/Pool.sol';
import {RateLimiter} from 'ccip/libraries/RateLimiter.sol';
import {Client} from 'ccip/libraries/Client.sol';
import {TokenAdminRegistry} from 'ccip/tokenAdminRegistry/TokenAdminRegistry.sol';
import {EVM2EVMOnRamp} from 'ccip/onRamp/EVM2EVMOnRamp.sol';
import {EVM2EVMOffRamp} from 'ccip/offRamp/EVM2EVMOffRamp.sol';
import {Router} from 'ccip/Router.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {GovV3Helpers} from 'aave-helpers/src/GovV3Helpers.sol';
import {AaveV3Arbitrum} from 'aave-address-book/AaveV3Arbitrum.sol';
import {MiscEthereum} from 'aave-address-book/MiscEthereum.sol';
import {GovernanceV3Arbitrum} from 'aave-address-book/GovernanceV3Arbitrum.sol';
import {AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {MiscEthereum} from 'aave-address-book/MiscEthereum.sol';
import {GovernanceV3Avalanche} from 'aave-address-book/GovernanceV3Avalanche.sol';
import {MiscAvalanche} from 'aave-address-book/MiscAvalanche.sol';
import {UpgradeableGhoToken} from 'gho-core/gho/UpgradeableGhoToken.sol';
import {IUpgradeableTokenPool_1_4} from 'src/interfaces/ccip/IUpgradeableTokenPool_1_4.sol';
import {AaveV3Avalanche_GHOAvaxLaunch_20241106} from './AaveV3Avalanche_GHOAvaxLaunch_20241106.sol';
import {AaveV3Ethereum_GHOAvaxLaunch_20241106} from './AaveV3Ethereum_GHOAvaxLaunch_20241106.sol';

/**
 * @dev Test for AaveV3Ethereum_GHOAvaxLaunch_20241106
 * command: FOUNDRY_PROFILE=mainnet forge test --match-path=src/20241106_Multi_GHOAvaxLaunch/AaveV3Ethereum_GHOAvaxLaunch_20241106.t.sol -vv
 */
contract AaveV3Ethereum_GHOAvaxLaunch_20241106_Test is ProtocolV3TestBase {
  AaveV3Ethereum_GHOAvaxLaunch_20241106 internal proposal;

  UpgradeableLockReleaseTokenPool public constant TOKEN_POOL =
    UpgradeableLockReleaseTokenPool(MiscEthereum.GHO_CCIP_TOKEN_POOL);
  address public constant GHO_TOKEN = AaveV3EthereumAssets.GHO_UNDERLYING;
  UpgradeableGhoToken public GHO = UpgradeableGhoToken(GHO_TOKEN);

  address public constant AVAX_GHO_TOKEN = 0x2e234DAe75C793f67A35089C9d99245E1C58470b;
  address public constant AVAX_TOKEN_POOL = 0x5991A2dF15A8F6A256D3Ec51E99254Cd3fb576A9;
  address public constant AVAX_REGISTRY_ADMIN = 0xA3f32a07CCd8569f49cf350D4e61C016CA484644;
  address public constant AVAX_TOKEN_ADMIN_REGISTRY = 0xc8df5D618c6a59Cc6A311E96a39450381001464F;
  address public constant AVAX_RMN_PROXY = 0xcBD48A8eB077381c3c4Eb36b402d7283aB2b11Bc;
  address public constant AVAX_ROUTER = 0xF4c7E640EdA248ef95972845a62bdC74237805dB;
  uint64 public constant CCIP_AVAX_CHAIN_SELECTOR = 6433500567565415381;
  uint64 public constant CCIP_ARB_CHAIN_SELECTOR = 4949039107694359620;

  event Released(address indexed sender, address indexed recipient, uint256 amount);
  event Locked(address indexed sender, uint256 amount);
  event CCIPSendRequested(Internal.EVM2EVMMessage message);
  event Transfer(address indexed from, address indexed to, uint256 value);

  function setUp() public {
    // Execute Avax proposal to deploy Avax token pool
    vm.createSelectFork(vm.rpcUrl('avalanche'), 53559217);

    // TODO: Decide if we want to deploy this beforehand or in AIP
    _deployGhoToken();

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

    // Switch to Ethereum and create proposal
    vm.createSelectFork(vm.rpcUrl('mainnet'), 21133428);

    // TODO: Find tokenPoolAndProxy address on Eth pool
    // Configure TokenPoolAndProxy for Avalanche
    // Prank Registry owner
    /*
    vm.startPrank(REGISTRY_ADMIN);
    _configureCcipTokenPool(TOKEN_POOL_AND_PROXY, CCIP_AVAX_CHAIN_SELECTOR);
    vm.stopPrank();
    */
    proposal = new AaveV3Ethereum_GHOAvaxLaunch_20241106();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest('AaveV3Ethereum_GHOAvaxLaunch_20241106', AaveV3Ethereum.POOL, address(proposal));

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

    // ETH <> ARB

    // Lock
    uint256 amount = 100e18; // 100 GHO
    deal(address(GHO), user, amount);
    uint64 arbChainSelector = proposal.CCIP_ARB_CHAIN_SELECTOR();

    uint256 startingGhoBalance = GHO.balanceOf(address(TOKEN_POOL));

    // mock router transfer of funds from user to token pool
    vm.prank(user);
    GHO.transfer(address(TOKEN_POOL), amount);

    vm.expectEmit(false, true, false, true, address(TOKEN_POOL));
    emit Locked(address(0), amount);

    vm.prank(ramp);
    IPoolPriorTo1_5(address(TOKEN_POOL)).lockOrBurn(
      user,
      bytes(''),
      amount,
      arbChainSelector,
      bytes('')
    );
    assertEq(GHO.balanceOf(address(TOKEN_POOL)), startingGhoBalance + amount);
    assertEq(GHO.balanceOf(user), 0);

    // Release
    vm.expectEmit(true, true, true, true, address(GHO));
    emit Transfer(address(TOKEN_POOL), user, amount);

    vm.expectEmit(false, true, true, true, address(TOKEN_POOL));
    emit Released(address(0), user, amount);

    IPoolPriorTo1_5(address(TOKEN_POOL)).releaseOrMint(
      bytes(''),
      user,
      amount,
      arbChainSelector,
      bytes('')
    );
    assertEq(GHO.balanceOf(address(TOKEN_POOL)), startingGhoBalance);
    assertEq(GHO.balanceOf(user), amount);

    // ETH <> AVAX

    // Lock
    deal(address(GHO), user, amount);
    uint64 avaxChainSelector = proposal.CCIP_AVAX_CHAIN_SELECTOR();

    startingGhoBalance = GHO.balanceOf(address(TOKEN_POOL));

    // mock router transfer of funds from user to token pool
    vm.prank(user);
    GHO.transfer(address(TOKEN_POOL), amount);

    vm.expectEmit(false, true, false, true, address(TOKEN_POOL));
    emit Locked(address(0), amount);

    vm.prank(ramp);
    IPoolPriorTo1_5(address(TOKEN_POOL)).lockOrBurn(
      user,
      bytes(''),
      amount,
      arbChainSelector,
      bytes('')
    );
    assertEq(GHO.balanceOf(address(TOKEN_POOL)), startingGhoBalance + amount);
    assertEq(GHO.balanceOf(user), 0);

    // Release
    vm.expectEmit(true, true, true, true, address(GHO));
    emit Transfer(address(TOKEN_POOL), user, amount);

    vm.expectEmit(false, true, true, true, address(TOKEN_POOL));
    emit Released(address(0), user, amount);

    IPoolPriorTo1_5(address(TOKEN_POOL)).releaseOrMint(
      bytes(''),
      user,
      amount,
      arbChainSelector,
      bytes('')
    );
    assertEq(GHO.balanceOf(address(TOKEN_POOL)), startingGhoBalance);
    assertEq(GHO.balanceOf(user), amount);
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

  function _deployCcipTokenPool() internal returns (address) {
    address imple = address(
      new UpgradeableBurnMintTokenPool(AVAX_GHO_TOKEN, 18, AVAX_RMN_PROXY, false)
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

  // ---
  // Test Helpers
  // ---

  function _validateCcipTokenPool() internal view {
    // Configs
    uint64[] memory supportedChains = TOKEN_POOL.getSupportedChains();
    assertEq(supportedChains.length, 2);

    // ARB
    assertEq(supportedChains[0], proposal.CCIP_ARB_CHAIN_SELECTOR());

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

  // ---
  // Utils
  // ---

  function _configureCcipTokenPool(address tokenPool, uint64 chainSelector) internal {
    IUpgradeableTokenPool_1_4.ChainUpdate[]
      memory chainUpdates = new IUpgradeableTokenPool_1_4.ChainUpdate[](1);
    RateLimiter.Config memory rateConfig = RateLimiter.Config({
      isEnabled: false,
      capacity: 0,
      rate: 0
    });
    chainUpdates[0] = IUpgradeableTokenPool_1_4.ChainUpdate({
      remoteChainSelector: chainSelector,
      allowed: true,
      remotePoolAddress: abi.encode(AVAX_TOKEN_POOL),
      remoteTokenAddress: abi.encode(AVAX_GHO_TOKEN),
      outboundRateLimiterConfig: rateConfig,
      inboundRateLimiterConfig: rateConfig
    });
    IUpgradeableTokenPool_1_4(tokenPool).applyChainUpdates(chainUpdates);
  }
}
