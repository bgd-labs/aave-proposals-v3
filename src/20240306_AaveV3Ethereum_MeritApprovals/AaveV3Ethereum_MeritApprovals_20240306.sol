// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';

/**
 * @title Merit Approvals
 * @author karpatkey_TokenLogic_ACI
 * - Snapshot: https://snapshot.org/#/aave.eth/proposal/0xc80da83fadfe4f8a4c56e1643895cb7e9b1af1d9dcd374f1b41ded5c95b42f68
 * - Discussion: https://governance.aave.com/t/arfc-merit-a-new-aave-alignment-user-reward-system/16646
 */
contract AaveV3Ethereum_MeritApprovals_20240306 is IProposalGenericExecutor {
  uint256 public constant GHO_ALLOWANCE = 2_900_000 ether;
  uint256 public constant WETH_V3_ALLOWANCE = 600 ether;
  address public constant MERIT_WALLET = 0xdeadD8aB03075b7FBA81864202a2f59EE25B312b;

  function execute() external {
    AaveV3Ethereum.COLLECTOR.approve(
      AaveV3EthereumAssets.GHO_UNDERLYING,
      MERIT_WALLET,
      GHO_ALLOWANCE
    );
    AaveV3Ethereum.COLLECTOR.approve(
      AaveV3EthereumAssets.WETH_A_TOKEN,
      MERIT_WALLET,
      WETH_V3_ALLOWANCE
    );
  }
}
