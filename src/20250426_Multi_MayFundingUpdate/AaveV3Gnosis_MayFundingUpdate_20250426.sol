// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {AaveV3Gnosis, AaveV3GnosisAssets} from 'aave-address-book/AaveV3Gnosis.sol';
import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
/**
 * @title May Funding Update
 * @author TokenLogic
 * - Snapshot: Direct-to-AIP
 * - Discussion: https://governance.aave.com/t/arfc-may-2025-funding-update/21906
 */
contract AaveV3Gnosis_MayFundingUpdate_20250426 is IProposalGenericExecutor {
  /// https://gnosisscan.io/address/0xdef1FA4CEfe67365ba046a7C630D6B885298E210
  address public constant ACI = 0xdef1FA4CEfe67365ba046a7C630D6B885298E210;
  uint256 public constant EURE_AMOUNT = 25_000e18;

  function execute() external {
    AaveV3Gnosis.COLLECTOR.approve(IERC20(AaveV3GnosisAssets.EURe_A_TOKEN), ACI, EURE_AMOUNT);
  }
}
