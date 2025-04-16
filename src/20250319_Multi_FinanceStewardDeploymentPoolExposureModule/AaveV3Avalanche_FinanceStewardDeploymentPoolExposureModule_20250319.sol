// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {IERC20 as IERC20D} from 'forge-std/interfaces/IERC20.sol';
import {IAccessControl} from 'openzeppelin-contracts/contracts/access/IAccessControl.sol';
import {AaveV2Avalanche, AaveV2AvalancheAssets} from 'aave-address-book/AaveV2Avalanche.sol';
import {AaveV3Avalanche, AaveV3AvalancheAssets} from 'aave-address-book/AaveV3Avalanche.sol';
import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {ReserveConfiguration} from 'aave-v3-origin/contracts/protocol/libraries/configuration/ReserveConfiguration.sol';

import {DustBinSender} from './DustBinSender.sol';
import {Values} from './Values.sol';

/**
 * @title Finance Steward Deployment: Pool Exposure Module
 * @author @TokenLogic
 * - Snapshot: https://snapshot.box/#/s:aave.eth/proposal/0x1730ba3a2dd1f7b0b00cfae01b0c9f1bb7494b848c5de517275e2c72cf8c7b4d
 * - Discussion: https://governance.aave.com/t/arfc-aave-finance-steward-deployment/21495
 */
contract AaveV3Avalanche_FinanceStewardDeploymentPoolExposureModule_20250319 is
  IProposalGenericExecutor,
  DustBinSender
{
  function execute() external {
    send(
      AaveV3Avalanche.POOL,
      AaveV3Avalanche.COLLECTOR,
      address(AaveV3Avalanche.ORACLE),
      AaveV3Avalanche.DUST_BIN
    );

    address[] memory reserves = AaveV2Avalanche.POOL.getReservesList();
    uint256 reservesLen = reserves.length;

    for (uint256 i = 0; i < reservesLen; i++) {
      address reserve = reserves[i];
      (address aToken, , ) = AaveV2Avalanche.AAVE_PROTOCOL_DATA_PROVIDER.getReserveTokensAddresses(
        reserve
      );
      uint256 decimals = IERC20D(reserve).decimals();
      uint256 tokenAmount = Values.getTokenAmountByDollarValue(
        reserve,
        address(AaveV2Avalanche.ORACLE),
        decimals,
        MIN_DOLLAR_VALUE
      );
      uint256 balanceDustBin = IERC20(aToken).balanceOf(AaveV3Avalanche.DUST_BIN);

      if (balanceDustBin < tokenAmount) {
        uint256 balanceCollector = IERC20(aToken).balanceOf(address(AaveV3Avalanche.COLLECTOR));
        if (balanceCollector > 0) {
          uint256 toSend = tokenAmount - balanceDustBin;
          AaveV3Avalanche.COLLECTOR.transfer(
            IERC20(aToken),
            AaveV3Avalanche.DUST_BIN,
            balanceCollector >= toSend ? toSend : balanceCollector
          );
        }
      }
    }

    IAccessControl(address(AaveV3Avalanche.COLLECTOR)).grantRole(
      'FUNDS_ADMIN',
      AaveV3Avalanche.POOL_EXPOSURE_STEWARD
    );
  }
}
