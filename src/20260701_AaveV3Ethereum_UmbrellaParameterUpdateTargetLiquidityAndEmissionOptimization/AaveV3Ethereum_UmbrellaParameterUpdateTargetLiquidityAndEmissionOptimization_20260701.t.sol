// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {UmbrellaEthereum, UmbrellaEthereumAssets} from 'aave-address-book/UmbrellaEthereum.sol';
import {IUmbrella} from 'aave-address-book/common/IUmbrella.sol';
import {IRewardsController} from 'aave-umbrella/rewards/interfaces/IRewardsController.sol';
import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Ethereum_UmbrellaParameterUpdateTargetLiquidityAndEmissionOptimization_20260701} from './AaveV3Ethereum_UmbrellaParameterUpdateTargetLiquidityAndEmissionOptimization_20260701.sol';

/**
 * @dev Test for AaveV3Ethereum_UmbrellaParameterUpdateTargetLiquidityAndEmissionOptimization_20260701
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20260701_AaveV3Ethereum_UmbrellaParameterUpdateTargetLiquidityAndEmissionOptimization/AaveV3Ethereum_UmbrellaParameterUpdateTargetLiquidityAndEmissionOptimization_20260701.t.sol -vv
 */
contract AaveV3Ethereum_UmbrellaParameterUpdateTargetLiquidityAndEmissionOptimization_20260701_Test is
  ProtocolV3TestBase
{
  IRewardsController internal constant REWARDS_CONTROLLER =
    IRewardsController(UmbrellaEthereum.UMBRELLA_REWARDS_CONTROLLER);

  // Expected per-second rates: ARFC annual budget / 365 days rounded down.
  uint256 internal constant USDT_EXPECTED_EMISSION = 40588; // 1.28M aEthUSDT / year
  uint256 internal constant USDC_EXPECTED_EMISSION = 38685; // 1.22M aEthUSDC / year
  uint256 internal constant WETH_EXPECTED_EMISSION = 14903602232369; // 470 aEthWETH / year

  // Live Umbrella config at the fork block.
  uint256 internal constant USDT_CURRENT_TARGET_LIQUIDITY = 92_413_776e6;
  uint256 internal constant USDC_CURRENT_TARGET_LIQUIDITY = 58_330_074e6;
  uint256 internal constant WETH_CURRENT_TARGET_LIQUIDITY = 23_893.07490733916715e18;
  uint256 internal constant GHO_CURRENT_TARGET_LIQUIDITY = 12_000_000e18;

  uint256 internal constant USDT_CURRENT_EMISSION = 116_374; // 3.67M aEthUSDT / year
  uint256 internal constant USDC_CURRENT_EMISSION = 73_883; // 2.33M aEthUSDC / year
  uint256 internal constant WETH_CURRENT_EMISSION = 17_440_385_591_070; // 550 aEthWETH / year
  uint256 internal constant GHO_CURRENT_EMISSION = 38_051_750_380_517_503; // 1.2M GHO / year

  AaveV3Ethereum_UmbrellaParameterUpdateTargetLiquidityAndEmissionOptimization_20260701
    internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 25439286);
    proposal = new AaveV3Ethereum_UmbrellaParameterUpdateTargetLiquidityAndEmissionOptimization_20260701();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   * forge-config: default.isolate = true
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Ethereum_UmbrellaParameterUpdateTargetLiquidityAndEmissionOptimization_20260701',
      AaveV3Ethereum.POOL,
      address(proposal)
    );
  }

  function test_targetLiquidityUpdated() public {
    assertEq(
      _targetLiquidity(UmbrellaEthereumAssets.STK_WA_USDT_V1),
      USDT_CURRENT_TARGET_LIQUIDITY
    );
    assertEq(
      _targetLiquidity(UmbrellaEthereumAssets.STK_WA_USDC_V1),
      USDC_CURRENT_TARGET_LIQUIDITY
    );
    assertEq(
      _targetLiquidity(UmbrellaEthereumAssets.STK_WA_WETH_V1),
      WETH_CURRENT_TARGET_LIQUIDITY
    );
    assertEq(_targetLiquidity(UmbrellaEthereumAssets.STK_GHO_V1), GHO_CURRENT_TARGET_LIQUIDITY);

    executePayload(vm, address(proposal));

    assertEq(
      _targetLiquidity(UmbrellaEthereumAssets.STK_WA_USDT_V1),
      proposal.STATA_USDT_TARGET_LIQUIDITY()
    );
    assertEq(
      _targetLiquidity(UmbrellaEthereumAssets.STK_WA_USDC_V1),
      proposal.STATA_USDC_TARGET_LIQUIDITY()
    );
    assertEq(
      _targetLiquidity(UmbrellaEthereumAssets.STK_WA_WETH_V1),
      proposal.STATA_WETH_TARGET_LIQUIDITY()
    );
    assertEq(_targetLiquidity(UmbrellaEthereumAssets.STK_GHO_V1), proposal.GHO_TARGET_LIQUIDITY());
  }

  function test_maxEmissionPerSecondUpdated() public {
    assertEq(
      _emission(UmbrellaEthereumAssets.STK_WA_USDT_V1, AaveV3EthereumAssets.USDT_A_TOKEN),
      USDT_CURRENT_EMISSION
    );
    assertEq(
      _emission(UmbrellaEthereumAssets.STK_WA_USDC_V1, AaveV3EthereumAssets.USDC_A_TOKEN),
      USDC_CURRENT_EMISSION
    );
    assertEq(
      _emission(UmbrellaEthereumAssets.STK_WA_WETH_V1, AaveV3EthereumAssets.WETH_A_TOKEN),
      WETH_CURRENT_EMISSION
    );
    assertEq(
      _emission(UmbrellaEthereumAssets.STK_GHO_V1, AaveV3EthereumAssets.GHO_UNDERLYING),
      GHO_CURRENT_EMISSION
    );

    executePayload(vm, address(proposal));

    assertEq(
      _emission(UmbrellaEthereumAssets.STK_WA_USDT_V1, AaveV3EthereumAssets.USDT_A_TOKEN),
      USDT_EXPECTED_EMISSION
    );
    assertEq(
      _emission(UmbrellaEthereumAssets.STK_WA_USDC_V1, AaveV3EthereumAssets.USDC_A_TOKEN),
      USDC_EXPECTED_EMISSION
    );
    assertEq(
      _emission(UmbrellaEthereumAssets.STK_WA_WETH_V1, AaveV3EthereumAssets.WETH_A_TOKEN),
      WETH_EXPECTED_EMISSION
    );
    assertEq(_emission(UmbrellaEthereumAssets.STK_GHO_V1, AaveV3EthereumAssets.GHO_UNDERLYING), 0);
  }

  function test_distributionEndUnchanged() public {
    uint256 usdtBefore = _distributionEnd(
      UmbrellaEthereumAssets.STK_WA_USDT_V1,
      AaveV3EthereumAssets.USDT_A_TOKEN
    );
    uint256 usdcBefore = _distributionEnd(
      UmbrellaEthereumAssets.STK_WA_USDC_V1,
      AaveV3EthereumAssets.USDC_A_TOKEN
    );
    uint256 wethBefore = _distributionEnd(
      UmbrellaEthereumAssets.STK_WA_WETH_V1,
      AaveV3EthereumAssets.WETH_A_TOKEN
    );

    executePayload(vm, address(proposal));

    assertEq(
      _distributionEnd(UmbrellaEthereumAssets.STK_WA_USDT_V1, AaveV3EthereumAssets.USDT_A_TOKEN),
      usdtBefore
    );
    assertEq(
      _distributionEnd(UmbrellaEthereumAssets.STK_WA_USDC_V1, AaveV3EthereumAssets.USDC_A_TOKEN),
      usdcBefore
    );
    assertEq(
      _distributionEnd(UmbrellaEthereumAssets.STK_WA_WETH_V1, AaveV3EthereumAssets.WETH_A_TOKEN),
      wethBefore
    );
  }

  function test_ghoRewardDisabled() public {
    assertGt(
      _distributionEnd(UmbrellaEthereumAssets.STK_GHO_V1, AaveV3EthereumAssets.GHO_UNDERLYING),
      vm.getBlockTimestamp()
    );

    executePayload(vm, address(proposal));

    // Disabling a reward cuts its distributionEnd to the execution timestamp.
    assertEq(
      _distributionEnd(UmbrellaEthereumAssets.STK_GHO_V1, AaveV3EthereumAssets.GHO_UNDERLYING),
      vm.getBlockTimestamp()
    );
  }

  function test_ghoDeficitOffsetIncreased() public {
    assertLt(
      IUmbrella(UmbrellaEthereum.UMBRELLA).getDeficitOffset(AaveV3EthereumAssets.GHO_UNDERLYING),
      proposal.GHO_DEFICIT_OFFSET()
    );

    executePayload(vm, address(proposal));

    assertEq(
      IUmbrella(UmbrellaEthereum.UMBRELLA).getDeficitOffset(AaveV3EthereumAssets.GHO_UNDERLYING),
      proposal.GHO_DEFICIT_OFFSET()
    );
  }

  function test_rewardPayerSetToCollector() public {
    uint256 usdtDistEnd = _distributionEnd(
      UmbrellaEthereumAssets.STK_WA_USDT_V1,
      AaveV3EthereumAssets.USDT_A_TOKEN
    );
    uint256 usdcDistEnd = _distributionEnd(
      UmbrellaEthereumAssets.STK_WA_USDC_V1,
      AaveV3EthereumAssets.USDC_A_TOKEN
    );
    uint256 wethDistEnd = _distributionEnd(
      UmbrellaEthereumAssets.STK_WA_WETH_V1,
      AaveV3EthereumAssets.WETH_A_TOKEN
    );

    vm.expectEmit(UmbrellaEthereum.UMBRELLA_REWARDS_CONTROLLER);
    emit IRewardsController.RewardConfigUpdated(
      UmbrellaEthereumAssets.STK_WA_USDT_V1,
      AaveV3EthereumAssets.USDT_A_TOKEN,
      USDT_EXPECTED_EMISSION,
      usdtDistEnd,
      address(AaveV3Ethereum.COLLECTOR)
    );
    vm.expectEmit(UmbrellaEthereum.UMBRELLA_REWARDS_CONTROLLER);
    emit IRewardsController.RewardConfigUpdated(
      UmbrellaEthereumAssets.STK_WA_USDC_V1,
      AaveV3EthereumAssets.USDC_A_TOKEN,
      USDC_EXPECTED_EMISSION,
      usdcDistEnd,
      address(AaveV3Ethereum.COLLECTOR)
    );
    vm.expectEmit(UmbrellaEthereum.UMBRELLA_REWARDS_CONTROLLER);
    emit IRewardsController.RewardConfigUpdated(
      UmbrellaEthereumAssets.STK_WA_WETH_V1,
      AaveV3EthereumAssets.WETH_A_TOKEN,
      WETH_EXPECTED_EMISSION,
      wethDistEnd,
      address(AaveV3Ethereum.COLLECTOR)
    );
    vm.expectEmit(true, true, true, false, UmbrellaEthereum.UMBRELLA_REWARDS_CONTROLLER);
    emit IRewardsController.RewardConfigUpdated(
      UmbrellaEthereumAssets.STK_GHO_V1,
      AaveV3EthereumAssets.GHO_UNDERLYING,
      0,
      0,
      address(0)
    );

    executePayload(vm, address(proposal));
  }

  function test_rewardAllowancesRenewed() public {
    address collector = address(AaveV3Ethereum.COLLECTOR);
    address rewardsController = UmbrellaEthereum.UMBRELLA_REWARDS_CONTROLLER;

    uint256 usdtBefore = IERC20(AaveV3EthereumAssets.USDT_A_TOKEN).allowance(
      collector,
      rewardsController
    );
    uint256 usdcBefore = IERC20(AaveV3EthereumAssets.USDC_A_TOKEN).allowance(
      collector,
      rewardsController
    );

    assertGt(usdtBefore, 0);
    assertGt(usdcBefore, 0);

    executePayload(vm, address(proposal));

    assertEq(
      IERC20(AaveV3EthereumAssets.USDT_A_TOKEN).allowance(collector, rewardsController) -
        usdtBefore,
      proposal.USDT_RENEWAL_ALLOWANCE()
    );
    assertEq(
      IERC20(AaveV3EthereumAssets.USDC_A_TOKEN).allowance(collector, rewardsController) -
        usdcBefore,
      proposal.USDC_RENEWAL_ALLOWANCE()
    );
  }

  function test_rewardAllowancesSufficient() public {
    address collector = address(AaveV3Ethereum.COLLECTOR);
    address rewardsController = UmbrellaEthereum.UMBRELLA_REWARDS_CONTROLLER;

    executePayload(vm, address(proposal));

    assertGe(
      IERC20(AaveV3EthereumAssets.USDT_A_TOKEN).allowance(collector, rewardsController),
      _maxOutstandingRewards(
        UmbrellaEthereumAssets.STK_WA_USDT_V1,
        AaveV3EthereumAssets.USDT_A_TOKEN
      )
    );
    assertGe(
      IERC20(AaveV3EthereumAssets.USDC_A_TOKEN).allowance(collector, rewardsController),
      _maxOutstandingRewards(
        UmbrellaEthereumAssets.STK_WA_USDC_V1,
        AaveV3EthereumAssets.USDC_A_TOKEN
      )
    );
  }

  function _targetLiquidity(address stakeToken) internal view returns (uint256) {
    return REWARDS_CONTROLLER.getAssetData(stakeToken).targetLiquidity;
  }

  function _emission(address stakeToken, address reward) internal view returns (uint256) {
    return REWARDS_CONTROLLER.getRewardData(stakeToken, reward).maxEmissionPerSecond;
  }

  function _distributionEnd(address stakeToken, address reward) internal view returns (uint256) {
    return REWARDS_CONTROLLER.getRewardData(stakeToken, reward).distributionEnd;
  }

  function _maxOutstandingRewards(
    address stakeToken,
    address reward
  ) internal view returns (uint256) {
    return
      _emission(stakeToken, reward) *
      (_distributionEnd(stakeToken, reward) - vm.getBlockTimestamp());
  }
}
