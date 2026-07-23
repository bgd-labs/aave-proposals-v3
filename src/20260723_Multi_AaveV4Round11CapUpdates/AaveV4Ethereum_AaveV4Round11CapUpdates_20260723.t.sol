// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers} from 'aave-helpers/src/GovV3Helpers.sol';
import {AaveV4EthereumHubs, AaveV4EthereumAssets, AaveV4EthereumSpokes} from 'aave-address-book/AaveV4Ethereum.sol';
import {IHub} from 'aave-v4/hub/interfaces/IHub.sol';

import 'forge-std/Test.sol';
import {ProtocolV4TestBaseEthereum} from 'aave-helpers/src/v4-protocol-test/ProtocolV4TestBaseEthereum.sol';
import {AaveV4Ethereum_AaveV4Round11CapUpdates_20260723} from './AaveV4Ethereum_AaveV4Round11CapUpdates_20260723.sol';

/**
 * @dev Test for AaveV4Ethereum_AaveV4Round11CapUpdates_20260723
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20260723_Multi_AaveV4Round11CapUpdates/AaveV4Ethereum_AaveV4Round11CapUpdates_20260723.t.sol -vv
 */
contract AaveV4Ethereum_AaveV4Round11CapUpdates_20260723_Test is ProtocolV4TestBaseEthereum {
  AaveV4Ethereum_AaveV4Round11CapUpdates_20260723 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 25595214);
    proposal = new AaveV4Ethereum_AaveV4Round11CapUpdates_20260723();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   * forge-config: default.isolate = true
   */
  function test_defaultProposalExecution() public {
    defaultTest('AaveV4Ethereum_AaveV4Round11CapUpdates_20260723', address(proposal));
  }

  // prettier-ignore
  function test_caps_coreHub_before() public {
    //                                                                                                             addCap     drawCap
    _assertCaps(IHub(address(AaveV4EthereumHubs.CORE_HUB)), address(AaveV4EthereumSpokes.ETHERFI_ESPOKE), AaveV4EthereumAssets.WETH_UNDERLYING,   0,          13_000);
    _assertCaps(IHub(address(AaveV4EthereumHubs.CORE_HUB)), address(AaveV4EthereumSpokes.ETHERFI_ESPOKE), AaveV4EthereumAssets.weETH_UNDERLYING,  18_000,     0);
    _assertCaps(IHub(address(AaveV4EthereumHubs.CORE_HUB)), address(AaveV4EthereumSpokes.GOLD_SPOKE),     AaveV4EthereumAssets.USDG_UNDERLYING,   0,          1_000_000);
    _assertCaps(IHub(address(AaveV4EthereumHubs.CORE_HUB)), address(AaveV4EthereumSpokes.GOLD_SPOKE),     AaveV4EthereumAssets.XAUt_UNDERLYING,   2_500,      0);
    _assertCaps(IHub(address(AaveV4EthereumHubs.CORE_HUB)), address(AaveV4EthereumSpokes.GOLD_SPOKE),     AaveV4EthereumAssets.frxUSD_UNDERLYING, 0,          1_000_000);
    _assertCaps(IHub(address(AaveV4EthereumHubs.CORE_HUB)), address(AaveV4EthereumSpokes.MAIN_SPOKE),     AaveV4EthereumAssets.LINK_UNDERLYING,   750_000,    0);
    _assertCaps(IHub(address(AaveV4EthereumHubs.CORE_HUB)), address(AaveV4EthereumSpokes.MAIN_SPOKE),     AaveV4EthereumAssets.USDG_UNDERLYING,   50_000_000, 27_200_000);
    _assertCaps(IHub(address(AaveV4EthereumHubs.CORE_HUB)), address(AaveV4EthereumSpokes.MAIN_SPOKE),     AaveV4EthereumAssets.WBTC_UNDERLYING,   1_150,      100);
    _assertCaps(IHub(address(AaveV4EthereumHubs.CORE_HUB)), address(AaveV4EthereumSpokes.MAIN_SPOKE),     AaveV4EthereumAssets.WETH_UNDERLYING,   30_000,     2_600);
  }

  // prettier-ignore
  function test_caps_primeHub_before() public {
    //                                                                                                               addCap drawCap
    _assertCaps(IHub(address(AaveV4EthereumHubs.PRIME_HUB)), address(AaveV4EthereumSpokes.BLUECHIP_SPOKE), AaveV4EthereumAssets.WBTC_UNDERLYING,   400,    0);
    _assertCaps(IHub(address(AaveV4EthereumHubs.PRIME_HUB)), address(AaveV4EthereumSpokes.BLUECHIP_SPOKE), AaveV4EthereumAssets.WETH_UNDERLYING,   5_000,  0);
    _assertCaps(IHub(address(AaveV4EthereumHubs.PRIME_HUB)), address(AaveV4EthereumSpokes.BLUECHIP_SPOKE), AaveV4EthereumAssets.cbBTC_UNDERLYING,  130,    0);
    _assertCaps(IHub(address(AaveV4EthereumHubs.PRIME_HUB)), address(AaveV4EthereumSpokes.BLUECHIP_SPOKE), AaveV4EthereumAssets.wstETH_UNDERLYING, 7_000,  0);
  }

  function test_hubSpokeConfigUpdate_CORE_HUB_ETHERFI_ESPOKE_WETH() public {
    IHub hub = IHub(address(AaveV4EthereumHubs.CORE_HUB));
    uint256 assetId = hub.getAssetId(AaveV4EthereumAssets.WETH_UNDERLYING);
    IHub.SpokeConfig memory before = hub.getSpokeConfig(
      assetId,
      address(AaveV4EthereumSpokes.ETHERFI_ESPOKE)
    );
    GovV3Helpers.executePayload(vm, address(proposal));
    IHub.SpokeConfig memory cfg = hub.getSpokeConfig(
      assetId,
      address(AaveV4EthereumSpokes.ETHERFI_ESPOKE)
    );
    assertEq(uint256(cfg.addCap), uint256(before.addCap), 'addCap unchanged');
    assertEq(uint256(cfg.drawCap), uint256(20_000), 'drawCap mismatch');
    assertEq(
      uint256(cfg.riskPremiumThreshold),
      uint256(before.riskPremiumThreshold),
      'riskPremiumThreshold unchanged'
    );
    assertEq(cfg.active, before.active, 'active unchanged');
    assertEq(cfg.halted, before.halted, 'halted unchanged');
  }
  function test_hubSpokeConfigUpdate_CORE_HUB_ETHERFI_ESPOKE_weETH() public {
    IHub hub = IHub(address(AaveV4EthereumHubs.CORE_HUB));
    uint256 assetId = hub.getAssetId(AaveV4EthereumAssets.weETH_UNDERLYING);
    IHub.SpokeConfig memory before = hub.getSpokeConfig(
      assetId,
      address(AaveV4EthereumSpokes.ETHERFI_ESPOKE)
    );
    GovV3Helpers.executePayload(vm, address(proposal));
    IHub.SpokeConfig memory cfg = hub.getSpokeConfig(
      assetId,
      address(AaveV4EthereumSpokes.ETHERFI_ESPOKE)
    );
    assertEq(uint256(cfg.addCap), uint256(28_000), 'addCap mismatch');
    assertEq(uint256(cfg.drawCap), uint256(before.drawCap), 'drawCap unchanged');
    assertEq(
      uint256(cfg.riskPremiumThreshold),
      uint256(before.riskPremiumThreshold),
      'riskPremiumThreshold unchanged'
    );
    assertEq(cfg.active, before.active, 'active unchanged');
    assertEq(cfg.halted, before.halted, 'halted unchanged');
  }
  function test_hubSpokeConfigUpdate_CORE_HUB_GOLD_SPOKE_USDG() public {
    IHub hub = IHub(address(AaveV4EthereumHubs.CORE_HUB));
    uint256 assetId = hub.getAssetId(AaveV4EthereumAssets.USDG_UNDERLYING);
    IHub.SpokeConfig memory before = hub.getSpokeConfig(
      assetId,
      address(AaveV4EthereumSpokes.GOLD_SPOKE)
    );
    GovV3Helpers.executePayload(vm, address(proposal));
    IHub.SpokeConfig memory cfg = hub.getSpokeConfig(
      assetId,
      address(AaveV4EthereumSpokes.GOLD_SPOKE)
    );
    assertEq(uint256(cfg.addCap), uint256(before.addCap), 'addCap unchanged');
    assertEq(uint256(cfg.drawCap), uint256(2_000_000), 'drawCap mismatch');
    assertEq(
      uint256(cfg.riskPremiumThreshold),
      uint256(before.riskPremiumThreshold),
      'riskPremiumThreshold unchanged'
    );
    assertEq(cfg.active, before.active, 'active unchanged');
    assertEq(cfg.halted, before.halted, 'halted unchanged');
  }
  function test_hubSpokeConfigUpdate_CORE_HUB_GOLD_SPOKE_XAUt() public {
    IHub hub = IHub(address(AaveV4EthereumHubs.CORE_HUB));
    uint256 assetId = hub.getAssetId(AaveV4EthereumAssets.XAUt_UNDERLYING);
    IHub.SpokeConfig memory before = hub.getSpokeConfig(
      assetId,
      address(AaveV4EthereumSpokes.GOLD_SPOKE)
    );
    GovV3Helpers.executePayload(vm, address(proposal));
    IHub.SpokeConfig memory cfg = hub.getSpokeConfig(
      assetId,
      address(AaveV4EthereumSpokes.GOLD_SPOKE)
    );
    assertEq(uint256(cfg.addCap), uint256(3_800), 'addCap mismatch');
    assertEq(uint256(cfg.drawCap), uint256(before.drawCap), 'drawCap unchanged');
    assertEq(
      uint256(cfg.riskPremiumThreshold),
      uint256(before.riskPremiumThreshold),
      'riskPremiumThreshold unchanged'
    );
    assertEq(cfg.active, before.active, 'active unchanged');
    assertEq(cfg.halted, before.halted, 'halted unchanged');
  }
  function test_hubSpokeConfigUpdate_CORE_HUB_GOLD_SPOKE_frxUSD() public {
    IHub hub = IHub(address(AaveV4EthereumHubs.CORE_HUB));
    uint256 assetId = hub.getAssetId(AaveV4EthereumAssets.frxUSD_UNDERLYING);
    IHub.SpokeConfig memory before = hub.getSpokeConfig(
      assetId,
      address(AaveV4EthereumSpokes.GOLD_SPOKE)
    );
    GovV3Helpers.executePayload(vm, address(proposal));
    IHub.SpokeConfig memory cfg = hub.getSpokeConfig(
      assetId,
      address(AaveV4EthereumSpokes.GOLD_SPOKE)
    );
    assertEq(uint256(cfg.addCap), uint256(before.addCap), 'addCap unchanged');
    assertEq(uint256(cfg.drawCap), uint256(2_000_000), 'drawCap mismatch');
    assertEq(
      uint256(cfg.riskPremiumThreshold),
      uint256(before.riskPremiumThreshold),
      'riskPremiumThreshold unchanged'
    );
    assertEq(cfg.active, before.active, 'active unchanged');
    assertEq(cfg.halted, before.halted, 'halted unchanged');
  }
  function test_hubSpokeConfigUpdate_CORE_HUB_MAIN_SPOKE_LINK() public {
    IHub hub = IHub(address(AaveV4EthereumHubs.CORE_HUB));
    uint256 assetId = hub.getAssetId(AaveV4EthereumAssets.LINK_UNDERLYING);
    IHub.SpokeConfig memory before = hub.getSpokeConfig(
      assetId,
      address(AaveV4EthereumSpokes.MAIN_SPOKE)
    );
    GovV3Helpers.executePayload(vm, address(proposal));
    IHub.SpokeConfig memory cfg = hub.getSpokeConfig(
      assetId,
      address(AaveV4EthereumSpokes.MAIN_SPOKE)
    );
    assertEq(uint256(cfg.addCap), uint256(900_000), 'addCap mismatch');
    assertEq(uint256(cfg.drawCap), uint256(before.drawCap), 'drawCap unchanged');
    assertEq(
      uint256(cfg.riskPremiumThreshold),
      uint256(before.riskPremiumThreshold),
      'riskPremiumThreshold unchanged'
    );
    assertEq(cfg.active, before.active, 'active unchanged');
    assertEq(cfg.halted, before.halted, 'halted unchanged');
  }
  function test_hubSpokeConfigUpdate_CORE_HUB_MAIN_SPOKE_USDG() public {
    IHub hub = IHub(address(AaveV4EthereumHubs.CORE_HUB));
    uint256 assetId = hub.getAssetId(AaveV4EthereumAssets.USDG_UNDERLYING);
    IHub.SpokeConfig memory before = hub.getSpokeConfig(
      assetId,
      address(AaveV4EthereumSpokes.MAIN_SPOKE)
    );
    GovV3Helpers.executePayload(vm, address(proposal));
    IHub.SpokeConfig memory cfg = hub.getSpokeConfig(
      assetId,
      address(AaveV4EthereumSpokes.MAIN_SPOKE)
    );
    assertEq(uint256(cfg.addCap), uint256(65_000_000), 'addCap mismatch');
    assertEq(uint256(cfg.drawCap), uint256(35_000_000), 'drawCap mismatch');
    assertEq(
      uint256(cfg.riskPremiumThreshold),
      uint256(before.riskPremiumThreshold),
      'riskPremiumThreshold unchanged'
    );
    assertEq(cfg.active, before.active, 'active unchanged');
    assertEq(cfg.halted, before.halted, 'halted unchanged');
  }
  function test_hubSpokeConfigUpdate_CORE_HUB_MAIN_SPOKE_WBTC() public {
    IHub hub = IHub(address(AaveV4EthereumHubs.CORE_HUB));
    uint256 assetId = hub.getAssetId(AaveV4EthereumAssets.WBTC_UNDERLYING);
    IHub.SpokeConfig memory before = hub.getSpokeConfig(
      assetId,
      address(AaveV4EthereumSpokes.MAIN_SPOKE)
    );
    GovV3Helpers.executePayload(vm, address(proposal));
    IHub.SpokeConfig memory cfg = hub.getSpokeConfig(
      assetId,
      address(AaveV4EthereumSpokes.MAIN_SPOKE)
    );
    assertEq(uint256(cfg.addCap), uint256(1_350), 'addCap mismatch');
    assertEq(uint256(cfg.drawCap), uint256(120), 'drawCap mismatch');
    assertEq(
      uint256(cfg.riskPremiumThreshold),
      uint256(before.riskPremiumThreshold),
      'riskPremiumThreshold unchanged'
    );
    assertEq(cfg.active, before.active, 'active unchanged');
    assertEq(cfg.halted, before.halted, 'halted unchanged');
  }
  function test_hubSpokeConfigUpdate_CORE_HUB_MAIN_SPOKE_WETH() public {
    IHub hub = IHub(address(AaveV4EthereumHubs.CORE_HUB));
    uint256 assetId = hub.getAssetId(AaveV4EthereumAssets.WETH_UNDERLYING);
    IHub.SpokeConfig memory before = hub.getSpokeConfig(
      assetId,
      address(AaveV4EthereumSpokes.MAIN_SPOKE)
    );
    GovV3Helpers.executePayload(vm, address(proposal));
    IHub.SpokeConfig memory cfg = hub.getSpokeConfig(
      assetId,
      address(AaveV4EthereumSpokes.MAIN_SPOKE)
    );
    assertEq(uint256(cfg.addCap), uint256(38_000), 'addCap mismatch');
    assertEq(uint256(cfg.drawCap), uint256(3_300), 'drawCap mismatch');
    assertEq(
      uint256(cfg.riskPremiumThreshold),
      uint256(before.riskPremiumThreshold),
      'riskPremiumThreshold unchanged'
    );
    assertEq(cfg.active, before.active, 'active unchanged');
    assertEq(cfg.halted, before.halted, 'halted unchanged');
  }
  function test_hubSpokeConfigUpdate_PRIME_HUB_BLUECHIP_SPOKE_WBTC() public {
    IHub hub = IHub(address(AaveV4EthereumHubs.PRIME_HUB));
    uint256 assetId = hub.getAssetId(AaveV4EthereumAssets.WBTC_UNDERLYING);
    IHub.SpokeConfig memory before = hub.getSpokeConfig(
      assetId,
      address(AaveV4EthereumSpokes.BLUECHIP_SPOKE)
    );
    GovV3Helpers.executePayload(vm, address(proposal));
    IHub.SpokeConfig memory cfg = hub.getSpokeConfig(
      assetId,
      address(AaveV4EthereumSpokes.BLUECHIP_SPOKE)
    );
    assertEq(uint256(cfg.addCap), uint256(700), 'addCap mismatch');
    assertEq(uint256(cfg.drawCap), uint256(before.drawCap), 'drawCap unchanged');
    assertEq(
      uint256(cfg.riskPremiumThreshold),
      uint256(before.riskPremiumThreshold),
      'riskPremiumThreshold unchanged'
    );
    assertEq(cfg.active, before.active, 'active unchanged');
    assertEq(cfg.halted, before.halted, 'halted unchanged');
  }
  function test_hubSpokeConfigUpdate_PRIME_HUB_BLUECHIP_SPOKE_WETH() public {
    IHub hub = IHub(address(AaveV4EthereumHubs.PRIME_HUB));
    uint256 assetId = hub.getAssetId(AaveV4EthereumAssets.WETH_UNDERLYING);
    IHub.SpokeConfig memory before = hub.getSpokeConfig(
      assetId,
      address(AaveV4EthereumSpokes.BLUECHIP_SPOKE)
    );
    GovV3Helpers.executePayload(vm, address(proposal));
    IHub.SpokeConfig memory cfg = hub.getSpokeConfig(
      assetId,
      address(AaveV4EthereumSpokes.BLUECHIP_SPOKE)
    );
    assertEq(uint256(cfg.addCap), uint256(8_000), 'addCap mismatch');
    assertEq(uint256(cfg.drawCap), uint256(before.drawCap), 'drawCap unchanged');
    assertEq(
      uint256(cfg.riskPremiumThreshold),
      uint256(before.riskPremiumThreshold),
      'riskPremiumThreshold unchanged'
    );
    assertEq(cfg.active, before.active, 'active unchanged');
    assertEq(cfg.halted, before.halted, 'halted unchanged');
  }
  function test_hubSpokeConfigUpdate_PRIME_HUB_BLUECHIP_SPOKE_cbBTC() public {
    IHub hub = IHub(address(AaveV4EthereumHubs.PRIME_HUB));
    uint256 assetId = hub.getAssetId(AaveV4EthereumAssets.cbBTC_UNDERLYING);
    IHub.SpokeConfig memory before = hub.getSpokeConfig(
      assetId,
      address(AaveV4EthereumSpokes.BLUECHIP_SPOKE)
    );
    GovV3Helpers.executePayload(vm, address(proposal));
    IHub.SpokeConfig memory cfg = hub.getSpokeConfig(
      assetId,
      address(AaveV4EthereumSpokes.BLUECHIP_SPOKE)
    );
    assertEq(uint256(cfg.addCap), uint256(300), 'addCap mismatch');
    assertEq(uint256(cfg.drawCap), uint256(before.drawCap), 'drawCap unchanged');
    assertEq(
      uint256(cfg.riskPremiumThreshold),
      uint256(before.riskPremiumThreshold),
      'riskPremiumThreshold unchanged'
    );
    assertEq(cfg.active, before.active, 'active unchanged');
    assertEq(cfg.halted, before.halted, 'halted unchanged');
  }
  function test_hubSpokeConfigUpdate_PRIME_HUB_BLUECHIP_SPOKE_wstETH() public {
    IHub hub = IHub(address(AaveV4EthereumHubs.PRIME_HUB));
    uint256 assetId = hub.getAssetId(AaveV4EthereumAssets.wstETH_UNDERLYING);
    IHub.SpokeConfig memory before = hub.getSpokeConfig(
      assetId,
      address(AaveV4EthereumSpokes.BLUECHIP_SPOKE)
    );
    GovV3Helpers.executePayload(vm, address(proposal));
    IHub.SpokeConfig memory cfg = hub.getSpokeConfig(
      assetId,
      address(AaveV4EthereumSpokes.BLUECHIP_SPOKE)
    );
    assertEq(uint256(cfg.addCap), uint256(14_000), 'addCap mismatch');
    assertEq(uint256(cfg.drawCap), uint256(before.drawCap), 'drawCap unchanged');
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
