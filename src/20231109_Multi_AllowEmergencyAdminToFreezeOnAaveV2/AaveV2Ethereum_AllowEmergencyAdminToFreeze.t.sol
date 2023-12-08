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
  address internal payload = address(0x23AceD103f5E22bD22B9272c82f29C0E51abC5c2);
  address internal ammPayload = address(0xf75cBd975756C52aA7321d10E6aCA90e07835Dee);
  address internal sentinelPayload = address(0x9441B65EE553F70df9C77d45d3283B6BC24F222d);

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 18577114);
  }

  function test_defaultPayloadExecution_PoolConfigurator() public {
    defaultTest(
      'AaveV2Etherum_AllowEmergencyAdminToFreeze_Test',
      AaveV2Ethereum.POOL,
      address(payload)
    );
  }

  function test_defaultPayloadExecution_PoolConfigurator_Amm() public {
    defaultTestAmm(
      'AaveV2Etherum_AllowEmergencyAdminToFreezeAmm_Test',
      AaveV2EthereumAMM.POOL,
      address(ammPayload)
    );
  }

  function test_defaultPayloadExecution_Sentinel_Amm() public {
    defaultTestAmm(
      'AaveV2Etherum_AllowEmergencyAdminToFreezeSentinel_Test',
      AaveV2EthereumAMM.POOL,
      sentinelPayload
    );
  }

  function defaultTestAmm(
    string memory _reportName,
    ILendingPool _pool,
    address _payload
  ) internal returns (ReserveConfig[] memory, ReserveConfig[] memory) {
    string memory beforeString = string(abi.encodePacked(_reportName, '_before'));
    ReserveConfig[] memory configBefore = createConfigurationSnapshot(beforeString, _pool);

    executePayload(vm, _payload);

    string memory afterString = string(abi.encodePacked(_reportName, '_after'));
    ReserveConfig[] memory configAfter = createConfigurationSnapshot(afterString, _pool);

    diffReports(beforeString, afterString);
    return (configBefore, configAfter);
  }
}
