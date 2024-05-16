// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';

/**
 * @title ACI Ad Astra
 * @author Marc Zeller - Aave chan Initiative
 * - Snapshot: https://snapshot.org/#/aave.eth/proposal/0x477b3dd277c13cc1b0c1086a04b87d221edd5d09ffd588a246457e6dc3bf2b77
 * - Discussion: https://governance.aave.com/t/arfc-aci-phase-iii-ad-astra/17515
 */
contract AaveV3Ethereum_ACIAdAstra_20240506 is IProposalGenericExecutor {
  address public constant ACI_MULTISIG = 0xac140648435d03f784879cd789130F22Ef588Fcd;

  // 5th May till proposal execution catch up 2740 GHO per day x 6 days = 16440 GHO
  uint256 public constant GHO_UPFRONT_AMOUNT = 16_440 ether;

  // ACI stream for a Year
  uint256 public constant GHO_STREAM_AMOUNT = 1_000_000 ether;
  uint256 public constant GHO_STREAM_DURATION = 365 days;

  uint256 public constant ACTUAL_STREAM =
    (GHO_STREAM_AMOUNT / GHO_STREAM_DURATION) * GHO_STREAM_DURATION;

  function execute() external {
    AaveV3Ethereum.COLLECTOR.createStream(
      ACI_MULTISIG,
      ACTUAL_STREAM,
      AaveV3EthereumAssets.GHO_UNDERLYING,
      block.timestamp,
      block.timestamp + GHO_STREAM_DURATION
    );

    AaveV3Ethereum.COLLECTOR.transfer(
      AaveV3EthereumAssets.GHO_UNDERLYING,
      ACI_MULTISIG,
      GHO_UPFRONT_AMOUNT
    );
  }
}
