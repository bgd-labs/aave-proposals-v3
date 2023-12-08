// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';
import {IAaveOracle} from 'aave-address-book/AaveV2.sol';

/**
 * @title Fixed REP price feed on AAVE v1
 * @author BGD labs (@bgdlabs)
 * - Discussion: https://governance.aave.com/t/bgd-technical-maintenance-proposals/15274/2
 */
contract AaveV1Ethereum_FixedREPPriceFeed_20231031 is IProposalGenericExecutor {
  address public constant REP = 0x1985365e9f78359a9B6AD760e32412f4a445E862;
  address public constant REP_ADAPTER = 0xc7751400F809cdB0C167F87985083C558a0610F7;
  address public constant AAVE_V1_ORACLE = 0x76B47460d7F7c5222cFb6b6A75615ab10895DDe4;

  function execute() external {
    address[] memory assets = new address[](1);
    address[] memory sources = new address[](1);

    assets[0] = REP;
    sources[0] = REP_ADAPTER;

    IAaveOracle(AAVE_V1_ORACLE).setAssetSources(assets, sources);
  }
}
