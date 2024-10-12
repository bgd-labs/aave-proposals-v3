// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {CollectorUtils} from 'aave-helpers/src/CollectorUtils.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';

/**
 * @title Chaos Labs <> Aave Risk Management Service Renewal
 * @author Aave Chan Initiative
 * - Snapshot: TODO
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
        amount: 1_000_000 ether,
        start: block.timestamp,
        duration: 365 days
      })
    );

    CollectorUtils.stream(
      AaveV3Ethereum.COLLECTOR,
      CollectorUtils.CreateStreamInput({
        underlying: AaveV3EthereumAssets.USDC_A_TOKEN,
        receiver: CHAOS_LABS_RECEIVER,
        amount: 1_000_000 ether,
        start: block.timestamp,
        duration: 365 days
      })
    );
  }
}
