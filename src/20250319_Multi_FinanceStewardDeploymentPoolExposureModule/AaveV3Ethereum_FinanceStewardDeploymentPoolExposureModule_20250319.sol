// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {IERC20 as IERC20D} from 'forge-std/interfaces/IERC20.sol';
import {IAccessControl} from 'openzeppelin-contracts/contracts/access/IAccessControl.sol';
import {AaveV2Ethereum, AaveV2EthereumAssets} from 'aave-address-book/AaveV2Ethereum.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {IPriceOracleGetter} from 'aave-address-book/AaveV3.sol';
import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';

import {Values} from './Values.sol';

/**
 * @title Finance Steward Deployment: Pool Exposure Module
 * @author @TokenLogic
 * - Snapshot: https://snapshot.box/#/s:aave.eth/proposal/0x1730ba3a2dd1f7b0b00cfae01b0c9f1bb7494b848c5de517275e2c72cf8c7b4d
 * - Discussion: https://governance.aave.com/t/arfc-aave-finance-steward-deployment/21495
 */
contract AaveV3Ethereum_FinanceStewardDeploymentPoolExposureModule_20250319 is
  IProposalGenericExecutor
{
  uint256 public constant MIN_DOLLAR_VALUE = 100;

  function execute() external {
    address[] memory reserves = AaveV3Ethereum.POOL.getReservesList();
    uint256 reservesLen = reserves.length;

    for (uint256 i = 0; i < reservesLen; i++) {
      address reserve = reserves[i];

      if (reserve == AaveV3EthereumAssets.GHO_UNDERLYING) {
        continue;
      }

      address aToken = AaveV3Ethereum.POOL.getReserveAToken(reserve);
      uint256 decimals = IERC20D(reserve).decimals();

      uint256 tokenAmount = Values.getTokenAmountByDollarValue(
        reserve,
        address(AaveV3Ethereum.ORACLE),
        decimals,
        MIN_DOLLAR_VALUE
      );
      uint256 balanceDustBin = IERC20(aToken).balanceOf(AaveV3Ethereum.DUST_BIN);

      if (balanceDustBin < tokenAmount) {
        uint256 balanceCollector = IERC20(aToken).balanceOf(address(AaveV3Ethereum.COLLECTOR));

        if (balanceCollector > 0) {
          uint256 toSend = tokenAmount - balanceDustBin;
          AaveV3Ethereum.COLLECTOR.transfer(
            IERC20(aToken),
            AaveV3Ethereum.DUST_BIN,
            balanceCollector >= toSend ? toSend : balanceCollector
          );
        }
      }
    }

    uint256 ethPrice = IPriceOracleGetter(address(AaveV3Ethereum.ORACLE)).getAssetPrice(
      AaveV3EthereumAssets.WETH_UNDERLYING
    );

    reserves = AaveV2Ethereum.POOL.getReservesList();
    reservesLen = reserves.length;

    for (uint256 i = 0; i < reservesLen; i++) {
      address reserve = reserves[i];

      // Cannot be transferred
      if (reserve == AaveV2EthereumAssets.AMPL_UNDERLYING) {
        continue;
      }

      (address aToken, , ) = AaveV2Ethereum.AAVE_PROTOCOL_DATA_PROVIDER.getReserveTokensAddresses(
        reserve
      );
      uint256 decimals = IERC20D(reserve).decimals();

      uint256 tokenAmount = Values.getTokenAmountByDollarValueEthOracle(
        reserve,
        address(AaveV2Ethereum.ORACLE),
        decimals,
        MIN_DOLLAR_VALUE,
        ethPrice
      );
      uint256 balanceDustBin = IERC20(aToken).balanceOf(AaveV3Ethereum.DUST_BIN);

      if (balanceDustBin < tokenAmount) {
        uint256 balanceCollector = IERC20(aToken).balanceOf(address(AaveV3Ethereum.COLLECTOR));

        if (balanceCollector > 0) {
          uint256 toSend = tokenAmount - balanceDustBin;
          AaveV3Ethereum.COLLECTOR.transfer(
            IERC20(aToken),
            AaveV3Ethereum.DUST_BIN,
            balanceCollector >= toSend ? toSend : balanceCollector
          );
        }
      }
    }

    IAccessControl(address(AaveV3Ethereum.COLLECTOR)).grantRole(
      'FUNDS_ADMIN',
      AaveV3Ethereum.POOL_EXPOSURE_STEWARD
    );
  }
}
