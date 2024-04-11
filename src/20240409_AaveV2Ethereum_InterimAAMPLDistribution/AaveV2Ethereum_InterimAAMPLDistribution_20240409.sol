// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

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
 * @title Interim aAMPL distribution
 * @author BGD Labs
 * - Snapshot: https://snapshot.org/#/aave.eth/proposal/0xb7226dd6441b67225924082215f7a512bfd98252897ee43a879084e07ab53607
 * - Discussion: https://governance.aave.com/t/arfc-aampl-interim-distribution/17184
 */
contract AaveV2Ethereum_InterimAAMPLDistribution_20240409 is IProposalGenericExecutor {
  IDistributionCreator public constant DISTRIBUTION_CREATOR =
    IDistributionCreator(0x8BB4C975Ff3c250e0ceEA271728547f3802B36Fd);
  address public constant REWARD_TOKEN = AaveV2EthereumAssets.USDC_UNDERLYING;
  uint256 public constant REWARD_AMOUNT_PLUS_FEES = 298_543_522_440;
  string public constant FILE_URL =
    'https://angle-blog.infura-ipfs.io/ipfs/Qmb9uJbEdppQsL8W4aVKxREoHo42iXtcp4CV1FLE5tY8Rt';

  function execute() external {
    // 1. send funds to executor
    // 0.5% fee for angle merkle distributor
    AaveV2Ethereum.COLLECTOR.transfer(
      AaveV2EthereumAssets.USDC_A_TOKEN,
      address(this),
      REWARD_AMOUNT_PLUS_FEES + 1 // account for imprecision on transfer
    );
    AaveV2Ethereum.POOL.withdraw(REWARD_TOKEN, REWARD_AMOUNT_PLUS_FEES, address(this));
    // 2. approve to merkl
    IERC20(REWARD_TOKEN).approve(address(DISTRIBUTION_CREATOR), REWARD_AMOUNT_PLUS_FEES);
    // 3. accept tos
    DISTRIBUTION_CREATOR.acceptConditions();
    // 4.create campaign
    IDistributionCreator.CampaignParameters memory newCampaign = IDistributionCreator
      .CampaignParameters({
        campaignId: '',
        creator: address(0),
        rewardToken: REWARD_TOKEN,
        amount: REWARD_AMOUNT_PLUS_FEES,
        campaignType: 4,
        startTimestamp: uint32(block.timestamp + 2 hours),
        duration: 1 hours,
        campaignData: abi.encode(FILE_URL, string(''), bytes('0x'))
      });
    DISTRIBUTION_CREATOR.createCampaign(newCampaign);
  }
}
