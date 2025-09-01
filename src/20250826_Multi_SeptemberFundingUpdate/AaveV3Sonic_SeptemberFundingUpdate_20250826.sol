// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {AaveV3Sonic, AaveV3SonicAssets} from 'aave-address-book/AaveV3Sonic.sol';
import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';

/**
 * @title September Funding Update
 * @author @TokenLogic
 * - Snapshot: Direct-to-AIP
 * - Discussion: https://governance.aave.com/t/direct-to-aip-september-2025-funding-update/22915
 */
contract AaveV3Sonic_SeptemberFundingUpdate_20250826 is IProposalGenericExecutor {
  address public constant MASIV_NESTED_SAFE = 0x565B80842eCEDad88A2564Ea375CE875Ed3bAdeC;
  uint256 public constant WS_AMOUNT = 300_000 ether;

  function execute() external {
    AaveV3Sonic.COLLECTOR.approve(
      IERC20(AaveV3SonicAssets.wS_A_TOKEN),
      MASIV_NESTED_SAFE,
      WS_AMOUNT
    );
  }
}
