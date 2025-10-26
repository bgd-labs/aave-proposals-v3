// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {AaveV3EthereumLido, AaveV3EthereumLidoAssets} from 'aave-address-book/AaveV3EthereumLido.sol';
import {CollectorUtils} from 'aave-helpers/src/CollectorUtils.sol';
import {MiscEthereum} from 'aave-address-book/MiscEthereum.sol';

/**
 * @title Security Services for Aave v4 <> Certora
 * @author Aave-chan Initiative
 * - Snapshot: https://snapshot.box/#/s:aavedao.eth/proposal/0xc84ffd9516f6c5248a4c79224baaf0191c8ce240a0e48482ce16594da6d0196d
 * - Discussion: https://governance.aave.com/t/arfc-security-services-for-aave-v4-certora/23222
 */
contract AaveV3EthereumLido_SecurityServicesForAaveV4Certora_20251026 is IProposalGenericExecutor {
  address public constant CERTORA = 0x0F11640BF66e2D9352d9c41434A5C6E597c5e4c8;
  uint256 public constant STREAM_DURATION = 365 days;
  uint256 public constant AGHO_AMOUNT = 2_390_000 ether;

  function execute() external {
    CollectorUtils.stream(
      AaveV3EthereumLido.COLLECTOR,
      CollectorUtils.CreateStreamInput({
        underlying: AaveV3EthereumLidoAssets.GHO_A_TOKEN,
        receiver: CERTORA,
        amount: AGHO_AMOUNT,
        start: block.timestamp,
        duration: STREAM_DURATION
      })
    );
  }
}
