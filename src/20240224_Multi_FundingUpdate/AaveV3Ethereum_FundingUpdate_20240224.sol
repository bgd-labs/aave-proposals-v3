// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';

/**
 * @title Funding Update
 * @author karpatkey_TokenLogic
 * - Snapshot: https://snapshot.org/#/aave.eth/proposal/0x4dd4dff7096bf7ab8c4c071975d40f4cf709c41b4b6b7c60777a6dd50d2ecd09
 * - Discussion: https://governance.aave.com/t/arfc-funding-update/16675
 */
contract AaveV3Ethereum_FundingUpdate_20240224 is IProposalGenericExecutor {
  address public constant ALC_SAFE = 0x205e795336610f5131Be52F09218AF19f0f3eC60;

  uint256 public constant USDC_V2_TO_MIGRATE = 300_000e6;
  uint256 public constant USDC_V3_TO_SWAP = 1_250_000e6;
  uint256 public constant USDT_V3_TO_SWAP = 1_500_000e6;
  uint256 public constant USDT_V2_TO_SWAP = 200_000e6;
  uint256 public constant BUSD_V2_TO_SWAP = 50 ether;

  function execute() external {
    _migrate();
    _swap();
  }

  function _swap() internal {}

  function _migrate() internal {}
}
