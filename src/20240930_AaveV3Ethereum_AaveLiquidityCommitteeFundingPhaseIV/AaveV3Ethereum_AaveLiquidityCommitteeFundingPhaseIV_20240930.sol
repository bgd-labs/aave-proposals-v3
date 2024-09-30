// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
/**
 * @title Aave Liquidity Committee Funding Phase IV
 * @author @karpatkey_TokenLogic
 * - Snapshot: https://snapshot.org/#/aave.eth/proposal/0x7b59c555f5a51a3377b1aee0f5f21fc205958f1388926efb94172644bacfa1d6
 * - Discussion: https://governance.aave.com/t/arfc-aave-liquidity-committee-funding-phase-iv/19188
 */
contract AaveV3Ethereum_AaveLiquidityCommitteeFundingPhaseIV_20240930 is IProposalGenericExecutor {
  // https://etherscan.io/address/0xA1c93D2687f7014Aaf588c764E3Ce80aF016229b
  address public constant ALC_SAFE = 0xA1c93D2687f7014Aaf588c764E3Ce80aF016229b;
  uint256 public constant AMOUNT = 950_000e18;

  function execute() external {
    AaveV3Ethereum.COLLECTOR.approve(AaveV3EthereumAssets.GHO_UNDERLYING, ALC_SAFE, AMOUNT);
  }
}
