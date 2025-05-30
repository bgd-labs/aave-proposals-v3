// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {SafeERC20} from 'openzeppelin-contracts/contracts/token/ERC20/utils/SafeERC20.sol';
import {SafeCast} from 'openzeppelin-contracts/contracts/utils/math/SafeCast.sol';

import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {MiscEthereum} from 'aave-address-book/MiscEthereum.sol';

import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';

import {CollectorUtils, ICollector} from 'aave-helpers/src/CollectorUtils.sol';

import {IAaveCLRobotOperator} from '../interfaces/IAaveCLRobotOperator.sol';

/**
 * @title UmbrellaActivation
 * @author BGD Labs (@bgdlabs)
 * - Snapshot: https://snapshot.box/#/s:aavedao.eth/proposal/0xbe792a1db33cd7803e23810553e5a6a728c3ac15827ad2652aa6de1858fa5596
 * - Discussion: https://governance.aave.com/t/arfc-aave-umbrella-activation/21521
 * @notice This payload registers and activates `SlashingRobot` and `UmbrellaPPCRobot`.
 */
contract AaveV3Ethereum_RobotActivation_20250515 is IProposalGenericExecutor {
  using CollectorUtils for ICollector;
  using SafeERC20 for IERC20;
  using SafeCast for uint256;

  address public constant UMBRELLA_PPC_ROBOT = 0x4a672f57D724e310d7d0c7b64fd9D734832FD3E9;
  address public constant SLASHING_ROBOT = 0x4216d695070ce243e48A3bB0646CaA4DDB81B957;

  uint96 public constant SLASHING_ROBOT_LINK_AMOUNT = 200 * 1e18;
  uint96 public constant UMBRELLA_PPC_ROBOT_LINK_AMOUNT = 200 * 1e18;

  function execute() external {
    AaveV3Ethereum.COLLECTOR.withdrawFromV3(
      CollectorUtils.IOInput({
        pool: address(AaveV3Ethereum.POOL),
        underlying: AaveV3EthereumAssets.LINK_UNDERLYING,
        amount: SLASHING_ROBOT_LINK_AMOUNT + UMBRELLA_PPC_ROBOT_LINK_AMOUNT
      }),
      address(this)
    );
    uint96 linkBalance = IERC20(AaveV3EthereumAssets.LINK_UNDERLYING)
      .balanceOf(address(this))
      .toUint96();
    IERC20(AaveV3EthereumAssets.LINK_UNDERLYING).forceApprove(
      MiscEthereum.AAVE_CL_ROBOT_OPERATOR,
      linkBalance
    );

    IAaveCLRobotOperator(MiscEthereum.AAVE_CL_ROBOT_OPERATOR).register(
      'Slashing robot',
      SLASHING_ROBOT,
      '', // check data
      5_000_000, // gas limit
      SLASHING_ROBOT_LINK_AMOUNT,
      0,
      ''
    );
    IAaveCLRobotOperator(MiscEthereum.AAVE_CL_ROBOT_OPERATOR).register(
      'Umbrella PermissionedPayloadsController robot',
      UMBRELLA_PPC_ROBOT,
      '', // check data
      5_000_000, // gas limit
      linkBalance - SLASHING_ROBOT_LINK_AMOUNT,
      0,
      ''
    );
  }
}
