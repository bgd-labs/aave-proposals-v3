// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';

/**
 * @title TokenLogic Funding
 * @author TokenLogic
 * - Snapshot: https://snapshot.org/#/aave.eth/proposal/0x66d766a8584ae23e137ca142902f68a6ba4fddf2874fa52815288b72ac9e84ce
 * - Discussion: https://governance.aave.com/t/arfc-retrospective-funding-proposal/15324
 */
contract AaveV3Ethereum_TokenLogicFunding_20231114 is IProposalGenericExecutor {
  
  uint256 public constant AMOUNT = 115_000 * 1e18;
  address public constant TOKENLOGIC = 0x3e4A9f478C0c13A15137Fc81e9d8269F127b4B40;
  address public constant GHO = AaveV3EthereumAssets.GHO_UNDERLYING;

  function execute() external {
    AaveV3Ethereum.COLLECTOR.transfer(GHO, TOKENLOGIC, AMOUNT);
  }
}
