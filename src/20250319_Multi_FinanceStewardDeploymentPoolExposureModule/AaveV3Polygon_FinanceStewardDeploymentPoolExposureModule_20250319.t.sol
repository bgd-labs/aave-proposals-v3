// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {IAccessControl} from 'openzeppelin-contracts/contracts/access/IAccessControl.sol';
import {AaveV2Polygon, AaveV2PolygonAssets} from 'aave-address-book/AaveV2Polygon.sol';
import {AaveV3Polygon, AaveV3PolygonAssets} from 'aave-address-book/AaveV3Polygon.sol';
import {IPriceOracleGetter} from 'aave-address-book/AaveV3.sol';
import {ProtocolV3TestBase} from 'aave-helpers/src/ProtocolV3TestBase.sol';

import {AaveV3Polygon_FinanceStewardDeploymentPoolExposureModule_20250319} from './AaveV3Polygon_FinanceStewardDeploymentPoolExposureModule_20250319.sol';
import {BalanceChecker} from './BalanceChecker.sol';
import {Values} from './Values.sol';

/**
 * @dev Test for AaveV3Polygon_FinanceStewardDeploymentPoolExposureModule_20250319
 * command: FOUNDRY_PROFILE=polygon forge test --match-path=src/20250319_Multi_FinanceStewardDeploymentPoolExposureModule/AaveV3Polygon_FinanceStewardDeploymentPoolExposureModule_20250319.t.sol -vv
 */
contract AaveV3Polygon_FinanceStewardDeploymentPoolExposureModule_20250319_Test is BalanceChecker {
  AaveV3Polygon_FinanceStewardDeploymentPoolExposureModule_20250319 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('polygon'), 69238268);
    proposal = new AaveV3Polygon_FinanceStewardDeploymentPoolExposureModule_20250319();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Polygon_FinanceStewardDeploymentPoolExposureModule_20250319',
      AaveV3Polygon.POOL,
      address(proposal)
    );
  }

  function test_accessGranted() public {
    assertFalse(
      IAccessControl(address(AaveV3Polygon.COLLECTOR)).hasRole(
        'FUNDS_ADMIN',
        AaveV3Polygon.POOL_EXPOSURE_STEWARD
      )
    );

    executePayload(vm, address(proposal));

    assertTrue(
      IAccessControl(address(AaveV3Polygon.COLLECTOR)).hasRole(
        'FUNDS_ADMIN',
        AaveV3Polygon.POOL_EXPOSURE_STEWARD
      )
    );
  }

  function test_allReservesHaveEnoughBalanceOnDustBin() public {
    executePayload(vm, address(proposal));

    assertBalances(AaveV3Polygon.POOL, address(AaveV3Polygon.ORACLE), AaveV3Polygon.DUST_BIN);
  }

  function test_allReservesHaveEnoughBalanceOnDustBinV2() public {
    executePayload(vm, address(proposal));

    TestBalance tester = new TestBalance();

    address[] memory reserves = AaveV2Polygon.POOL.getReservesList();
    uint256 reservesLen = reserves.length;
    uint256 ethPrice = IPriceOracleGetter(address(AaveV3Polygon.ORACLE)).getAssetPrice(
      AaveV3PolygonAssets.WETH_UNDERLYING
    );

    for (uint256 i = 0; i < reservesLen; i++) {
      address reserve = reserves[i];

      // Collector does not hold any balance
      if (
        reserve == AaveV2PolygonAssets.AAVE_UNDERLYING ||
        reserve == AaveV2PolygonAssets.DPI_UNDERLYING ||
        reserve == AaveV2PolygonAssets.SUSHI_UNDERLYING
      ) {
        continue;
      }

      (address aToken, , ) = AaveV2Polygon.AAVE_PROTOCOL_DATA_PROVIDER.getReserveTokensAddresses(
        reserve
      );
      (uint256 decimals, , , , , , , , , ) = AaveV2Polygon
        .AAVE_PROTOCOL_DATA_PROVIDER
        .getReserveConfigurationData(reserve);

      uint256 tokenAmount = Values.getTokenAmountByDollarValueEthOracle(
        reserve,
        address(AaveV2Polygon.ORACLE),
        decimals,
        100,
        ethPrice
      );
      uint256 balanceDustBin = IERC20(aToken).balanceOf(AaveV3Polygon.DUST_BIN);

      try tester.isGreaterThanOrEqual(balanceDustBin, tokenAmount) {} catch {
        assertGt(balanceDustBin, 0, 'v2 aToken does not have greater than 0 balance in dust bin');
      }
    }
  }
}

contract TestBalance is ProtocolV3TestBase {
  function isGreaterThanOrEqual(uint256 balanceDustBin, uint256 minTokenAmount) public pure {
    assertGe(balanceDustBin, minTokenAmount, 'a token does not have greater than $100 in dust bin');
  }
}
