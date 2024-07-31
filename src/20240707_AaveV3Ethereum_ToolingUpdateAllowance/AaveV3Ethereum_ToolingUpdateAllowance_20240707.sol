// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';

/**
 * @title Tooling Update Allowance
 * @author TokenLogic
 * - Snapshot: https://snapshot.org/#/aave.eth/proposal/0x461571b38365b12ebe39b80d4d9663daa9c7e574cd4bf190ec6fb48dec96371f
 * - Discussion: https://governance.aave.com/t/arfc-treasury-management-tooling-upgrade/15201
 */
contract AaveV3Ethereum_ToolingUpdateAllowance_20240707 is IProposalGenericExecutor {
  address public constant TOKEN_LOGIC = 0x3e4A9f478C0c13A15137Fc81e9d8269F127b4B40;
  uint256 public constant ALLOWANCE = 12_430 ether;

  function execute() external {
    AaveV3Ethereum.COLLECTOR.approve(AaveV3EthereumAssets.GHO_UNDERLYING, TOKEN_LOGIC, ALLOWANCE);
  }
}
