// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';
import {IDistributionCreator} from './interfaces/IDistributionCreator.sol';
import {SafeERC20} from 'solidity-utils/contracts/oz-common/SafeERC20.sol';

/**
 * @title aAMPL Second Distribution
 * @author BGD Labs (@bgdlabs)
 * - Snapshot: https://snapshot.org/#/aave.eth/proposal/0x372ea60168390ca30be8890ae18ba3c1bb171428ad613a3c8c1a568721c1d65d
 * - Discussion: https://governance.aave.com/t/arfc-aampl-second-distribution/17464
 */
contract AaveV2Ethereum_AAMPLSecondDistribution_20240429 is IProposalGenericExecutor {
  using SafeERC20 for IERC20;

  IDistributionCreator public constant DISTRIBUTION_CREATOR =
    IDistributionCreator(0x8BB4C975Ff3c250e0ceEA271728547f3802B36Fd);
  address public constant REWARD_TOKEN = AaveV3EthereumAssets.USDC_A_TOKEN;
  uint256 public constant REWARD_AMOUNT_PLUS_FEES = 766_436_793678;
  string public constant FILE_URL =
    'https://angle-blog.infura-ipfs.io/ipfs/QmTvv4u6MUb6cwThCi7tma1ZJ1XUe9mQmaGcHEmLZhazre';

  function execute() external {
    // 1. send funds to executor (0.5% fee for angle merkle distributor)
    AaveV3Ethereum.COLLECTOR.transfer(
      AaveV3EthereumAssets.USDC_A_TOKEN,
      address(this),
      REWARD_AMOUNT_PLUS_FEES + 1 // account for imprecision on transfer
    );

    uint256 aUSDCBalance = IERC20(AaveV3EthereumAssets.USDC_A_TOKEN).balanceOf(address(this));

    // 2. approve to merkl
    IERC20(REWARD_TOKEN).forceApprove(address(DISTRIBUTION_CREATOR), aUSDCBalance);

    // 3. create campaign
    IDistributionCreator.CampaignParameters memory newCampaign = IDistributionCreator
      .CampaignParameters({
        campaignId: '',
        creator: address(0),
        rewardToken: REWARD_TOKEN,
        amount: aUSDCBalance,
        campaignType: 4,
        startTimestamp: uint32(block.timestamp + 2 hours),
        duration: 1 hours,
        campaignData: abi.encode(FILE_URL, string(''), bytes('0x'))
      });
    DISTRIBUTION_CREATOR.createCampaign(newCampaign);
  }
}
