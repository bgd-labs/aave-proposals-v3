// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV2Ethereum, AaveV2EthereumAssets} from 'aave-address-book/AaveV2Ethereum.sol';
import {GovernanceV3Ethereum} from 'aave-address-book/GovernanceV3Ethereum.sol';

import 'forge-std/Test.sol';
import {ProtocolV2TestBase, ReserveConfig} from 'aave-helpers/ProtocolV2TestBase.sol';
import {AaveV2Ethereum_MerklTest_20240409, IDistributionCreator} from './AaveV2Ethereum_MerklTest_20240409.sol';

/**
 * @dev Test for AaveV2Ethereum_MerklTest_20240409
 * command: make test-contract filter=AaveV2Ethereum_MerklTest_20240409
 */
contract AaveV2Ethereum_MerklTest_20240409_Test is ProtocolV2TestBase {
  AaveV2Ethereum_MerklTest_20240409 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 19627195);
    proposal = new AaveV2Ethereum_MerklTest_20240409();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest('AaveV2Ethereum_MerklTest_20240409', AaveV2Ethereum.POOL, address(proposal));
  }

  function test_dataCorrectness() public {
    executePayload(vm, address(proposal));

    IDistributionCreator.CampaignParameters memory campaign = proposal
      .DISTRIBUTION_CREATOR()
      .campaign(bytes32(0xf9c2eb37d44c3495bb42c51d2483f332ace5f1a0e02d828a3bc6f32e5d02ab30));

    assertEq(campaign.creator, GovernanceV3Ethereum.EXECUTOR_LVL_1);
    assertEq(campaign.rewardToken, AaveV2EthereumAssets.USDC_UNDERLYING);
    // assertEq(campaign.amount, 300_000e6);
    assertEq(campaign.campaignType, 4);
    assertGt(campaign.startTimestamp, block.timestamp);
    assertEq(campaign.duration, 3600);
    (string memory url, , ) = abi.decode(campaign.campaignData, (string, string, bytes));
    assertEq(url, proposal.FILE_URL());
  }
}
