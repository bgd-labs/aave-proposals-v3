// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IERC20Metadata} from 'solidity-utils/contracts/oz-common/interfaces/IERC20Metadata.sol';
import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {CollectorUtils} from 'aave-helpers/src/CollectorUtils.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';

/**
 * @title Aave <> Certora Continuous Security Services
 * @author Aave Chan Initiative
 * - Snapshot: https://snapshot.org/#/aave.eth/proposal/0xebf0b33be0c3784b2928112414f08e31ac57705f49d46668bfef6fa6f761141d
 * - Discussion: https://governance.aave.com/t/arfc-aave-certora-continuous-security-services/19262
 */
contract AaveV3Ethereum_AaveCertoraContinuousSecurityServices_20241014 is IProposalGenericExecutor {
  address public constant CERTORA_RECEIVER = 0xE8555F05b3f5a1F4566CD7da98c4e5F195258B65;
  uint256 public constant AAVE_PRICE = 100_00000000; //TODO: sets aave price

  function execute() external {
    CollectorUtils.stream(
      AaveV3Ethereum.COLLECTOR,
      CollectorUtils.CreateStreamInput({
        underlying: AaveV3EthereumAssets.GHO_UNDERLYING,
        receiver: CERTORA_RECEIVER,
        amount: 1_150_000 * 10 ** IERC20Metadata(AaveV3EthereumAssets.GHO_UNDERLYING).decimals(),
        start: block.timestamp,
        duration: 1757548800000 - block.timestamp // ends on 11 september 2025
      })
    );

    CollectorUtils.stream(
      AaveV3Ethereum.COLLECTOR,
      CollectorUtils.CreateStreamInput({
        underlying: AaveV3EthereumAssets.AAVE_UNDERLYING,
        receiver: CERTORA_RECEIVER,
        amount: (550_000 *
          10 ** IERC20Metadata(AaveV3EthereumAssets.AAVE_UNDERLYING).decimals() *
          10 ** 8) / AAVE_PRICE,
        start: block.timestamp,
        duration: 1757548800000 - block.timestamp // ends on 11 september 2025
      })
    );
  }
}
