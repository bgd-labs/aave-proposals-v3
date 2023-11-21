// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Ethereum} from 'aave-address-book/AaveV3Ethereum.sol';
import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV3Ethereum_AaveTreasuryRWAAllocation_20231121} from './AaveV3Ethereum_AaveTreasuryRWAAllocation_20231121.sol';

/**
 * @dev Test for AaveV3Ethereum_AaveTreasuryRWAAllocation_20231121
 * command: make test-contract filter=AaveV3Ethereum_AaveTreasuryRWAAllocation_20231121
 */
contract AaveV3Ethereum_AaveTreasuryRWAAllocation_20231121_Test is ProtocolV3TestBase {
  AaveV3Ethereum_AaveTreasuryRWAAllocation_20231121 internal proposal;
  event Decision(string agreed);

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 18620189);
    proposal = new AaveV3Ethereum_AaveTreasuryRWAAllocation_20231121();
  }

  function test_defaultProposalExecution() public {
    // Setting up expected event emission
    vm.expectEmit();
    emit Decision(
      'The Aave DAO approves and ratify the following documents : \n\n1) the articles of Association : https://centrifuge.mypinata.cloud/ipfs/QmSn1Jx4PCPCvJDwx5JHqAcrCYFtCdVGtXc2Dcmk8NFauM\n\n2) The Memorandum Of association : https://centrifuge.mypinata.cloud/ipfs/QmeNnARf9CqLQ9krQn8b4UCnBaWhUhLryEBqrVqW9cuTjV This AIP payload also serves as a DAO resolution approving, authorizing and empowering Leeward Management Limited to do all acts necessary to onboard with and enter into the Subscription Agreement for the Anemoy Liquid Treasury Fund 1 (the "Fund") with an initial investment of the equivalent of $1m in shares including executing any and all documentation necessary to further the investment in the Fund'
    );

    // Execute the proposal and run the test
    defaultTest(
      'AaveV3Ethereum_AaveTreasuryRWAAllocation_20231121',
      AaveV3Ethereum.POOL,
      address(proposal)
    );
  }
}
