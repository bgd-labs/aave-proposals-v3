// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {GhoMonad} from 'aave-address-book/GhoMonad.sol';
import {AaveV3Monad} from 'aave-address-book/AaveV3Monad.sol';
import {GovernanceV3Monad} from 'aave-address-book/GovernanceV3Monad.sol';
import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';

import {CCIPChainSelectors} from 'src/helpers/gho-launch/constants/CCIPChainSelectors.sol';
import {IGhoReserve} from 'src/interfaces/IGhoReserve.sol';
import {IGsm} from 'src/interfaces/IGsm.sol';
import {IGsmRegistry} from 'src/interfaces/IGsmRegistry.sol';

import {RemoteGSMLaunchMonadSetup} from './setup/RemoteGSMLaunchMonadSetup.sol';

/**
 * @title Remote GSM Launch: Monad
 * @author TokenLogic
 * - Snapshot: https://snapshot.org/#/s:aavedao.eth/proposal/0x24f105bd023c476a9b85fa87ff795bfeec769fa799ce6ada8e2724c9738049f6
 * - Discussion: https://governance.aave.com/t/arfc-deploy-aave-protocol-v3-7-on-monad/24943
 *
 * NOTE: granting RISK_ADMIN_ROLE on AaveV3Monad.ACL_MANAGER to a GhoAaveSteward
 * is intentionally OUT OF SCOPE for this proposal. If a steward is not already
 * empowered on Monad, that grant must be made in a separate proposal before
 * the steward can call updateGhoBorrowCap / updateGhoBorrowRate / updateGhoSupplyCap.
 *
 * NOTE (CCIP receiver assumption): this proposal assumes the CCIP token-pool on
 * the Monad lane delivers bridged GHO to `AaveV3Monad.COLLECTOR`. The
 * Collector -> GhoReserve transfer below depends on that. If the CCIP receiver
 * for this lane is anything other than the Collector, this payload will revert.
 * Verify on-chain before deploy.
 */
contract AaveV3Monad_RemoteGSMLaunchMonad_20260701_Part2 is IProposalGenericExecutor {
  // https://monadscan.com/address/0x307707A53Cb51670a8bcC8a2808A349C65E1Fb92
  IGhoReserve public constant GHO_RESERVE = IGhoReserve(0x307707A53Cb51670a8bcC8a2808A349C65E1Fb92);

  // https://monadscan.com/address/0x6C4b8AC66a3C879129282C137fc038519b883AE6
  address public constant GHO_GSM_STEWARD = 0x6C4b8AC66a3C879129282C137fc038519b883AE6;

  // https://monadscan.com/address/0xAee666216888e92E9e8B7b31484D1D98eb6fA869
  address public constant GSM_REGISTRY = 0xAee666216888e92E9e8B7b31484D1D98eb6fA869;

  // GSM USDC
  // https://monadscan.com/address/0x3Cf3779EEf770931543ACd2C7f6ECd1b37E35caB
  address public constant GSM_USDC = 0x3Cf3779EEf770931543ACd2C7f6ECd1b37E35caB;

  // https://monadscan.com/address/0xC26bF89C90cd9cE12360D08bB494695206189159
  address public constant USDC_ORACLE_SWAP_FREEZER = 0xC26bF89C90cd9cE12360D08bB494695206189159;

  // https://monadscan.com/address/0xAcB3d2f60CAA4966dE003E22936033FFBE7f6787
  address public constant GSM_USDC_FEE_STRATEGY = 0xAcB3d2f60CAA4966dE003E22936033FFBE7f6787;

  function execute() external {
    GHO_RESERVE.grantRole(GHO_RESERVE.LIMIT_MANAGER_ROLE(), GhoMonad.RISK_COUNCIL);

    _wireGsm(
      IGsm(GSM_USDC),
      RemoteGSMLaunchMonadSetup.GSM_USDC_RESERVE_LIMIT,
      USDC_ORACLE_SWAP_FREEZER,
      RemoteGSMLaunchMonadSetup.GSM_USDC_INITIAL_EXPOSURE_CAP,
      GSM_USDC_FEE_STRATEGY
    );

    AaveV3Monad.COLLECTOR.transfer(
      IERC20(GhoMonad.GHO_TOKEN),
      address(GHO_RESERVE),
      RemoteGSMLaunchMonadSetup.GHO_BRIDGE_AMOUNT
    );

    // Restore ONLY the Monad <> Ethereum lane rate-limit config to its standard values, undoing
    // the temporary inbound bump from Part 1. Every other lane is intentionally left untouched.
    // Facilitator Bucket Capacity does not need to change.
    RemoteGSMLaunchMonadSetup.restoreLaneRateLimitConfig(
      GhoMonad.GHO_CCIP_TOKEN_POOL,
      CCIPChainSelectors.ETHEREUM
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
    gsm.grantRole(swapFreezerRole, GovernanceV3Monad.EXECUTOR_LVL_1);

    // Add GSM to GSM Registry
    IGsmRegistry(GSM_REGISTRY).addGsm(address(gsm));

    // GHO GSM Steward
    gsm.grantRole(gsm.CONFIGURATOR_ROLE(), GHO_GSM_STEWARD);

    // Update deployed exposure cap to initial value
    gsm.updateExposureCap(initialExposureCap);

    gsm.updateFeeStrategy(feeStrategy);
  }
}
