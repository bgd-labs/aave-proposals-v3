// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GhoCCIPChains} from '../../helpers/gho-launch/constants/GhoCCIPChains.sol';
import {AaveV3GHOLane} from '../../helpers/gho-launch/AaveV3GHOLane.sol';
import {AaveV3Ink_GHOInkLaunch_20250814} from '../AaveV3Ink_GHOInkLaunch_20250814.sol';
import {AaveV3GHOLaunchTest_PostExecution, AaveV3GHOLaunchTest_PreExecution} from '../../helpers/gho-launch/tests/AaveV3GHOLaunchTest.sol';

uint256 constant INK_BLOCK_NUMBER = 24796622;

contract AaveV3Ink_GHOInkLaunch_20250814_PreExecution is AaveV3GHOLaunchTest_PreExecution {
  // https://docs.chain.link/ccip/directory/mainnet/chain/ethereum-mainnet-ink-1
  address internal constant RMN = 0x3A293fa336E118900AD0f2EcfeC0DAa6A4DeDaA1;

  address internal constant RISK_COUNCIL = 0x8513e6F37dBc52De87b166980Fa3F50639694B60;

  constructor() AaveV3GHOLaunchTest_PreExecution(GhoCCIPChains.INK(), 'ink', INK_BLOCK_NUMBER) {}

  function setUp() public virtual override {
    super.setUp();
  }

  function _deployAaveV3GHOLaneProposal() internal virtual override returns (AaveV3GHOLane) {
    return new AaveV3Ink_GHOInkLaunch_20250814();
  }

  function _validateConstants() internal view virtual override {
    assertEq(LOCAL_TOKEN_ADMIN_REGISTRY.typeAndVersion(), 'TokenAdminRegistry 1.5.0');
    assertEq(LOCAL_TOKEN_POOL.typeAndVersion(), 'BurnMintTokenPool 1.5.1');
    assertEq(LOCAL_CCIP_ROUTER.typeAndVersion(), 'Router 1.2.0');
  }

  function _localRiskCouncil() internal view virtual override returns (address) {
    return RISK_COUNCIL;
  }

  function _localRmnProxy() internal view virtual override returns (address) {
    return RMN;
  }

  function _aavePoolAddressesProvider() internal view virtual override returns (address) {
    return address(0); // Not needed as it is only used at GHO Aave Core Stewards Config test
  }

  function _aaveProtocolDataProvider() internal view virtual override returns (address) {
    return address(0); // Not needed as it is only used at GHO Aave Core Stewards Config test
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
  constructor() AaveV3GHOLaunchTest_PostExecution(GhoCCIPChains.INK(), 'ink', INK_BLOCK_NUMBER) {}

  function _deployAaveV3GHOLaneProposal() internal virtual override returns (AaveV3GHOLane) {
    return new AaveV3Ink_GHOInkLaunch_20250814();
  }

  function _validateConstants() internal view virtual override {
    assertEq(LOCAL_TOKEN_ADMIN_REGISTRY.typeAndVersion(), 'TokenAdminRegistry 1.5.0');
    assertEq(LOCAL_TOKEN_POOL.typeAndVersion(), 'BurnMintTokenPool 1.5.1');
    assertEq(LOCAL_CCIP_ROUTER.typeAndVersion(), 'Router 1.2.0');
  }
}
