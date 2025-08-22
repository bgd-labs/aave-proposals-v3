// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {GhoEthereum} from 'aave-address-book/GhoEthereum.sol';
import {GovernanceV3Ethereum} from 'aave-address-book/GovernanceV3Ethereum.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Ethereum_GHOFacilitatorReplacement_20250821} from './AaveV3Ethereum_GHOFacilitatorReplacement_20250821.sol';

import {ProxyAdmin, ITransparentUpgradeableProxy} from 'openzeppelin-contracts/contracts/proxy/transparent/ProxyAdmin.sol';

import {IGhoToken} from './interfaces/IGhoToken.sol';
import {IGhoBucketSteward} from './interfaces/IGhoBucketSteward.sol';

/**
 * @dev Test for AaveV3Ethereum_GHOFacilitatorReplacement_20250821
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20250821_AaveV3Ethereum_GHOFacilitatorReplacement/AaveV3Ethereum_GHOFacilitatorReplacement_20250821.t.sol -vv
 */
contract AaveV3Ethereum_GHOFacilitatorReplacement_20250821_Test is ProtocolV3TestBase {
  AaveV3Ethereum_GHOFacilitatorReplacement_20250821 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 23190163);
    proposal = new AaveV3Ethereum_GHOFacilitatorReplacement_20250821();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Ethereum_GHOFacilitatorReplacement_20250821',
      AaveV3Ethereum.POOL,
      address(proposal)
    );
  }

  function test_facilitatorLevelAndCapacity() public {
    (uint256 capacityFromOldFacilitator, uint256 levelFromOldFacilitator) = IGhoToken(
      AaveV3EthereumAssets.GHO_UNDERLYING
    ).getFacilitatorBucket(proposal.OLD_FACILITATOR());

    executePayload(vm, address(proposal));

    (uint256 newCapacityFromOldFacilitator, uint256 newLevelFromOldFacilitator) = IGhoToken(
      AaveV3EthereumAssets.GHO_UNDERLYING
    ).getFacilitatorBucket(proposal.OLD_FACILITATOR());
    assertEq(newCapacityFromOldFacilitator, 0);
    assertEq(newLevelFromOldFacilitator, 0);

    (uint256 capacityFromNewFacilitator, uint256 levelFromNewFacilitator) = IGhoToken(
      AaveV3EthereumAssets.GHO_UNDERLYING
    ).getFacilitatorBucket(proposal.NEW_FACILITATOR());
    assertEq(capacityFromNewFacilitator, capacityFromOldFacilitator);
    assertEq(levelFromNewFacilitator, levelFromOldFacilitator);
  }

  function test_roles() public {
    executePayload(vm, address(proposal));

    assertFalse(AaveV3Ethereum.ACL_MANAGER.isRiskAdmin(proposal.OLD_FACILITATOR()));
    assertTrue(AaveV3Ethereum.ACL_MANAGER.isRiskAdmin(proposal.NEW_FACILITATOR()));

    assertTrue(
      IGhoBucketSteward(GhoEthereum.GHO_BUCKET_STEWARD).isControlledFacilitator(
        proposal.NEW_FACILITATOR()
      )
    );
    assertFalse(
      IGhoBucketSteward(GhoEthereum.GHO_BUCKET_STEWARD).isControlledFacilitator(
        proposal.OLD_FACILITATOR()
      )
    );
  }

  function test_proxyAdmin() public {
    executePayload(vm, address(proposal));

    address proxyAdmin = 0x40E4243C9471bb0a84Ba0968bccc9b8975E5Ee62;

    address newImplementation = address(new TestImplementation());

    vm.startPrank(GovernanceV3Ethereum.EXECUTOR_LVL_1);

    ProxyAdmin(proxyAdmin).upgradeAndCall({
      proxy: ITransparentUpgradeableProxy(proposal.NEW_FACILITATOR()),
      implementation: newImplementation,
      data: ''
    });

    vm.stopPrank();

    assertEq(TestImplementation(proposal.NEW_FACILITATOR()).CONSTANT_VALUE(), 1);
  }
}

contract TestImplementation {
  uint256 public constant CONSTANT_VALUE = 1;
}
