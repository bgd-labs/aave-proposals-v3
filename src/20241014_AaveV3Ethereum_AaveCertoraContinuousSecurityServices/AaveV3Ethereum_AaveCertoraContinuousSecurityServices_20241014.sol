// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IERC20Metadata} from 'solidity-utils/contracts/oz-common/interfaces/IERC20Metadata.sol';
import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {CollectorUtils} from 'aave-helpers/src/CollectorUtils.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {MiscEthereum} from 'aave-address-book/MiscEthereum.sol';

/**
 * @title Aave <> Certora Continuous Security Services
 * @author Aave Chan Initiative
 * - Snapshot: https://snapshot.org/#/aave.eth/proposal/0xebf0b33be0c3784b2928112414f08e31ac57705f49d46668bfef6fa6f761141d
 * - Discussion: https://governance.aave.com/t/arfc-aave-certora-continuous-security-services/19262
 */
contract AaveV3Ethereum_AaveCertoraContinuousSecurityServices_20241014 is IProposalGenericExecutor {
  address public constant CERTORA_RECEIVER = 0x0F11640BF66e2D9352d9c41434A5C6E597c5e4c8;
  uint256 public constant AAVE_PRICE = 152_38026736; // from https://dune.com/queries/4163180/7006698 with timestamp 2024-10-15
  uint256 public constant STOP_TIME = 1757548800; // ends on 11 september 2025

  function execute() external {
    uint256 DURATION = STOP_TIME - block.timestamp;

    CollectorUtils.stream(
      AaveV3Ethereum.COLLECTOR,
      CollectorUtils.CreateStreamInput({
        underlying: AaveV3EthereumAssets.GHO_UNDERLYING,
        receiver: CERTORA_RECEIVER,
        amount: 1_150_000 * 10 ** IERC20Metadata(AaveV3EthereumAssets.GHO_UNDERLYING).decimals(),
        start: block.timestamp,
        duration: DURATION // ends on 11 september 2025
      })
    );

    uint256 AAVE_AMOUNT = (550_000 *
      10 ** IERC20Metadata(AaveV3EthereumAssets.AAVE_UNDERLYING).decimals() *
      10 ** 8) / AAVE_PRICE; // oracle is 8 decimals
    uint256 ACTUAL_AMOUNT = (AAVE_AMOUNT / DURATION) * DURATION;

    MiscEthereum.AAVE_ECOSYSTEM_RESERVE_CONTROLLER.createStream(
      MiscEthereum.ECOSYSTEM_RESERVE,
      CERTORA_RECEIVER,
      ACTUAL_AMOUNT,
      AaveV3EthereumAssets.AAVE_UNDERLYING,
      block.timestamp,
      STOP_TIME
    );
  }
}
