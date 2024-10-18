// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Arbitrum, AaveV3ArbitrumAssets} from 'aave-address-book/AaveV3Arbitrum.sol';
import {IACLManager} from 'aave-address-book/AaveV3.sol';
import {MiscArbitrum} from 'aave-address-book/MiscArbitrum.sol';
import {ProxyAdmin} from 'solidity-utils/contracts/transparent-proxy/ProxyAdmin.sol';
import {TransparentUpgradeableProxy} from 'solidity-utils/contracts/transparent-proxy/TransparentUpgradeableProxy.sol';
import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {IAccessControl} from '@openzeppelin/contracts/access/IAccessControl.sol';

import {IGhoBucketSteward} from 'src/interfaces/IGhoBucketSteward.sol';
import {IGhoToken} from 'src/interfaces/IGhoToken.sol';
import {IUpgradeableLockReleaseTokenPool} from 'src/interfaces/ccip/IUpgradeableLockReleaseTokenPool.sol';

/**
 * @title GHO Steward v2 Upgrade
 * @author @karpatkey_TokenLogic
 * - Snapshot: https://snapshot.org/#/aave.eth/proposal/0xc5e7df1536ef9fc71a7d2e2f6fee6e4e20e37a50b4e0f1646616d066b8697da5
 * - Discussion: https://governance.aave.com/t/arfc-gho-steward-v2-upgrade/19116
 */
contract AaveV3Arbitrum_GHOStewardV2Upgrade_20241007 is IProposalGenericExecutor {
  // https://arbiscan.io/address/0xb78eda33eb5493d56f14a81023ce69438a562a2c
  address public constant NEW_CCIP_POOL_IMPL = 0xb78eDA33EB5493d56f14a81023CE69438a562A2c;

  // https://arbiscan.io/address/0xa9afaE6A53E90f9E4CE0717162DF5Bc3d9aBe7B2
  address public constant GHO_BUCKET_STEWARD = 0xa9afaE6A53E90f9E4CE0717162DF5Bc3d9aBe7B2;

  // https://arbiscan.io/address/0xcd04d93bea13921dad05240d577090b5ac36dfca
  address public constant GHO_AAVE_STEWARD = 0xCd04D93bEA13921DaD05240D577090b5AC36DfCA;

  // https://arbiscan.io/address/0xb329CEFF2c362F315900d245eC88afd24C4949D5
  address public constant GHO_CCIP_STEWARD = 0xb329CEFF2c362F315900d245eC88afd24C4949D5;

  function execute() external {
    // New CCIP Token Pool
    ProxyAdmin(MiscArbitrum.PROXY_ADMIN).upgrade(
      TransparentUpgradeableProxy(payable(MiscArbitrum.GHO_CCIP_TOKEN_POOL)),
      NEW_CCIP_POOL_IMPL
    );

    // Gho Bucket Steward
    IGhoToken(AaveV3ArbitrumAssets.GHO_UNDERLYING).grantRole(
      IGhoToken(AaveV3ArbitrumAssets.GHO_UNDERLYING).BUCKET_MANAGER_ROLE(),
      GHO_BUCKET_STEWARD
    );

    address[] memory controlledFacilitators = new address[](1);
    controlledFacilitators[0] = MiscArbitrum.GHO_CCIP_TOKEN_POOL;
    IGhoBucketSteward(GHO_BUCKET_STEWARD).setControlledFacilitator(controlledFacilitators, true);

    // Gho Aave Steward
    IAccessControl(address(AaveV3Arbitrum.ACL_MANAGER)).grantRole(
      IACLManager(address(AaveV3Arbitrum.ACL_MANAGER)).RISK_ADMIN_ROLE(),
      GHO_AAVE_STEWARD
    );

    // Gho CCIP Steward
    IUpgradeableLockReleaseTokenPool(MiscArbitrum.GHO_CCIP_TOKEN_POOL).setRateLimitAdmin(
      GHO_CCIP_STEWARD
    );
  }
}
