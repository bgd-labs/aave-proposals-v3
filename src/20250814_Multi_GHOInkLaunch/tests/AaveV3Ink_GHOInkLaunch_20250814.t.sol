// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GHOInkLaunchConstants} from '../GHOInkLaunchConstants.sol';
import {GhoCCIPChains} from '../abstraction/constants/GhoCCIPChains.sol';
import {AaveV3GHOLane} from '../abstraction/AaveV3GHOLane.sol';
import {AaveV3Ink_GHOInkLaunch_20250814} from '../AaveV3Ink_GHOInkLaunch_20250814.sol';
import {AaveV3GHOLaunchTest_PostExecution, AaveV3GHOLaunchTest_PreExecution} from '../abstraction/tests/AaveV3GHOLaunchTest.sol';

contract AaveV3Ink_GHOInkLaunch_20250814_PreExecution is AaveV3GHOLaunchTest_PreExecution {
  constructor()
    AaveV3GHOLaunchTest_PreExecution(
      GhoCCIPChains.INK(),
      'ink',
      GHOInkLaunchConstants.INK_BLOCK_NUMBER
    )
  {}

  function _deployAaveV3GHOLaneProposal() internal virtual override returns (AaveV3GHOLane) {
    return new AaveV3Ink_GHOInkLaunch_20250814();
  }

  function _expectedSupportedChains()
    internal
    view
    virtual
    override
    returns (GhoCCIPChains.ChainInfo[] memory)
  {
    GhoCCIPChains.ChainInfo[] memory chains = new GhoCCIPChains.ChainInfo[](5);
    chains[0] = GhoCCIPChains.ETHEREUM();
    chains[1] = GhoCCIPChains.ARBITRUM();
    chains[2] = GhoCCIPChains.BASE();
    chains[3] = GhoCCIPChains.AVALANCHE();
    chains[4] = GhoCCIPChains.GNOSIS();
    return chains;
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
    // GHO Aave Core is not configured on this proposal
  }
}

contract AaveV3Ink_GHOInkLaunch_20250814_PostExecution is AaveV3GHOLaunchTest_PostExecution {
  constructor()
    AaveV3GHOLaunchTest_PostExecution(
      GhoCCIPChains.INK(),
      'ink',
      GHOInkLaunchConstants.INK_BLOCK_NUMBER
    )
  {}

  function _deployAaveV3GHOLaneProposal() internal virtual override returns (AaveV3GHOLane) {
    return new AaveV3Ink_GHOInkLaunch_20250814();
  }

  function _expectedSupportedChains()
    internal
    view
    virtual
    override
    returns (GhoCCIPChains.ChainInfo[] memory)
  {
    GhoCCIPChains.ChainInfo[] memory chains = new GhoCCIPChains.ChainInfo[](5);
    chains[0] = GhoCCIPChains.ETHEREUM();
    chains[1] = GhoCCIPChains.ARBITRUM();
    chains[2] = GhoCCIPChains.BASE();
    chains[3] = GhoCCIPChains.AVALANCHE();
    chains[4] = GhoCCIPChains.GNOSIS();
    return chains;
  }

  function _validateConstants() internal view virtual override {
    assertEq(LOCAL_TOKEN_ADMIN_REGISTRY.typeAndVersion(), 'TokenAdminRegistry 1.5.0');
    assertEq(LOCAL_TOKEN_POOL.typeAndVersion(), 'BurnMintTokenPool 1.5.1');
    assertEq(LOCAL_CCIP_ROUTER.typeAndVersion(), 'Router 1.2.0');
  }
}
