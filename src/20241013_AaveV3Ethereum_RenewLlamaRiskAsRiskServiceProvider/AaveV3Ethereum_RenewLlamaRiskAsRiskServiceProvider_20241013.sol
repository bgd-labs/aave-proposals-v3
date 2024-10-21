// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IERC20Metadata} from 'solidity-utils/contracts/oz-common/interfaces/IERC20Metadata.sol';
import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {CollectorUtils} from 'aave-helpers/src/CollectorUtils.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';

/**
 * @title Renew LlamaRisk as Risk Service Provider
 * @author Aave Chan Initiative
 * - Snapshot: https://snapshot.org/#/aave.eth/proposal/0x3c8116f97f990bf61fe63c636c1ae85630ad355e26881285aa4fefaebd8c9c0d
 * - Discussion: https://governance.aave.com/t/arfc-renew-llamarisk-as-risk-service-provider/19277
 */
contract AaveV3Ethereum_RenewLlamaRiskAsRiskServiceProvider_20241013 is IProposalGenericExecutor {
  address public constant LLAMA_RISK_RECEIVER = 0xE8555F05b3f5a1F4566CD7da98c4e5F195258B65;

  function execute() external {
    CollectorUtils.stream(
      AaveV3Ethereum.COLLECTOR,
      CollectorUtils.CreateStreamInput({
        underlying: AaveV3EthereumAssets.GHO_UNDERLYING,
        receiver: LLAMA_RISK_RECEIVER,
        amount: 400_000 * 10 ** IERC20Metadata(AaveV3EthereumAssets.GHO_UNDERLYING).decimals(),
        start: 1730098043, // 28 october 2024
        duration: 182 days // 6 month, 28 april 2025
      })
    );
  }
}
