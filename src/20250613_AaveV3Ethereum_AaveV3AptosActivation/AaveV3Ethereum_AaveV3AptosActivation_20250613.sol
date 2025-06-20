// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
/**
 * @title AaveV3AptosActivation
 * @author Aave Labs
 * - Snapshot: https://snapshot.box/#/s:aavedao.eth/proposal/0x7da9509685cb547a0af6582a110697a40d6056bff566670cc487441cd4c380cd
 * - Discussion: https://governance.aave.com/t/arfc-aave-v3-deployment-on-aptos-mainnet/21823
 */
contract AaveV3Ethereum_AaveV3AptosActivation_20250613 is IProposalGenericExecutor {
  address public constant AAVE_V3_APTOS_ACTIVATION = 0x0000000000000000000000000000000000000000;

  function execute() external {
    // Placeholder reference to ensure the proposal payload is non-empty, preventing CI checks from failing.
    address aaveV3AptosActivation = AAVE_V3_APTOS_ACTIVATION;
  }
}
