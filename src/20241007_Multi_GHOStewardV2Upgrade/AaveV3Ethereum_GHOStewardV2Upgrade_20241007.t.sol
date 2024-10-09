// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {MiscEthereum} from 'aave-address-book/MiscEthereum.sol';
import {IACLManager} from 'aave-address-book/AaveV3.sol';
import {IAccessControl} from '@openzeppelin/contracts/access/IAccessControl.sol';
import {ProtocolV3TestBase} from 'aave-helpers/src/ProtocolV3TestBase.sol';

import {AaveV3Ethereum_GHOStewardV2Upgrade_20241007} from './AaveV3Ethereum_GHOStewardV2Upgrade_20241007.sol';
import {IGhoBucketSteward} from 'src/interfaces/IGhoBucketSteward.sol';
import {IGhoToken} from 'src/interfaces/IGhoToken.sol';
import {IGsm} from 'src/interfaces/IGsm.sol';
import {IUpgradeableLockReleaseTokenPool} from 'src/interfaces/ccip/IUpgradeableLockReleaseTokenPool.sol';

/**
 * @dev Test for AaveV3Ethereum_GHOStewardV2Upgrade_20241007
 * command: FOUNDRY_PROFILE=mainnet forge test --match-path=src/20241007_Multi_GHOStewardV2Upgrade/AaveV3Ethereum_GHOStewardV2Upgrade_20241007.t.sol -vv
 */
contract AaveV3Ethereum_GHOStewardV2Upgrade_20241007_Test is ProtocolV3TestBase {
  AaveV3Ethereum_GHOStewardV2Upgrade_20241007 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 20925231);
    proposal = new AaveV3Ethereum_GHOStewardV2Upgrade_20241007();
  }

  function test_roles() public {
    address ACL_MANAGER = AaveV3Ethereum.POOL_ADDRESSES_PROVIDER.getACLManager();

    // Gho Bucket Steward
    assertEq(
      IGhoToken(AaveV3EthereumAssets.GHO_UNDERLYING).hasRole(
        IGhoToken(AaveV3EthereumAssets.GHO_UNDERLYING).BUCKET_MANAGER_ROLE(),
        proposal.GHO_BUCKET_STEWARD()
      ),
      false
    );

    // Gho Aave Steward
    assertEq(
      IAccessControl(ACL_MANAGER).hasRole(
        IACLManager(ACL_MANAGER).RISK_ADMIN_ROLE(),
        proposal.GHO_AAVE_STEWARD()
      ),
      false
    );

    // Gho CCIP Steward
    assertEq(
      IUpgradeableLockReleaseTokenPool(MiscEthereum.GHO_CCIP_TOKEN_POOL).getBridgeLimitAdmin(),
      address(0)
    );
    assertEq(
      IUpgradeableLockReleaseTokenPool(MiscEthereum.GHO_CCIP_TOKEN_POOL).getRateLimitAdmin(),
      address(0)
    );

    // GHO GSM Steward
    assertEq(
      IGsm(MiscEthereum.GSM_USDC).hasRole(
        IGsm(MiscEthereum.GSM_USDC).CONFIGURATOR_ROLE(),
        proposal.GHO_GSM_STEWARD()
      ),
      false
    );
    assertEq(
      IGsm(MiscEthereum.GSM_USDT).hasRole(
        IGsm(MiscEthereum.GSM_USDT).CONFIGURATOR_ROLE(),
        proposal.GHO_GSM_STEWARD()
      ),
      false
    );

    executePayload(vm, address(proposal));

    // Gho Bucket Steward
    assertEq(
      IGhoToken(AaveV3EthereumAssets.GHO_UNDERLYING).hasRole(
        IGhoToken(AaveV3EthereumAssets.GHO_UNDERLYING).BUCKET_MANAGER_ROLE(),
        proposal.GHO_BUCKET_STEWARD()
      ),
      true
    );

    assertTrue(_isControlledFacilitator(AaveV3EthereumAssets.GHO_A_TOKEN));
    assertTrue(_isControlledFacilitator(MiscEthereum.GSM_USDC));
    assertTrue(_isControlledFacilitator(MiscEthereum.GSM_USDT));

    // Gho Aave Steward
    assertEq(
      IAccessControl(ACL_MANAGER).hasRole(
        IACLManager(ACL_MANAGER).RISK_ADMIN_ROLE(),
        proposal.GHO_AAVE_STEWARD()
      ),
      true
    );

    assertEq(
      IUpgradeableLockReleaseTokenPool(MiscEthereum.GHO_CCIP_TOKEN_POOL).getBridgeLimitAdmin(),
      proposal.GHO_CCIP_STEWARD()
    );
    assertEq(
      IUpgradeableLockReleaseTokenPool(MiscEthereum.GHO_CCIP_TOKEN_POOL).getRateLimitAdmin(),
      proposal.GHO_CCIP_STEWARD()
    );

    // GHO GSM Steward
    assertEq(
      IGsm(MiscEthereum.GSM_USDC).hasRole(
        IGsm(MiscEthereum.GSM_USDC).CONFIGURATOR_ROLE(),
        proposal.GHO_GSM_STEWARD()
      ),
      true
    );
    assertEq(
      IGsm(MiscEthereum.GSM_USDT).hasRole(
        IGsm(MiscEthereum.GSM_USDT).CONFIGURATOR_ROLE(),
        proposal.GHO_GSM_STEWARD()
      ),
      true
    );
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Ethereum_GHOStewardV2Upgrade_20241007',
      AaveV3Ethereum.POOL,
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
