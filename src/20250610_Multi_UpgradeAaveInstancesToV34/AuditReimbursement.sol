// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';

contract AuditReimbursement is IProposalGenericExecutor {
  address public constant BGD_SAFE = 0xb812d0944f8F581DfAA3a93Dda0d22EcEf51A9CF;

  function execute() external {
    AaveV3Ethereum.COLLECTOR.transfer(
      IERC20(AaveV3EthereumAssets.USDT_A_TOKEN),
      BGD_SAFE,
      213_125e6
    );
  }
}
