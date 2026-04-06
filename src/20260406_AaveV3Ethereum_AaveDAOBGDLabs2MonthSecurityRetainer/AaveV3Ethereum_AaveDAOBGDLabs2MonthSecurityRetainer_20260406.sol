// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {ICollector, CollectorUtils} from 'aave-helpers/src/CollectorUtils.sol';
import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';

/**
 * @title Aave DAO <> BGD Labs. 2-month security retainer
 * @author BGD Labs (@bgdlabs)
 * - Snapshot: Direct To AIP
 * - Discussion: https://governance.aave.com/t/direct-to-aip-aave-dao-bgd-labs-2-month-security-retainer/24385
 */
contract AaveV3Ethereum_AaveDAOBGDLabs2MonthSecurityRetainer_20260406 is IProposalGenericExecutor {
  using CollectorUtils for ICollector;

  address public constant BGD_RECEIVER = 0xb812d0944f8F581DfAA3a93Dda0d22EcEf51A9CF;
  uint256 public constant BGD_REIMBURSE_USDT_AMOUNT = 200_000e6;

  function execute() external {
    AaveV3Ethereum.COLLECTOR.withdrawFromV3(
      CollectorUtils.IOInput({
        pool: address(AaveV3Ethereum.POOL),
        underlying: AaveV3EthereumAssets.USDT_UNDERLYING,
        amount: BGD_REIMBURSE_USDT_AMOUNT
      }),
      BGD_RECEIVER
    );
  }
}
