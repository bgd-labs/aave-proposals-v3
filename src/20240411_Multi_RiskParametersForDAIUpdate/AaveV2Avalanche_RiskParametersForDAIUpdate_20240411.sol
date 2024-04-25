// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';
import {AaveV2Avalanche, AaveV2AvalancheAssets} from 'aave-address-book/AaveV2Avalanche.sol';

/**
 * @title Risk Parameters for DAI Update
 * @author Aave Chan Initiative
 * - Snapshot: https://snapshot.org/#/aave.eth/proposal/0x9f024edf6b8ebe1177503fbed3ceb6b5847cc0cae0e9269132c39b223db30023
 * - Discussion: https://governance.aave.com/t/arfc-risk-parameters-for-dai-update/17211
 */
contract AaveV2Avalanche_RiskParametersForDAIUpdate_20240411 is IProposalGenericExecutor {
  function execute() external {
    // custom code goes here
    AaveV2Avalanche.POOL_CONFIGURATOR.configureReserveAsCollateral(
      AaveV2AvalancheAssets.DAIe_UNDERLYING,
      63_00,
      77_00,
      105_00
    );
  }
}
