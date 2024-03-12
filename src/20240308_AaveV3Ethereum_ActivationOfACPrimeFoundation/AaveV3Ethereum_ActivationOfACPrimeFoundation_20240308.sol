// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';

/**
 * @title Activation of A-C Prime Foundation
 * @author @Khan
 * - Snapshot: https://snapshot.org/#/aave.eth/proposal/0x71db494e4b49e7533c5ccaa566686b2d045b0761cb3296a2d77af4b500566eb0
 * - Discussion: https://governance.aave.com/t/arfc-aave-treasury-rwa-allocation/14790
 */
contract AaveV3Ethereum_ActivationOfACPrimeFoundation_20240308 is IProposalGenericExecutor {
  event Decision(string agreed);

  function execute() external {
    // This AIP payload serves as a DAO resolution providing binding approval from the Aave DAO to approve and ratify the following documents:
    // 1. The Articles of Association
    // 2. The Memorandum of Association

    emit Decision(
      'The Aave DAO approves and ratifies the following documents: \n\n 1) The articles of Association: https://cloudflare-ipfs.com/ipfs/QmXvgvLb87tFr8JmJjx7pAThAU1gAsHFLqdMa12zt2f6R6) \n\n 2) The Memorandum Of Association: https://cloudflare-ipfs.com/ipfs/QmaB3Z4oN4Bcc4SEZ8WH2duKLpPqRYKqYC5TMqpQaddfrB \n\n'
    );
  }
}
