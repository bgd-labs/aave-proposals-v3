// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Arbitrum} from 'aave-address-book/AaveV3Arbitrum.sol';
import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';

/**
 * @title addFlashborrowers
 * @author Aave Chan Initiative
 * - Snapshot: https://snapshot.org/#/aave.eth/proposal/0x09bb9e7cffc974d330d82ce7a0b0502b573d6f3b4f839ea15d6629613901e96d
 * - Discussion: https://governance.aave.com/t/arfc-add-contango-protocol-cian-protocol-and-index-coop-to-flashborrowers-on-aave-v3/16478
 */
contract AaveV3Arbitrum_AddFlashborrowers_20240306 is IProposalGenericExecutor {
  address public constant CONTANGO_PROTOCOL = 0x5e2aDC1F256f990D73a69875E06AF8A8404e3a03;

  function execute() external {
    AaveV3Arbitrum.ACL_MANAGER.addFlashBorrower(CONTANGO_PROTOCOL);
  }
}
