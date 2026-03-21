// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {ProtocolV3TestBase} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Ethereum_MKRAndUSDtbOracleAdjustments_20260127} from './AaveV3Ethereum_MKRAndUSDtbOracleAdjustments_20260127.sol';

/**
 * @dev Test for AaveV3Ethereum_MKRAndUSDtbOracleAdjustments_20260127
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20260127_AaveV3Ethereum_MKRAndUSDtbOracleAdjustments/AaveV3Ethereum_MKRAndUSDtbOracleAdjustments_20260127.t.sol -vvv
 */
contract AaveV3Ethereum_MKRAndUSDtbOracleAdjustments_20260127_Test is ProtocolV3TestBase {
  AaveV3Ethereum_MKRAndUSDtbOracleAdjustments_20260127 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 24324715);
    proposal = new AaveV3Ethereum_MKRAndUSDtbOracleAdjustments_20260127();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Ethereum_MKRAndUSDtbOracleAdjustments_20260127',
      AaveV3Ethereum.POOL,
      address(proposal)
    );
  }

  function test_oraclePriceFeedsUpdated() public {
    executePayload(vm, address(proposal));

    assertEq(
      AaveV3Ethereum.ORACLE.getSourceOfAsset(AaveV3EthereumAssets.MKR_UNDERLYING),
      0x44Bb2a64bAf94210B583338D3D97b1e8288Bd478
    );
    assertEq(
      AaveV3Ethereum.ORACLE.getSourceOfAsset(AaveV3EthereumAssets.USDtb_UNDERLYING),
      0x88025072A7dB6Db5e54E46d43850bb44CA93D6C0
    );
  }
}
