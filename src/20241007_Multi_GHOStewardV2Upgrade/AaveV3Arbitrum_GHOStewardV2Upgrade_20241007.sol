// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Arbitrum, AaveV3ArbitrumAssets} from 'aave-address-book/AaveV3Arbitrum.sol';
import {IACLManager} from 'aave-address-book/AaveV3.sol';
import {MiscArbitrum} from 'aave-address-book/MiscArbitrum.sol';
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
  // https://arbiscan.io/address/0xb78eda33eb5493d56f14a81023ce69438a562a2c#code
  address public constant NEW_CCIP_POOL_TOKEN = 0xb78eDA33EB5493d56f14a81023CE69438a562A2c;

  // https://arbiscan.io/address/0x7658a0eae448c8b7714044f959faea13f5e202fa
  address public constant GHO_BUCKET_STEWARD = 0x7658A0EAe448c8b7714044F959fAeA13f5E202FA;

  // https://arbiscan.io/address/0xcd04d93bea13921dad05240d577090b5ac36dfca
  address public constant GHO_AAVE_STEWARD = 0xCd04D93bEA13921DaD05240D577090b5AC36DfCA;

  // https://arbiscan.io/address/0x7484eabea5306eb616ca448cbf442a617dd22869
  address public constant GHO_CCIP_STEWARD = 0x7484eaBeA5306eB616CA448CBF442a617Dd22869;

  function execute() external {
    address ACL_MANAGER = AaveV3Arbitrum.POOL_ADDRESSES_PROVIDER.getACLManager();

    // New CCIP Token Pool
    IProxyAdmin(MiscArbitrum.PROXY_ADMIN).upgrade(
      TransparentUpgradeableProxy(payable(MiscArbitrum.GHO_CCIP_TOKEN_POOL)),
      NEW_CCIP_POOL_TOKEN
    );

    // Gho Bucket Steward
    IGhoToken(AaveV3ArbitrumAssets.GHO_UNDERLYING).grantRole(
      IGhoToken(AaveV3ArbitrumAssets.GHO_UNDERLYING).BUCKET_MANAGER_ROLE(),
      GHO_BUCKET_STEWARD
    );

    address[] memory controlledFacilitators = new address[](1);
    controlledFacilitators[0] = NEW_CCIP_POOL_TOKEN;
    IGhoBucketSteward(GHO_BUCKET_STEWARD).setControlledFacilitator(controlledFacilitators, true);

    // Gho Aave Steward
    IAccessControl(ACL_MANAGER).grantRole(
      IACLManager(ACL_MANAGER).RISK_ADMIN_ROLE(),
      GHO_AAVE_STEWARD
    );

    // Gho CCIP Steward
    IUpgradeableLockReleaseTokenPool(MiscArbitrum.GHO_CCIP_TOKEN_POOL).setRateLimitAdmin(
      GHO_CCIP_STEWARD
    );
  }
}

interface IProxyAdmin {
  /**
   * @dev Upgrades `proxy` to `implementation`. See {TransparentUpgradeableProxy-upgradeTo}.
   *
   * Requirements:
   *
   * - This contract must be the admin of `proxy`.
   */
  function upgrade(TransparentUpgradeableProxy proxy, address implementation) external;
}
