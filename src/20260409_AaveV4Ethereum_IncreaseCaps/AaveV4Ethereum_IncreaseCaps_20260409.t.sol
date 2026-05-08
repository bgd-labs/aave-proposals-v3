// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IHub, IHubConfigurator, IAccessManagerEnumerable} from 'aave-address-book/AaveV4.sol';
import {IExecutor} from 'aave-address-book/governance-v3/IExecutor.sol';
import {AaveV4Ethereum, AaveV4EthereumHubs, AaveV4EthereumSpokes, AaveV4EthereumAssets} from 'aave-address-book/AaveV4Ethereum.sol';
import {Roles} from 'aave-helpers/lib/aave-address-book/lib/aave-v4/src/deployments/utils/libraries/Roles.sol';
import {AaveV4ConfigEngine} from 'aave-helpers/lib/aave-address-book/lib/aave-v4/src/config-engine/AaveV4ConfigEngine.sol';
import 'aave-helpers/src/ProtocolV4TestBase.sol';
import {AaveV4EthereumSpokeHelpers, AaveV4EthereumTokenizationSpokeHelpers} from 'aave-helpers/src/dependencies/v4/AaveV4EthereumHelpers.sol';

import {AaveV4Ethereum_IncreaseCaps_20260409} from './AaveV4Ethereum_IncreaseCaps_20260409.sol';

/**
 * @dev Test for AaveV4Ethereum_IncreaseCaps_20260409
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20260409_AaveV4Ethereum_IncreaseCaps/AaveV4Ethereum_IncreaseCaps_20260409.t.sol -vv
 */
contract AaveV4Ethereum_IncreaseCaps_20260409_Test is ProtocolV4TestBase {
  AaveV4Ethereum_IncreaseCaps_20260409 internal payload;

  IAccessManagerEnumerable internal constant ACCESS_MANAGER = AaveV4Ethereum.ACCESS_MANAGER;
  IHubConfigurator internal constant HUB_CONFIGURATOR = AaveV4Ethereum.HUB_CONFIGURATOR;

  address internal constant SECURITY_COUNCIL = 0x187AAE17d4931310B3fc75743e7F16Bdc9eD77e9;
  address internal constant EXECUTOR = 0x14339e2178A954d5FB839D5Ff31644fE0F25F517;

  IHub internal constant CORE_HUB = AaveV4EthereumHubs.CORE_HUB;
  IHub internal constant PRIME_HUB = AaveV4EthereumHubs.PRIME_HUB;
  IHub internal constant PLUS_HUB = AaveV4EthereumHubs.PLUS_HUB;

  function setUp() public virtual {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 24843480);

    payload = new AaveV4Ethereum_IncreaseCaps_20260409();

    // Grant HUB_CONFIGURATOR_DOMAIN_ADMIN_ROLE to the executor so the
    // payload (delegatecalled by executor) can update spoke caps.
    vm.prank(SECURITY_COUNCIL);
    ACCESS_MANAGER.grantRole(Roles.HUB_CONFIGURATOR_DOMAIN_ADMIN_ROLE, EXECUTOR, 0);
  }

  // ================================================================
  // Execution & role revocation
  // ================================================================

  function test_executorHasRoleBeforeExecution() public view virtual {
    (bool hasRole, ) = ACCESS_MANAGER.hasRole(Roles.HUB_CONFIGURATOR_DOMAIN_ADMIN_ROLE, EXECUTOR);
    assertTrue(hasRole, 'Executor should have HUB_CONFIGURATOR_DOMAIN_ADMIN_ROLE before execution');
  }

  function test_roleActiveAfterExecution() public virtual {
    _executePayload();

    (bool hasRole, ) = ACCESS_MANAGER.hasRole(Roles.HUB_CONFIGURATOR_DOMAIN_ADMIN_ROLE, EXECUTOR);
    assertTrue(hasRole, 'Executor should have HUB_CONFIGURATOR_DOMAIN_ADMIN_ROLE after execution');
  }

  function test_executeWithRecording() public virtual {
    string memory reportName = 'AaveV4Ethereum_IncreaseCaps_20260409';

    IHub[] memory hubs = AaveV4EthereumHubHelpers.getHubs();
    ISpoke[] memory spokes = AaveV4EthereumSpokeHelpers.getUserSpokes();

    string memory beforeName = string.concat(reportName, '_before');
    string memory afterName = string.concat(reportName, '_after');

    Types.V4Snapshot memory snapshotBefore = createV4Snapshot(spokes, hubs);
    writeV4SnapshotJson(beforeName, snapshotBefore);

    (string memory rawDiff, string memory logsJson) = _executePayloadWithRecording();

    Types.V4Snapshot memory snapshotAfter = createV4Snapshot(spokes, hubs);
    writeV4SnapshotJson(afterName, snapshotAfter);

    string memory afterPath = string.concat('./reports/', afterName, '.json');
    vm.writeJson(rawDiff, afterPath, '$.raw');
    vm.writeJson(logsJson, afterPath, '$.logs');

    diffV4Snapshots(reportName, snapshotBefore, snapshotAfter);
  }

  // ================================================================
  // E2E tests (supply, borrow, repay, liquidation, tokenization, gateways)
  // ================================================================

  function test_e2e() public virtual {
    _executePayload();

    vm.pauseGasMetering();
    e2eTestAllSpokes({
      spokes: AaveV4EthereumSpokeHelpers.getUserSpokes(),
      testPositionManagers: true
    });
    e2eTestAllTokenizationSpokes(AaveV4EthereumTokenizationSpokeHelpers.getTokenizationSpokes());
    vm.resumeGasMetering();
  }

  // ================================================================
  // Cap updates — Core Hub
  //
  // | Spoke   | Asset | Current Add | Proposed Add | Current Draw | Proposed Draw |
  // |---------|-------|-------------|--------------|--------------|---------------|
  // | Etherfi | WETH  |           0 |            - |          530 |         1,600 |
  // | Etherfi | weETH |         500 |        1,500 |            0 |             - |
  // | Forex   | USDC  |     187,500 |      300,000 |       50,000 |       100,000 |
  // | Forex   | USDT  |     200,000 |      300,000 |       50,000 |       100,000 |
  // | Gold    | XAUt  |         125 |          200 |            0 |             - |
  // | Kelp    | WETH  |           0 |            - |          588 |         1,600 |
  // | Kelp    | rsETH |         563 |        1,500 |            0 |             - |
  // | Lido    | WETH  |           0 |            - |          441 |         1,600 |
  // | Lido    | wstETH|         406 |        1,500 |            0 |             - |
  // | Main    | AAVE  |       5,000 |        8,000 |            0 |             - |
  // | Main    | GHO   |     500,000 |    1,000,000 |      500,000 |     1,000,000 |
  // | Main    | LINK  |      31,250 |       50,000 |            0 |             - |
  // | Main    | USDC  |   1,250,000 |    4,000,000 |    1,250,000 |     4,000,000 |
  // | Main    | USDG  |     500,000 |    1,500,000 |      340,000 |     1,000,000 |
  // | Main    | USDT  |   1,250,000 |    2,500,000 |    1,250,000 |     2,500,000 |
  // | Main    | WBTC  |          16 |           25 |            1 |             2 |
  // | Main    | WETH  |       1,500 |        3,500 |          130 |           300 |
  // | Main    | frxUSD|     500,000 |    1,500,000 |      312,500 |     1,000,000 |
  // | Main    | weETH |          58 |          150 |            0 |             - |
  // | Main    | wstETH|         229 |          400 |            0 |             - |
  // ================================================================

  // prettier-ignore
  function test_caps_coreHub_before() public virtual {
    //                                                                                                                  addCap     drawCap
    _assertCaps(CORE_HUB, address(AaveV4EthereumSpokes.ETHERFI_E_SPOKE), AaveV4EthereumAssets.WETH_UNDERLYING,          0,         530);
    _assertCaps(CORE_HUB, address(AaveV4EthereumSpokes.ETHERFI_E_SPOKE), AaveV4EthereumAssets.weETH_UNDERLYING,         500,       0);
    _assertCaps(CORE_HUB, address(AaveV4EthereumSpokes.FOREX_SPOKE),     AaveV4EthereumAssets.USDC_UNDERLYING,          187_500,   50_000);
    _assertCaps(CORE_HUB, address(AaveV4EthereumSpokes.FOREX_SPOKE),     AaveV4EthereumAssets.USDT_UNDERLYING,          200_000,   50_000);
    _assertCaps(CORE_HUB, address(AaveV4EthereumSpokes.GOLD_SPOKE),      AaveV4EthereumAssets.XAUt_UNDERLYING,          125,       0);
    _assertCaps(CORE_HUB, address(AaveV4EthereumSpokes.KELP_E_SPOKE),    AaveV4EthereumAssets.WETH_UNDERLYING,          0,         588);
    _assertCaps(CORE_HUB, address(AaveV4EthereumSpokes.KELP_E_SPOKE),    AaveV4EthereumAssets.rsETH_UNDERLYING,         563,       0);
    _assertCaps(CORE_HUB, address(AaveV4EthereumSpokes.LIDO_E_SPOKE),    AaveV4EthereumAssets.WETH_UNDERLYING,          0,         441);
    _assertCaps(CORE_HUB, address(AaveV4EthereumSpokes.LIDO_E_SPOKE),    AaveV4EthereumAssets.wstETH_UNDERLYING,        406,       0);
    _assertCaps(CORE_HUB, address(AaveV4EthereumSpokes.MAIN_SPOKE),      AaveV4EthereumAssets.AAVE_UNDERLYING,          5_000,     0);
    _assertCaps(CORE_HUB, address(AaveV4EthereumSpokes.MAIN_SPOKE),      AaveV4EthereumAssets.GHO_UNDERLYING,           500_000,   500_000);
    _assertCaps(CORE_HUB, address(AaveV4EthereumSpokes.MAIN_SPOKE),      AaveV4EthereumAssets.LINK_UNDERLYING,          31_250,    0);
    _assertCaps(CORE_HUB, address(AaveV4EthereumSpokes.MAIN_SPOKE),      AaveV4EthereumAssets.USDC_UNDERLYING,          1_250_000, 1_250_000);
    _assertCaps(CORE_HUB, address(AaveV4EthereumSpokes.MAIN_SPOKE),      AaveV4EthereumAssets.USDG_UNDERLYING,          500_000,   340_000);
    _assertCaps(CORE_HUB, address(AaveV4EthereumSpokes.MAIN_SPOKE),      AaveV4EthereumAssets.USDT_UNDERLYING,          1_250_000, 1_250_000);
    _assertCaps(CORE_HUB, address(AaveV4EthereumSpokes.MAIN_SPOKE),      AaveV4EthereumAssets.WBTC_UNDERLYING,          16,        1);
    _assertCaps(CORE_HUB, address(AaveV4EthereumSpokes.MAIN_SPOKE),      AaveV4EthereumAssets.WETH_UNDERLYING,          1_500,     130);
    _assertCaps(CORE_HUB, address(AaveV4EthereumSpokes.MAIN_SPOKE),      AaveV4EthereumAssets.frxUSD_UNDERLYING,        500_000,   312_500);
    _assertCaps(CORE_HUB, address(AaveV4EthereumSpokes.MAIN_SPOKE),      AaveV4EthereumAssets.weETH_UNDERLYING,         58,        0);
    _assertCaps(CORE_HUB, address(AaveV4EthereumSpokes.MAIN_SPOKE),      AaveV4EthereumAssets.wstETH_UNDERLYING,        229,       0);
  }

  // prettier-ignore
  function test_caps_coreHub() public virtual {
    _executePayload();

    //                                                                                                                  addCap     drawCap
    _assertCaps(CORE_HUB, address(AaveV4EthereumSpokes.ETHERFI_E_SPOKE), AaveV4EthereumAssets.WETH_UNDERLYING,          0,         1_600);
    _assertCaps(CORE_HUB, address(AaveV4EthereumSpokes.ETHERFI_E_SPOKE), AaveV4EthereumAssets.weETH_UNDERLYING,         1_500,     0);
    _assertCaps(CORE_HUB, address(AaveV4EthereumSpokes.FOREX_SPOKE),     AaveV4EthereumAssets.USDC_UNDERLYING,          300_000,   100_000);
    _assertCaps(CORE_HUB, address(AaveV4EthereumSpokes.FOREX_SPOKE),     AaveV4EthereumAssets.USDT_UNDERLYING,          300_000,   100_000);
    _assertCaps(CORE_HUB, address(AaveV4EthereumSpokes.GOLD_SPOKE),      AaveV4EthereumAssets.XAUt_UNDERLYING,          200,       0);
    _assertCaps(CORE_HUB, address(AaveV4EthereumSpokes.KELP_E_SPOKE),    AaveV4EthereumAssets.WETH_UNDERLYING,          0,         1_600);
    _assertCaps(CORE_HUB, address(AaveV4EthereumSpokes.KELP_E_SPOKE),    AaveV4EthereumAssets.rsETH_UNDERLYING,         1_500,     0);
    _assertCaps(CORE_HUB, address(AaveV4EthereumSpokes.LIDO_E_SPOKE),    AaveV4EthereumAssets.WETH_UNDERLYING,          0,         1_600);
    _assertCaps(CORE_HUB, address(AaveV4EthereumSpokes.LIDO_E_SPOKE),    AaveV4EthereumAssets.wstETH_UNDERLYING,        1_500,     0);
    _assertCaps(CORE_HUB, address(AaveV4EthereumSpokes.MAIN_SPOKE),      AaveV4EthereumAssets.AAVE_UNDERLYING,          8_000,     0);
    _assertCaps(CORE_HUB, address(AaveV4EthereumSpokes.MAIN_SPOKE),      AaveV4EthereumAssets.GHO_UNDERLYING,           1_000_000, 1_000_000);
    _assertCaps(CORE_HUB, address(AaveV4EthereumSpokes.MAIN_SPOKE),      AaveV4EthereumAssets.LINK_UNDERLYING,          50_000,    0);
    _assertCaps(CORE_HUB, address(AaveV4EthereumSpokes.MAIN_SPOKE),      AaveV4EthereumAssets.USDC_UNDERLYING,          4_000_000, 4_000_000);
    _assertCaps(CORE_HUB, address(AaveV4EthereumSpokes.MAIN_SPOKE),      AaveV4EthereumAssets.USDG_UNDERLYING,          1_500_000, 1_000_000);
    _assertCaps(CORE_HUB, address(AaveV4EthereumSpokes.MAIN_SPOKE),      AaveV4EthereumAssets.USDT_UNDERLYING,          2_500_000, 2_500_000);
    _assertCaps(CORE_HUB, address(AaveV4EthereumSpokes.MAIN_SPOKE),      AaveV4EthereumAssets.WBTC_UNDERLYING,          25,        2);
    _assertCaps(CORE_HUB, address(AaveV4EthereumSpokes.MAIN_SPOKE),      AaveV4EthereumAssets.WETH_UNDERLYING,          3_500,     300);
    _assertCaps(CORE_HUB, address(AaveV4EthereumSpokes.MAIN_SPOKE),      AaveV4EthereumAssets.frxUSD_UNDERLYING,        1_500_000, 1_000_000);
    _assertCaps(CORE_HUB, address(AaveV4EthereumSpokes.MAIN_SPOKE),      AaveV4EthereumAssets.weETH_UNDERLYING,         150,       0);
    _assertCaps(CORE_HUB, address(AaveV4EthereumSpokes.MAIN_SPOKE),      AaveV4EthereumAssets.wstETH_UNDERLYING,        400,       0);
  }

  // ================================================================
  // Cap updates — Prime Hub
  //
  // | Spoke    | Asset | Current Add | Proposed Add | Current Draw | Proposed Draw |
  // |----------|-------|-------------|--------------|--------------|---------------|
  // | Bluechip | GHO   |     500,000 |    2,000,000 |      562,500 |     2,250,000 |
  // | Bluechip | USDC  |     150,000 |      750,000 |      175,000 |       875,000 |
  // | Bluechip | USDT  |     150,000 |      750,000 |      187,500 |       940,000 |
  // | Bluechip | WBTC  |           6 |           15 |            0 |             - |
  // | Bluechip | WETH  |         130 |          300 |            0 |             - |
  // | Bluechip | cbBTC |           5 |           12 |            0 |             - |
  // | Bluechip | wstETH|         114 |          300 |            0 |             - |
  // ================================================================

  // prettier-ignore
  function test_caps_primeHub_before() public virtual {
    //                                                                                                                   addCap     drawCap
    _assertCaps(PRIME_HUB, address(AaveV4EthereumSpokes.BLUECHIP_SPOKE), AaveV4EthereumAssets.GHO_UNDERLYING,            500_000,   562_500);
    _assertCaps(PRIME_HUB, address(AaveV4EthereumSpokes.BLUECHIP_SPOKE), AaveV4EthereumAssets.USDC_UNDERLYING,           150_000,   175_000);
    _assertCaps(PRIME_HUB, address(AaveV4EthereumSpokes.BLUECHIP_SPOKE), AaveV4EthereumAssets.USDT_UNDERLYING,           150_000,   187_500);
    _assertCaps(PRIME_HUB, address(AaveV4EthereumSpokes.BLUECHIP_SPOKE), AaveV4EthereumAssets.WBTC_UNDERLYING,           6,         0);
    _assertCaps(PRIME_HUB, address(AaveV4EthereumSpokes.BLUECHIP_SPOKE), AaveV4EthereumAssets.WETH_UNDERLYING,           130,       0);
    _assertCaps(PRIME_HUB, address(AaveV4EthereumSpokes.BLUECHIP_SPOKE), AaveV4EthereumAssets.cbBTC_UNDERLYING,          5,         0);
    _assertCaps(PRIME_HUB, address(AaveV4EthereumSpokes.BLUECHIP_SPOKE), AaveV4EthereumAssets.wstETH_UNDERLYING,         114,       0);
  }

  // prettier-ignore
  function test_caps_primeHub() public virtual {
    _executePayload();

    //                                                                                                                   addCap     drawCap
    _assertCaps(PRIME_HUB, address(AaveV4EthereumSpokes.BLUECHIP_SPOKE), AaveV4EthereumAssets.GHO_UNDERLYING,            2_000_000, 2_250_000);
    _assertCaps(PRIME_HUB, address(AaveV4EthereumSpokes.BLUECHIP_SPOKE), AaveV4EthereumAssets.USDC_UNDERLYING,           750_000,   875_000);
    _assertCaps(PRIME_HUB, address(AaveV4EthereumSpokes.BLUECHIP_SPOKE), AaveV4EthereumAssets.USDT_UNDERLYING,           750_000,   940_000);
    _assertCaps(PRIME_HUB, address(AaveV4EthereumSpokes.BLUECHIP_SPOKE), AaveV4EthereumAssets.WBTC_UNDERLYING,           15,        0);
    _assertCaps(PRIME_HUB, address(AaveV4EthereumSpokes.BLUECHIP_SPOKE), AaveV4EthereumAssets.WETH_UNDERLYING,           300,       0);
    _assertCaps(PRIME_HUB, address(AaveV4EthereumSpokes.BLUECHIP_SPOKE), AaveV4EthereumAssets.cbBTC_UNDERLYING,          12,        0);
    _assertCaps(PRIME_HUB, address(AaveV4EthereumSpokes.BLUECHIP_SPOKE), AaveV4EthereumAssets.wstETH_UNDERLYING,         300,       0);
  }

  // ================================================================
  // Cap updates — Plus Hub
  //
  // | Spoke            | Asset            | Current Add | Proposed Add | Current Draw | Proposed Draw |
  // |------------------|------------------|-------------|--------------|--------------|---------------|
  // | Ethena Ecosystem | GHO              |     500,000 |      750,000 |      562,500 |       850,000 |
  // | Ethena Ecosystem | PT-sUSDE-7MAY2026|   1,400,000 |    2,000,000 |            0 |             - |
  // | Ethena Ecosystem | USDC             |     150,000 |      300,000 |      187,500 |       375,000 |
  // | Ethena Ecosystem | USDT             |     150,000 |      300,000 |      187,500 |       375,000 |
  // | Ethena Ecosystem | USDe             |     312,500 |      750,000 |      300,000 |       720,000 |
  // | Ethena Ecosystem | sUSDe            |     375,000 |      750,000 |            0 |             - |
  // ================================================================

  // prettier-ignore
  function test_caps_plusHub_before() public virtual {
    //                                                                                                                                        addCap     drawCap
    _assertCaps(PLUS_HUB, address(AaveV4EthereumSpokes.ETHENA_ECOSYSTEM_SPOKE), AaveV4EthereumAssets.GHO_UNDERLYING,                          500_000,   562_500);
    _assertCaps(PLUS_HUB, address(AaveV4EthereumSpokes.ETHENA_ECOSYSTEM_SPOKE), AaveV4EthereumAssets.PT_sUSDE_7MAY2026_UNDERLYING,            1_400_000, 0);
    _assertCaps(PLUS_HUB, address(AaveV4EthereumSpokes.ETHENA_ECOSYSTEM_SPOKE), AaveV4EthereumAssets.USDC_UNDERLYING,                         150_000,   187_500);
    _assertCaps(PLUS_HUB, address(AaveV4EthereumSpokes.ETHENA_ECOSYSTEM_SPOKE), AaveV4EthereumAssets.USDT_UNDERLYING,                         150_000,   187_500);
    _assertCaps(PLUS_HUB, address(AaveV4EthereumSpokes.ETHENA_ECOSYSTEM_SPOKE), AaveV4EthereumAssets.USDe_UNDERLYING,                         312_500,   300_000);
    _assertCaps(PLUS_HUB, address(AaveV4EthereumSpokes.ETHENA_ECOSYSTEM_SPOKE), AaveV4EthereumAssets.sUSDe_UNDERLYING,                        375_000,   0);
  }

  // prettier-ignore
  function test_caps_plusHub() public virtual {
    _executePayload();

    //                                                                                                                                         addCap     drawCap
    _assertCaps(PLUS_HUB, address(AaveV4EthereumSpokes.ETHENA_ECOSYSTEM_SPOKE), AaveV4EthereumAssets.GHO_UNDERLYING,                           750_000,   850_000);
    _assertCaps(PLUS_HUB, address(AaveV4EthereumSpokes.ETHENA_ECOSYSTEM_SPOKE), AaveV4EthereumAssets.PT_sUSDE_7MAY2026_UNDERLYING,             2_000_000, 0);
    _assertCaps(PLUS_HUB, address(AaveV4EthereumSpokes.ETHENA_ECOSYSTEM_SPOKE), AaveV4EthereumAssets.USDC_UNDERLYING,                          300_000,   375_000);
    _assertCaps(PLUS_HUB, address(AaveV4EthereumSpokes.ETHENA_ECOSYSTEM_SPOKE), AaveV4EthereumAssets.USDT_UNDERLYING,                          300_000,   375_000);
    _assertCaps(PLUS_HUB, address(AaveV4EthereumSpokes.ETHENA_ECOSYSTEM_SPOKE), AaveV4EthereumAssets.USDe_UNDERLYING,                          750_000,   720_000);
    _assertCaps(PLUS_HUB, address(AaveV4EthereumSpokes.ETHENA_ECOSYSTEM_SPOKE), AaveV4EthereumAssets.sUSDe_UNDERLYING,                         750_000,   0);
  }

  // ================================================================
  // Credit Lines
  //
  // | Origin   | Target Spoke     | Asset | Current Credit Line | Proposed Credit Line |
  // |----------|------------------|-------|---------------------|----------------------|
  // | Core Hub | Ethena Ecosystem | USDC  |             125,000 |              250,000 |
  // | Core Hub | Ethena Ecosystem | USDT  |             125,000 |              250,000 |
  // | Core Hub | Ethena Ecosystem | frxUSD|              62,500 |              125,000 |
  // | Core Hub | Bluechip         | USDC  |             125,000 |              250,000 |
  // | Core Hub | Bluechip         | USDT  |             125,000 |              250,000 |
  // | Core Hub | Bluechip         | frxUSD|              62,500 |              125,000 |
  // | Core Hub | Bluechip         | EURC  |              50,000 |              100,000 |
  // ================================================================

  // prettier-ignore
  function test_creditLines_before() public virtual {
    //                                                                                                                                      addCap  drawCap
    _assertCaps(CORE_HUB, address(AaveV4EthereumSpokes.ETHENA_ECOSYSTEM_SPOKE), AaveV4EthereumAssets.USDC_UNDERLYING,                       0,      125_000);
    _assertCaps(CORE_HUB, address(AaveV4EthereumSpokes.ETHENA_ECOSYSTEM_SPOKE), AaveV4EthereumAssets.USDT_UNDERLYING,                       0,      125_000);
    _assertCaps(CORE_HUB, address(AaveV4EthereumSpokes.ETHENA_ECOSYSTEM_SPOKE), AaveV4EthereumAssets.frxUSD_UNDERLYING,                     0,      62_500);
    _assertCaps(CORE_HUB, address(AaveV4EthereumSpokes.BLUECHIP_SPOKE),         AaveV4EthereumAssets.USDC_UNDERLYING,                       0,      125_000);
    _assertCaps(CORE_HUB, address(AaveV4EthereumSpokes.BLUECHIP_SPOKE),         AaveV4EthereumAssets.USDT_UNDERLYING,                       0,      125_000);
    _assertCaps(CORE_HUB, address(AaveV4EthereumSpokes.BLUECHIP_SPOKE),         AaveV4EthereumAssets.frxUSD_UNDERLYING,                     0,      62_500);
    _assertCaps(CORE_HUB, address(AaveV4EthereumSpokes.BLUECHIP_SPOKE),         AaveV4EthereumAssets.EURC_UNDERLYING,                       0,      50_000);
  }

  // prettier-ignore
  function test_creditLines() public virtual {
    _executePayload();

    //                                                                                                                                      addCap  drawCap
    _assertCaps(CORE_HUB, address(AaveV4EthereumSpokes.ETHENA_ECOSYSTEM_SPOKE), AaveV4EthereumAssets.USDC_UNDERLYING,                       0,      250_000);
    _assertCaps(CORE_HUB, address(AaveV4EthereumSpokes.ETHENA_ECOSYSTEM_SPOKE), AaveV4EthereumAssets.USDT_UNDERLYING,                       0,      250_000);
    _assertCaps(CORE_HUB, address(AaveV4EthereumSpokes.ETHENA_ECOSYSTEM_SPOKE), AaveV4EthereumAssets.frxUSD_UNDERLYING,                     0,      125_000);
    _assertCaps(CORE_HUB, address(AaveV4EthereumSpokes.BLUECHIP_SPOKE),         AaveV4EthereumAssets.USDC_UNDERLYING,                       0,      250_000);
    _assertCaps(CORE_HUB, address(AaveV4EthereumSpokes.BLUECHIP_SPOKE),         AaveV4EthereumAssets.USDT_UNDERLYING,                       0,      250_000);
    _assertCaps(CORE_HUB, address(AaveV4EthereumSpokes.BLUECHIP_SPOKE),         AaveV4EthereumAssets.frxUSD_UNDERLYING,                     0,      125_000);
    _assertCaps(CORE_HUB, address(AaveV4EthereumSpokes.BLUECHIP_SPOKE),         AaveV4EthereumAssets.EURC_UNDERLYING,                       0,      100_000);
  }

  // ================================================================
  // Helpers
  // ================================================================

  /// @dev Executes the payload via the executor using delegatecall.
  function _executePayload() internal virtual {
    vm.prank(SECURITY_COUNCIL);
    IExecutor(EXECUTOR).executeTransaction(
      address(payload),
      0,
      'execute()',
      bytes(''),
      true // withDelegatecall
    );
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

  function _executePayloadWithRecording()
    internal
    returns (string memory rawDiff, string memory logsJson)
  {
    uint256 startGas = gasleft();
    vm.startStateDiffRecording();
    vm.recordLogs();

    _executePayload();

    uint256 gasUsed = startGas - gasleft();
    assertLt(gasUsed, (block.gaslimit * 95) / 100, 'BLOCK_GAS_LIMIT_EXCEEDED');

    rawDiff = vm.getStateDiffJson();
    logsJson = vm.getRecordedLogsJson();
  }
}
