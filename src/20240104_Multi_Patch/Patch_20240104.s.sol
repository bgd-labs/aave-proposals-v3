// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers, IPayloadsControllerCore, PayloadsControllerUtils} from 'aave-helpers/GovV3Helpers.sol';
import {WithChainIdValidation, EthereumScript, PolygonScript, AvalancheScript, OptimismScript, ArbitrumScript, MetisScript, BaseScript, GnosisScript} from 'aave-helpers/ScriptUtils.sol';
import {AaveV3Ethereum_Patch_20240104} from './AaveV3Ethereum_Patch_20240104.sol';
import {AaveV3Polygon_Patch_20240104} from './AaveV3Polygon_Patch_20240104.sol';
import {AaveV3Avalanche_Patch_20240104} from './AaveV3Avalanche_Patch_20240104.sol';
import {AaveV3Optimism_Patch_20240104} from './AaveV3Optimism_Patch_20240104.sol';
import {AaveV3Arbitrum_Patch_20240104} from './AaveV3Arbitrum_Patch_20240104.sol';
import {AaveV3Base_Patch_20240104} from './AaveV3Base_Patch_20240104.sol';
import {AaveV3Gnosis_Patch_20240104} from './AaveV3Gnosis_Patch_20240104.sol';

abstract contract GenericDeploy is WithChainIdValidation {
  function _getPayload() internal virtual returns (bytes memory);

  function run() external broadcast {
    // deploy payloads
    address payload0 = GovV3Helpers.deployDeterministic(_getPayload());

    // register action at payloadsController
    GovV3Helpers.createPayload(GovV3Helpers.buildAction(payload0));
  }
}

/**
 * @dev Deploy Ethereum
 * deploy-command: make deploy-ledger contract=src/20240104_Multi_Patch/Patch_20240104.s.sol:DeployEthereum chain=mainnet
 * verify-command: npx catapulta-verify -b broadcast/Patch_20240104.s.sol/1/run-latest.json
 */
contract DeployEthereum is EthereumScript, GenericDeploy {
  function _getPayload() internal override returns (bytes memory) {
    return type(AaveV3Ethereum_Patch_20240104).creationCode;
  }
}

/**
 * @dev Deploy Polygon
 * deploy-command: make deploy-ledger contract=src/20240104_Multi_Patch/Patch_20240104.s.sol:DeployPolygon chain=polygon
 * verify-command: npx catapulta-verify -b broadcast/Patch_20240104.s.sol/137/run-latest.json
 */
contract DeployPolygon is PolygonScript, GenericDeploy {
  function _getPayload() internal override returns (bytes memory) {
    return type(AaveV3Polygon_Patch_20240104).creationCode;
  }
}

/**
 * @dev Deploy Avalanche
 * deploy-command: make deploy-ledger contract=src/20240104_Multi_Patch/Patch_20240104.s.sol:DeployAvalanche chain=avalanche
 * verify-command: npx catapulta-verify -b broadcast/Patch_20240104.s.sol/43114/run-latest.json
 */
contract DeployAvalanche is AvalancheScript, GenericDeploy {
  function _getPayload() internal override returns (bytes memory) {
    return type(AaveV3Avalanche_Patch_20240104).creationCode;
  }
}

/**
 * @dev Deploy Optimism
 * deploy-command: make deploy-ledger contract=src/20240104_Multi_Patch/Patch_20240104.s.sol:DeployOptimism chain=optimism
 * verify-command: npx catapulta-verify -b broadcast/Patch_20240104.s.sol/10/run-latest.json
 */
contract DeployOptimism is OptimismScript, GenericDeploy {
  function _getPayload() internal override returns (bytes memory) {
    return type(AaveV3Optimism_Patch_20240104).creationCode;
  }
}

/**
 * @dev Deploy Arbitrum
 * deploy-command: make deploy-ledger contract=src/20240104_Multi_Patch/Patch_20240104.s.sol:DeployArbitrum chain=arbitrum
 * verify-command: npx catapulta-verify -b broadcast/Patch_20240104.s.sol/42161/run-latest.json
 */
contract DeployArbitrum is ArbitrumScript, GenericDeploy {
  function _getPayload() internal override returns (bytes memory) {
    return type(AaveV3Arbitrum_Patch_20240104).creationCode;
  }
}

/**
 * @dev Deploy Base
 * deploy-command: make deploy-ledger contract=src/20240104_Multi_Patch/Patch_20240104.s.sol:DeployBase chain=base
 * verify-command: npx catapulta-verify -b broadcast/Patch_20240104.s.sol/8453/run-latest.json
 */
contract DeployBase is BaseScript, GenericDeploy {
  function _getPayload() internal override returns (bytes memory) {
    return type(AaveV3Base_Patch_20240104).creationCode;
  }
}

/**
 * @dev Deploy Gnosis
 * deploy-command: make deploy-ledger contract=src/20240104_Multi_Patch/Patch_20240104.s.sol:DeployGnosis chain=gnosis
 * verify-command: npx catapulta-verify -b broadcast/Patch_20240104.s.sol/100/run-latest.json
 */
contract DeployGnosis is GnosisScript, GenericDeploy {
  function _getPayload() internal override returns (bytes memory) {
    return type(AaveV3Gnosis_Patch_20240104).creationCode;
  }
}

/**
 * @dev Create Proposal
 * command: make deploy-ledger contract=src/20240104_Multi_Patch/Patch_20240104.s.sol:CreateProposal chain=mainnet
 */
contract CreateProposal is EthereumScript {
  function run() external {
    // create payloads
    PayloadsControllerUtils.Payload[] memory payloads = new PayloadsControllerUtils.Payload[](7);

    // compose actions for validation
    payloads[0] = GovV3Helpers.buildMainnetPayload(
      vm,
      GovV3Helpers.buildAction(type(AaveV3Ethereum_Patch_20240104).creationCode)
    );

    payloads[1] = GovV3Helpers.buildPolygonPayload(
      vm,
      GovV3Helpers.buildAction(type(AaveV3Polygon_Patch_20240104).creationCode)
    );

    payloads[2] = GovV3Helpers.buildAvalanchePayload(
      vm,
      GovV3Helpers.buildAction(type(AaveV3Avalanche_Patch_20240104).creationCode)
    );

    payloads[3] = GovV3Helpers.buildOptimismPayload(
      vm,
      GovV3Helpers.buildAction(type(AaveV3Optimism_Patch_20240104).creationCode)
    );

    payloads[4] = GovV3Helpers.buildArbitrumPayload(
      vm,
      GovV3Helpers.buildAction(type(AaveV3Arbitrum_Patch_20240104).creationCode)
    );

    payloads[5] = GovV3Helpers.buildBasePayload(
      vm,
      GovV3Helpers.buildAction(type(AaveV3Base_Patch_20240104).creationCode)
    );

    payloads[6] = GovV3Helpers.buildGnosisPayload(
      vm,
      GovV3Helpers.buildAction(type(AaveV3Gnosis_Patch_20240104).creationCode)
    );

    // create proposal
    vm.startBroadcast();
    GovV3Helpers.createProposal(
      vm,
      payloads,
      GovV3Helpers.ipfsHashFile(vm, 'src/20240104_Multi_Patch/Patch.md')
    );
  }
}
