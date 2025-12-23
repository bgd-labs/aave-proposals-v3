// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {CollectorUtils, ICollector} from 'aave-helpers/src/CollectorUtils.sol';

/**
 * @title Migrate automated risk update infra to chaos agents
 * @author BGD Labs (@bgdlabs)
 * - Snapshot: https://snapshot.org/#/s:aavedao.eth/proposal/0x9795f1b7057d2780b3382b9f67f309fbfead98e7357a88df4c309dbbfefcbeb7
 * - Discussion: https://governance.aave.com/t/arfc-chaos-risk-agents/23401
 */
contract AaveV3Ethereum_ReimburseLinkForRobot_20251201 is IProposalGenericExecutor {
  using CollectorUtils for ICollector;

  uint256 public constant LINK_AMOUNT = 120 ether;
  address public constant BGD_RECEIVER = 0xb812d0944f8F581DfAA3a93Dda0d22EcEf51A9CF;

  function execute() external {
    AaveV3Ethereum.COLLECTOR.withdrawFromV3(
      CollectorUtils.IOInput({
        pool: address(AaveV3Ethereum.POOL),
        underlying: AaveV3EthereumAssets.LINK_UNDERLYING,
        amount: LINK_AMOUNT
      }),
      BGD_RECEIVER
    );
  }
}
