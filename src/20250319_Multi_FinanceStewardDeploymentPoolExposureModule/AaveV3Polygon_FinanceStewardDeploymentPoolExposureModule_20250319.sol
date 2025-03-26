// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {IERC20 as IERC20D} from 'forge-std/interfaces/IERC20.sol';
import {IAccessControl} from 'openzeppelin-contracts/contracts/access/IAccessControl.sol';
import {AaveV2Polygon, AaveV2PolygonAssets} from 'aave-address-book/AaveV2Polygon.sol';
import {AaveV3Polygon, AaveV3PolygonAssets} from 'aave-address-book/AaveV3Polygon.sol';
import {IPriceOracleGetter} from 'aave-address-book/AaveV3.sol';
import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {DataTypes} from 'aave-v3-origin/contracts/protocol/libraries/types/DataTypes.sol';
import {ReserveConfiguration} from 'aave-v3-origin/contracts/protocol/libraries/configuration/ReserveConfiguration.sol';

import {DustBinSender} from './DustBinSender.sol';
import {Values} from './Values.sol';

/**
 * @title Finance Steward Deployment: Pool Exposure Module
 * @author @TokenLogic
 * - Snapshot: https://snapshot.box/#/s:aave.eth/proposal/0x1730ba3a2dd1f7b0b00cfae01b0c9f1bb7494b848c5de517275e2c72cf8c7b4d
 * - Discussion: https://governance.aave.com/t/arfc-aave-finance-steward-deployment/21495
 */
contract AaveV3Polygon_FinanceStewardDeploymentPoolExposureModule_20250319 is
  IProposalGenericExecutor,
  DustBinSender
{
  using ReserveConfiguration for DataTypes.ReserveConfigurationMap;

  function execute() external {
    send(
      AaveV3Polygon.POOL,
      AaveV3Polygon.COLLECTOR,
      address(AaveV3Polygon.ORACLE),
      AaveV3Polygon.DUST_BIN
    );

    uint256 ethPrice = IPriceOracleGetter(address(AaveV3Polygon.ORACLE)).getAssetPrice(
      AaveV3PolygonAssets.WETH_UNDERLYING
    );

    address[] memory reserves = AaveV2Polygon.POOL.getReservesList();
    uint256 reservesLen = reserves.length;

    for (uint256 i = 0; i < reservesLen; i++) {
      address reserve = reserves[i];
      (address aToken, , ) = AaveV2Polygon.AAVE_PROTOCOL_DATA_PROVIDER.getReserveTokensAddresses(
        reserve
      );
      uint256 decimals = IERC20D(reserve).decimals();
      uint256 tokenAmount = Values.getTokenAmountByDollarValueEthOracle(
        reserve,
        address(AaveV2Polygon.ORACLE),
        decimals,
        MIN_DOLLAR_VALUE,
        ethPrice
      );
      uint256 balanceDustBin = IERC20(aToken).balanceOf(AaveV3Polygon.DUST_BIN);

      if (balanceDustBin < tokenAmount) {
        uint256 balanceCollector = IERC20(aToken).balanceOf(address(AaveV3Polygon.COLLECTOR));
        if (balanceCollector > 0) {
          uint256 toSend = tokenAmount - balanceDustBin;
          AaveV3Polygon.COLLECTOR.transfer(
            IERC20(aToken),
            AaveV3Polygon.DUST_BIN,
            balanceCollector >= toSend ? toSend : balanceCollector
          );
        }
      }
    }

    IAccessControl(address(AaveV3Polygon.COLLECTOR)).grantRole(
      'FUNDS_ADMIN',
      AaveV3Polygon.POOL_EXPOSURE_STEWARD
    );
  }
}
