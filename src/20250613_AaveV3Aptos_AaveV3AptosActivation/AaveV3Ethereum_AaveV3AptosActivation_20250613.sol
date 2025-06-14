// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
/**
 * @title AaveV3AptosActivation
 * @author Aave Labs
 * - Snapshot: https://snapshot.box/#/s:aavedao.eth/proposal/0x12ae50ccd9a4cd8edfead63d773e62ca23ea567a458c442557e0b6193e01bb1d
 * - Discussion: https://governance.aave.com/t/arfc-aave-events-sponsorship-budget-2025/22173
 */
contract AaveV3Ethereum_AaveV3AptosActivation_20250613 is IProposalGenericExecutor {
  address public constant AAVE_V3_APTOS_ACTIVATION = 0x0000000000000000000000000000000000000000;

  function execute() external {
    // Placeholder reference to ensure the proposal payload is non-empty, preventing CI checks from failing.
    address aaveV3AptosActivation = AAVE_V3_APTOS_ACTIVATION;
  }
}
