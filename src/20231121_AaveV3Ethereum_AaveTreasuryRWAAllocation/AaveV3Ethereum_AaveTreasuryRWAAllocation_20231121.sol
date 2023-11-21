// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';

/**
 * @title Activation of A-C Prime Foundation
 * @author @Khan - Centrifuge (Powered By ACI Skywards)
 * - Snapshot: https://snapshot.org/#/aave.eth/proposal/0x71db494e4b49e7533c5ccaa566686b2d045b0761cb3296a2d77af4b500566eb0
 * - Discussion: https://governance.aave.com/t/arfc-aave-treasury-rwa-allocation/14790
 */
contract AaveV3Ethereum_AaveTreasuryRWAAllocation_20231121 is IProposalGenericExecutor {
  event Decision(string agreed);

  function execute() external {
    // This AIP payload serves as a DAO resolution providing binding approval from the Aave DAO to do all acts necessary to establish and incorporate the A-C Foundation, appoint and authorize Leeward Management Limited as registered office, supervisor and director, and approve and ratify the following documents :
    // The Articles of Association and the Memorandum of Association
    // This AIP payload also serves as a DAO resolution approving, authorizing and empowering Leeward Management Limited to do all acts necessary to onboard with and enter into the Subscription Agreement for the Anemoy Liquid Treasury Fund 1 (the “Fund”) with an initial investment of the equivalent of $1m in shares including executing any and all documentation necessary to further the investment in the Fund

    emit Decision(
      'The Aave DAO approves and ratify the following documents : \n\n1) the articles of Association : https://centrifuge.mypinata.cloud/ipfs/QmSn1Jx4PCPCvJDwx5JHqAcrCYFtCdVGtXc2Dcmk8NFauM\n\n2) The Memorandum Of association : https://centrifuge.mypinata.cloud/ipfs/QmeNnARf9CqLQ9krQn8b4UCnBaWhUhLryEBqrVqW9cuTjV This AIP payload also serves as a DAO resolution approving, authorizing and empowering Leeward Management Limited to do all acts necessary to onboard with and enter into the Subscription Agreement for the Anemoy Liquid Treasury Fund 1 (the "Fund") with an initial investment of the equivalent of $1m in shares including executing any and all documentation necessary to further the investment in the Fund'
    );
  }
}
