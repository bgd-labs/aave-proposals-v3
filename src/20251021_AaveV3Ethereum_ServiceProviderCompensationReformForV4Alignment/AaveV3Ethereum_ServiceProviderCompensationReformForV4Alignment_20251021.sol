// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {AaveV3EthereumLido, AaveV3EthereumLidoAssets} from 'aave-address-book/AaveV3EthereumLido.sol';
import {AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {CollectorUtils} from 'aave-helpers/src/CollectorUtils.sol';
import {ReformData} from './ReformData.sol';
import {MiscEthereum} from 'aave-address-book/MiscEthereum.sol';

/**
 * @title Service Provider Compensation Reform for V4 Alignment
 * @author Aave-chan Initiative
 * - Snapshot: https://snapshot.box/#/s:aavedao.eth/proposal/0xdf44cfaac72f0413d639d017c299a6491ba74a55fffcfdf74debfba51932891b
 * - Discussion: https://governance.aave.com/t/arfc-service-provider-compensation-reform-for-v4-alignment/23246
 */
contract AaveV3Ethereum_ServiceProviderCompensationReformForV4Alignment_20251021 is
  IProposalGenericExecutor
{
  function execute() external {
    ReformData.ReformDataStructure[] memory reformData = ReformData.getReformData();

    for (uint256 i = 0; i < reformData.length; i++) {
      // cancel the previous stream
      AaveV3EthereumLido.COLLECTOR.cancelStream(reformData[i].toCancel);

      // create the new one
      CollectorUtils.stream(
        AaveV3EthereumLido.COLLECTOR,
        CollectorUtils.CreateStreamInput({
          underlying: AaveV3EthereumLidoAssets.GHO_A_TOKEN,
          receiver: reformData[i].recipient,
          amount: reformData[i].amount,
          start: block.timestamp,
          duration: ReformData.STREAM_DURATION
        })
      );

      // distribute the grant
      MiscEthereum.AAVE_ECOSYSTEM_RESERVE_CONTROLLER.transfer(
        MiscEthereum.ECOSYSTEM_RESERVE,
        AaveV3EthereumAssets.AAVE_UNDERLYING,
        reformData[i].recipient,
        ReformData.GRANT_AMOUNT
      );
    }

    // AAVE token are in the ecosystem reserve, the flow is a bit different
    ReformData.ReformDataStructure memory reformDataAAVE = ReformData.getReformDataAAVE();

    // cancel
    MiscEthereum.AAVE_ECOSYSTEM_RESERVE_CONTROLLER.cancelStream(
      MiscEthereum.ECOSYSTEM_RESERVE,
      reformDataAAVE.toCancel
    );

    // recreate
    uint256 amount = (reformDataAAVE.amount / ReformData.STREAM_DURATION) *
      ReformData.STREAM_DURATION;
    MiscEthereum.AAVE_ECOSYSTEM_RESERVE_CONTROLLER.createStream(
      MiscEthereum.ECOSYSTEM_RESERVE,
      reformDataAAVE.recipient,
      amount,
      AaveV3EthereumAssets.AAVE_UNDERLYING,
      block.timestamp,
      block.timestamp + ReformData.STREAM_DURATION // The non-wrapped version is (start, stop) instead of (start, duration)
    );
  }
}
