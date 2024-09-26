// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers, IPayloadsControllerCore} from 'aave-helpers/src/GovV3Helpers.sol';
import {ZkSyncScript} from 'aave-helpers/src/ScriptUtils.sol';

library Payloads {
  address internal constant POLYGON = 0x78DFB8b12bbCc65f415284f3C1ffA412678a725d;
  address internal constant GNOSIS = 0xe427FCbD54169136391cfEDf68E96abB13dA87A0;
  address internal constant OPTIMISM = 0x09B5429d2c70b31379dAfAdC3F0fa015306a8d04;
  address internal constant ARBITRUM = 0xAdDb96Fb6A795faf042DD25BD4710267C41D1F74;
  address internal constant AVALANCHE = 0x09262648Fce84992B68AbF216BfC47731F154462;
  address internal constant BASE = 0x84B08568906ee891de1c23175E5B92d7Df7DDCc4;
  address internal constant SCROLL = 0x89654c66A6abd7174b525D05C2f4c442a615cee8;
  address internal constant BNB = 0xe88fb4EAf67Ea87BB458e24C94BEf0EB02b5F449;
  address internal constant PROTO = 0xb08c48659d6035698B0f1a61deA9C14a59f89622;
  address internal constant ZKSYNC = 0x2d32D84459344D2977928563c7c1F13E1bC69658;
  address internal constant METIS = 0x84B08568906ee891de1c23175E5B92d7Df7DDCc4;
  address internal constant LIDO = 0xf519083f06D2cD0Aa6dd780f0D06b2987a77F290;
  address internal constant ETHERFI = 0x4E48C38a08388c29d9b71c657367e0D0cEf3A790;
}

/**
 * @dev Deploy ZkSync
 * deploy-command: make deploy-ledger contract=zksync/src/20240924_Multi_UpgradeAllAaveInstancesTo32/UpgradeAllAaveInstancesTo32_20240924.s.sol:DeployZkSync chain=zksync
 * verify-command: FOUNDRY_PROFILE=zksync npx catapulta-verify -b broadcast/UpgradeAllAaveInstancesTo32_20240924.s.sol/324/run-latest.json
 */
contract DeployZkSync is ZkSyncScript {
  function run() external broadcast {
    // compose action
    IPayloadsControllerCore.ExecutionAction[]
      memory actions = new IPayloadsControllerCore.ExecutionAction[](1);
    actions[0] = GovV3Helpers.buildAction(0x2d32D84459344D2977928563c7c1F13E1bC69658);

    // register action at payloadsController
    GovV3Helpers.createPayload(actions);
  }
}
