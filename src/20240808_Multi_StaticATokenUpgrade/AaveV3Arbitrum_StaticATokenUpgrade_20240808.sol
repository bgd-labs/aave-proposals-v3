// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';
import {GenericUpgradePayload} from './GenericUpgradePayload.sol';
import {AaveV3Arbitrum} from 'aave-address-book/AaveV3Arbitrum.sol';
import {MiscArbitrum} from 'aave-address-book/MiscArbitrum.sol';

/**
 * @title Static A Token Upgrade
 * @author BGD Labs @bgdlabs
 * - Snapshot: TODO
 * - Discussion: TODO
 */
contract AaveV3Arbitrum_StaticATokenUpgrade_20240808 is
  IProposalGenericExecutor,
  GenericUpgradePayload
{
  constructor()
    GenericUpgradePayload(
      MiscArbitrum.PROXY_ADMIN,
      AaveV3Arbitrum.STATIC_A_TOKEN_FACTORY,
      address(0),
      address(0)
    )
  {}
}
