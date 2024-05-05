// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';

/**
 * @title Aave v3.1 Cantina competition
 * @author BGD Labs @bgdlabs
 * - Snapshot: https://snapshot.org/#/aave.eth/proposal/0x79de5212e90a562918f72d47809bba5af1221cce4a8cd6dd38b89f38984e90ee
 * - Discussion: https://governance.aave.com/t/arfc-bgd-aave-3-1-cantina-competition/17485
 */
contract AaveV3Ethereum_AaveV31CantinaCompetition_20240503 is IProposalGenericExecutor {
  address public constant CANTINA_RECIPIENT = 0x3Dcb7CFbB431A11CAbb6f7F2296E2354f488Efc2;
  uint256 public constant TOTAL_AMOUNT = 195_000 ether;

  function execute() external {
    AaveV3Ethereum.COLLECTOR.transfer(
      AaveV3EthereumAssets.GHO_UNDERLYING,
      CANTINA_RECIPIENT,
      TOTAL_AMOUNT
    );
  }
}
