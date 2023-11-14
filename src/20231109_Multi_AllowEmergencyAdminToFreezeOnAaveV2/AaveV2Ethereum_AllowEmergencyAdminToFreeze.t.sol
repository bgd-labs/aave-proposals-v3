// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV2Ethereum} from 'aave-address-book/AaveV2Ethereum.sol';
import {AaveV2EthereumAMM} from 'aave-address-book/AaveV2EthereumAMM.sol';

import 'forge-std/Test.sol';
import 'aave-helpers/ProtocolV2TestBase.sol';

/**
 * @dev Test for AaveV2Etherum_AllowEmergencyAdminToFreeze
 * command: make test-contract filter=AaveV2Etherum_AllowEmergencyAdminToFreeze_Test
 */
contract AaveV2Etherum_AllowEmergencyAdminToFreeze_Test is ProtocolV2TestBase {
  address internal proposal = address(0xf75cBd975756C52aA7321d10E6aCA90e07835Dee);
  address internal sentinelPayload = address(0x9441B65EE553F70df9C77d45d3283B6BC24F222d);

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 18569843);
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest('AaveV2Etherum_AllowEmergencyAdminToFreeze_Test', AaveV2Ethereum.POOL, address(proposal));
    defaultTestAmm('AaveV2Etherum_AllowEmergencyAdminToFreeze_Test',  AaveV2EthereumAMM.POOL, sentinelPayload);
  }

  function defaultTestAmm(
    string memory reportName,
    ILendingPool pool,
    address payload
  ) internal returns (ReserveConfig[] memory, ReserveConfig[] memory) {
    string memory beforeString = string(abi.encodePacked(reportName, '_before'));
    ReserveConfig[] memory configBefore = createConfigurationSnapshot(beforeString, pool);

    executePayload(vm, payload);

    string memory afterString = string(abi.encodePacked(reportName, '_after'));
    ReserveConfig[] memory configAfter = createConfigurationSnapshot(afterString, pool);

    diffReports(beforeString, afterString);
    return (configBefore, configAfter);
  }
}
