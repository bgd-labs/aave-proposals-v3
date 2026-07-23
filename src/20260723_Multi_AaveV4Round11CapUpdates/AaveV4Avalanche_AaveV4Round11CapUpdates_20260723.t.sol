// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers} from 'aave-helpers/src/GovV3Helpers.sol';
import {AaveV4AvalancheHubs, AaveV4AvalancheAssets, AaveV4AvalancheSpokes} from 'aave-address-book/AaveV4Avalanche.sol';
import {IHub} from 'aave-v4/hub/interfaces/IHub.sol';

import 'forge-std/Test.sol';
import {ProtocolV4TestBaseAvalanche} from 'aave-helpers/src/v4-protocol-test/ProtocolV4TestBaseAvalanche.sol';
import {AaveV4Avalanche_AaveV4Round11CapUpdates_20260723} from './AaveV4Avalanche_AaveV4Round11CapUpdates_20260723.sol';

/**
 * @dev Test for AaveV4Avalanche_AaveV4Round11CapUpdates_20260723
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20260723_Multi_AaveV4Round11CapUpdates/AaveV4Avalanche_AaveV4Round11CapUpdates_20260723.t.sol -vv
 */
contract AaveV4Avalanche_AaveV4Round11CapUpdates_20260723_Test is ProtocolV4TestBaseAvalanche {
  AaveV4Avalanche_AaveV4Round11CapUpdates_20260723 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('avalanche'), 91036002);
    proposal = new AaveV4Avalanche_AaveV4Round11CapUpdates_20260723();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   * forge-config: default.isolate = true
   */
  function test_defaultProposalExecution() public {
    defaultTest('AaveV4Avalanche_AaveV4Round11CapUpdates_20260723', address(proposal));
  }

  // prettier-ignore
  function test_caps_coreHub_before() public {
    //                                                                                                            addCap drawCap
    _assertCaps(IHub(address(AaveV4AvalancheHubs.CORE_HUB)), address(AaveV4AvalancheSpokes.FOREX_SPOKE), AaveV4AvalancheAssets.USDC_UNDERLYING, 200_000, 150_000);
    _assertCaps(IHub(address(AaveV4AvalancheHubs.CORE_HUB)), address(AaveV4AvalancheSpokes.FOREX_SPOKE), AaveV4AvalancheAssets.USDt_UNDERLYING, 200_000, 150_000);
  }

  function test_hubSpokeConfigUpdate_CORE_HUB_FOREX_SPOKE_USDC() public {
    IHub hub = IHub(address(AaveV4AvalancheHubs.CORE_HUB));
    uint256 assetId = hub.getAssetId(AaveV4AvalancheAssets.USDC_UNDERLYING);
    IHub.SpokeConfig memory before = hub.getSpokeConfig(
      assetId,
      address(AaveV4AvalancheSpokes.FOREX_SPOKE)
    );
    GovV3Helpers.executePayload(vm, address(proposal));
    IHub.SpokeConfig memory cfg = hub.getSpokeConfig(
      assetId,
      address(AaveV4AvalancheSpokes.FOREX_SPOKE)
    );
    assertEq(uint256(cfg.addCap), uint256(400_000), 'addCap mismatch');
    assertEq(uint256(cfg.drawCap), uint256(350_000), 'drawCap mismatch');
    assertEq(
      uint256(cfg.riskPremiumThreshold),
      uint256(before.riskPremiumThreshold),
      'riskPremiumThreshold unchanged'
    );
    assertEq(cfg.active, before.active, 'active unchanged');
    assertEq(cfg.halted, before.halted, 'halted unchanged');
  }
  function test_hubSpokeConfigUpdate_CORE_HUB_FOREX_SPOKE_USDt() public {
    IHub hub = IHub(address(AaveV4AvalancheHubs.CORE_HUB));
    uint256 assetId = hub.getAssetId(AaveV4AvalancheAssets.USDt_UNDERLYING);
    IHub.SpokeConfig memory before = hub.getSpokeConfig(
      assetId,
      address(AaveV4AvalancheSpokes.FOREX_SPOKE)
    );
    GovV3Helpers.executePayload(vm, address(proposal));
    IHub.SpokeConfig memory cfg = hub.getSpokeConfig(
      assetId,
      address(AaveV4AvalancheSpokes.FOREX_SPOKE)
    );
    assertEq(uint256(cfg.addCap), uint256(400_000), 'addCap mismatch');
    assertEq(uint256(cfg.drawCap), uint256(350_000), 'drawCap mismatch');
    assertEq(
      uint256(cfg.riskPremiumThreshold),
      uint256(before.riskPremiumThreshold),
      'riskPremiumThreshold unchanged'
    );
    assertEq(cfg.active, before.active, 'active unchanged');
    assertEq(cfg.halted, before.halted, 'halted unchanged');
  }

  function _assertCaps(
    IHub hub,
    address spoke,
    address underlying,
    uint256 expectedAddCap,
    uint256 expectedDrawCap
  ) internal view {
    uint256 assetId = hub.getAssetId(underlying);
    IHub.SpokeConfig memory config = hub.getSpokeConfig(assetId, spoke);
    assertEq(config.addCap, expectedAddCap, 'addCap mismatch');
    assertEq(config.drawCap, expectedDrawCap, 'drawCap mismatch');
  }
}
