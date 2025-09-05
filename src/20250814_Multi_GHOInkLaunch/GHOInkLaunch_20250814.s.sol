// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers, IPayloadsControllerCore, PayloadsControllerUtils} from 'aave-helpers/src/GovV3Helpers.sol';
import {GovernanceV3Ethereum} from 'aave-address-book/GovernanceV3Ethereum.sol';
import {EthereumScript, ArbitrumScript, BaseScript, AvalancheScript, GnosisScript, InkScript} from 'solidity-utils/contracts/utils/ScriptUtils.sol';
import {Ethereum_Ink_AaveV3GHOLane_20250814} from './remote-lanes/Ethereum_Ink_AaveV3GHOLane_20250814.sol';
import {Arbitrum_Ink_AaveV3GHOLane_20250814} from './remote-lanes/Arbitrum_Ink_AaveV3GHOLane_20250814.sol';
import {Base_Ink_AaveV3GHOLane_20250814} from './remote-lanes/Base_Ink_AaveV3GHOLane_20250814.sol';
import {Avalanche_Ink_AaveV3GHOLane_20250814} from './remote-lanes/Avalanche_Ink_AaveV3GHOLane_20250814.sol';
import {Gnosis_Ink_AaveV3GHOLane_20250814} from './remote-lanes/Gnosis_Ink_AaveV3GHOLane_20250814.sol';
import {AaveV3Ink_GHOInkLaunch_20250814} from './AaveV3Ink_GHOInkLaunch_20250814.sol';
import {ChainIds} from 'solidity-utils/contracts/utils/ChainHelpers.sol';

contract DeployEthereum is EthereumScript {
  function run() external broadcast {
    // deploy payloads
    address payload0 = GovV3Helpers.deployDeterministic(
      type(Ethereum_Ink_AaveV3GHOLane_20250814).creationCode
    );

    // compose action
    IPayloadsControllerCore.ExecutionAction[]
      memory actions = new IPayloadsControllerCore.ExecutionAction[](1);
    actions[0] = GovV3Helpers.buildAction(payload0);

    // register action at payloadsController
    GovV3Helpers.createPayload(actions);
  }
}

contract DeployArbitrum is ArbitrumScript {
  function run() external broadcast {
    // deploy payloads
    address payload0 = GovV3Helpers.deployDeterministic(
      type(Arbitrum_Ink_AaveV3GHOLane_20250814).creationCode
    );

    // compose action
    IPayloadsControllerCore.ExecutionAction[]
      memory actions = new IPayloadsControllerCore.ExecutionAction[](1);
    actions[0] = GovV3Helpers.buildAction(payload0);

    // register action at payloadsController
    GovV3Helpers.createPayload(actions);
  }
}

contract DeployBase is BaseScript {
  function run() external broadcast {
    // deploy payloads
    address payload0 = GovV3Helpers.deployDeterministic(
      type(Base_Ink_AaveV3GHOLane_20250814).creationCode
    );

    // compose action
    IPayloadsControllerCore.ExecutionAction[]
      memory actions = new IPayloadsControllerCore.ExecutionAction[](1);
    actions[0] = GovV3Helpers.buildAction(payload0);

    // register action at payloadsController
    GovV3Helpers.createPayload(actions);
  }
}

contract DeployAvalanche is AvalancheScript {
  function run() external broadcast {
    // deploy payloads
    address payload0 = GovV3Helpers.deployDeterministic(
      type(Avalanche_Ink_AaveV3GHOLane_20250814).creationCode
    );

    // compose action
    IPayloadsControllerCore.ExecutionAction[]
      memory actions = new IPayloadsControllerCore.ExecutionAction[](1);
    actions[0] = GovV3Helpers.buildAction(payload0);

    // register action at payloadsController
    GovV3Helpers.createPayload(actions);
  }
}

contract DeployGnosis is GnosisScript {
  function run() external broadcast {
    // deploy payloads
    address payload0 = GovV3Helpers.deployDeterministic(
      type(Gnosis_Ink_AaveV3GHOLane_20250814).creationCode
    );

    // compose action
    IPayloadsControllerCore.ExecutionAction[]
      memory actions = new IPayloadsControllerCore.ExecutionAction[](1);
    actions[0] = GovV3Helpers.buildAction(payload0);

    // register action at payloadsController
    GovV3Helpers.createPayload(actions);
  }
}

contract DeployInk is InkScript {
  function run() external broadcast {
    // deploy payloads
    address payload0 = GovV3Helpers.deployDeterministic(
      type(AaveV3Ink_GHOInkLaunch_20250814).creationCode
    );

    // compose action
    IPayloadsControllerCore.ExecutionAction[]
      memory launchActions = new IPayloadsControllerCore.ExecutionAction[](1);
    launchActions[0] = GovV3Helpers.buildAction(payload0);

    // register action at payloadsController
    GovV3Helpers.createPayload(launchActions);
  }
}

contract CreateProposal is EthereumScript {
  function run() external {
    // create payloads
    PayloadsControllerUtils.Payload[] memory payloads = new PayloadsControllerUtils.Payload[](6);

    // compose actions for validation
    IPayloadsControllerCore.ExecutionAction[]
      memory actionsEthereum = new IPayloadsControllerCore.ExecutionAction[](1);
    actionsEthereum[0] = GovV3Helpers.buildAction(
      type(Ethereum_Ink_AaveV3GHOLane_20250814).creationCode
    );
    payloads[0] = GovV3Helpers.buildMainnetPayload(vm, actionsEthereum);

    IPayloadsControllerCore.ExecutionAction[]
      memory actionsArbitrum = new IPayloadsControllerCore.ExecutionAction[](1);
    actionsArbitrum[0] = GovV3Helpers.buildAction(
      type(Arbitrum_Ink_AaveV3GHOLane_20250814).creationCode
    );
    payloads[1] = GovV3Helpers.buildArbitrumPayload(vm, actionsArbitrum);

    IPayloadsControllerCore.ExecutionAction[]
      memory actionsBase = new IPayloadsControllerCore.ExecutionAction[](1);
    actionsBase[0] = GovV3Helpers.buildAction(type(Base_Ink_AaveV3GHOLane_20250814).creationCode);
    payloads[2] = GovV3Helpers.buildBasePayload(vm, actionsBase);

    IPayloadsControllerCore.ExecutionAction[]
      memory actionsAvalanche = new IPayloadsControllerCore.ExecutionAction[](1);
    actionsAvalanche[0] = GovV3Helpers.buildAction(
      type(Avalanche_Ink_AaveV3GHOLane_20250814).creationCode
    );
    payloads[3] = GovV3Helpers.buildAvalanchePayload(vm, actionsAvalanche);

    IPayloadsControllerCore.ExecutionAction[]
      memory actionsGnosis = new IPayloadsControllerCore.ExecutionAction[](1);
    actionsGnosis[0] = GovV3Helpers.buildAction(
      type(Gnosis_Ink_AaveV3GHOLane_20250814).creationCode
    );
    payloads[4] = GovV3Helpers.buildGnosisPayload(vm, actionsGnosis);

    IPayloadsControllerCore.ExecutionAction[]
      memory actionsInkLaunch = new IPayloadsControllerCore.ExecutionAction[](1);
    actionsInkLaunch[0] = GovV3Helpers.buildAction(
      type(AaveV3Ink_GHOInkLaunch_20250814).creationCode
    );
    payloads[5] = GovV3Helpers.buildInkPayload(vm, actionsInkLaunch);

    // create proposal
    vm.startBroadcast();
    GovV3Helpers.createProposal(
      vm,
      payloads,
      GovernanceV3Ethereum.VOTING_PORTAL_ETH_POL,
      GovV3Helpers.ipfsHashFile(vm, 'src/20250814_Multi_GHOInkLaunch/GHOInkLaunch.md')
    );
  }
}
