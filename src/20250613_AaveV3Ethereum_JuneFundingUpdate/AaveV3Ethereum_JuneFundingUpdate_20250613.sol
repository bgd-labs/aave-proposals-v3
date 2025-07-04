// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {AaveV3EthereumLidoAssets} from 'aave-address-book/AaveV3EthereumLido.sol';
import {MiscEthereum} from 'aave-address-book/MiscEthereum.sol';
import {CollectorUtils, ICollector} from 'aave-helpers/src/CollectorUtils.sol';
import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';

/**
 * @title June Funding Update
 * @author @TokenLogic
 * - Snapshot: Direct-to-AIP
 * - Discussion: https://governance.aave.com/t/direct-to-aip-june-2025-funding-update/22352/2
 */
contract AaveV3Ethereum_JuneFundingUpdate_20250613 is IProposalGenericExecutor {
  using CollectorUtils for ICollector;

  /// Approvals Constants
  /// https://etherscan.io/address/0x22740deBa78d5a0c24C58C740e3715ec29de1bFa
  address public constant AFC_SAFE = 0x22740deBa78d5a0c24C58C740e3715ec29de1bFa;
  uint256 public constant AFC_USDT_ALLOWANCE = 2_000_000e6;

  function execute() external {
    // AFC aEthUSDT Approval
    AaveV3Ethereum.COLLECTOR.approve(
      IERC20(AaveV3EthereumAssets.USDT_A_TOKEN),
      AFC_SAFE,
      AFC_USDT_ALLOWANCE
    );
  }
}
