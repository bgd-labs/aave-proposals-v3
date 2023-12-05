// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';

/**
 * @title GHO_Incident_Report
 * @author Aave Co.
 * - Snapshot: https://snapshot.org/#/aave.eth/proposal/0x87098e081bb28ad8a28f02886303c75e83593c3e25764626ccf4cf584e230c75
 * - Discussion: https://governance.aave.com/t/arfc-gho-bounty-for-integration-issue-detection/15296
 */
contract AaveV3Ethereum_GHO_Incident_Report_20231122 is IProposalGenericExecutor {
  address public constant RECEIVER = 0x7D51910845011B41Cc32806644dA478FEfF2f11F;

  uint256 public constant GHO_AMOUNT = 50_000e18;

  function execute() external {
    // transfers gho tokens to incident reporter
    AaveV3Ethereum.COLLECTOR.transfer(AaveV3EthereumAssets.GHO_UNDERLYING, RECEIVER, GHO_AMOUNT);
  }
}
