// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {IERC20 as IERC20D} from 'forge-std/interfaces/IERC20.sol';
import {IAccessControl} from 'openzeppelin-contracts/contracts/access/IAccessControl.sol';
import {AaveV2Ethereum, AaveV2EthereumAssets} from 'aave-address-book/AaveV2Ethereum.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {ProtocolV3TestBase} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {IPoolDataProvider, IPriceOracleGetter} from 'aave-address-book/AaveV3.sol';

import {AaveV3Ethereum_FinanceStewardDeploymentPoolExposureModule_20250319} from './AaveV3Ethereum_FinanceStewardDeploymentPoolExposureModule_20250319.sol';
import {Values} from './Values.sol';

/**
 * @dev Test for AaveV3Ethereum_FinanceStewardDeploymentPoolExposureModule_20250319
 * command: FOUNDRY_PROFILE=mainnet forge test --match-path=src/20250319_Multi_FinanceStewardDeploymentPoolExposureModule/AaveV3Ethereum_FinanceStewardDeploymentPoolExposureModule_20250319.t.sol -vv
 */
contract AaveV3Ethereum_FinanceStewardDeploymentPoolExposureModule_20250319_Test is
  ProtocolV3TestBase
{
  AaveV3Ethereum_FinanceStewardDeploymentPoolExposureModule_20250319 internal proposal;
  TestBalance internal tester;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 22080648);
    proposal = new AaveV3Ethereum_FinanceStewardDeploymentPoolExposureModule_20250319();
    tester = new TestBalance();
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
    assertFalse(
      IAccessControl(address(AaveV3Ethereum.COLLECTOR)).hasRole(
        'FUNDS_ADMIN',
        AaveV3Ethereum.POOL_EXPOSURE_STEWARD
      )
    );

    executePayload(vm, address(proposal));

    assertTrue(
      IAccessControl(address(AaveV3Ethereum.COLLECTOR)).hasRole(
        'FUNDS_ADMIN',
        AaveV3Ethereum.POOL_EXPOSURE_STEWARD
      )
    );
  }

  function test_allReservesHaveEnoughBalanceOnDustBinV3() public {
    executePayload(vm, address(proposal));

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
        100
      );
      uint256 balanceDustBin = IERC20(aToken).balanceOf(AaveV3Ethereum.DUST_BIN);

      try tester.isGreaterThanOrEqual(balanceDustBin, tokenAmount) {} catch {
        assertGt(balanceDustBin, 0, 'v3 aToken does not have greater than 0 balance in dust bin');
      }
    }
  }

  function test_allReservesHaveEnoughBalanceOnDustBinV2() public {
    executePayload(vm, address(proposal));

    address[] memory reserves = AaveV2Ethereum.POOL.getReservesList();
    uint256 reservesLen = reserves.length;
    uint256 ethPrice = IPriceOracleGetter(address(AaveV3Ethereum.ORACLE)).getAssetPrice(
      AaveV3EthereumAssets.WETH_UNDERLYING
    );

    for (uint256 i = 0; i < reservesLen; i++) {
      address reserve = reserves[i];

      if (
        reserve == AaveV2EthereumAssets.AAVE_UNDERLYING ||
        reserve == AaveV2EthereumAssets.AMPL_UNDERLYING ||
        reserve == AaveV2EthereumAssets.stETH_UNDERLYING
      ) {
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
        100,
        ethPrice
      );
      uint256 balanceDustBin = IERC20(aToken).balanceOf(AaveV3Ethereum.DUST_BIN);

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
