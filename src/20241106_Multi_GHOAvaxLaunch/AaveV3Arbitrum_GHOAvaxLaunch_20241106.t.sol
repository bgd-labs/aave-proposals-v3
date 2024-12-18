// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import 'forge-std/Test.sol';
import {TransparentUpgradeableProxy} from 'solidity-utils/contracts/transparent-proxy/TransparentUpgradeableProxy.sol';
import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {UpgradeableBurnMintTokenPool} from 'ccip/pools/GHO/UpgradeableBurnMintTokenPool.sol';
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
import {MiscArbitrum} from 'aave-address-book/MiscArbitrum.sol';
import {GovernanceV3Arbitrum} from 'aave-address-book/GovernanceV3Arbitrum.sol';
import {AaveV3ArbitrumAssets} from 'aave-address-book/AaveV3Arbitrum.sol';
import {MiscEthereum} from 'aave-address-book/MiscEthereum.sol';
import {GovernanceV3Avalanche} from 'aave-address-book/GovernanceV3Avalanche.sol';
import {MiscAvalanche} from 'aave-address-book/MiscAvalanche.sol';
import {UpgradeableGhoToken} from 'gho-core/gho/UpgradeableGhoToken.sol';
import {IUpgradeableTokenPool_1_4} from 'src/interfaces/ccip/IUpgradeableTokenPool_1_4.sol';
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
  address public constant AVAX_GHO_TOKEN = 0x2e234DAe75C793f67A35089C9d99245E1C58470b;
  address public constant AVAX_TOKEN_POOL = 0x5991A2dF15A8F6A256D3Ec51E99254Cd3fb576A9;
  address public constant AVAX_REGISTRY_ADMIN = 0xA3f32a07CCd8569f49cf350D4e61C016CA484644;
  address public constant AVAX_TOKEN_ADMIN_REGISTRY = 0xc8df5D618c6a59Cc6A311E96a39450381001464F;
  address public constant AVAX_RMN_PROXY = 0xcBD48A8eB077381c3c4Eb36b402d7283aB2b11Bc;
  address public constant AVAX_ROUTER = 0xF4c7E640EdA248ef95972845a62bdC74237805dB;
  address public constant ETH_TOKEN_POOL = MiscEthereum.GHO_CCIP_TOKEN_POOL;
  address public constant CCIP_ARB_ETH_ON_RAMP = 0x67761742ac8A21Ec4D76CA18cbd701e5A6F3Bef3;
  address public constant CCIP_ARB_ETH_OFF_RAMP = 0x91e46cc5590A4B9182e47f40006140A7077Dec31;
  address public constant CCIP_ARB_AVAX_ON_RAMP = 0xe80cC83B895ada027b722b78949b296Bd1fC5639;
  address public constant CCIP_ARB_AVAX_OFF_RAMP = 0x95095007d5Cc3E7517A1A03c9e228adA5D0bc376;
  address public constant TOKEN_POOL_AND_PROXY = 0x26329558f08cbb40d6a4CCA0E0C67b29D64A8c50;
  uint64 public constant CCIP_AVAX_CHAIN_SELECTOR = 6433500567565415381;

  event Minted(address indexed sender, address indexed recipient, uint256 amount);
  event Burned(address indexed sender, uint256 amount);
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

    // Switch to Arbitrum and create proposal
    vm.createSelectFork(vm.rpcUrl('arbitrum'), 279521658);

    // Configure TokenPoolAndProxy for Avalanche
    // Prank Registry owner
    vm.startPrank(REGISTRY_ADMIN);
    _configureCcipTokenPool(TOKEN_POOL_AND_PROXY, CCIP_AVAX_CHAIN_SELECTOR);
    vm.stopPrank();
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

    // Mint
    uint64 avaxChainSelector = proposal.CCIP_AVAX_CHAIN_SELECTOR();

    vm.expectEmit(true, true, true, true, address(GHO));
    emit Transfer(address(0), user, amount);

    vm.expectEmit(false, true, true, true, address(TOKEN_POOL));
    emit Minted(address(0), user, amount);

    IPoolPriorTo1_5(address(TOKEN_POOL)).releaseOrMint(
      bytes(''),
      user,
      amount,
      avaxChainSelector,
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
      avaxChainSelector,
      bytes('')
    );

    assertEq(_getFacilitatorLevel(address(TOKEN_POOL)), startingFacilitatorLevel);
    assertEq(GHO.balanceOf(address(TOKEN_POOL)), startingGhoBalance);
  }

  /// @dev CCIP e2e eth <> arb
  function test_ccipE2E_ETH_ARB() public {
    GovV3Helpers.executePayload(vm, address(proposal));

    uint64 ethChainSelector = proposal.CCIP_ETH_CHAIN_SELECTOR();

    // Chainlink config
    Router router = Router(TOKEN_POOL.getRouter());

    {
      Router.OnRamp[] memory onRampUpdates = new Router.OnRamp[](1);
      Router.OffRamp[] memory offRampUpdates = new Router.OffRamp[](1);
      // ETH -> ARB
      onRampUpdates[0] = Router.OnRamp({
        destChainSelector: ethChainSelector,
        onRamp: CCIP_ARB_ETH_ON_RAMP
      });
      // ARB -> ETH
      offRampUpdates[0] = Router.OffRamp({
        sourceChainSelector: ethChainSelector,
        offRamp: CCIP_ARB_ETH_OFF_RAMP
      });
      address routerOwner = router.owner();
      vm.startPrank(routerOwner);
      router.applyRampUpdates(onRampUpdates, new Router.OffRamp[](0), offRampUpdates);
    }

    {
      // OnRamp Price Registry
      EVM2EVMOnRamp.DynamicConfig memory onRampDynamicConfig = EVM2EVMOnRamp(CCIP_ARB_ETH_ON_RAMP)
        .getDynamicConfig();
      Internal.PriceUpdates memory priceUpdate = _getSingleTokenPriceUpdateStruct(
        address(GHO),
        1e18
      );

      IPriceRegistry(onRampDynamicConfig.priceRegistry).updatePrices(priceUpdate);
      // OffRamp Price Registry
      EVM2EVMOffRamp.DynamicConfig memory offRampDynamicConfig = EVM2EVMOffRamp(
        CCIP_ARB_ETH_OFF_RAMP
      ).getDynamicConfig();
      IPriceRegistry(offRampDynamicConfig.priceRegistry).updatePrices(priceUpdate);
    }

    // User executes ccipSend
    address user = makeAddr('user');
    uint256 amount = 100e18; // 100 GHO
    deal(user, 1e18); // 1 ETH

    uint256 startingGhoBalance = GHO.balanceOf(address(TOKEN_POOL));
    uint256 startingFacilitatorLevel = _getFacilitatorLevel(address(TOKEN_POOL));

    // Mint tokens to user so can burn and bridge out
    vm.startPrank(address(TOKEN_POOL));
    GHO.mint(user, amount);

    assertEq(GHO.balanceOf(address(TOKEN_POOL)), startingGhoBalance);
    assertEq(_getFacilitatorLevel(address(TOKEN_POOL)), startingFacilitatorLevel + amount);

    vm.startPrank(user);
    // Use address(0) to use native token as fee token
    _sendCcip(router, address(GHO), amount, address(0), ethChainSelector, user);

    assertEq(GHO.balanceOf(user), 0);
    assertEq(GHO.balanceOf(address(TOKEN_POOL)), startingGhoBalance);
    assertEq(_getFacilitatorLevel(address(TOKEN_POOL)), startingFacilitatorLevel);
  }

  /// @dev CCIP e2e avax <> arb
  function test_ccipE2E_AVAX_ARB() public {
    GovV3Helpers.executePayload(vm, address(proposal));

    uint64 avaxChainSelector = proposal.CCIP_AVAX_CHAIN_SELECTOR();

    // Chainlink config
    Router router = Router(TOKEN_POOL.getRouter());

    {
      Router.OnRamp[] memory onRampUpdates = new Router.OnRamp[](1);
      Router.OffRamp[] memory offRampUpdates = new Router.OffRamp[](1);
      // AVAX -> ARB
      onRampUpdates[0] = Router.OnRamp({
        destChainSelector: avaxChainSelector,
        onRamp: CCIP_ARB_AVAX_ON_RAMP
      });
      // ARB -> AVAX
      offRampUpdates[0] = Router.OffRamp({
        sourceChainSelector: avaxChainSelector,
        offRamp: CCIP_ARB_AVAX_OFF_RAMP
      });
      address routerOwner = router.owner();
      vm.startPrank(routerOwner);
      router.applyRampUpdates(onRampUpdates, new Router.OffRamp[](0), offRampUpdates);
    }

    {
      // OnRamp Price Registry
      EVM2EVMOnRamp.DynamicConfig memory onRampDynamicConfig = EVM2EVMOnRamp(CCIP_ARB_AVAX_ON_RAMP)
        .getDynamicConfig();
      Internal.PriceUpdates memory priceUpdate = _getSingleTokenPriceUpdateStruct(
        address(GHO),
        1e18
      );

      IPriceRegistry(onRampDynamicConfig.priceRegistry).updatePrices(priceUpdate);
      // OffRamp Price Registry
      EVM2EVMOffRamp.DynamicConfig memory offRampDynamicConfig = EVM2EVMOffRamp(
        CCIP_ARB_AVAX_OFF_RAMP
      ).getDynamicConfig();
      IPriceRegistry(offRampDynamicConfig.priceRegistry).updatePrices(priceUpdate);
    }

    // User executes ccipSend
    address user = makeAddr('user');
    uint256 amount = 100e18; // 100 GHO
    deal(user, 1e18); // 1 ETH

    uint256 startingGhoBalance = GHO.balanceOf(address(TOKEN_POOL));
    uint256 startingFacilitatorLevel = _getFacilitatorLevel(address(TOKEN_POOL));

    // Mint tokens to user so can burn and bridge out
    vm.startPrank(address(TOKEN_POOL));
    GHO.mint(user, amount);

    assertEq(GHO.balanceOf(address(TOKEN_POOL)), startingGhoBalance);
    assertEq(_getFacilitatorLevel(address(TOKEN_POOL)), startingFacilitatorLevel + amount);

    vm.startPrank(user);
    // Use address(0) to use native token as fee token
    _sendCcip(router, address(GHO), amount, address(0), avaxChainSelector, user);

    assertEq(GHO.balanceOf(user), 0);
    assertEq(GHO.balanceOf(address(TOKEN_POOL)), startingGhoBalance);
    assertEq(_getFacilitatorLevel(address(TOKEN_POOL)), startingFacilitatorLevel);
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

  function _getFacilitatorLevel(address f) internal view returns (uint256) {
    (, uint256 level) = GHO.getFacilitatorBucket(f);
    return level;
  }

  function _sendCcip(
    Router router,
    address token,
    uint256 amount,
    address feeToken,
    uint64 destChainSelector,
    address receiver
  ) internal {
    Client.EVM2AnyMessage memory message = _generateSingleTokenMessage(
      receiver,
      token,
      amount,
      feeToken
    );
    uint256 expectedFee = router.getFee(destChainSelector, message);

    IERC20(token).approve(address(router), amount);
    router.ccipSend{value: expectedFee}(destChainSelector, message);
  }

  function _generateSingleTokenMessage(
    address receiver,
    address token,
    uint256 amount,
    address feeToken
  ) public pure returns (Client.EVM2AnyMessage memory) {
    Client.EVMTokenAmount[] memory tokenAmounts = new Client.EVMTokenAmount[](1);
    tokenAmounts[0] = Client.EVMTokenAmount({token: token, amount: amount});
    return
      Client.EVM2AnyMessage({
        receiver: abi.encode(receiver),
        data: '',
        tokenAmounts: tokenAmounts,
        feeToken: feeToken,
        extraArgs: '' //Client._argsToBytes(Client.EVMExtraArgsV1({gasLimit: 200_000}))
      });
  }

  function _getSingleTokenPriceUpdateStruct(
    address token,
    uint224 price
  ) internal pure returns (Internal.PriceUpdates memory) {
    Internal.TokenPriceUpdate[] memory tokenPriceUpdates = new Internal.TokenPriceUpdate[](1);
    tokenPriceUpdates[0] = Internal.TokenPriceUpdate({sourceToken: token, usdPerToken: price});

    Internal.PriceUpdates memory priceUpdates = Internal.PriceUpdates({
      tokenPriceUpdates: tokenPriceUpdates,
      gasPriceUpdates: new Internal.GasPriceUpdate[](0)
    });

    return priceUpdates;
  }
}
