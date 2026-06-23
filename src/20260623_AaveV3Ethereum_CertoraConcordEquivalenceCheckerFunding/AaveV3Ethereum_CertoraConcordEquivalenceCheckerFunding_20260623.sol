// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';

/**
 * @title Certora Concord Equivalence Checker Funding
 * @author Certora (implemented by Aave Labs)
 * - Snapshot: https://snapshot.org/#/s:aavedao.eth/proposal/0xcf9ca2d7a9b1ee819b6b76f8dae1cdc7fb507e027f044e90d7937b4b264a42c1
 * - Discussion: https://governance.aave.com/t/arfc-strengthening-upgrade-safety-concord-equivalence-checker-by-certora/24713
 */
contract AaveV3Ethereum_CertoraConcordEquivalenceCheckerFunding_20260623 is
  IProposalGenericExecutor
{
  // https://etherscan.io/address/0x0f11640bF66E2d9352D9c41434A5C6E597C5E4c8
  address public constant CERTORA_RECEIVER = 0x0F11640BF66e2D9352d9c41434A5C6E597c5e4c8;

  uint256 public constant FUNDING_AMOUNT = 50_000e18;

  function execute() external {
    AaveV3Ethereum.COLLECTOR.transfer(
      IERC20(AaveV3EthereumAssets.GHO_UNDERLYING),
      CERTORA_RECEIVER,
      FUNDING_AMOUNT
    );
  }
}
