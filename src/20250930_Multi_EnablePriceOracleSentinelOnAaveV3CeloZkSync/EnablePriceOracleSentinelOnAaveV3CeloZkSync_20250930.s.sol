// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers, IPayloadsControllerCore, PayloadsControllerUtils} from 'aave-helpers/src/GovV3Helpers.sol';
import {GovernanceV3Ethereum} from 'aave-address-book/GovernanceV3Ethereum.sol';
import {EthereumScript, CeloScript, ChainIds} from 'solidity-utils/contracts/utils/ScriptUtils.sol';
import {GovernanceV3ZkSync} from 'aave-address-book/GovernanceV3ZkSync.sol';

import {AaveV3Celo_EnablePriceOracleSentinelOnAaveV3CeloZkSync_20250930} from './AaveV3Celo_EnablePriceOracleSentinelOnAaveV3CeloZkSync_20250930.sol';

/**
 * @dev Deploy Celo
 * deploy-command: make deploy-ledger contract=src/20250930_Multi_EnablePriceOracleSentinelOnAaveV3CeloZkSync/EnablePriceOracleSentinelOnAaveV3CeloZkSync_20250930.s.sol:DeployCelo chain=celo
 * verify-command: FOUNDRY_PROFILE=deploy npx catapulta-verify -b broadcast/EnablePriceOracleSentinelOnAaveV3CeloZkSync_20250930.s.sol/42220/run-latest.json
 */
contract DeployCelo is CeloScript {
  function run() external broadcast {
    // deploy payloads
    address payload0 = GovV3Helpers.deployDeterministic(
      type(AaveV3Celo_EnablePriceOracleSentinelOnAaveV3CeloZkSync_20250930).creationCode
    );

    // compose action
    IPayloadsControllerCore.ExecutionAction[]
      memory actions = new IPayloadsControllerCore.ExecutionAction[](1);
    actions[0] = GovV3Helpers.buildAction(payload0);

    // register action at payloadsController
    GovV3Helpers.createPayload(actions);
  }
}

/**
 * @dev Create Proposal
 * command: make deploy-ledger contract=src/20250930_Multi_EnablePriceOracleSentinelOnAaveV3CeloZkSync/EnablePriceOracleSentinelOnAaveV3CeloZkSync_20250930.s.sol:CreateProposal chain=mainnet
 */
contract CreateProposal is EthereumScript {
  function run() external {
    // create payloads
    PayloadsControllerUtils.Payload[] memory payloads = new PayloadsControllerUtils.Payload[](2);

    // compose actions for validation
    {
      payloads[0] = PayloadsControllerUtils.Payload({
        chain: ChainIds.ZKSYNC,
        accessLevel: PayloadsControllerUtils.AccessControl.Level_1,
        payloadsController: address(GovernanceV3ZkSync.PAYLOADS_CONTROLLER),
        payloadId: 0 // TODO
      });
    }

    {
      IPayloadsControllerCore.ExecutionAction[]
        memory actionsCelo = new IPayloadsControllerCore.ExecutionAction[](1);
      actionsCelo[0] = GovV3Helpers.buildAction(
        type(AaveV3Celo_EnablePriceOracleSentinelOnAaveV3CeloZkSync_20250930).creationCode
      );
      payloads[1] = GovV3Helpers.buildCeloPayload(vm, actionsCelo);
    }

    // create proposal
    vm.startBroadcast();
    GovV3Helpers.createProposal(
      vm,
      payloads,
      GovernanceV3Ethereum.VOTING_PORTAL_ETH_AVAX,
      GovV3Helpers.ipfsHashFile(
        vm,
        'src/20250930_Multi_EnablePriceOracleSentinelOnAaveV3CeloZkSync/EnablePriceOracleSentinelOnAaveV3CeloZkSync.md'
      )
    );
  }
}
