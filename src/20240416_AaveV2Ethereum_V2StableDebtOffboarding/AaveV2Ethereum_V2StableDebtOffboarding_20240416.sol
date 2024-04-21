// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV2Ethereum} from 'aave-address-book/AaveV2Ethereum.sol';
import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';
/**
 * @title V2 Stable Debt Offboarding
 * @author BGD Labs @bgdlabs
 * - Snapshot: https://snapshot.org/#/aave.eth/proposal/0xb58ef33b4b7f4c35b7a6834b24f11b282d713b5e9f527f29d782aef04886c189
 * - Discussion: https://governance.aave.com/t/bgd-full-deprecation-of-stable-rate/16473
 */
contract AaveV2Ethereum_V2StableDebtOffboarding_20240416 is IProposalGenericExecutor {
  address public constant LENDING_POOL_IMPL = 0x02D84abD89Ee9DB409572f19B6e1596c301F3c81;

  function execute() external {
    AaveV2Ethereum.POOL_ADDRESSES_PROVIDER.setLendingPoolImpl(LENDING_POOL_IMPL);
  }
}
