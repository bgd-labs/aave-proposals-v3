// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {AaveV3EthereumLido, AaveV3EthereumLidoAssets} from 'aave-address-book/AaveV3EthereumLido.sol';
import {CollectorUtils} from 'aave-helpers/src/CollectorUtils.sol';
import {MiscEthereum} from 'aave-address-book/MiscEthereum.sol';

/**
 * @title Security Services for Aave Current Infrastructure <> Certora
 * @author Aave-chan Initiative
 * - Snapshot: https://snapshot.box/#/s:aavedao.eth/proposal/0xabaa167899193af7aab389c6412d18802845a88b9bb4061952c82ce78e670f71
 * - Discussion: https://governance.aave.com/t/arfc-security-services-for-aave-current-infrastructure-certora/23221
 */
contract AaveV3EthereumLido_SecurityServicesForAaveCurrentInfrastructureCertora_20251026 is
  IProposalGenericExecutor
{
  address public constant CERTORA = 0x0F11640BF66e2D9352d9c41434A5C6E597c5e4c8;
  uint256 public constant STREAM_DURATION = 365 days;
  uint256 public constant AGHO_AMOUNT = 238_000 ether;

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
