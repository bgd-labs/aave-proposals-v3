// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {CollectorUtils, ICollector} from 'aave-helpers/src/CollectorUtils.sol';
/**
 * @title Aave V3.3 Sherlock Contest Funding
 * @author BGD Labs @bgdlabs
 * - Snapshot: https://snapshot.box/#/s:aave.eth/proposal/0x8c04404012d9b74c3e7cebff2ddff3c9d40a280b4cfa7c2fca42be2a59b005ee
 * - Discussion: https://governance.aave.com/t/arfc-bgd-aave-v3-3-sherlock-contest/20498
 */
contract AaveV3Ethereum_AaveV33SherlockContestFunding_20250106 is IProposalGenericExecutor {
  using CollectorUtils for ICollector;

  address public constant BGD_RECIPIENT = 0xb812d0944f8F581DfAA3a93Dda0d22EcEf51A9CF;
  address public constant SHERLOCK_RECIPIENT = 0x666B8EbFbF4D5f0CE56962a25635CfF563F13161;

  uint256 public constant BGD_USDC_AMOUNT = 30_000e6;
  uint256 public constant SHERLOCK_USDC_AMOUNT = 200_000e6;

  function execute() external {
    AaveV3Ethereum.COLLECTOR.withdrawFromV3(
      CollectorUtils.IOInput({
        pool: address(AaveV3Ethereum.POOL),
        underlying: AaveV3EthereumAssets.USDC_UNDERLYING,
        amount: BGD_USDC_AMOUNT
      }),
      BGD_RECIPIENT
    );

    AaveV3Ethereum.COLLECTOR.withdrawFromV3(
      CollectorUtils.IOInput({
        pool: address(AaveV3Ethereum.POOL),
        underlying: AaveV3EthereumAssets.USDC_UNDERLYING,
        amount: SHERLOCK_USDC_AMOUNT
      }),
      SHERLOCK_RECIPIENT
    );
  }
}
