// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IERC20Metadata} from 'solidity-utils/contracts/oz-common/interfaces/IERC20Metadata.sol';
import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {CollectorUtils} from 'aave-helpers/src/CollectorUtils.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';

/**
 * @title Chaos Labs <> Aave Risk Management Service Renewal
 * @author Aave Chan Initiative
 * - Snapshot: https://snapshot.org/#/aave.eth/proposal/0xa8ec5cf2568691144861b38af1b2cef4f95d33d0912fea28438132cabf4b6c28
 * - Discussion: https://governance.aave.com/t/arfc-chaos-labs-aave-risk-management-service-renewal/19306
 */
contract AaveV3Ethereum_ChaosLabsAaveRiskManagementServiceRenewal_20241012 is
  IProposalGenericExecutor
{
  address public constant CHAOS_LABS_RECEIVER = 0xbC540e0729B732fb14afA240aA5A047aE9ba7dF0;

  function execute() external {
    CollectorUtils.stream(
      AaveV3Ethereum.COLLECTOR,
      CollectorUtils.CreateStreamInput({
        underlying: AaveV3EthereumAssets.GHO_UNDERLYING,
        receiver: CHAOS_LABS_RECEIVER,
        amount: 1_000_000 * 10 ** IERC20Metadata(AaveV3EthereumAssets.GHO_UNDERLYING).decimals(),
        start: 1731405180, // 12 november, last stream end + 1 second
        duration: 365 days
      })
    );

    CollectorUtils.stream(
      AaveV3Ethereum.COLLECTOR,
      CollectorUtils.CreateStreamInput({
        underlying: AaveV3EthereumAssets.USDT_A_TOKEN,
        receiver: CHAOS_LABS_RECEIVER,
        amount: 1_000_000 * 10 ** IERC20Metadata(AaveV3EthereumAssets.USDT_A_TOKEN).decimals(),
        start: 1731405180,
        duration: 365 days
      })
    );
  }
}
