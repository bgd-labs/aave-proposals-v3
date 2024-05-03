// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import 'forge-std/Test.sol';
import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {AaveV2Ethereum, AaveV2EthereumAssets} from 'aave-address-book/AaveV2Ethereum.sol';
import {AaveV1} from 'aave-address-book/AaveV1.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV1Ethereum_AaveV1Deprecation_20240502} from './AaveV1Ethereum_AaveV1Deprecation_20240502.sol';

interface ILendingPool {
  function liquidationCall(
    address _collateral,
    address _reserve,
    address _user,
    uint256 _purchaseAmount,
    bool _receiveAToken
  ) external payable;

  function repay(address _reserve, uint256 _amount, address payable _onBehalfOf) external payable;

  function offboardingLiquidationCall(
    address _collateral,
    address _reserve,
    address _user,
    uint256 _purchaseAmount
  ) external payable;

  function getUserAccountData(
    address _user
  )
    external
    view
    returns (
      uint256 totalLiquidityETH,
      uint256 totalCollateralETH,
      uint256 totalBorrowsETH,
      uint256 totalFeesETH,
      uint256 availableBorrowsETH,
      uint256 currentLiquidationThreshold,
      uint256 ltv,
      uint256 healthFactor
    );

  function getReserveData(
    address _reserve
  )
    external
    view
    returns (
      uint256 totalLiquidity,
      uint256 availableLiquidity,
      uint256 totalBorrowsStable,
      uint256 totalBorrowsVariable,
      uint256 liquidityRate,
      uint256 variableBorrowRate,
      uint256 stableBorrowRate,
      uint256 averageStableBorrowRate,
      uint256 utilizationRate,
      uint256 liquidityIndex,
      uint256 variableBorrowIndex,
      address aTokenAddress,
      uint40 lastUpdateTimestamp
    );

  function getUserReserveData(
    address _reserve,
    address _user
  )
    external
    view
    returns (
      uint256 currentATokenBalance,
      uint256 currentBorrowBalance,
      uint256 principalBorrowBalance,
      uint256 borrowRateMode,
      uint256 borrowRate,
      uint256 liquidityRate,
      uint256 originationFee,
      uint256 variableBorrowIndex,
      uint256 lastUpdateTimestamp,
      bool usageAsCollateralEnabled
    );
}

interface IAToken {
  function redeem(uint256 _amount) external;
}

/**
 * @dev Test for AaveV1Ethereum_AaveV1Deprecation_20240502
 * command: make test-contract filter=AaveV1Ethereum_AaveV1Deprecation_20240502
 */
contract AaveV1Ethereum_AaveV1Deprecation_20240502_Test is ProtocolV3TestBase {
  AaveV1Ethereum_AaveV1Deprecation_20240502 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 19782461);
    proposal = new AaveV1Ethereum_AaveV1Deprecation_20240502();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    executePayload(vm, address(proposal));
  }

  struct V1User {
    address payable user;
    address collateral;
    address debt;
  }

  /**
   * Users should be liquidatable at 500bps penalty
   */
  function test_healthyLiquidateShouldUse500bpsLB() public {
    executePayload(vm, address(proposal));
    V1User[] memory users = _getUsers();
    for (uint256 i = 0; i < users.length; i++) {
      (, uint256 currentBorrowBalance, , , , , , , , ) = ILendingPool(AaveV1.POOL)
        .getUserReserveData(users[i].debt, users[i].user);
      // offboarding liquidations should provide a fixed 5% bonus
      (, uint256 totalCollateralETHBefore, uint256 totalBorrowsETHBefore, , , , , ) = ILendingPool(
        AaveV1.POOL
      ).getUserAccountData(users[i].user);
      if (users[i].debt == 0xEeeeeEeeeEeEeeEeEeEeeEEEeeeeEeeeeeeeEEeE) {
        deal(address(this), 1000 ether);
        ILendingPool(AaveV1.POOL).liquidationCall{value: currentBorrowBalance}(
          users[i].collateral,
          users[i].debt,
          users[i].user,
          type(uint256).max,
          false
        );
      } else {
        deal(users[i].debt, address(this), currentBorrowBalance);
        assertEq(currentBorrowBalance, IERC20(users[i].debt).balanceOf(address(this)));
        IERC20(users[i].debt).approve(proposal.ADDRESSES_PROVIDER().getLendingPoolCore(), 0);
        IERC20(users[i].debt).approve(
          proposal.ADDRESSES_PROVIDER().getLendingPoolCore(),
          type(uint256).max
        );
        ILendingPool(AaveV1.POOL).liquidationCall(
          users[i].collateral,
          users[i].debt,
          users[i].user,
          type(uint256).max,
          false
        );
      }
      (, uint256 totalCollateralETHAfter, uint256 totalBorrowsETHAfter, , , , , ) = ILendingPool(
        AaveV1.POOL
      ).getUserAccountData(users[i].user);

      uint256 collateralDiff = totalCollateralETHBefore - totalCollateralETHAfter;
      uint256 borrowsDiff = totalBorrowsETHBefore - totalBorrowsETHAfter;
      assertGt(collateralDiff, borrowsDiff);
      assertApproxEqAbs((borrowsDiff * 1 ether) / collateralDiff, 0.95 ether, 0.006 ether); // should be ~5% + rounding
    }
  }

  /**
   * Users should be able to repay their debt
   */
  function test_repay() public {
    executePayload(vm, address(proposal));

    V1User[] memory users = _getUsers();
    for (uint256 i = 0; i < users.length; i++) {
      vm.startPrank(users[i].user);

      // repay
      _repayV1(users[i].debt, users[i].user);

      vm.stopPrank();
    }
  }

  /**
   * Users should be able to redeem their collateral
   */
  function test_redeem() public {
    executePayload(vm, address(proposal));

    V1User[] memory users = _getUsers();

    for (uint256 i = 0; i < users.length; i++) {
      vm.startPrank(users[i].user);
      _repayV1(users[i].debt, users[i].user);

      // redeem
      _redeemV1(users[i].collateral, users[i].user, 100);

      vm.stopPrank();
    }
  }

  /**
   * Rates should be updated and rate should be zero
   */
  function test_rates() public {
    address[] memory reserves = proposal.CORE().getReserves();
    uint256 snapshot = vm.snapshot();
    for (uint256 i = 0; i < reserves.length; i++) {
      uint256 lIndexBefore = proposal.CORE().getReserveLiquidityCumulativeIndex(reserves[i]);
      uint256 vIndexBefore = proposal.CORE().getReserveVariableBorrowsCumulativeIndex(reserves[i]);
      executePayload(vm, address(proposal));
      uint256 lIndexAfter = proposal.CORE().getReserveLiquidityCumulativeIndex(reserves[i]);
      uint256 vIndexAfter = proposal.CORE().getReserveVariableBorrowsCumulativeIndex(reserves[i]);
      uint256 liquidityRateAfter = proposal.CORE().getReserveCurrentLiquidityRate(reserves[i]);
      uint256 variableRateAfter = proposal.CORE().getReserveCurrentVariableBorrowRate(reserves[i]);
      // uint256 stableRateAfter = proposal.CORE().getReserveCurrentStableBorrowRate(reserves[i]);

      assertEq(lIndexBefore, lIndexAfter);
      assertEq(vIndexBefore, vIndexAfter);
      assertEq(liquidityRateAfter, 0);
      assertEq(variableRateAfter, 0);
      // stable rate is non zero because the lendingRateOracle still has baseRate set
      // assertEq(stableRateAfter, 0);
      vm.revertTo(snapshot);
    }
  }

  /**
   * oracle prices should be approximately equal (1% diff allowed)
   */
  function test_oracle() public {
    address[] memory reserves = proposal.CORE().getReserves();
    uint256 snapshot = vm.snapshot();
    for (uint256 i = 0; i < reserves.length; i++) {
      uint256 priceBefore = proposal.ORACLE().getAssetPrice(reserves[i]);
      executePayload(vm, address(proposal));
      uint256 priceAfter = proposal.ORACLE().getAssetPrice(reserves[i]);

      assertApproxEqAbs(priceBefore, priceAfter, priceBefore / 100);
      vm.revertTo(snapshot);
    }
  }

  function _getUsers() internal pure returns (V1User[] memory) {
    V1User[] memory users = new V1User[](3);
    users[0] = V1User(
      payable(0x0675182195661f8FB984F61c98842628382702A0),
      AaveV2EthereumAssets.WBTC_UNDERLYING,
      AaveV2EthereumAssets.DAI_UNDERLYING
    );
    users[1] = V1User(
      payable(0x622a24C72e7810272D026b70f7ed08Ff8Db93Af6),
      0xEeeeeEeeeEeEeeEeEeEeeEEEeeeeEeeeeeeeEEeE,
      AaveV2EthereumAssets.BUSD_UNDERLYING
    );
    users[2] = V1User(
      payable(0x0db15b403AE023b1C9B07e95D9294710514292aC),
      0xEeeeeEeeeEeEeeEeEeEeeEEEeeeeEeeeeeeeEEeE,
      AaveV2EthereumAssets.USDC_UNDERLYING
    );
    return users;
  }

  function _repayV1(address debtAsset, address payable user) internal {
    (, uint256 currentBorrowBalance, , , , , uint256 originationFee, , , ) = ILendingPool(
      AaveV1.POOL
    ).getUserReserveData(debtAsset, user);
    uint256 debt = currentBorrowBalance + originationFee;
    if (debtAsset == 0xEeeeeEeeeEeEeeEeEeEeeEEEeeeeEeeeeeeeEEeE) {
      deal(user, debt);
      ILendingPool(AaveV1.POOL).repay{value: debt}(debtAsset, type(uint256).max, user);
    } else {
      deal(debtAsset, user, debt);
      IERC20(debtAsset).approve(proposal.ADDRESSES_PROVIDER().getLendingPoolCore(), 0);
      IERC20(debtAsset).approve(
        proposal.ADDRESSES_PROVIDER().getLendingPoolCore(),
        type(uint256).max
      );
      ILendingPool(AaveV1.POOL).repay(debtAsset, type(uint256).max, user);
    }
    (, uint256 currentBorrowBalanceAfter, , , , , uint256 originationFeeAfter, , , ) = ILendingPool(
      AaveV1.POOL
    ).getUserReserveData(debtAsset, user);
    assertEq(currentBorrowBalanceAfter + originationFeeAfter, 0, vm.toString(debtAsset));
  }

  function _redeemV1(address token, address user, uint256 amount) internal {
    (uint256 currentATokenBalance, , , , , , , , , ) = ILendingPool(AaveV1.POOL).getUserReserveData(
      token,
      user
    );
    address aToken = proposal.CORE().getReserveATokenAddress(token);
    IAToken(aToken).redeem(amount);
    (uint256 currentATokenBalanceAfter, , , , , , , , , ) = ILendingPool(AaveV1.POOL)
      .getUserReserveData(token, user);
    assertEq(currentATokenBalance - amount, currentATokenBalanceAfter);
  }

  fallback() external payable {}
}
