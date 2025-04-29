// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {AaveV3EthereumLido, AaveV3EthereumLidoAssets} from 'aave-address-book/AaveV3EthereumLido.sol';
import {CollectorUtils} from 'aave-helpers/src/CollectorUtils.sol';

/**
 * @title ACI Phase IV – “Road to 80”
 * @author Aave-Chan Initiative
 * - Snapshot: https://snapshot.box/#/s:aavedao.eth/proposal/0x58ba7872571d324f9ac6f56c0aa87d1393b9712d853e95096545afa965da2e2d
 * - Discussion: https://governance.aave.com/t/arfc-aci-phase-iv-road-to-80/21830
 */
contract AaveV3EthereumLido_ACIPhaseIVRoadTo80_20250418 is IProposalGenericExecutor {
  // duration
  uint256 public constant STREAM_DURATION = 365 days;
  // budgets
  uint256 public constant STREAM_AMOUNT = 3_000_000 ether;
  // stream receivers
  address public constant ACI = 0x55Ac902cb75cC15288D473ed8E3E185a75b3f330; // treasury.aci.eth
  function execute() external {
    CollectorUtils.stream(
      AaveV3EthereumLido.COLLECTOR,
      CollectorUtils.CreateStreamInput({
        underlying: AaveV3EthereumLidoAssets.GHO_A_TOKEN,
        receiver: ACI,
        amount: STREAM_AMOUNT,
        start: block.timestamp,
        duration: STREAM_DURATION
      })
    );
  }
}
