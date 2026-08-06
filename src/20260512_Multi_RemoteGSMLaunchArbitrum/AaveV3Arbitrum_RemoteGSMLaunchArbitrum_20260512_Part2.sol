// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {AaveV3Arbitrum} from 'aave-address-book/AaveV3Arbitrum.sol';
import {GhoArbitrum} from 'aave-address-book/GhoArbitrum.sol';
import {GovernanceV3Arbitrum} from 'aave-address-book/GovernanceV3Arbitrum.sol';
import {ICollector} from 'aave-helpers/src/CollectorUtils.sol';
import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';

import {CCIPChainSelectors} from '../helpers/gho-launch/constants/CCIPChainSelectors.sol';
import {IGhoReserve} from 'src/interfaces/IGhoReserve.sol';
import {IGsm} from 'src/interfaces/IGsm.sol';
import {IGsmRegistry} from 'src/interfaces/IGsmRegistry.sol';

import {RemoteGSMLaunchArbitrumSetup} from './setup/RemoteGSMLaunchArbitrumSetup.sol';

/**
 * @title Remote GSM Launch: Arbitrum
 * @author TokenLogic
 * - Snapshot: https://snapshot.org/#/s:aavedao.eth/proposal/0xf24321514fb593af9e5082d26a1358819ec0f648db8fdb5c2b083f53ef785793
 * - Discussion: https://governance.aave.com/t/arfc-launch-remotegsm-on-arbitrum/24986
 *
 * NOTE: granting RISK_ADMIN_ROLE on AaveV3Arbitrum.ACL_MANAGER to a GhoAaveSteward
 * is intentionally OUT OF SCOPE for this proposal. If a steward is not already
 * empowered on Arbitrum, that grant must be made in a separate proposal before
 * the steward can call updateGhoBorrowCap / updateGhoBorrowRate / updateGhoSupplyCap.
 *
 * NOTE (CCIP receiver assumption): this proposal assumes the CCIP token-pool on
 * the Arbitrum lane delivers bridged GHO to `AaveV3Arbitrum.COLLECTOR`. The
 * Collector -> GhoReserve transfer below depends on that. If the CCIP receiver
 * for this lane is anything other than the Collector, this payload will revert.
 * Verify on-chain before deploy.
 */
contract AaveV3Arbitrum_RemoteGSMLaunchArbitrum_20260512_Part2 is IProposalGenericExecutor {
  // GhoReserve
  // https://arbiscan.io/address/0xC912D64F9F649897dC0244da3835869d410d053e
  IGhoReserve public constant GHO_RESERVE = IGhoReserve(0xC912D64F9F649897dC0244da3835869d410d053e);

  // https://arbiscan.io/address/0x4DFfA29C526b5CFB419e14E3111516Fbf929797D
  address public constant GHO_GSM_STEWARD = 0x4DFfA29C526b5CFB419e14E3111516Fbf929797D;

  // https://arbiscan.io/address/0x2Be58aD215AA8552CB5BD038a88d0dE39d2427BB
  address public constant GSM_REGISTRY = 0x2Be58aD215AA8552CB5BD038a88d0dE39d2427BB;

  // GSM USDC
  // https://arbiscan.io/address/0x53E0cE250d06043414070100458546AaF4e284eD
  address public constant GSM_USDC = 0x53E0cE250d06043414070100458546AaF4e284eD;

  // https://arbiscan.io/address/0xC5aF63c233eA19cB191b36D16C1e25cDA08409E7
  address public constant USDC_ORACLE_SWAP_FREEZER = 0xC5aF63c233eA19cB191b36D16C1e25cDA08409E7;

  // https://arbiscan.io/address/0x2169Bf2084bDb881587b3Cf6B24011E6AA091FdE
  address public constant GSM_USDC_FEE_STRATEGY = 0x2169Bf2084bDb881587b3Cf6B24011E6AA091FdE;

  function execute() external {
    GHO_RESERVE.grantRole(GHO_RESERVE.LIMIT_MANAGER_ROLE(), GhoArbitrum.RISK_COUNCIL);

    _wireGsm(
      IGsm(GSM_USDC),
      RemoteGSMLaunchArbitrumSetup.GSM_USDC_RESERVE_LIMIT,
      USDC_ORACLE_SWAP_FREEZER,
      RemoteGSMLaunchArbitrumSetup.GSM_USDC_INITIAL_EXPOSURE_CAP,
      GSM_USDC_FEE_STRATEGY
    );

    AaveV3Arbitrum.COLLECTOR.transfer(
      IERC20(GhoArbitrum.GHO_TOKEN),
      address(GHO_RESERVE),
      RemoteGSMLaunchArbitrumSetup.GHO_BRIDGE_AMOUNT
    );

    // Restore bridge limits after GHO bridging, and normalize all GHO lanes rate-limit config to canonical defaults.
    // Facilitator Bucket Capacity does not need to change.
    RemoteGSMLaunchArbitrumSetup.normalizeIORateLimitsForAllNetworks(
      GhoArbitrum.GHO_CCIP_TOKEN_POOL,
      CCIPChainSelectors.ARBITRUM
    );
  }

  function _wireGsm(
    IGsm gsm,
    uint128 reserveLimit,
    address oracleSwapFreezer,
    uint128 initialExposureCap,
    address feeStrategy
  ) internal {
    gsm.updateGhoReserve(address(GHO_RESERVE));

    // Enroll GSM as entity and set limit
    GHO_RESERVE.addEntity(address(gsm));
    GHO_RESERVE.setLimit(address(gsm), reserveLimit);

    // Add GSM Swap Freezer role to OracleSwapFreezers
    bytes32 swapFreezerRole = gsm.SWAP_FREEZER_ROLE();
    gsm.grantRole(swapFreezerRole, oracleSwapFreezer);
    gsm.grantRole(swapFreezerRole, GovernanceV3Arbitrum.EXECUTOR_LVL_1);

    // Add GSM to GSM Registry
    IGsmRegistry(GSM_REGISTRY).addGsm(address(gsm));

    // GHO GSM Steward
    gsm.grantRole(gsm.CONFIGURATOR_ROLE(), GHO_GSM_STEWARD);

    // Update deployed exposure cap to initial value
    gsm.updateExposureCap(initialExposureCap);

    gsm.updateFeeStrategy(feeStrategy);
  }
}
