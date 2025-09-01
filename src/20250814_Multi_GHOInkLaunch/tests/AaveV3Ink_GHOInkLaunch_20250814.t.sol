// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GHOInkLaunchConstants} from '../GHOInkLaunchConstants.sol';
import {GhoCCIPChains} from '../../helpers/gho-launch/constants/GhoCCIPChains.sol';
import {AaveV3GHOLane} from '../../helpers/gho-launch/AaveV3GHOLane.sol';
import {AaveV3Ink_GHOInkLaunch_20250814} from '../AaveV3Ink_GHOInkLaunch_20250814.sol';
import {AaveV3GHOLaunchTest_PostExecution, AaveV3GHOLaunchTest_PreExecution} from '../../helpers/gho-launch/tests/AaveV3GHOLaunchTest.sol';
import {CCIPChainTokenAdminRegistries} from '../../helpers/gho-launch/constants/CCIPChainTokenAdminRegistries.sol';
import {ITokenAdminRegistry} from 'src/interfaces/ccip/ITokenAdminRegistry.sol';
import {GovV3Helpers} from 'aave-helpers/src/GovV3Helpers.sol';
import {GovernanceV3Ink} from 'aave-address-book/GovernanceV3Ink.sol';

contract AaveV3Ink_GHOInkLaunch_20250814_PreExecution is AaveV3GHOLaunchTest_PreExecution {
  constructor() AaveV3GHOLaunchTest_PreExecution(GhoCCIPChains.INK(), 'ink', 22331165) {}

  function setUp() public virtual override {
    super.setUp();
  }

  function _executePayload() internal virtual override {
    _mockAdministratorProposal();
    GovV3Helpers.executePayload(
      vm,
      address(proposal),
      address(GovernanceV3Ink.PAYLOADS_CONTROLLER)
    );
  }

  // TODO: Temporary mock until done on Ink
  function _mockAdministratorProposal() internal {
    vm.startPrank(ITokenAdminRegistry(CCIPChainTokenAdminRegistries.INK).owner());
    ITokenAdminRegistry(CCIPChainTokenAdminRegistries.INK).proposeAdministrator(
      GhoCCIPChains.INK().ghoToken,
      GhoCCIPChains.INK().owner
    );
    vm.stopPrank();
  }

  function test_defaultProposalExecution() public virtual override {
    vm.skip(true); // TODO: Not using the proper payload controller - Change needed at aave-helpers for default test
  }

  function _deployAaveV3GHOLaneProposal() internal virtual override returns (AaveV3GHOLane) {
    return new AaveV3Ink_GHOInkLaunch_20250814();
  }

  function _validateConstants() internal view virtual override {
    assertEq(LOCAL_TOKEN_ADMIN_REGISTRY.typeAndVersion(), 'TokenAdminRegistry 1.5.0');
    assertEq(LOCAL_TOKEN_POOL.typeAndVersion(), 'BurnMintTokenPool 1.5.1');
    assertEq(LOCAL_CCIP_ROUTER.typeAndVersion(), 'Router 1.2.0');
  }

  function _reportName() internal view virtual override returns (string memory) {
    return 'AaveV3Ink_GHOInkLaunch_20250814';
  }

  function _aavePool() internal view virtual override returns (address) {
    return GHOInkLaunchConstants.POOL;
  }

  function _localRiskCouncil() internal view virtual override returns (address) {
    return GHOInkLaunchConstants.RISK_COUNCIL;
  }

  function _localRmnProxy() internal view virtual override returns (address) {
    return GHOInkLaunchConstants.RMN;
  }

  function _aavePoolAddressesProvider() internal view virtual override returns (address) {
    return GHOInkLaunchConstants.POOL_ADDRESSES_PROVIDER;
  }

  function _aaveProtocolDataProvider() internal view virtual override returns (address) {
    return GHOInkLaunchConstants.AAVE_PROTOCOL_DATA_PROVIDER;
  }

  function _test_ghoAaveCore_stewardsConfig() internal view virtual override {
    // GHO Aave Core Steward is not configured on this proposal
  }

  function _test_ghoAaveCore_stewardsRoles_beforePayloadExecution() internal view virtual override {
    // GHO Aave Core Steward is not configured on this proposal
  }

  function _test_ghoAaveCore_stewardsRoles_afterPayloadExecution() internal view virtual override {
    // GHO Aave Core Steward is not configured on this proposal
  }
}

contract AaveV3Ink_GHOInkLaunch_20250814_PostExecution is AaveV3GHOLaunchTest_PostExecution {
  constructor() AaveV3GHOLaunchTest_PostExecution(GhoCCIPChains.INK(), 'ink', 22331165) {}

  function _executePayload() internal virtual override {
    _mockAdministratorProposal();
    GovV3Helpers.executePayload(
      vm,
      address(proposal),
      address(GovernanceV3Ink.PAYLOADS_CONTROLLER)
    );
  }

  // TODO: Temporary mock until done on Ink
  function _mockAdministratorProposal() internal {
    vm.startPrank(ITokenAdminRegistry(CCIPChainTokenAdminRegistries.INK).owner());
    ITokenAdminRegistry(CCIPChainTokenAdminRegistries.INK).proposeAdministrator(
      GhoCCIPChains.INK().ghoToken,
      GhoCCIPChains.INK().owner
    );
    vm.stopPrank();
  }

  function _aavePool() internal view virtual override returns (address) {
    return GHOInkLaunchConstants.POOL;
  }

  function _deployAaveV3GHOLaneProposal() internal virtual override returns (AaveV3GHOLane) {
    return new AaveV3Ink_GHOInkLaunch_20250814();
  }

  function _validateConstants() internal view virtual override {
    assertEq(LOCAL_TOKEN_ADMIN_REGISTRY.typeAndVersion(), 'TokenAdminRegistry 1.5.0');
    assertEq(LOCAL_TOKEN_POOL.typeAndVersion(), 'BurnMintTokenPool 1.5.1');
    assertEq(LOCAL_CCIP_ROUTER.typeAndVersion(), 'Router 1.2.0');
  }
}
