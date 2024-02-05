// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers, IPayloadsControllerCore, PayloadsControllerUtils} from 'aave-helpers/GovV3Helpers.sol';
import {EthereumScript, PolygonScript} from 'aave-helpers/ScriptUtils.sol';
import {AaveV2Ethereum_MigrationOfRemainingGovV2Permissions_20240130, AaveV2Ethereum_MigrationOfRemainingGovV2Permissions_Part2_20240130} from './AaveV2Ethereum_MigrationOfRemainingGovV2Permissions_20240130.sol';
import {MainnetPayload} from './MainnetPayload.sol';
import {PolygonPayload} from './PolygonPayload.sol';

library PayloadsToDeploy {
  function part1(address mainnetPayload, address polygonPayload) internal returns (address) {
    uint256 estimatedOnchainExecution = block.timestamp +
      5 days + // governance
      1 days + // executor delay
      1 days; // margin for error (time between payload deployment & proposal creation)
    return
      GovV3Helpers.deployDeterministic(
        abi.encodePacked(
          type(AaveV2Ethereum_MigrationOfRemainingGovV2Permissions_20240130).creationCode,
          abi.encode(mainnetPayload, polygonPayload, estimatedOnchainExecution)
        )
      );
  }

  function part2(address payload) internal returns (address) {
    return
      GovV3Helpers.deployDeterministic(
        abi.encodePacked(
          type(AaveV2Ethereum_MigrationOfRemainingGovV2Permissions_Part2_20240130).creationCode,
          abi.encode(payload)
        )
      );
  }
}

/**
 * @dev Deploy Polygon
 * deploy-command: make deploy-ledger contract=src/20240130_AaveV2Ethereum_MigrationOfRemainingGovV2Permissions/MigrationOfRemainingGovV2Permissions_20240130.s.sol:DeployPolygon chain=polygon
 * verify-command: npx catapulta-verify -b broadcast/MigrationOfRemainingGovV2Permissions_20240130.s.sol/137/run-latest.json
 */
contract DeployPolygon is PolygonScript {
  function run() external broadcast {
    new PolygonPayload();
  }
}

/**
 * @dev Deploy Ethereum
 * deploy-command: make deploy-ledger contract=src/20240130_AaveV2Ethereum_MigrationOfRemainingGovV2Permissions/MigrationOfRemainingGovV2Permissions_20240130.s.sol:DeployEthereum chain=mainnet
 * verify-command: npx catapulta-verify -b broadcast/MigrationOfRemainingGovV2Permissions_20240130.s.sol/1/run-latest.json
 */
contract DeployEthereum is EthereumScript {
  address internal constant POLYGON_PAYLOAD = address(0x40F9a4FB0E9E2a982c0A7547A6a48965BD480235);

  function run() external broadcast {
    require(POLYGON_PAYLOAD != address(0));
    MainnetPayload payload = new MainnetPayload();
    // deploy payloads
    address payload0 = PayloadsToDeploy.part1(address(payload), POLYGON_PAYLOAD);

    address payload1 = PayloadsToDeploy.part2(address(payload0));

    // compose action
    IPayloadsControllerCore.ExecutionAction[]
      memory actions0 = new IPayloadsControllerCore.ExecutionAction[](1);
    actions0[0] = GovV3Helpers.buildAction(payload0);

    IPayloadsControllerCore.ExecutionAction[]
      memory actions1 = new IPayloadsControllerCore.ExecutionAction[](1);
    actions1[0] = GovV3Helpers.buildAction(payload1);

    // register action at payloadsController
    GovV3Helpers.createPayload(actions0);
    GovV3Helpers.createPayload(actions1);
  }
}

/**
 * @dev Create Proposal
 * command: make deploy-ledger contract=src/20240130_AaveV2Ethereum_MigrationOfRemainingGovV2Permissions/MigrationOfRemainingGovV2Permissions_20240130.s.sol:CreateProposal chain=mainnet
 */
contract CreateProposal is EthereumScript {
  function run() external {
    // create payloads
    PayloadsControllerUtils.Payload[] memory payloads = new PayloadsControllerUtils.Payload[](1);

    // compose actions for validation
    IPayloadsControllerCore.ExecutionAction[]
      memory actionsEthereum0 = new IPayloadsControllerCore.ExecutionAction[](1);
    actionsEthereum0[0] = GovV3Helpers.buildAction(
      address(0xd15280055CfE8A8AD69EBC5108582fE5CF9e72ae)
    );
    payloads[0] = GovV3Helpers.buildMainnetPayload(vm, actionsEthereum0);

    IPayloadsControllerCore.ExecutionAction[]
      memory actionsEthereum1 = new IPayloadsControllerCore.ExecutionAction[](1);
    actionsEthereum1[0] = GovV3Helpers.buildAction(
      address(0xb26EF5Fcef56262A5a21565b7665ffe2068DaE7C)
    );
    payloads[1] = GovV3Helpers.buildMainnetPayload(vm, actionsEthereum1);
    // create proposal
    vm.startBroadcast();
    GovV3Helpers.createProposal(
      vm,
      payloads,
      GovV3Helpers.ipfsHashFile(
        vm,
        'src/20240130_AaveV2Ethereum_MigrationOfRemainingGovV2Permissions/MigrationOfRemainingGovV2Permissions.md'
      )
    );
  }
}
