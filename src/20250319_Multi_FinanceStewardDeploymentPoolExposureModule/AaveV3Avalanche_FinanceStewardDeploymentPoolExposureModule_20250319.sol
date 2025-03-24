// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {IAccessControl} from 'openzeppelin-contracts/contracts/access/IAccessControl.sol';
import {AaveV2Avalanche, AaveV2AvalancheAssets} from 'aave-address-book/AaveV2Avalanche.sol';
import {AaveV3Avalanche, AaveV3AvalancheAssets} from 'aave-address-book/AaveV3Avalanche.sol';
import {IPriceOracleGetter} from 'aave-address-book/AaveV3.sol';
import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {DataTypes} from 'aave-v3-origin/contracts/protocol/libraries/types/DataTypes.sol';
import {ReserveConfiguration} from 'aave-v3-origin/contracts/protocol/libraries/configuration/ReserveConfiguration.sol';

import {Values} from './Values.sol';

/**
 * @title Finance Steward Deployment: Pool Exposure Module
 * @author @TokenLogic
 * - Snapshot: https://snapshot.box/#/s:aave.eth/proposal/0x1730ba3a2dd1f7b0b00cfae01b0c9f1bb7494b848c5de517275e2c72cf8c7b4d
 * - Discussion: https://governance.aave.com/t/arfc-aave-finance-steward-deployment/21495
 */
contract AaveV3Avalanche_FinanceStewardDeploymentPoolExposureModule_20250319 is
  IProposalGenericExecutor
{
  using ReserveConfiguration for DataTypes.ReserveConfigurationMap;

  uint256 public constant MIN_DOLLAR_VALUE = 100;

  function execute() external {
    address[] memory reserves = AaveV3Avalanche.POOL.getReservesList();
    uint256 reservesLen = reserves.length;

    for (uint256 i = 0; i < reservesLen; i++) {
      address reserve = reserves[i];
      address aToken = AaveV3Avalanche.POOL.getReserveAToken(reserve);
      DataTypes.ReserveConfigurationMap memory configuration = AaveV3Avalanche
        .POOL
        .getConfiguration(reserve);
      (, , , uint256 decimals, ) = configuration.getParams();

      uint256 tokenAmount = Values.getTokenAmountByDollarValue(
        reserve,
        address(AaveV3Avalanche.ORACLE),
        decimals,
        MIN_DOLLAR_VALUE
      );
      uint256 balanceDustBin = IERC20(aToken).balanceOf(AaveV3Avalanche.DUST_BIN);

      if (balanceDustBin < tokenAmount) {
        uint256 balanceCollector = IERC20(aToken).balanceOf(address(AaveV3Avalanche.COLLECTOR));
        uint256 toSend = tokenAmount - balanceDustBin;
        AaveV3Avalanche.COLLECTOR.transfer(
          IERC20(aToken),
          AaveV3Avalanche.DUST_BIN,
          balanceCollector >= toSend ? toSend : balanceCollector
        );
      }
    }

    uint256 ethPrice = IPriceOracleGetter(address(AaveV3Avalanche.ORACLE)).getAssetPrice(
      AaveV3AvalancheAssets.WETHe_UNDERLYING
    );

    reserves = AaveV2Avalanche.POOL.getReservesList();
    reservesLen = reserves.length;

    for (uint256 i = 0; i < reservesLen; i++) {
      address reserve = reserves[i];

      (address aToken, , ) = AaveV2Avalanche.AAVE_PROTOCOL_DATA_PROVIDER.getReserveTokensAddresses(
        reserve
      );
      (uint256 decimals, , , , , , , , , ) = AaveV2Avalanche
        .AAVE_PROTOCOL_DATA_PROVIDER
        .getReserveConfigurationData(reserve);

      uint256 tokenAmount = Values.getTokenAmountByDollarValueEthOracle(
        reserve,
        address(AaveV2Avalanche.ORACLE),
        decimals,
        MIN_DOLLAR_VALUE,
        ethPrice
      );
      uint256 balanceDustBin = IERC20(aToken).balanceOf(AaveV3Avalanche.DUST_BIN);

      if (balanceDustBin < tokenAmount) {
        uint256 balanceCollector = IERC20(aToken).balanceOf(address(AaveV3Avalanche.COLLECTOR));
        uint256 toSend = tokenAmount - balanceDustBin;
        AaveV3Avalanche.COLLECTOR.transfer(
          IERC20(aToken),
          AaveV3Avalanche.DUST_BIN,
          balanceCollector >= toSend ? toSend : balanceCollector
        );
      }
    }

    IAccessControl(address(AaveV3Avalanche.COLLECTOR)).grantRole(
      'FUNDS_ADMIN',
      AaveV3Avalanche.POOL_EXPOSURE_STEWARD
    );
  }
}
