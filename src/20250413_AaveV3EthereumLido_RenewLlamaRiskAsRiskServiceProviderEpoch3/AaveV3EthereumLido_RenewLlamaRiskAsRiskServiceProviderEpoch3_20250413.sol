// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {AaveV3EthereumLido, AaveV3EthereumLidoAssets} from 'aave-address-book/AaveV3EthereumLido.sol';
import {CollectorUtils} from 'aave-helpers/src/CollectorUtils.sol';

/**
 * @title Renew LlamaRisk as Risk Service Provider - epoch 3
 * @author Aave-Chan Initiative
 * - Snapshot: https://snapshot.box/#/s:aavedao.eth/proposal/0x70ce585823c2c1a60cb6bbd64750682a2a9a4b501e3f4342812ebf6bb5d51892
 * - Discussion: https://governance.aave.com/t/arfc-renew-llamarisk-as-risk-service-provider-epoch-3/21666
 */
contract AaveV3EthereumLido_RenewLlamaRiskAsRiskServiceProviderEpoch3_20250413 is
  IProposalGenericExecutor
{
  // stream information
  uint256 public constant STREAM_DURATION = 365 days;
  // budgets
  uint256 public constant STREAM_AMOUNT = 1_000_000 ether;
  // stream receivers
  address public constant LLAMA_RISK = 0x9eE16dBDE572886342fc1e2Db8525DEFB007b27c;
  function execute() external {
    CollectorUtils.stream(
      AaveV3EthereumLido.COLLECTOR,
      CollectorUtils.CreateStreamInput({
        underlying: AaveV3EthereumLidoAssets.GHO_A_TOKEN,
        receiver: LLAMA_RISK,
        amount: STREAM_AMOUNT,
        start: block.timestamp,
        duration: STREAM_DURATION
      })
    );
  }
}
