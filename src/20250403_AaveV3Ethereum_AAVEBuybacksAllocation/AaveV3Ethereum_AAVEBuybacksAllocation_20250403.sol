// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';

/**
 * @title AAVE Buybacks allocation
 * @author ACI
 * - Snapshot: https://snapshot.box/#/s:aave.eth/proposal/0xf0591fe8e54900da9929fe25c466c2b4a0fac6e8f7a3a000087797363847fb65
 * - Discussion: https://governance.aave.com/t/arfc-aavenomics-implementation-part-one/21248
 */
contract AaveV3Ethereum_AAVEBuybacksAllocation_20250403 is IProposalGenericExecutor {
  address public constant AFC = 0x22740deBa78d5a0c24C58C740e3715ec29de1bFa;

  uint256 public constant USDT_AMOUNT = 4_000_000 * 10 ** 6; // 4M USDT

  function execute() external {
    // Approve USDT from Collector to AFC
    AaveV3Ethereum.COLLECTOR.approve(IERC20(AaveV3EthereumAssets.USDT_A_TOKEN), AFC, USDT_AMOUNT);
  }
}
