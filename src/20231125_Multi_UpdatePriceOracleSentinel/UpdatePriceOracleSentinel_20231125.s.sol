// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers, IPayloadsControllerCore, PayloadsControllerUtils} from 'aave-helpers/GovV3Helpers.sol';
import {EthereumScript, OptimismScript, ArbitrumScript, MetisScript, BaseScript} from 'aave-helpers/ScriptUtils.sol';
import {AaveV3Optimism_UpdatePriceOracleSentinel_20231125} from './AaveV3Optimism_UpdatePriceOracleSentinel_20231125.sol';
import {AaveV3Arbitrum_UpdatePriceOracleSentinel_20231125} from './AaveV3Arbitrum_UpdatePriceOracleSentinel_20231125.sol';
import {AaveV3Metis_UpdatePriceOracleSentinel_20231125} from './AaveV3Metis_UpdatePriceOracleSentinel_20231125.sol';
import {AaveV3Base_UpdatePriceOracleSentinel_20231125} from './AaveV3Base_UpdatePriceOracleSentinel_20231125.sol';

/**
 * @dev Deploy Optimism
 * command: make deploy-ledger contract=src/20231125_Multi_UpdatePriceOracleSentinel/UpdatePriceOracleSentinel_20231125.s.sol:DeployOptimism chain=optimism
 */
contract DeployOptimism is OptimismScript {
  function run() external broadcast {
    // deploy payloads
    AaveV3Optimism_UpdatePriceOracleSentinel_20231125 payload0 = new AaveV3Optimism_UpdatePriceOracleSentinel_20231125();

    // compose action
    IPayloadsControllerCore.ExecutionAction[]
      memory actions = new IPayloadsControllerCore.ExecutionAction[](1);
    actions[0] = GovV3Helpers.buildAction(address(payload0));

    // register action at payloadsController
    GovV3Helpers.createPayload(actions);
  }
}

/**
 * @dev Deploy Arbitrum
 * command: make deploy-ledger contract=src/20231125_Multi_UpdatePriceOracleSentinel/UpdatePriceOracleSentinel_20231125.s.sol:DeployArbitrum chain=arbitrum
 */
contract DeployArbitrum is ArbitrumScript {
  function run() external broadcast {
    // deploy payloads
    AaveV3Arbitrum_UpdatePriceOracleSentinel_20231125 payload0 = new AaveV3Arbitrum_UpdatePriceOracleSentinel_20231125();

    // compose action
    IPayloadsControllerCore.ExecutionAction[]
      memory actions = new IPayloadsControllerCore.ExecutionAction[](1);
    actions[0] = GovV3Helpers.buildAction(address(payload0));

    // register action at payloadsController
    GovV3Helpers.createPayload(actions);
  }
}

/**
 * @dev Deploy Metis
 * command: make deploy-ledger contract=src/20231125_Multi_UpdatePriceOracleSentinel/UpdatePriceOracleSentinel_20231125.s.sol:DeployMetis chain=metis
 */
contract DeployMetis is MetisScript {
  function run() external broadcast {
    // deploy payloads
    AaveV3Metis_UpdatePriceOracleSentinel_20231125 payload0 = new AaveV3Metis_UpdatePriceOracleSentinel_20231125();

    // compose action
    IPayloadsControllerCore.ExecutionAction[]
      memory actions = new IPayloadsControllerCore.ExecutionAction[](1);
    actions[0] = GovV3Helpers.buildAction(address(payload0));

    // register action at payloadsController
    GovV3Helpers.createPayload(actions);
  }
}

/**
 * @dev Deploy Base
 * command: make deploy-ledger contract=src/20231125_Multi_UpdatePriceOracleSentinel/UpdatePriceOracleSentinel_20231125.s.sol:DeployBase chain=base
 */
contract DeployBase is BaseScript {
  function run() external broadcast {
    // deploy payloads
    AaveV3Base_UpdatePriceOracleSentinel_20231125 payload0 = new AaveV3Base_UpdatePriceOracleSentinel_20231125();

    // compose action
    IPayloadsControllerCore.ExecutionAction[]
      memory actions = new IPayloadsControllerCore.ExecutionAction[](1);
    actions[0] = GovV3Helpers.buildAction(address(payload0));

    // register action at payloadsController
    GovV3Helpers.createPayload(actions);
  }
}

/**
 * @dev Create Proposal
 * command: make deploy-ledger contract=src/20231125_Multi_UpdatePriceOracleSentinel/UpdatePriceOracleSentinel_20231125.s.sol:CreateProposal chain=mainnet
 */
contract CreateProposal is EthereumScript {
  function run() external {
    // create payloads
    PayloadsControllerUtils.Payload[] memory payloads = new PayloadsControllerUtils.Payload[](4);

    // compose actions for validation
    IPayloadsControllerCore.ExecutionAction[]
      memory actionsOptimism = new IPayloadsControllerCore.ExecutionAction[](1);
    actionsOptimism[0] = GovV3Helpers.buildAction(0x7f9e2cE0e7A24358e360611382aA5CdCB0aEF86c);
    payloads[0] = GovV3Helpers.buildOptimismPayload(vm, actionsOptimism);

    IPayloadsControllerCore.ExecutionAction[]
      memory actionsArbitrum = new IPayloadsControllerCore.ExecutionAction[](1);
    actionsArbitrum[0] = GovV3Helpers.buildAction(0x1685D81212580DD4cDA287616C2f6F4794927e18);
    payloads[1] = GovV3Helpers.buildArbitrumPayload(vm, actionsArbitrum);

    IPayloadsControllerCore.ExecutionAction[]
      memory actionsMetis = new IPayloadsControllerCore.ExecutionAction[](1);
    actionsMetis[0] = GovV3Helpers.buildAction(0x3999d49Bbad3A7375B0376BDF2bA4f2e3c9F5177);
    payloads[2] = GovV3Helpers.buildMetisPayload(vm, actionsMetis);

    IPayloadsControllerCore.ExecutionAction[]
      memory actionsBase = new IPayloadsControllerCore.ExecutionAction[](1);
    actionsBase[0] = GovV3Helpers.buildAction(0xb5a1Fe36dcf5Ba149Cb8d90A03f4709141eE5442);
    payloads[3] = GovV3Helpers.buildBasePayload(vm, actionsBase);

    // create proposal
    vm.startBroadcast();
    GovV3Helpers.createProposal2_5(
      vm,
      payloads,
      GovV3Helpers.ipfsHashFile(
        vm,
        'src/20231125_Multi_UpdatePriceOracleSentinel/UpdatePriceOracleSentinel.md'
      )
    );
  }
}
