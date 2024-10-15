// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Arbitrum, AaveV3ArbitrumAssets} from 'aave-address-book/AaveV3Arbitrum.sol';
import {MiscArbitrum} from 'aave-address-book/MiscArbitrum.sol';
import {GovernanceV3Arbitrum} from 'aave-address-book/GovernanceV3Arbitrum.sol';
import {IACLManager} from 'aave-address-book/AaveV3.sol';
import {IAccessControl} from '@openzeppelin/contracts/access/IAccessControl.sol';
import {TransparentUpgradeableProxy} from 'solidity-utils/contracts/transparent-proxy/TransparentUpgradeableProxy.sol';
import {ProtocolV3TestBase} from 'aave-helpers/src/ProtocolV3TestBase.sol';

import {AaveV3Arbitrum_GHOStewardV2Upgrade_20241007} from './AaveV3Arbitrum_GHOStewardV2Upgrade_20241007.sol';
import {IGhoBucketSteward} from 'src/interfaces/IGhoBucketSteward.sol';
import {IGhoToken} from 'src/interfaces/IGhoToken.sol';
import {IGsm} from 'src/interfaces/IGsm.sol';
import {IUpgradeableLockReleaseTokenPool} from 'src/interfaces/ccip/IUpgradeableLockReleaseTokenPool.sol';

/**
 * @dev Test for AaveV3Arbitrum_GHOStewardV2Upgrade_20241007
 * command: FOUNDRY_PROFILE=arbitrum forge test --match-path=src/20241007_Multi_GHOStewardV2Upgrade/AaveV3Arbitrum_GHOStewardV2Upgrade_20241007.t.sol -vv
 */
contract AaveV3Arbitrum_GHOStewardV2Upgrade_20241007_Test is ProtocolV3TestBase {
  AaveV3Arbitrum_GHOStewardV2Upgrade_20241007 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('arbitrum'), 263919610);
    proposal = new AaveV3Arbitrum_GHOStewardV2Upgrade_20241007();
  }

  function test_roles() public {
    // Gho Bucket Steward
    assertEq(
      IGhoToken(AaveV3ArbitrumAssets.GHO_UNDERLYING).hasRole(
        IGhoToken(AaveV3ArbitrumAssets.GHO_UNDERLYING).BUCKET_MANAGER_ROLE(),
        proposal.GHO_BUCKET_STEWARD()
      ),
      false
    );

    // Gho Aave Steward
    assertEq(
      IAccessControl(address(AaveV3Arbitrum.ACL_MANAGER)).hasRole(
        IACLManager(address(AaveV3Arbitrum.ACL_MANAGER)).RISK_ADMIN_ROLE(),
        proposal.GHO_AAVE_STEWARD()
      ),
      false
    );

    // Gho CCIP Steward
    vm.expectRevert(); // getRateLimitAdmin doesn't exist yet
    IUpgradeableLockReleaseTokenPool(MiscArbitrum.GHO_CCIP_TOKEN_POOL).getRateLimitAdmin();

    executePayload(vm, address(proposal));

    vm.prank(MiscArbitrum.PROXY_ADMIN);
    address impl = TransparentUpgradeableProxy(payable(MiscArbitrum.GHO_CCIP_TOKEN_POOL))
      .implementation();

    IUpgradeableLockReleaseTokenPool poolToken = IUpgradeableLockReleaseTokenPool(
      proposal.NEW_CCIP_POOL_TOKEN()
    );

    assertEq(impl, proposal.NEW_CCIP_POOL_TOKEN());
    assertTrue(poolToken.owner() != address(0));

    address owner = makeAddr('owner');
    address router = makeAddr('router');
    address[] memory list = new address[](0);

    vm.expectRevert();
    poolToken.initialize(owner, list, router);

    // Gho Bucket Steward
    assertEq(
      IGhoToken(AaveV3ArbitrumAssets.GHO_UNDERLYING).hasRole(
        IGhoToken(AaveV3ArbitrumAssets.GHO_UNDERLYING).BUCKET_MANAGER_ROLE(),
        proposal.GHO_BUCKET_STEWARD()
      ),
      true
    );

    assertTrue(_isControlledFacilitator(MiscArbitrum.GHO_CCIP_TOKEN_POOL));

    // Gho Aave Steward
    assertEq(
      IAccessControl(address(AaveV3Arbitrum.ACL_MANAGER)).hasRole(
        IACLManager(address(AaveV3Arbitrum.ACL_MANAGER)).RISK_ADMIN_ROLE(),
        proposal.GHO_AAVE_STEWARD()
      ),
      true
    );

    assertEq(
      IUpgradeableLockReleaseTokenPool(MiscArbitrum.GHO_CCIP_TOKEN_POOL).getRateLimitAdmin(),
      proposal.GHO_CCIP_STEWARD()
    );
  }

  function test_poolTokenFunctionality() public {
    executePayload(vm, address(proposal));

    IUpgradeableLockReleaseTokenPool poolToken = IUpgradeableLockReleaseTokenPool(
      MiscArbitrum.GHO_CCIP_TOKEN_POOL
    );

    poolToken.getRateLimitAdmin();
    poolToken.owner();

    vm.startPrank(GovernanceV3Arbitrum.EXECUTOR_LVL_1);
    poolToken.setRateLimitAdmin(proposal.GHO_CCIP_STEWARD());
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Arbitrum_GHOStewardV2Upgrade_20241007',
      AaveV3Arbitrum.POOL,
      address(proposal)
    );
  }

  function _isControlledFacilitator(address target) internal view returns (bool) {
    address[] memory controlledFacilitators = IGhoBucketSteward(proposal.GHO_BUCKET_STEWARD())
      .getControlledFacilitators();
    for (uint256 i = 0; i < controlledFacilitators.length; i++) {
      if (controlledFacilitators[i] == target) {
        return true;
      }
    }
    return false;
  }
}
