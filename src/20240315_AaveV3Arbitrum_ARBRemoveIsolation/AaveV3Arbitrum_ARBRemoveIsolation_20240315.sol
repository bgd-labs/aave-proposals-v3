// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import {AaveV3Arbitrum, AaveV3ArbitrumAssets} from 'aave-address-book/AaveV3Arbitrum.sol';
import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';

/**
 * @title ARB Remove Isolation Mode
 * @author karpatkey_TokenLogic_ACI
 * - Snapshot: https://snapshot.org/#/aave.eth/proposal/0xbc5471496bbc2beda343625cee22c34fc9672785112cc5d19a25ca87c5b422c3
 * - Discussion: https://governance.aave.com/t/arfc-remove-arb-from-isolation-mode-on-arbitrum-market/16703
 */
contract AaveV3Arbitrum_ARBRemoveIsolation_20240315 is IProposalGenericExecutor {
  function execute() external {
    // set debtCeiling to 0 exits isolation Mode
    AaveV3Arbitrum.POOL_CONFIGURATOR.setDebtCeiling(AaveV3ArbitrumAssets.ARB_UNDERLYING, 0);
  }
}
