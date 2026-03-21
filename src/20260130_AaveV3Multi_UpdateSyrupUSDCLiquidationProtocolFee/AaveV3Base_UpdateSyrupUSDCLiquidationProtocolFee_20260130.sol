// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {AaveV3Base, AaveV3BaseAssets} from 'aave-address-book/AaveV3Base.sol';

/**
 * @title Update syrupUSDC liquidation protocol fee
 * @author Aavechan Initiative @aci
 * - Snapshot: direct-to-aip
 * - Discussion: https://governance.aave.com/t/direct-to-aip-update-syrupusdc-liquidation-protocol-fee-on-aave-v3-base-instance/23963
 */
contract AaveV3Base_UpdateSyrupUSDCLiquidationProtocolFee_20260130 is IProposalGenericExecutor {
  function execute() external {
    AaveV3Base.POOL_CONFIGURATOR.setLiquidationProtocolFee(
      AaveV3BaseAssets.syrupUSDC_UNDERLYING,
      10_00
    );
  }
}
