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
  address public constant ACI = 0xD4416b13d2b3a9aBae7AcD5D6C2BbDBE25686401;
  uint256 public constant EURE_AMOUNT = 25_000e18;

  function execute() external {
    AaveV3Gnosis.COLLECTOR.approve(IERC20(AaveV3GnosisAssets.EURe_A_TOKEN), ACI, EURE_AMOUNT);
  }
}
