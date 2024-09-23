// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {GovernanceV3Ethereum} from 'aave-address-book/GovernanceV3Ethereum.sol';
import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {SafeERC20} from 'solidity-utils/contracts/oz-common/SafeERC20.sol';
import {AaveV3Ethereum} from 'aave-address-book/AaveV3Ethereum.sol';

/**
 * @title tBTC Seed
 * @author BGD Labs (@bgdlabs)
 */
contract AaveV3Ethereum_TBTCSeed_20240923 is IProposalGenericExecutor {
  using SafeERC20 for IERC20;

  address public constant TBTC = 0x18084fbA666a33d37592fA2633fD49a74DD93a88;
  uint256 public constant SEED_AMOUNT = 0.002 ether;
  uint40 public constant PAYLOAD_ID = 175;

  function execute() external {
    GovernanceV3Ethereum.PAYLOADS_CONTROLLER.executePayload(PAYLOAD_ID);

    IERC20(TBTC).forceApprove(address(AaveV3Ethereum.POOL), SEED_AMOUNT);
    AaveV3Ethereum.POOL.supply(TBTC, SEED_AMOUNT, address(AaveV3Ethereum.COLLECTOR), 0);
  }
}
