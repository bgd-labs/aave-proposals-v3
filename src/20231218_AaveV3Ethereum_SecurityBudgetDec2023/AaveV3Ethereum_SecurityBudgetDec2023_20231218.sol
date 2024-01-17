// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';

/**
 * @title Security Budget Dec 2023
 * @author BGD Labs (@bgdlabs)
 * - Snapshot: https://snapshot.org/#/aave.eth/proposal/0xf95bc210e3e93c2112c694cb158db22c93504155b48c03d9358e4c41c33ee782
 * - Discussion: https://governance.aave.com/t/arfc-bgd-security-budget-request-december-2023/15783
 */
contract AaveV3Ethereum_SecurityBudgetDec2023_20231218 is IProposalGenericExecutor {
  address public constant BGD = 0xb812d0944f8F581DfAA3a93Dda0d22EcEf51A9CF;

  address public constant CANTINA = 0x3Dcb7CFbB431A11CAbb6f7F2296E2354f488Efc2;

  function execute() external {
    AaveV3Ethereum.COLLECTOR.transfer(AaveV3EthereumAssets.DAI_A_TOKEN, BGD, 42_000 ether);

    AaveV3Ethereum.COLLECTOR.transfer(AaveV3EthereumAssets.USDC_A_TOKEN, address(this), 109_200e6);
    AaveV3Ethereum.POOL.withdraw(AaveV3EthereumAssets.USDC_UNDERLYING, type(uint256).max, CANTINA);
  }
}
