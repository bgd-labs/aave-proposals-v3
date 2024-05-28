// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV2Ethereum} from 'aave-address-book/AaveV2Ethereum.sol';
import {AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {ProtocolV2TestBase} from 'aave-helpers/ProtocolV2TestBase.sol';
import {AaveV2Ethereum_AAMPLSecondDistribution_20240429, IDistributionCreator} from './AaveV2Ethereum_AAMPLSecondDistribution_20240429.sol';
import {GovernanceV3Ethereum} from 'aave-address-book/GovernanceV3Ethereum.sol';

/**
 * @dev Test for AaveV2Ethereum_AAMPLSecondDistribution_20240429
 * command: make test-contract filter=AaveV2Ethereum_AAMPLSecondDistribution_20240429
 */
contract AaveV2Ethereum_AAMPLSecondDistribution_20240429_Test is ProtocolV2TestBase {
  AaveV2Ethereum_AAMPLSecondDistribution_20240429 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 19761486);
    proposal = new AaveV2Ethereum_AAMPLSecondDistribution_20240429();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV2Ethereum_AAMPLSecondDistribution_20240429',
      AaveV2Ethereum.POOL,
      address(proposal)
    );
  }

  function test_createCampaign() public {
    executePayload(vm, address(proposal));

    IDistributionCreator.CampaignParameters memory campaign = proposal
      .DISTRIBUTION_CREATOR()
      .campaign(bytes32(0x04538a26c6088b568f6364ccc59b577ece656177c84076ab281dba3ea91576c7));

    assertEq(campaign.creator, GovernanceV3Ethereum.EXECUTOR_LVL_1);
    assertEq(campaign.rewardToken, proposal.REWARD_TOKEN());
    assertLt(campaign.amount, proposal.REWARD_AMOUNT_PLUS_FEES() + 1);
    assertEq(campaign.campaignType, 4);
    assertGt(campaign.startTimestamp, block.timestamp);
    assertEq(campaign.duration, 3600);
    (string memory url, , ) = abi.decode(campaign.campaignData, (string, string, bytes));
    assertEq(url, proposal.FILE_URL());
  }
}
