// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {SafeERC20} from 'solidity-utils/contracts/oz-common/SafeERC20.sol';
import {MiscPolygon} from 'aave-address-book/MiscPolygon.sol';
import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';

interface IAavePolEthPlasmaBridge {
  function bridge(uint256 amount) external;
}

/**
 * @title April Finance Update
 * @author @karpatkey_TokenLogic
 * - Snapshot: Direct-to-AIP
 * - Discussion: https://governance.aave.com/t/arfc-april-finance-update/17390
 */
contract AaveV2Polygon_AprilFinanceUpdate_20240421_PartB is IProposalGenericExecutor {
  using SafeERC20 for IERC20;

  error InsufficientBalance();

  IAavePolEthPlasmaBridge public constant plasmaBridge =
    IAavePolEthPlasmaBridge(0xc980508cC8866f726040Da1C0C61f682e74aBc39);

  address public constant NATIVE_MATIC = 0x0000000000000000000000000000000000001010;

  function execute() external {
    uint256 balance = IERC20(NATIVE_MATIC).balanceOf(address(plasmaBridge));
    if (balance < 570_000 ether) revert InsufficientBalance();
    plasmaBridge.bridge(balance);
  }
}
