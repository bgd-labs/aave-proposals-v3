// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {AaveV2Ethereum, AaveV2EthereumAssets} from 'aave-address-book/AaveV2Ethereum.sol';
import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';

interface IDistributionCreator {
  struct CampaignParameters {
    // POPULATED ONCE CREATED

    // ID of the campaign. This can be left as a null bytes32 when creating campaigns
    // on Merkl.
    bytes32 campaignId;
    // CHOSEN BY CAMPAIGN CREATOR

    // Address of the campaign creator, if marked as address(0), it will be overriden with the
    // address of the `msg.sender` creating the campaign
    address creator;
    // Address of the token used as a reward
    address rewardToken;
    // Amount of `rewardToken` to distribute across all the epochs
    // Amount distributed per epoch is `amount/numEpoch`
    uint256 amount;
    // Type of campaign
    uint32 campaignType;
    // Timestamp at which the campaign should start
    uint32 startTimestamp;
    // Duration of the campaign in seconds. Has to be a multiple of EPOCH = 3600
    uint32 duration;
    // Extra data to pass to specify the campaign
    bytes campaignData;
  }

  function campaign(bytes32 id) external view returns (CampaignParameters memory);

  function acceptConditions() external;

  function createCampaign(CampaignParameters memory newCampaign) external returns (bytes32);
}

/**
 * @title Merkl test
 * @author BGD Labs
 * - Snapshot: TODO
 * - Discussion: TODO
 */
contract AaveV2Ethereum_MerklTest_20240409 is IProposalGenericExecutor {
  IDistributionCreator public constant DISTRIBUTION_CREATOR =
    IDistributionCreator(0x8BB4C975Ff3c250e0ceEA271728547f3802B36Fd);
  address public constant REWARD_TOKEN = AaveV2EthereumAssets.USDC_UNDERLYING;
  uint256 public constant REWARD_AMOUNT = 300_000e6;
  string public constant FILE_URL = 'TODO';

  function execute() external {
    // 1. send funds to executor
    // 0.5% fee for angle merkle distributor
    uint256 amountPlusFee = REWARD_AMOUNT + (REWARD_AMOUNT * 5) / 1000;
    AaveV2Ethereum.COLLECTOR.transfer(
      AaveV2EthereumAssets.USDC_A_TOKEN,
      address(this),
      amountPlusFee + 1 // account for imprecision on transfer
    );
    AaveV2Ethereum.POOL.withdraw(REWARD_TOKEN, amountPlusFee, address(this));
    // 2. approve to merkl
    IERC20(REWARD_TOKEN).approve(0x8BB4C975Ff3c250e0ceEA271728547f3802B36Fd, amountPlusFee);
    // 3. accept tos
    DISTRIBUTION_CREATOR.acceptConditions();
    // 4.create campaign
    IDistributionCreator.CampaignParameters memory newCampaign = IDistributionCreator
      .CampaignParameters({
        campaignId: '',
        creator: address(0),
        rewardToken: REWARD_TOKEN,
        amount: amountPlusFee,
        campaignType: 4,
        startTimestamp: uint32(block.timestamp + 2 hours),
        duration: 1 hours,
        campaignData: abi.encode(FILE_URL, string(''), bytes('0x'))
      });
    DISTRIBUTION_CREATOR.createCampaign(newCampaign);
  }
}
