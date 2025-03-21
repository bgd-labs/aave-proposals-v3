// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {IAccessControl} from 'openzeppelin-contracts/contracts/access/IAccessControl.sol';
import {AaveV3Optimism} from 'aave-address-book/AaveV3Optimism.sol';
import {IPoolDataProvider, IPriceOracleGetter} from 'aave-address-book/AaveV3.sol';
import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {DataTypes} from 'aave-v3-origin/contracts/protocol/libraries/types/DataTypes.sol';
import {ReserveConfiguration} from 'aave-v3-origin/contracts/protocol/libraries/configuration/ReserveConfiguration.sol';

import {Values} from './Values.sol';

/**
 * @title Finance Steward Deployment: Pool Exposure Module
 * @author @TokenLogic
 * - Snapshot: TODO
 * - Discussion: https://governance.aave.com/t/arfc-aave-finance-steward-deployment/21495
 */
contract AaveV3Optimism_FinanceStewardDeploymentPoolExposureModule_20250319 is
  IProposalGenericExecutor
{
  using ReserveConfiguration for DataTypes.ReserveConfigurationMap;

  uint256 public constant MIN_DOLLAR_VALUE = 100;

  function execute() external {
    address[] memory reserves = AaveV3Optimism.POOL.getReservesList();
    uint256 reservesLen = reserves.length;

    for (uint256 i = 0; i < reservesLen; i++) {
      address reserve = reserves[i];
      address aToken = AaveV3Optimism.POOL.getReserveAToken(reserve);
      DataTypes.ReserveConfigurationMap memory configuration = AaveV3Optimism.POOL.getConfiguration(
        reserve
      );
      (, , , uint256 decimals, ) = configuration.getParams();

      uint256 tokenAmount = Values.getTokenAmountByDollarValue(
        aToken,
        address(AaveV3Optimism.ORACLE),
        decimals,
        MIN_DOLLAR_VALUE
      );
      uint256 balanceDustBin = IERC20(aToken).balanceOf(AaveV3Optimism.DUST_BIN);

      if (balanceDustBin < tokenAmount) {
        AaveV3Optimism.COLLECTOR.transfer(
          IERC20(aToken),
          AaveV3Optimism.DUST_BIN,
          tokenAmount - balanceDustBin
        );
      }
    }

    // IAccessControl(address(AaveV3Optimism.COLLECTOR)).grantRole(
    //   'FUNDS_ADMIN',
    //   AaveV3Optimism.POOL_EXPOSURE_STEWARD
    // );
  }
}
