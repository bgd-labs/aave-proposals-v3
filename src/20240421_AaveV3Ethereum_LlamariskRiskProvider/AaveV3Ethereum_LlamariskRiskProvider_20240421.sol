// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';

/**
 * @title Llamarisk Risk Provider
 * @author Aave Chan Initiative
 * - Snapshot: https://snapshot.org/#/aave.eth/proposal/0x2b7433455b16d50b9b6afdf2e60bfd6e733896224688c9891c371aa2597853a2
 * - Discussion: https://governance.aave.com/t/arfc-onboard-new-risk-service-provider/17348
 */
contract AaveV3Ethereum_LlamariskRiskProvider_20240421 is IProposalGenericExecutor {
  address public constant LLAMARISK_RECIPIENT = 0xa2482aA1376BEcCBA98B17578B17EcE82E6D9E86;
  uint256 public constant GHO_STREAM = 250_000 ether;
  uint256 public constant STREAM_DURATION = 180 days;

  uint256 public constant ACTUAL_GHO_STREAM = (GHO_STREAM / STREAM_DURATION) * STREAM_DURATION;
  function execute() external {
    // create a stream of 250 000 GHO to the Llamarisk team
    AaveV3Ethereum.COLLECTOR.createStream(
      LLAMARISK_RECIPIENT,
      ACTUAL_GHO_STREAM,
      AaveV3EthereumAssets.GHO_UNDERLYING,
      block.timestamp,
      block.timestamp + STREAM_DURATION
    );
  }
}
