// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {AaveV3EthereumLido, AaveV3EthereumLidoAssets} from 'aave-address-book/AaveV3EthereumLido.sol';
import {AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {MiscEthereum} from 'aave-address-book/MiscEthereum.sol';
import {CollectorUtils} from 'aave-helpers/src/CollectorUtils.sol';
import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';

/**
 * @title Renew LlamaRisk as Risk Service Provider - Epoch 4
 * @author LlamaRisk
 * - Snapshot: https://snapshot.box/#/s:aavedao.eth/proposal/0x139144f55e87579003f5f9ed53fc4b87bd0c7312fc9c356e5e4e164baa3f8077
 * - Discussion: https://governance.aave.com/t/arfc-renew-llamarisk-as-risk-service-provider-epoch-4/24446
 */
contract AaveV3EthereumLido_RenewLlamaRiskAsRiskServiceProviderEpoch4_20260513 is
  IProposalGenericExecutor
{
  address public constant LLAMA_RISK = 0x9eE16dBDE572886342fc1e2Db8525DEFB007b27c;

  uint256 public constant PREVIOUS_STREAM = 100071;

  uint256 public constant STREAM_DURATION = 365 days;

  uint256 public constant BULK_AMOUNT = 1_500_000 ether;
  uint256 public constant GHO_STREAM_AMOUNT = 1_500_000 ether;
  uint256 public constant AAVE_STREAM_AMOUNT = 5_000 ether;

  function execute() external {
    AaveV3EthereumLido.COLLECTOR.cancelStream(PREVIOUS_STREAM);

    AaveV3EthereumLido.COLLECTOR.transfer(
      IERC20(AaveV3EthereumLidoAssets.GHO_A_TOKEN),
      LLAMA_RISK,
      BULK_AMOUNT
    );

    CollectorUtils.stream(
      AaveV3EthereumLido.COLLECTOR,
      CollectorUtils.CreateStreamInput({
        underlying: AaveV3EthereumLidoAssets.GHO_A_TOKEN,
        receiver: LLAMA_RISK,
        amount: GHO_STREAM_AMOUNT,
        start: block.timestamp,
        duration: STREAM_DURATION
      })
    );

    uint256 aaveStreamAmount = (AAVE_STREAM_AMOUNT / STREAM_DURATION) * STREAM_DURATION;
    MiscEthereum.AAVE_ECOSYSTEM_RESERVE_CONTROLLER.createStream(
      MiscEthereum.ECOSYSTEM_RESERVE,
      LLAMA_RISK,
      aaveStreamAmount,
      AaveV3EthereumAssets.AAVE_UNDERLYING,
      block.timestamp,
      block.timestamp + STREAM_DURATION
    );
  }
}
