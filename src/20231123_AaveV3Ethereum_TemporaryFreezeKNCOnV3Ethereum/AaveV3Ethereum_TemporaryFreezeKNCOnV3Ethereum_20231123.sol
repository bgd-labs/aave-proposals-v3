// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3EthereumAssets, AaveV3Ethereum} from 'aave-address-book/AaveV3Ethereum.sol';
import {AaveV3PayloadEthereum} from 'aave-helpers/v3-config-engine/AaveV3PayloadEthereum.sol';

/**
 * @title Temporary Freeze KNC on V3 Ethereum
 * @author Chaos Labs
 * - Snapshot: Direct to AIP
 * - Discussion: https://governance.aave.com/t/arfc-temporary-freeze-knc-on-v3-ethereum/15654
 */
contract AaveV3Ethereum_TemporaryFreezeKNCOnV3Ethereum_20231123 is AaveV3PayloadEthereum {
  function _postExecute() internal override {
    AaveV3Ethereum.POOL_CONFIGURATOR.setReserveFreeze(AaveV3EthereumAssets.KNC_UNDERLYING, true);
  }
}
