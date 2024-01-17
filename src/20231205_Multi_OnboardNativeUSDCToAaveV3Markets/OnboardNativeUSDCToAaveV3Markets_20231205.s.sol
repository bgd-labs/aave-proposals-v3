// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers, IPayloadsControllerCore, PayloadsControllerUtils} from 'aave-helpers/GovV3Helpers.sol';
//import {AaveV3Markets} from 'aave-address-book/AaveV3Markets.sol';
import {EthereumScript, PolygonScript, OptimismScript, ArbitrumScript, BaseScript} from 'aave-helpers/ScriptUtils.sol';
import {AaveV3Polygon_OnboardNativeUSDCToAaveV3Markets_20231205} from './AaveV3Polygon_OnboardNativeUSDCToAaveV3Markets_20231205.sol';
import {AaveV3Optimism_OnboardNativeUSDCToAaveV3Markets_20231205} from './AaveV3Optimism_OnboardNativeUSDCToAaveV3Markets_20231205.sol';
import {AaveV3Arbitrum_OnboardNativeUSDCToAaveV3Markets_20231205} from './AaveV3Arbitrum_OnboardNativeUSDCToAaveV3Markets_20231205.sol';
import {AaveV3Base_OnboardNativeUSDCToAaveV3Markets_20231205} from './AaveV3Base_OnboardNativeUSDCToAaveV3Markets_20231205.sol';

/**
 * @dev Deploy Polygon
 * command: make deploy-ledger contract=src/20231205_Multi_OnboardNativeUSDCToAaveV3Markets/OnboardNativeUSDCToAaveV3Markets_20231205.s.sol:DeployPolygon chain=polygon
 */
contract DeployPolygon is PolygonScript {
  function run() external broadcast {
    // deploy payloads
    AaveV3Polygon_OnboardNativeUSDCToAaveV3Markets_20231205 payload0 = new AaveV3Polygon_OnboardNativeUSDCToAaveV3Markets_20231205();

    // compose action
    IPayloadsControllerCore.ExecutionAction[]
      memory actions = new IPayloadsControllerCore.ExecutionAction[](1);
    actions[0] = GovV3Helpers.buildAction(address(payload0));

    // register action at payloadsController
    GovV3Helpers.createPayload(actions);
  }
}

/**
 * @dev Deploy Optimism
 * command: make deploy-ledger contract=src/20231205_Multi_OnboardNativeUSDCToAaveV3Markets/OnboardNativeUSDCToAaveV3Markets_20231205.s.sol:DeployOptimism chain=optimism
 */
contract DeployOptimism is OptimismScript {
  function run() external broadcast {
    // deploy payloads
    AaveV3Optimism_OnboardNativeUSDCToAaveV3Markets_20231205 payload0 = new AaveV3Optimism_OnboardNativeUSDCToAaveV3Markets_20231205();

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
 * command: make deploy-ledger contract=src/20231205_Multi_OnboardNativeUSDCToAaveV3Markets/OnboardNativeUSDCToAaveV3Markets_20231205.s.sol:DeployArbitrum chain=arbitrum
 */
contract DeployArbitrum is ArbitrumScript {
  function run() external broadcast {
    // deploy payloads
    AaveV3Arbitrum_OnboardNativeUSDCToAaveV3Markets_20231205 payload0 = new AaveV3Arbitrum_OnboardNativeUSDCToAaveV3Markets_20231205();

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
 * command: make deploy-ledger contract=src/20231205_Multi_OnboardNativeUSDCToAaveV3Markets/OnboardNativeUSDCToAaveV3Markets_20231205.s.sol:DeployBase chain=base
 */
contract DeployBase is BaseScript {
  function run() external broadcast {
    // deploy payloads
    AaveV3Base_OnboardNativeUSDCToAaveV3Markets_20231205 payload0 = new AaveV3Base_OnboardNativeUSDCToAaveV3Markets_20231205();

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
 * command: make deploy-ledger contract=src/20231205_Multi_OnboardNativeUSDCToAaveV3Markets/OnboardNativeUSDCToAaveV3Markets_20231205.s.sol:CreateProposal chain=mainnet
 */
contract CreateProposal is EthereumScript {
  function run() external {
    // create payloads
    PayloadsControllerUtils.Payload[] memory payloads = new PayloadsControllerUtils.Payload[](4);

    // compose actions for validation
    IPayloadsControllerCore.ExecutionAction[]
      memory actionsPolygon = new IPayloadsControllerCore.ExecutionAction[](1);
    actionsPolygon[0] = GovV3Helpers.buildAction(address(0));
    payloads[0] = GovV3Helpers.buildPolygonPayload(vm, actionsPolygon);

    IPayloadsControllerCore.ExecutionAction[]
      memory actionsOptimism = new IPayloadsControllerCore.ExecutionAction[](1);
    actionsOptimism[0] = GovV3Helpers.buildAction(address(0));
    payloads[1] = GovV3Helpers.buildOptimismPayload(vm, actionsOptimism);

    IPayloadsControllerCore.ExecutionAction[]
      memory actionsArbitrum = new IPayloadsControllerCore.ExecutionAction[](1);
    actionsArbitrum[0] = GovV3Helpers.buildAction(address(0));
    payloads[2] = GovV3Helpers.buildArbitrumPayload(vm, actionsArbitrum);

    IPayloadsControllerCore.ExecutionAction[]
      memory actionsBase = new IPayloadsControllerCore.ExecutionAction[](1);
    actionsBase[0] = GovV3Helpers.buildAction(address(0));
    payloads[3] = GovV3Helpers.buildBasePayload(vm, actionsBase);

    // create proposal
    vm.startBroadcast();
    GovV3Helpers.createProposal2_5(
      vm,
      payloads,
      GovV3Helpers.ipfsHashFile(
        vm,
        'src/20231205_Multi_OnboardNativeUSDCToAaveV3Markets/OnboardNativeUSDCToAaveV3Markets.md'
      )
    );
  }
}
