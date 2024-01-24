// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import 'forge-std/Test.sol';
import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {ProtocolV2TestBase, ReserveConfig} from 'aave-helpers/ProtocolV2TestBase.sol';
import {AaveV1Ethereum_AaveV1Deprecation_20240115} from './AaveV1Ethereum_AaveV1Deprecation_20240115.sol';

interface ILendingPoolAddressesProvider {
  function getLendingPoolCore() external view returns (address);

  function getLendingPool() external view returns (address);

  function getLendingPoolLiquidationManager() external view returns (address);
}

interface ILendingPool {
  function liquidationCall(
    address _collateral,
    address _reserve,
    address _user,
    uint256 _purchaseAmount,
    bool _receiveAToken
  ) external payable;

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

/**
 * @dev Test for AaveV1Ethereum_AaveV1Deprecation_20240115
 * command: make test-contract filter=AaveV1Ethereum_AaveV1Deprecation_20240115
 */
contract AaveV1Ethereum_AaveV1Deprecation_20240115_Test is ProtocolV2TestBase {
  struct V1User {
    address user;
    address collateral;
    address debt;
  }

  ILendingPoolAddressesProvider public constant ADDRESSES_PROVIDER =
    ILendingPoolAddressesProvider(0x24a42fD28C976A61Df5D00D0599C34c4f90748c8);

  ILendingPool public constant POOL = ILendingPool(0x398eC7346DcD622eDc5ae82352F02bE94C62d119);

  AaveV1Ethereum_AaveV1Deprecation_20240115 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 19075684);
    proposal = new AaveV1Ethereum_AaveV1Deprecation_20240115();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    executePayload(vm, address(proposal));
    V1User[] memory users = new V1User[](1);
    users[0] = V1User(
      0x1F0aeAeE69468727BA258B0cf692E6bfecc2E286,
      0x514910771AF9Ca656af840dff83E8264EcF986CA, // LINK
      0x0000000000085d4780B73119b644AE5ecd22b376 // TUSD
    );
    for (uint256 i = 0; i < users.length; i++) {
      (, uint256 currentBorrowBalance, , , , , , , , ) = POOL.getUserReserveData(
        users[i].debt,
        users[i].user
      );
      deal(users[i].debt, address(this), currentBorrowBalance);
      // offboarding liquidations should provide a fixed 1% bonus
      (, uint256 totalCollateralETHBefore, uint256 totalBorrowsETHBefore, , , , , ) = POOL
        .getUserAccountData(users[i].user);
      IERC20(users[i].debt).approve(ADDRESSES_PROVIDER.getLendingPoolCore(), type(uint256).max);
      POOL.liquidationCall(
        users[i].collateral,
        users[i].debt,
        users[i].user,
        type(uint256).max,
        false
      );
      (, uint256 totalCollateralETHAfter, uint256 totalBorrowsETHAfter, , , , , ) = POOL
        .getUserAccountData(users[i].user);

      uint256 collateralDiff = totalCollateralETHBefore - totalCollateralETHAfter;
      uint256 borrowsDiff = totalBorrowsETHBefore - totalBorrowsETHAfter;
      assertGt(collateralDiff, borrowsDiff);
      assertApproxEqAbs((borrowsDiff * 1 ether) / collateralDiff, 0.99 ether, 0.001 ether); // should be ~1% + rounding
    }
  }
}
