// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Arbitrum, AaveV3ArbitrumAssets} from 'aave-address-book/AaveV3Arbitrum.sol';
import {IACLManager} from 'aave-address-book/AaveV3.sol';
import {MiscArbitrum} from 'aave-address-book/MiscArbitrum.sol';
import {TransparentUpgradeableProxy} from 'solidity-utils/contracts/transparent-proxy/TransparentUpgradeableProxy.sol';
import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {IAccessControl} from '@openzeppelin/contracts/access/IAccessControl.sol';

import {IGhoToken} from 'src/interfaces/IGhoToken.sol';
import {IUpgradeableLockReleaseTokenPool} from 'src/interfaces/ccip/IUpgradeableLockReleaseTokenPool.sol';

/**
 * @title GHO Steward v2 Upgrade
 * @author @karpatkey_TokenLogic
 * - Snapshot: https://snapshot.org/#/aave.eth/proposal/0xc5e7df1536ef9fc71a7d2e2f6fee6e4e20e37a50b4e0f1646616d066b8697da5
 * - Discussion: https://governance.aave.com/t/arfc-gho-steward-v2-upgrade/19116
 */
contract AaveV3Arbitrum_GHOStewardV2Upgrade_20241007 is IProposalGenericExecutor {
  // https://arbiscan.io/address/0xb78eda33eb5493d56f14a81023ce69438a562a2c#code
  address public constant NEW_CCIP_POOL_TOKEN = 0xb78eDA33EB5493d56f14a81023CE69438a562A2c;

  address public constant GHO_BUCKET_STEWARD = address(0); // TODO

  address public constant GHO_AAVE_STEWARD = address(0); // TODO

  address public constant GHO_CCIP_STEWARD = address(0); // TODO

  function execute() external {
    address ACL_MANAGER = AaveV3Arbitrum.POOL_ADDRESSES_PROVIDER.getACLManager();

    // New CCIP Token Pool
    TransparentUpgradeableProxy(payable(MiscArbitrum.GHO_CCIP_TOKEN_POOL)).upgradeTo(
      NEW_CCIP_POOL_TOKEN
    );

    // Gho Bucket Steward
    IGhoToken(AaveV3ArbitrumAssets.GHO_UNDERLYING).grantRole(
      IGhoToken(AaveV3ArbitrumAssets.GHO_UNDERLYING).BUCKET_MANAGER_ROLE(),
      address(GHO_BUCKET_STEWARD)
    );

    // Gho Aave Steward
    IAccessControl(ACL_MANAGER).grantRole(
      IACLManager(ACL_MANAGER).RISK_ADMIN_ROLE(),
      address(GHO_AAVE_STEWARD)
    );

    // Gho CCIP Steward
    IUpgradeableLockReleaseTokenPool(NEW_CCIP_POOL_TOKEN).setRateLimitAdmin(GHO_CCIP_STEWARD);
  }
}
