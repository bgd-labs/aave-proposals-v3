// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import 'forge-std/Test.sol';
import {GovV3Helpers} from 'aave-helpers/GovV3Helpers.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV3Ethereum} from 'aave-address-book/AaveV3Ethereum.sol';
import {MiscEthereum} from 'aave-address-book/MiscEthereum.sol';
import {GovernanceV3Ethereum} from 'aave-address-book/GovernanceV3Ethereum.sol';
import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {RateLimiter} from 'ccip/v0.8/ccip/libraries/RateLimiter.sol';
import {Internal} from 'ccip/v0.8/ccip/libraries/Internal.sol';
import {Client} from 'ccip/v0.8/ccip/libraries/Client.sol';
import {Router} from 'ccip/v0.8/ccip/Router.sol';
import {PriceRegistry} from 'ccip/v0.8/ccip/PriceRegistry.sol';
import {EVM2EVMOnRamp} from 'ccip/v0.8/ccip/onRamp/EVM2EVMOnRamp.sol';
import {EVM2EVMOffRamp} from 'ccip/v0.8/ccip/offRamp/EVM2EVMOffRamp.sol';
import {IPool} from 'ccip/v0.8/ccip/interfaces/pools/IPool.sol';

import {UpgradeableLockReleaseTokenPool} from 'ccip/v0.8/ccip/pools/GHO/UpgradeableLockReleaseTokenPool.sol';
import {IGhoToken} from 'gho-core/gho/interfaces/IGhoToken.sol';

import {AaveV3Ethereum_GHOCrossChainLaunch_20240528} from './AaveV3Ethereum_GHOCrossChainLaunch_20240528.sol';

/**
 * @dev Test for AaveV3Ethereum_GHOCrossChainLaunch_20240528
 * command: FOUNDRY_PROFILE=mainnet forge test --match-path=src/20240528_Multi_GHOCrossChainLaunch/AaveV3Ethereum_GHOCrossChainLaunch_20240528.t.sol -vv
 */
contract AaveV3Ethereum_GHOCrossChainLaunch_20240528_Test is ProtocolV3TestBase {
  using Internal for Internal.EVM2EVMMessage;

  AaveV3Ethereum_GHOCrossChainLaunch_20240528 internal proposal;

  UpgradeableLockReleaseTokenPool internal TOKEN_POOL;
  IGhoToken internal GHO;

  address internal constant CCIP_ETH_ON_RAMP = 0x925228D7B82d883Dde340A55Fe8e6dA56244A22C;
  address internal constant CCIP_ETH_OFF_RAMP = 0xeFC4a18af59398FF23bfe7325F2401aD44286F4d;

  event Released(address indexed sender, address indexed recipient, uint256 amount);
  event Locked(address indexed sender, uint256 amount);
  event CCIPSendRequested(Internal.EVM2EVMMessage message);
  event Transfer(address indexed from, address indexed to, uint256 value);
  event Initialized(uint8 version);

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 20067000);
    proposal = new AaveV3Ethereum_GHOCrossChainLaunch_20240528();
    GHO = IGhoToken(MiscEthereum.GHO_TOKEN);
  }

  /// @dev General test of the proposal
  function test_defaultProposalExecution() public {
    vm.recordLogs();

    defaultTest(
      'AaveV3Ethereum_GHOCrossChainLaunch_20240528',
      AaveV3Ethereum.POOL,
      address(proposal)
    );

    // Fetch addresses
    Vm.Log[] memory entries = vm.getRecordedLogs();
    address ccipAddress;
    for (uint256 i = 0; i < entries.length; i++) {
      if (entries[i].topics[0] == Initialized.selector) {
        uint8 version = abi.decode(entries[i].data, (uint8));
        if (version == 1) {
          ccipAddress = entries[i].emitter;
          break;
        }
      }
    }
    TOKEN_POOL = UpgradeableLockReleaseTokenPool(ccipAddress);

    _validateCcipTokenPool();
  }

  /// @dev Test lock and release actions, mocking CCIP calls
  function test_ccipTokenPool() public {
    vm.recordLogs();

    GovV3Helpers.executePayload(vm, address(proposal));

    // Fetch addresses
    Vm.Log[] memory entries = vm.getRecordedLogs();
    address ccipAddress;
    for (uint256 i = 0; i < entries.length; i++) {
      if (entries[i].topics[0] == Initialized.selector) {
        uint8 version = abi.decode(entries[i].data, (uint8));
        if (version == 1) {
          ccipAddress = entries[i].emitter;
          break;
        }
      }
    }
    TOKEN_POOL = UpgradeableLockReleaseTokenPool(ccipAddress);

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

    // Lock
    uint256 amount = 500_000e18; // 500K GHO
    deal(address(GHO), user, amount);
    uint64 arbChainSelector = proposal.CCIP_ARB_CHAIN_SELECTOR();

    assertEq(GHO.balanceOf(address(TOKEN_POOL)), 0);

    // mock router transfer of funds from user to token pool
    vm.prank(user);
    GHO.transfer(address(TOKEN_POOL), amount);

    vm.expectEmit(false, true, false, true, address(TOKEN_POOL));
    emit Locked(address(0), amount);

    vm.prank(ramp);
    TOKEN_POOL.lockOrBurn(user, bytes(''), amount, arbChainSelector, bytes(''));
    assertEq(GHO.balanceOf(address(TOKEN_POOL)), amount);
    assertEq(GHO.balanceOf(user), 0);

    // Release
    vm.expectEmit(true, true, true, true, address(GHO));
    emit Transfer(address(TOKEN_POOL), user, amount);

    vm.expectEmit(false, true, true, true, address(TOKEN_POOL));
    emit Released(address(0), user, amount);

    TOKEN_POOL.releaseOrMint(bytes(''), user, amount, arbChainSelector, bytes(''));
    assertEq(GHO.balanceOf(address(TOKEN_POOL)), 0);
    assertEq(GHO.balanceOf(user), amount);
  }

  /// @dev CCIP e2e
  function test_ccipE2E() public {
    vm.recordLogs();

    GovV3Helpers.executePayload(vm, address(proposal));

    // Fetch addresses
    Vm.Log[] memory entries = vm.getRecordedLogs();
    address ccipAddress;
    for (uint256 i = 0; i < entries.length; i++) {
      if (entries[i].topics[0] == Initialized.selector) {
        uint8 version = abi.decode(entries[i].data, (uint8));
        if (version == 1) {
          ccipAddress = entries[i].emitter;
          break;
        }
      }
    }
    TOKEN_POOL = UpgradeableLockReleaseTokenPool(ccipAddress);

    uint64 arbChainSelector = proposal.CCIP_ARB_CHAIN_SELECTOR();

    // Chainlink config
    Router router = Router(proposal.CCIP_ROUTER());

    {
      // OnRamp and OffRamp
      Router.OnRamp[] memory onRampUpdates = new Router.OnRamp[](1);
      Router.OffRamp[] memory offRampUpdates = new Router.OffRamp[](1);
      // ARB -> ETH
      onRampUpdates[0] = Router.OnRamp({
        destChainSelector: arbChainSelector,
        onRamp: CCIP_ETH_ON_RAMP
      });
      // ETH -> ARB
      offRampUpdates[0] = Router.OffRamp({
        sourceChainSelector: arbChainSelector,
        offRamp: CCIP_ETH_OFF_RAMP
      });
      address routerOwner = router.owner();
      vm.startPrank(routerOwner);
      router.applyRampUpdates(onRampUpdates, new Router.OffRamp[](0), offRampUpdates);
    }

    {
      // Add TokenPool to OnRamp
      address[] memory tokens = new address[](1);
      IPool[] memory pools = new IPool[](1);
      tokens[0] = address(GHO);
      pools[0] = IPool(address(TOKEN_POOL));
      address onRampOwner = EVM2EVMOnRamp(CCIP_ETH_ON_RAMP).owner();
      vm.startPrank(onRampOwner);
      EVM2EVMOnRamp(CCIP_ETH_ON_RAMP).applyPoolUpdates(
        new Internal.PoolUpdate[](0),
        _getTokensAndPools(tokens, pools)
      );
    }

    {
      // OnRamp Price Registry
      EVM2EVMOnRamp.DynamicConfig memory onRampDynamicConfig = EVM2EVMOnRamp(CCIP_ETH_ON_RAMP)
        .getDynamicConfig();
      Internal.PriceUpdates memory priceUpdate = _getSingleTokenPriceUpdateStruct(
        address(GHO),
        1e18
      );

      PriceRegistry(onRampDynamicConfig.priceRegistry).updatePrices(priceUpdate);
      // OffRamp Price Registry
      EVM2EVMOffRamp.DynamicConfig memory offRampDynamicConfig = EVM2EVMOffRamp(CCIP_ETH_OFF_RAMP)
        .getDynamicConfig();
      PriceRegistry(offRampDynamicConfig.priceRegistry).updatePrices(priceUpdate);
    }

    // User executes ccipSend
    address user = makeAddr('user');
    uint256 amount = 500_000e18; // 500K GHO
    deal(user, 1e18); // 1 ETH
    deal(address(GHO), user, amount);

    assertEq(GHO.balanceOf(address(TOKEN_POOL)), 0);
    assertEq(TOKEN_POOL.getBridgeLimit(), proposal.CCIP_BRIDGE_LIMIT());
    assertEq(TOKEN_POOL.getCurrentBridgedAmount(), 0);

    vm.startPrank(user);
    // Use address(0) to use native token as fee token
    _sendCcip(router, address(GHO), amount, address(0), arbChainSelector, user);

    assertEq(GHO.balanceOf(user), 0);
    assertEq(GHO.balanceOf(address(TOKEN_POOL)), amount);
    assertEq(TOKEN_POOL.getBridgeLimit(), proposal.CCIP_BRIDGE_LIMIT());
    assertEq(TOKEN_POOL.getCurrentBridgedAmount(), amount);
  }

  // ---
  // Test Helpers
  // ---

  function _validateCcipTokenPool() internal {
    // Deployment
    assertEq(_getProxyAdminAddress(address(TOKEN_POOL)), MiscEthereum.PROXY_ADMIN);
    assertEq(address(TOKEN_POOL.getToken()), address(GHO));
    assertEq(TOKEN_POOL.owner(), GovernanceV3Ethereum.EXECUTOR_LVL_1);
    assertEq(TOKEN_POOL.getArmProxy(), proposal.CCIP_ARM_PROXY());
    assertEq(TOKEN_POOL.getRouter(), proposal.CCIP_ROUTER());

    // Config
    uint64[] memory supportedChains = TOKEN_POOL.getSupportedChains();
    assertEq(supportedChains.length, 1);
    assertEq(supportedChains[0], proposal.CCIP_ARB_CHAIN_SELECTOR());
    RateLimiter.TokenBucket memory outboundRateLimit = TOKEN_POOL
      .getCurrentOutboundRateLimiterState(proposal.CCIP_ARB_CHAIN_SELECTOR());
    RateLimiter.TokenBucket memory inboundRateLimit = TOKEN_POOL.getCurrentInboundRateLimiterState(
      proposal.CCIP_ARB_CHAIN_SELECTOR()
    );
    assertEq(outboundRateLimit.isEnabled, false);
    assertEq(inboundRateLimit.isEnabled, false);
  }

  // ---
  // Utils
  // --

  function _getProxyAdminAddress(address proxy) internal view returns (address) {
    bytes32 ERC1967_ADMIN_SLOT = 0xb53127684a568b3173ae13b9f8a6016e243e63b6e8ee1178d6a717850b5d6103;
    bytes32 adminSlot = vm.load(proxy, ERC1967_ADMIN_SLOT);
    return address(uint160(uint256(adminSlot)));
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
    IPool[] memory pools
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
