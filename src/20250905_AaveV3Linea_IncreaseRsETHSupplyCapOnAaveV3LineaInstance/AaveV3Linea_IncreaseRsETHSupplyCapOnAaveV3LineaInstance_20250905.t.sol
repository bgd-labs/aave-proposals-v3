// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Linea} from 'aave-address-book/AaveV3Linea.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Linea_IncreaseRsETHSupplyCapOnAaveV3LineaInstance_20250905} from './AaveV3Linea_IncreaseRsETHSupplyCapOnAaveV3LineaInstance_20250905.sol';

/**
 * @dev Test for AaveV3Linea_IncreaseRsETHSupplyCapOnAaveV3LineaInstance_20250905
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20250905_AaveV3Linea_IncreaseRsETHSupplyCapOnAaveV3LineaInstance/AaveV3Linea_IncreaseRsETHSupplyCapOnAaveV3LineaInstance_20250905.t.sol -vv
 */
contract AaveV3Linea_IncreaseRsETHSupplyCapOnAaveV3LineaInstance_20250905_Test is
  ProtocolV3TestBase
{
  AaveV3Linea_IncreaseRsETHSupplyCapOnAaveV3LineaInstance_20250905 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('linea'), 22963642);
    proposal = new AaveV3Linea_IncreaseRsETHSupplyCapOnAaveV3LineaInstance_20250905();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Linea_IncreaseRsETHSupplyCapOnAaveV3LineaInstance_20250905',
      AaveV3Linea.POOL,
      address(proposal)
    );
  }
}
