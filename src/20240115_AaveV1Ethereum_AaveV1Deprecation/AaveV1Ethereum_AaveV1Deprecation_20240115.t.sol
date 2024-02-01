// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import 'forge-std/Test.sol';
import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {ProtocolV2TestBase, ReserveConfig} from 'aave-helpers/ProtocolV2TestBase.sol';
import {AaveV1Ethereum_AaveV1Deprecation_20240115, ILendingPoolAddressesProvider, ILendingPoolCore} from './AaveV1Ethereum_AaveV1Deprecation_20240115.sol';

interface ILendingPool {
  function liquidationCall(
    address _collateral,
    address _reserve,
    address _user,
    uint256 _purchaseAmount,
    bool _receiveAToken
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

  function repay(address _reserve, uint256 _amount, address payable _onBehalfOf) external payable;
}

interface IAToken {
  function redeem(uint256 _amount) external;
}

/**
 * @dev Test for AaveV1Ethereum_AaveV1Deprecation_20240115
 * command: make test-contract filter=AaveV1Ethereum_AaveV1Deprecation_20240115
 */
contract AaveV1Ethereum_AaveV1Deprecation_20240115_Test is ProtocolV2TestBase {
  struct V1User {
    address payable user;
    address collateral;
    address debt;
  }

  ILendingPoolAddressesProvider public constant ADDRESSES_PROVIDER =
    ILendingPoolAddressesProvider(0x24a42fD28C976A61Df5D00D0599C34c4f90748c8);

  ILendingPoolCore public constant CORE =
    ILendingPoolCore(0x3dfd23A6c5E8BbcFc9581d2E864a68feb6a076d3);

  ILendingPool public constant POOL = ILendingPool(0x398eC7346DcD622eDc5ae82352F02bE94C62d119);

  AaveV1Ethereum_AaveV1Deprecation_20240115 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 19111804);
    proposal = new AaveV1Ethereum_AaveV1Deprecation_20240115();
  }

  /**
   * Check the IR is updated correctly
   */
  function test_ir() public {
    executePayload(vm, address(proposal));
    address[] memory reserves = CORE.getReserves();
    for (uint256 i = 0; i < reserves.length; i++) {
      assertEq(CORE.getReserveInterestRateStrategyAddress(reserves[i]), proposal.MINIMAL_IR());
    }
  }

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

  function test_redeem() public {
    executePayload(vm, address(proposal));
    V1User[] memory users = _getUsers();

    for (uint256 i = 0; i < users.length; i++) {
      vm.startPrank(users[i].user);

      // redeem
      _redeemV1(users[i].collateral, users[i].user, 100);

      vm.stopPrank();
    }
  }

  function _repayV1(address debtAsset, address payable user) internal {
    (, uint256 currentBorrowBalance, , , , , uint256 originationFee, , , ) = POOL
      .getUserReserveData(debtAsset, user);
    uint256 debt = currentBorrowBalance + originationFee;
    if (debtAsset == 0xEeeeeEeeeEeEeeEeEeEeeEEEeeeeEeeeeeeeEEeE) {
      deal(user, debt);
      POOL.repay{value: debt}(debtAsset, type(uint256).max, user);
    } else {
      deal2(debtAsset, user, debt);
      IERC20(debtAsset).approve(ADDRESSES_PROVIDER.getLendingPoolCore(), 0);
      IERC20(debtAsset).approve(ADDRESSES_PROVIDER.getLendingPoolCore(), type(uint256).max);
      POOL.repay(debtAsset, type(uint256).max, user);
    }
    (, uint256 currentBorrowBalanceAfter, , , , , uint256 originationFeeAfter, , , ) = POOL
      .getUserReserveData(debtAsset, user);
    assertEq(currentBorrowBalanceAfter + originationFeeAfter, 0, vm.toString(debtAsset));
  }

  function _redeemV1(address token, address user, uint256 amount) internal {
    (uint256 currentATokenBalance, , , , , , , , , ) = POOL.getUserReserveData(token, user);
    address aToken = CORE.getReserveATokenAddress(token);
    IAToken(aToken).redeem(amount);
    (uint256 currentATokenBalanceAfter, , , , , , , , , ) = POOL.getUserReserveData(token, user);
    assertEq(currentATokenBalance - amount, currentATokenBalanceAfter);
  }

  /**
   * check the liquidation mechanics work as intended
   */
  function test_testLiquidation() public {
    executePayload(vm, address(proposal));
    V1User[] memory users = _getUsers();
    for (uint256 i = 0; i < users.length; i++) {
      (, uint256 currentBorrowBalance, , , , , , , , ) = POOL.getUserReserveData(
        users[i].debt,
        users[i].user
      );
      // offboarding liquidations should provide a fixed 1% bonus
      (, uint256 totalCollateralETHBefore, uint256 totalBorrowsETHBefore, , , , , ) = POOL
        .getUserAccountData(users[i].user);
      if (users[i].debt == 0xEeeeeEeeeEeEeeEeEeEeeEEEeeeeEeeeeeeeEEeE) {
        deal(address(this), 1000 ether);
        POOL.liquidationCall{value: currentBorrowBalance}(
          users[i].collateral,
          users[i].debt,
          users[i].user,
          type(uint256).max,
          false
        );
      } else {
        deal2(users[i].debt, address(this), currentBorrowBalance);
        assertEq(currentBorrowBalance, IERC20(users[i].debt).balanceOf(address(this)));
        IERC20(users[i].debt).approve(ADDRESSES_PROVIDER.getLendingPoolCore(), 0);
        IERC20(users[i].debt).approve(ADDRESSES_PROVIDER.getLendingPoolCore(), type(uint256).max);
        POOL.liquidationCall(
          users[i].collateral,
          users[i].debt,
          users[i].user,
          type(uint256).max,
          false
        );
      }
      (, uint256 totalCollateralETHAfter, uint256 totalBorrowsETHAfter, , , , , ) = POOL
        .getUserAccountData(users[i].user);

      uint256 collateralDiff = totalCollateralETHBefore - totalCollateralETHAfter;
      uint256 borrowsDiff = totalBorrowsETHBefore - totalBorrowsETHAfter;
      assertGt(collateralDiff, borrowsDiff);
      assertApproxEqAbs((borrowsDiff * 1 ether) / collateralDiff, 0.99 ether, 0.001 ether); // should be ~1% + rounding
    }
  }

  function _getUsers() internal returns (V1User[] memory) {
    V1User[] memory users = new V1User[](4);
    users[0] = V1User(
      payable(0x1F0aeAeE69468727BA258B0cf692E6bfecc2E286),
      0x514910771AF9Ca656af840dff83E8264EcF986CA, // LINK
      0x0000000000085d4780B73119b644AE5ecd22b376 // TUSD
    );
    users[1] = V1User(
      payable(0x1F0aeAeE69468727BA258B0cf692E6bfecc2E286),
      0x514910771AF9Ca656af840dff83E8264EcF986CA, // LINK
      0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48 // USDC
    );
    users[2] = V1User(
      payable(0x310D5C8EE1512D5092ee4377061aE82E48973689),
      0x2260FAC5E5542a773Aa44fBCfeDf7C193bc2C599, // WBTC
      0xEeeeeEeeeEeEeeEeEeEeeEEEeeeeEeeeeeeeEEeE // weth
    );
    users[3] = V1User(
      payable(0xb570de1e7f1696DE9623e1784122EBCA1d6907e5),
      0x514910771AF9Ca656af840dff83E8264EcF986CA, // LINK
      0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48 // USDC
    );
    return users;
  }
}
