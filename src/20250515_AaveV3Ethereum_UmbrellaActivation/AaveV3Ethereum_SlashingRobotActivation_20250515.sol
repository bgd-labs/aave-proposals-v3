// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {SafeERC20} from 'openzeppelin-contracts/contracts/token/ERC20/utils/SafeERC20.sol';

import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {MiscEthereum} from 'aave-address-book/MiscEthereum.sol';

import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';

import {CollectorUtils} from 'aave-helpers/src/CollectorUtils.sol';

import {IAaveCLRobotOperator} from '../interfaces/IAaveCLRobotOperator.sol';

/**
 * @title UmbrellaActivation
 * @author BGD Labs (@bgdlabs)
 * - Snapshot: https://snapshot.box/#/s:aavedao.eth/proposal/0xbe792a1db33cd7803e23810553e5a6a728c3ac15827ad2652aa6de1858fa5596
 * - Discussion: https://governance.aave.com/t/arfc-aave-umbrella-activation/21521
 * @notice This payload registers and activates `SlashingRobot`.
 */
contract AaveV3Ethereum_SlashingRobotActivation_20250515 is IProposalGenericExecutor {
  using SafeERC20 for IERC20;

  address public constant SLASHING_ROBOT = 0x4216d695070ce243e48A3bB0646CaA4DDB81B957;
  uint96 public constant SLASHING_ROBOT_LINK_AMOUNT = 250 * 1e18;

  function execute() external {
    CollectorUtils.IOInput memory input = CollectorUtils.IOInput({
      pool: address(AaveV3Ethereum.POOL),
      underlying: AaveV3EthereumAssets.LINK_UNDERLYING,
      amount: SLASHING_ROBOT_LINK_AMOUNT
    });
    uint256 linkReceived = CollectorUtils.withdrawFromV3(
      AaveV3Ethereum.COLLECTOR,
      input,
      address(this)
    );

    IERC20(AaveV3EthereumAssets.LINK_UNDERLYING).forceApprove(
      MiscEthereum.AAVE_CL_ROBOT_OPERATOR,
      linkReceived
    );

    IAaveCLRobotOperator(MiscEthereum.AAVE_CL_ROBOT_OPERATOR).register(
      'Slashing robot',
      SLASHING_ROBOT,
      '', // check data
      5_000_000, // gas limit
      uint96(linkReceived),
      0,
      ''
    );
  }
}
