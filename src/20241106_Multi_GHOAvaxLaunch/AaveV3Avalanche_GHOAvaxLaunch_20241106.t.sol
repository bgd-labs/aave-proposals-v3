// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import 'forge-std/Test.sol';
import {TransparentUpgradeableProxy} from 'solidity-utils/contracts/transparent-proxy/TransparentUpgradeableProxy.sol';
import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {UpgradeableBurnMintTokenPool} from 'ccip/pools/GHO/UpgradeableBurnMintTokenPool.sol';
import {TokenAdminRegistry} from 'ccip/tokenAdminRegistry/TokenAdminRegistry.sol';
import {IPoolV1} from 'ccip/interfaces/IPool.sol';
import {IPriceRegistry} from 'ccip/interfaces/IPriceRegistry.sol';
import {Pool} from 'ccip/libraries/Pool.sol';
import {Internal} from 'ccip/libraries/Internal.sol';
import {RateLimiter} from 'ccip/libraries/RateLimiter.sol';
import {Client} from 'ccip/libraries/Client.sol';
import {EVM2EVMOnRamp} from 'ccip/onRamp/EVM2EVMOnRamp.sol';
import {EVM2EVMOffRamp} from 'ccip/offRamp/EVM2EVMOffRamp.sol';
import {Router} from 'ccip/Router.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {GovV3Helpers} from 'aave-helpers/src/GovV3Helpers.sol';
import {AaveV3Avalanche} from 'aave-address-book/AaveV3Avalanche.sol';
import {GovernanceV3Avalanche} from 'aave-address-book/GovernanceV3Avalanche.sol';
import {MiscAvalanche} from 'aave-address-book/MiscAvalanche.sol';
import {MiscEthereum} from 'aave-address-book/MiscEthereum.sol';
import {MiscArbitrum} from 'aave-address-book/MiscArbitrum.sol';
import {UpgradeableGhoToken} from 'gho-core/gho/UpgradeableGhoToken.sol';
import {AaveV3Avalanche_GHOAvaxLaunch_20241106} from './AaveV3Avalanche_GHOAvaxLaunch_20241106.sol';

/**
 * @dev Test for AaveV3Avalanche_GHOAvaxLaunch_20241106
 * command: FOUNDRY_PROFILE=avalanche forge test --match-path=src/20241106_Multi_GHOAvaxLaunch/AaveV3Avalanche_GHOAvaxLaunch_20241106.t.sol -vv
 */
contract AaveV3Avalanche_GHOAvaxLaunch_20241106_Test is ProtocolV3TestBase {
  AaveV3Avalanche_GHOAvaxLaunch_20241106 internal proposal;

  address internal constant CCIP_AVAX_ETH_ON_RAMP = 0xe8784c29c583C52FA89144b9e5DD91Df2a1C2587;
  address internal constant CCIP_AVAX_ETH_OFF_RAMP = 0xE5F21F43937199D4D57876A83077b3923F68EB76;
  address internal constant CCIP_AVAX_ARB_ON_RAMP = 0x4e910c8Bbe88DaDF90baa6c1B7850DbeA32c5B29;
  address internal constant CCIP_AVAX_ARB_OFF_RAMP = 0x508Ea280D46E4796Ce0f1Acf8BEDa610c4238dB3;

  address public constant TOKEN_ADMIN_REGISTRY = 0xc8df5D618c6a59Cc6A311E96a39450381001464F;
  address public constant REGISTRY_ADMIN = 0xA3f32a07CCd8569f49cf350D4e61C016CA484644;
  // TODO: Remove these constants once we have deployed pool address
  address public constant CCIP_RMN_PROXY = 0xcBD48A8eB077381c3c4Eb36b402d7283aB2b11Bc;
  address public constant CCIP_ROUTER = 0xF4c7E640EdA248ef95972845a62bdC74237805dB;
  address public constant ETH_TOKEN_POOL = MiscEthereum.GHO_CCIP_TOKEN_POOL;
  address public constant ARB_TOKEN_POOL = MiscArbitrum.GHO_CCIP_TOKEN_POOL;
  address public constant GHO_TOKEN = 0x2e234DAe75C793f67A35089C9d99245E1C58470b;
  UpgradeableGhoToken public GHO = UpgradeableGhoToken(GHO_TOKEN);
  UpgradeableBurnMintTokenPool public TOKEN_POOL;

  event Minted(address indexed sender, address indexed recipient, uint256 amount);
  event Burned(address indexed sender, uint256 amount);
  event Transfer(address indexed from, address indexed to, uint256 value);

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('avalanche'), 53559217);

    // TODO: Decide if we want to deploy this beforehand or in AIP
    _deployGhoToken();

    // TODO: Remove this deployment once we have deployed pool address
    address tokenPool = _deployCcipTokenPool(GHO_TOKEN);
    TOKEN_POOL = UpgradeableBurnMintTokenPool(tokenPool);

    // TODO: Remove this (will be done on chainlink's side)
    // Prank chainlink and set up admin role to be accepted on token registry
    vm.startPrank(REGISTRY_ADMIN);
    TokenAdminRegistry(TOKEN_ADMIN_REGISTRY).proposeAdministrator(
      GHO_TOKEN,
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

    // AVAX <> ETH

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

    // AVAX <> ARB

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
  }

  /// @dev CCIP e2e eth <> avax
  function test_ccipE2E_ETH_AVAX() public {
    GovV3Helpers.executePayload(vm, address(proposal));

    uint64 ethChainSelector = proposal.CCIP_ETH_CHAIN_SELECTOR();

    // Chainlink config
    Router router = Router(TOKEN_POOL.getRouter());

    {
      Router.OnRamp[] memory onRampUpdates = new Router.OnRamp[](1);
      Router.OffRamp[] memory offRampUpdates = new Router.OffRamp[](1);
      // ETH -> AVAX
      onRampUpdates[0] = Router.OnRamp({
        destChainSelector: ethChainSelector,
        onRamp: CCIP_AVAX_ETH_ON_RAMP
      });
      // AVAX -> ETH
      offRampUpdates[0] = Router.OffRamp({
        sourceChainSelector: ethChainSelector,
        offRamp: CCIP_AVAX_ETH_OFF_RAMP
      });
      address routerOwner = router.owner();
      vm.startPrank(routerOwner);
      router.applyRampUpdates(onRampUpdates, new Router.OffRamp[](0), offRampUpdates);
    }

    {
      // OnRamp Price Registry
      EVM2EVMOnRamp.DynamicConfig memory onRampDynamicConfig = EVM2EVMOnRamp(CCIP_AVAX_ETH_ON_RAMP)
        .getDynamicConfig();
      Internal.PriceUpdates memory priceUpdate = _getSingleTokenPriceUpdateStruct(
        address(GHO),
        1e18
      );

      IPriceRegistry(onRampDynamicConfig.priceRegistry).updatePrices(priceUpdate);
      // OffRamp Price Registry
      EVM2EVMOffRamp.DynamicConfig memory offRampDynamicConfig = EVM2EVMOffRamp(
        CCIP_AVAX_ETH_OFF_RAMP
      ).getDynamicConfig();
      IPriceRegistry(offRampDynamicConfig.priceRegistry).updatePrices(priceUpdate);
    }

    // User executes ccipSend
    address user = makeAddr('user');
    uint256 amount = 500_000e18; // 500K GHO
    deal(user, 1e18); // 1 ETH

    // Mint tokens to user so can burn and bridge out
    vm.startPrank(address(TOKEN_POOL));
    GHO.mint(user, amount);

    assertEq(GHO.balanceOf(address(TOKEN_POOL)), 0);
    (uint256 capacity, uint256 level) = GHO.getFacilitatorBucket(address(TOKEN_POOL));
    assertEq(capacity, proposal.CCIP_BUCKET_CAPACITY());
    assertEq(level, amount);

    vm.startPrank(user);
    // Use address(0) to use native token as fee token
    _sendCcip(router, address(GHO), amount, address(0), ethChainSelector, user);

    assertEq(GHO.balanceOf(user), 0);
    assertEq(GHO.balanceOf(address(TOKEN_POOL)), 0);
    (capacity, level) = GHO.getFacilitatorBucket(address(TOKEN_POOL));
    assertEq(capacity, proposal.CCIP_BUCKET_CAPACITY());
    assertEq(level, 0);
  }

  /// @dev CCIP e2e arb <> avax
  function test_ccipE2E_ARB_AVAX() public {
    GovV3Helpers.executePayload(vm, address(proposal));

    uint64 arbChainSelector = proposal.CCIP_ARB_CHAIN_SELECTOR();

    // Chainlink config
    Router router = Router(TOKEN_POOL.getRouter());

    {
      Router.OnRamp[] memory onRampUpdates = new Router.OnRamp[](1);
      Router.OffRamp[] memory offRampUpdates = new Router.OffRamp[](1);
      // ARB -> AVAX
      onRampUpdates[0] = Router.OnRamp({
        destChainSelector: arbChainSelector,
        onRamp: CCIP_AVAX_ARB_ON_RAMP
      });
      // AVAX -> ARB
      offRampUpdates[0] = Router.OffRamp({
        sourceChainSelector: arbChainSelector,
        offRamp: CCIP_AVAX_ARB_OFF_RAMP
      });
      address routerOwner = router.owner();
      vm.startPrank(routerOwner);
      router.applyRampUpdates(onRampUpdates, new Router.OffRamp[](0), offRampUpdates);
    }

    {
      // OnRamp Price Registry
      EVM2EVMOnRamp.DynamicConfig memory onRampDynamicConfig = EVM2EVMOnRamp(CCIP_AVAX_ARB_ON_RAMP)
        .getDynamicConfig();
      Internal.PriceUpdates memory priceUpdate = _getSingleTokenPriceUpdateStruct(
        address(GHO),
        1e18
      );

      IPriceRegistry(onRampDynamicConfig.priceRegistry).updatePrices(priceUpdate);
      // OffRamp Price Registry
      EVM2EVMOffRamp.DynamicConfig memory offRampDynamicConfig = EVM2EVMOffRamp(
        CCIP_AVAX_ARB_OFF_RAMP
      ).getDynamicConfig();
      IPriceRegistry(offRampDynamicConfig.priceRegistry).updatePrices(priceUpdate);
    }

    // User executes ccipSend
    address user = makeAddr('user');
    uint256 amount = 500_000e18; // 500K GHO
    deal(user, 1e18); // 1 ETH

    // Mint tokens to user so can burn and bridge out
    vm.startPrank(address(TOKEN_POOL));
    GHO.mint(user, amount);

    assertEq(GHO.balanceOf(address(TOKEN_POOL)), 0);
    (uint256 capacity, uint256 level) = GHO.getFacilitatorBucket(address(TOKEN_POOL));
    assertEq(capacity, proposal.CCIP_BUCKET_CAPACITY());
    assertEq(level, amount);

    vm.startPrank(user);
    // Use address(0) to use native token as fee token
    _sendCcip(router, address(GHO), amount, address(0), arbChainSelector, user);

    assertEq(GHO.balanceOf(user), 0);
    assertEq(GHO.balanceOf(address(TOKEN_POOL)), 0);
    (capacity, level) = GHO.getFacilitatorBucket(address(TOKEN_POOL));
    assertEq(capacity, proposal.CCIP_BUCKET_CAPACITY());
    assertEq(level, 0);
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
    address imple = address(new UpgradeableBurnMintTokenPool(ghoToken, 18, CCIP_RMN_PROXY, false));

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

  function _validateGhoDeployment() internal view {
    assertEq(GHO.totalSupply(), 0);
    assertEq(GHO.getFacilitatorsList().length, 1);
    assertEq(_getProxyAdminAddress(address(GHO)), MiscAvalanche.PROXY_ADMIN);
    assertTrue(GHO.hasRole(bytes32(0), GovernanceV3Avalanche.EXECUTOR_LVL_1));
    assertTrue(GHO.hasRole(GHO.FACILITATOR_MANAGER_ROLE(), GovernanceV3Avalanche.EXECUTOR_LVL_1));
    assertTrue(GHO.hasRole(GHO.BUCKET_MANAGER_ROLE(), GovernanceV3Avalanche.EXECUTOR_LVL_1));
  }

  function _validateCcipTokenPool() internal view {
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
        extraArgs: Client._argsToBytes(Client.EVMExtraArgsV1({gasLimit: 200_000}))
      });
  }

  function _getTokensAndPools(
    address[] memory tokens,
    IPoolV1[] memory pools
  ) internal pure returns (Internal.PoolUpdate[] memory) {
    Internal.PoolUpdate[] memory tokensAndPools = new Internal.PoolUpdate[](tokens.length);
    for (uint256 i = 0; i < tokens.length; ++i) {
      tokensAndPools[i] = Internal.PoolUpdate({token: tokens[i], pool: address(pools[i])});
    }
    return tokensAndPools;
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
