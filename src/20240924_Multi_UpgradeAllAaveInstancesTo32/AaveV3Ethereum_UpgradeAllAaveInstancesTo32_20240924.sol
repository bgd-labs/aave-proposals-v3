// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';

/**
 * @title Audit cost reimbursement
 * @author BGD labs
 * - Discussion: https://governance.aave.com/t/bgd-aave-v3-2-liquid-emodes/19037/4#p-48735-activation-stage-3
 */
contract AaveV3Ethereum_UpgradeAllAaveInstancesTo32_20240924 is IProposalGenericExecutor {
  address public constant BGD_RECEIVER = 0xb812d0944f8F581DfAA3a93Dda0d22EcEf51A9CF;

  function execute() external {
    AaveV3Ethereum.COLLECTOR.transfer(
      AaveV3EthereumAssets.GHO_UNDERLYING,
      BGD_RECEIVER,
      76_000 ether
    );
  }
}
