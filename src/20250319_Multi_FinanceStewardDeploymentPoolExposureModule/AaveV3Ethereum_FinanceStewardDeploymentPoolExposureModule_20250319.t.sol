// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {IAccessControl} from 'openzeppelin-contracts/contracts/access/IAccessControl.sol';
import {AaveV2Ethereum} from 'aave-address-book/AaveV2Ethereum.sol';
import {AaveV3Ethereum} from 'aave-address-book/AaveV3Ethereum.sol';
import {ProtocolV3TestBase} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {IPoolDataProvider, IPriceOracleGetter} from 'aave-address-book/AaveV3.sol';
import {DataTypes} from 'aave-v3-origin/contracts/protocol/libraries/types/DataTypes.sol';
import {ReserveConfiguration} from 'aave-v3-origin/contracts/protocol/libraries/configuration/ReserveConfiguration.sol';

import {AaveV3Ethereum_FinanceStewardDeploymentPoolExposureModule_20250319} from './AaveV3Ethereum_FinanceStewardDeploymentPoolExposureModule_20250319.sol';

/**
 * @dev Test for AaveV3Ethereum_FinanceStewardDeploymentPoolExposureModule_20250319
 * command: FOUNDRY_PROFILE=mainnet forge test --match-path=src/20250319_Multi_FinanceStewardDeploymentPoolExposureModule/AaveV3Ethereum_FinanceStewardDeploymentPoolExposureModule_20250319.t.sol -vv
 */
contract AaveV3Ethereum_FinanceStewardDeploymentPoolExposureModule_20250319_Test is
  ProtocolV3TestBase
{
  using ReserveConfiguration for DataTypes.ReserveConfigurationMap;

  AaveV3Ethereum_FinanceStewardDeploymentPoolExposureModule_20250319 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 22080648);
    proposal = new AaveV3Ethereum_FinanceStewardDeploymentPoolExposureModule_20250319();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Ethereum_FinanceStewardDeploymentPoolExposureModule_20250319',
      AaveV3Ethereum.POOL,
      address(proposal)
    );
  }

  function test_accessGranted() public {
    executePayload(vm, address(proposal));
  }

  function test_allReservesHaveEnoughBalanceOnDustBin() public {
    executePayload(vm, address(proposal));

    address[] memory reserves = AaveV3Ethereum.POOL.getReservesList();
    uint256 reservesLen = reserves.length;

    for (uint256 i = 0; i < reservesLen; i++) {
      address reserve = reserves[i];
      DataTypes.ReserveConfigurationMap memory configuration = AaveV3Ethereum.POOL.getConfiguration(
        reserve
      );
      (, , , uint256 decimals, ) = configuration.getParams();

      uint256 tokenAmount = _getTokenAmountByDollarValue(reserve, decimals, 100);
      uint256 balanceDustBin = IERC20(reserve).balanceOf(AaveV3Ethereum.DUST_BIN);

      if (balanceDustBin < tokenAmount) {
        AaveV3Ethereum.COLLECTOR.transfer(
          IERC20(reserve),
          AaveV3Ethereum.DUST_BIN,
          tokenAmount - balanceDustBin
        );
      }
    }
  }

  function _getTokenAmountByDollarValue(
    address underlying,
    uint256 decimals,
    uint256 dollarValue
  ) internal view returns (uint256) {
    uint256 latestAnswer = IPriceOracleGetter(address(AaveV3Ethereum.ORACLE)).getAssetPrice(
      underlying
    );
    return (dollarValue * 10 ** (8 + decimals)) / latestAnswer;
  }
}
