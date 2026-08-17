// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {AaveV3Base} from 'aave-address-book/AaveV3Base.sol';
import {IWrappedTokenGatewayV3} from 'aave-v3-origin/contracts/helpers/interfaces/IWrappedTokenGatewayV3.sol';
import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';

/**
 * @title July 2026 Funding Update
 * @author TokenLogic
 * - Snapshot: https://snapshot.box/#/s:aavedao.eth/proposal/0x2f86020fc038694a5c4738e3982e4fa92eb315aaa4d3ce2fa2be2a5808a9280b
 * - Discussion: https://governance.aave.com/t/direct-to-aip-july-2026-funding-update/25277
 */
contract AaveV3Base_July2026FundingUpdate_20260715 is IProposalGenericExecutor {
  function execute() external {
    uint256 collectorEthBalance = address(AaveV3Base.COLLECTOR).balance;
    AaveV3Base.COLLECTOR.transfer(
      IERC20(AaveV3Base.COLLECTOR.ETH_MOCK_ADDRESS()),
      address(this),
      collectorEthBalance
    );
    IWrappedTokenGatewayV3(AaveV3Base.WETH_GATEWAY).depositETH{value: collectorEthBalance}(
      address(AaveV3Base.POOL),
      address(AaveV3Base.COLLECTOR),
      0
    );
  }
}
