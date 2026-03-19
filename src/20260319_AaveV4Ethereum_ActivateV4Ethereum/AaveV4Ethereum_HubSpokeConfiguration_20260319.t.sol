// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Test} from 'forge-std/Test.sol';
import {AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {ISpoke} from '../interfaces/v4/ISpoke.sol';
import {AaveV4EthereumAddresses} from './AaveV4EthereumAddresses.sol';

/**
 * @dev Verifies Aave V4 Ethereum hub-spoke configuration matches the deployment spec.
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20260319_AaveV4Ethereum_ActivateV4Ethereum/AaveV4Ethereum_HubSpokeConfiguration_20260319.t.sol -vv
 */
contract AaveV4Ethereum_HubSpokeConfiguration_20260319_Test is Test {
  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 24693869);
  }

  // ---------------------------------------------------------------------------
  // Core Hub Spokes
  // ---------------------------------------------------------------------------

  function test_mainSpokeConfiguration() public view {
    address spoke = AaveV4EthereumAddresses.MAIN_SPOKE;
    address hub = AaveV4EthereumAddresses.CORE_HUB;

    // Main Spoke: 14 reserves, all on Core Hub
    // Collateral (9): wETH, wstETH, weETH, wBTC, cbBTC, USDT, USDC, LINK, AAVE
    // Borrowable (10): wBTC, cbBTC, wETH, USDT, USDC, USDG, RLUSD, frxUSD, GHO, EURC
    (uint256 total, uint256 onHub, uint256 collateral, uint256 borrowable) = _countReserves(
      spoke,
      hub
    );
    assertEq(total, 14, 'Main Spoke: wrong total reserve count');
    assertEq(onHub, 14, 'Main Spoke: all reserves should be on Core Hub');
    assertEq(collateral, 9, 'Main Spoke: wrong collateral count');
    assertEq(borrowable, 10, 'Main Spoke: wrong borrowable count');

    // Verify specific known tokens
    assertTrue(_isCollateralOnHub(spoke, hub, AaveV3EthereumAssets.WETH_UNDERLYING), 'WETH should be collateral');
    assertTrue(_isBorrowableOnHub(spoke, hub, AaveV3EthereumAssets.WETH_UNDERLYING), 'WETH should be borrowable');
    assertTrue(_isCollateralOnHub(spoke, hub, AaveV3EthereumAssets.wstETH_UNDERLYING), 'wstETH should be collateral');
    assertTrue(_isCollateralOnHub(spoke, hub, AaveV3EthereumAssets.weETH_UNDERLYING), 'weETH should be collateral');
    assertTrue(_isCollateralOnHub(spoke, hub, AaveV3EthereumAssets.WBTC_UNDERLYING), 'WBTC should be collateral');
    assertTrue(_isBorrowableOnHub(spoke, hub, AaveV3EthereumAssets.WBTC_UNDERLYING), 'WBTC should be borrowable');
    assertTrue(_isCollateralOnHub(spoke, hub, AaveV3EthereumAssets.cbBTC_UNDERLYING), 'cbBTC should be collateral');
    assertTrue(_isBorrowableOnHub(spoke, hub, AaveV3EthereumAssets.cbBTC_UNDERLYING), 'cbBTC should be borrowable');
    assertTrue(_isCollateralOnHub(spoke, hub, AaveV3EthereumAssets.USDT_UNDERLYING), 'USDT should be collateral');
    assertTrue(_isBorrowableOnHub(spoke, hub, AaveV3EthereumAssets.USDT_UNDERLYING), 'USDT should be borrowable');
    assertTrue(_isCollateralOnHub(spoke, hub, AaveV3EthereumAssets.USDC_UNDERLYING), 'USDC should be collateral');
    assertTrue(_isBorrowableOnHub(spoke, hub, AaveV3EthereumAssets.USDC_UNDERLYING), 'USDC should be borrowable');
    assertTrue(_isCollateralOnHub(spoke, hub, AaveV3EthereumAssets.LINK_UNDERLYING), 'LINK should be collateral');
    assertTrue(_isCollateralOnHub(spoke, hub, AaveV3EthereumAssets.AAVE_UNDERLYING), 'AAVE should be collateral');
    assertTrue(_isBorrowableOnHub(spoke, hub, AaveV3EthereumAssets.GHO_UNDERLYING), 'GHO should be borrowable');
    assertTrue(_isBorrowableOnHub(spoke, hub, AaveV3EthereumAssets.EURC_UNDERLYING), 'EURC should be borrowable');
  }

  function test_lidoSpokeConfiguration() public view {
    address spoke = AaveV4EthereumAddresses.LIDO_ESPOKE;
    address hub = AaveV4EthereumAddresses.CORE_HUB;

    // Lido eSpoke: 2 reserves on Core Hub
    // Collateral (1): wstETH
    // Borrowable (1): wETH
    (uint256 total, uint256 onHub, uint256 collateral, uint256 borrowable) = _countReserves(
      spoke,
      hub
    );
    assertEq(total, 2, 'Lido eSpoke: wrong total reserve count');
    assertEq(onHub, 2, 'Lido eSpoke: all reserves should be on Core Hub');
    assertEq(collateral, 1, 'Lido eSpoke: wrong collateral count');
    assertEq(borrowable, 1, 'Lido eSpoke: wrong borrowable count');

    assertTrue(_isCollateralOnHub(spoke, hub, AaveV3EthereumAssets.wstETH_UNDERLYING), 'wstETH should be collateral');
    assertFalse(_isBorrowableOnHub(spoke, hub, AaveV3EthereumAssets.wstETH_UNDERLYING), 'wstETH should not be borrowable');
    assertTrue(_isBorrowableOnHub(spoke, hub, AaveV3EthereumAssets.WETH_UNDERLYING), 'WETH should be borrowable');
    assertFalse(_isCollateralOnHub(spoke, hub, AaveV3EthereumAssets.WETH_UNDERLYING), 'WETH should not be collateral');
  }

  function test_etherfiSpokeConfiguration() public view {
    address spoke = AaveV4EthereumAddresses.ETHERFI_ESPOKE;
    address hub = AaveV4EthereumAddresses.CORE_HUB;

    (uint256 total, uint256 onHub, uint256 collateral, uint256 borrowable) = _countReserves(
      spoke,
      hub
    );
    assertEq(total, 2, 'EtherFi eSpoke: wrong total reserve count');
    assertEq(onHub, 2, 'EtherFi eSpoke: all reserves should be on Core Hub');
    assertEq(collateral, 1, 'EtherFi eSpoke: wrong collateral count');
    assertEq(borrowable, 1, 'EtherFi eSpoke: wrong borrowable count');

    assertTrue(_isCollateralOnHub(spoke, hub, AaveV3EthereumAssets.weETH_UNDERLYING), 'weETH should be collateral');
    assertTrue(_isBorrowableOnHub(spoke, hub, AaveV3EthereumAssets.WETH_UNDERLYING), 'WETH should be borrowable');
  }

  function test_kelpSpokeConfiguration() public view {
    address spoke = AaveV4EthereumAddresses.KELP_ESPOKE;
    address hub = AaveV4EthereumAddresses.CORE_HUB;

    (uint256 total, uint256 onHub, uint256 collateral, uint256 borrowable) = _countReserves(
      spoke,
      hub
    );
    assertEq(total, 2, 'Kelp eSpoke: wrong total reserve count');
    assertEq(onHub, 2, 'Kelp eSpoke: all reserves should be on Core Hub');
    assertEq(collateral, 1, 'Kelp eSpoke: wrong collateral count');
    assertEq(borrowable, 1, 'Kelp eSpoke: wrong borrowable count');

    assertTrue(_isCollateralOnHub(spoke, hub, AaveV3EthereumAssets.rsETH_UNDERLYING), 'rsETH should be collateral');
    assertTrue(_isBorrowableOnHub(spoke, hub, AaveV3EthereumAssets.WETH_UNDERLYING), 'WETH should be borrowable');
  }

  function test_lombardSpokeConfiguration() public view {
    address spoke = AaveV4EthereumAddresses.LOMBARD_BTC_SPOKE;
    address hub = AaveV4EthereumAddresses.CORE_HUB;

    (uint256 total, uint256 onHub, uint256 collateral, uint256 borrowable) = _countReserves(
      spoke,
      hub
    );
    assertEq(total, 3, 'Lombard Spoke: wrong total reserve count');
    assertEq(onHub, 3, 'Lombard Spoke: all reserves should be on Core Hub');
    assertEq(collateral, 1, 'Lombard Spoke: wrong collateral count');
    assertEq(borrowable, 2, 'Lombard Spoke: wrong borrowable count');

    assertTrue(_isCollateralOnHub(spoke, hub, AaveV3EthereumAssets.LBTC_UNDERLYING), 'LBTC should be collateral');
    assertTrue(_isBorrowableOnHub(spoke, hub, AaveV3EthereumAssets.WBTC_UNDERLYING), 'WBTC should be borrowable');
    assertTrue(_isBorrowableOnHub(spoke, hub, AaveV3EthereumAssets.cbBTC_UNDERLYING), 'cbBTC should be borrowable');
  }

  function test_goldSpokeConfiguration() public view {
    address spoke = AaveV4EthereumAddresses.GOLD_SPOKE;
    address hub = AaveV4EthereumAddresses.CORE_HUB;

    (uint256 total, uint256 onHub, uint256 collateral, uint256 borrowable) = _countReserves(
      spoke,
      hub
    );
    assertEq(total, 8, 'Gold Spoke: wrong total reserve count');
    assertEq(onHub, 8, 'Gold Spoke: all reserves should be on Core Hub');
    assertEq(collateral, 1, 'Gold Spoke: wrong collateral count');
    assertEq(borrowable, 7, 'Gold Spoke: wrong borrowable count');

    assertTrue(_isBorrowableOnHub(spoke, hub, AaveV3EthereumAssets.USDT_UNDERLYING), 'USDT should be borrowable');
    assertTrue(_isBorrowableOnHub(spoke, hub, AaveV3EthereumAssets.USDC_UNDERLYING), 'USDC should be borrowable');
    assertTrue(_isBorrowableOnHub(spoke, hub, AaveV3EthereumAssets.GHO_UNDERLYING), 'GHO should be borrowable');
    assertTrue(_isBorrowableOnHub(spoke, hub, AaveV3EthereumAssets.EURC_UNDERLYING), 'EURC should be borrowable');
  }

  function test_forexSpokeConfiguration() public view {
    address spoke = AaveV4EthereumAddresses.FOREX_SPOKE;
    address hub = AaveV4EthereumAddresses.CORE_HUB;

    (uint256 total, uint256 onHub, uint256 collateral, uint256 borrowable) = _countReserves(
      spoke,
      hub
    );
    assertEq(total, 7, 'Forex Spoke: wrong total reserve count');
    assertEq(onHub, 7, 'Forex Spoke: all reserves should be on Core Hub');
    assertEq(collateral, 3, 'Forex Spoke: wrong collateral count');
    assertEq(borrowable, 7, 'Forex Spoke: wrong borrowable count');

    assertTrue(_isCollateralOnHub(spoke, hub, AaveV3EthereumAssets.USDT_UNDERLYING), 'USDT should be collateral');
    assertTrue(_isBorrowableOnHub(spoke, hub, AaveV3EthereumAssets.USDT_UNDERLYING), 'USDT should be borrowable');
    assertTrue(_isCollateralOnHub(spoke, hub, AaveV3EthereumAssets.USDC_UNDERLYING), 'USDC should be collateral');
    assertTrue(_isBorrowableOnHub(spoke, hub, AaveV3EthereumAssets.USDC_UNDERLYING), 'USDC should be borrowable');
    assertTrue(_isCollateralOnHub(spoke, hub, AaveV3EthereumAssets.EURC_UNDERLYING), 'EURC should be collateral');
    assertTrue(_isBorrowableOnHub(spoke, hub, AaveV3EthereumAssets.EURC_UNDERLYING), 'EURC should be borrowable');
    assertTrue(_isBorrowableOnHub(spoke, hub, AaveV3EthereumAssets.GHO_UNDERLYING), 'GHO should be borrowable');
  }

  // ---------------------------------------------------------------------------
  // Prime Hub Spokes
  // ---------------------------------------------------------------------------

  function test_bluechipSpokeConfiguration() public view {
    address spoke = AaveV4EthereumAddresses.BLUECHIP_SPOKE;
    address primeHub = AaveV4EthereumAddresses.PRIME_HUB;
    address coreHub = AaveV4EthereumAddresses.CORE_HUB;

    uint256 totalCount = ISpoke(spoke).getReserveCount();
    assertEq(totalCount, 11, 'Bluechip Spoke: wrong total reserve count');

    (, uint256 onPrimeHub, uint256 primeCollateral, uint256 primeBorrowable) = _countReserves(
      spoke,
      primeHub
    );
    assertEq(onPrimeHub, 7, 'Bluechip Spoke: wrong Prime Hub reserve count');
    assertEq(primeCollateral, 4, 'Bluechip Spoke: wrong Prime Hub collateral count');
    assertEq(primeBorrowable, 3, 'Bluechip Spoke: wrong Prime Hub borrowable count');

    (, uint256 onCoreHub, uint256 coreCollateral, uint256 coreBorrowable) = _countReserves(
      spoke,
      coreHub
    );
    assertEq(onCoreHub, 4, 'Bluechip Spoke: wrong Core Hub reserve count');
    assertEq(coreCollateral, 0, 'Bluechip Spoke: Core Hub should have no collateral');
    assertEq(coreBorrowable, 4, 'Bluechip Spoke: wrong Core Hub borrowable count');

    // Verify specific tokens on Prime Hub
    assertTrue(_isCollateralOnHub(spoke, primeHub, AaveV3EthereumAssets.WETH_UNDERLYING), 'wETH should be collateral on Prime');
    assertTrue(_isCollateralOnHub(spoke, primeHub, AaveV3EthereumAssets.wstETH_UNDERLYING), 'wstETH should be collateral on Prime');
    assertTrue(_isCollateralOnHub(spoke, primeHub, AaveV3EthereumAssets.WBTC_UNDERLYING), 'wBTC should be collateral on Prime');
    assertTrue(_isCollateralOnHub(spoke, primeHub, AaveV3EthereumAssets.cbBTC_UNDERLYING), 'cbBTC should be collateral on Prime');
    assertTrue(_isBorrowableOnHub(spoke, primeHub, AaveV3EthereumAssets.USDT_UNDERLYING), 'USDT should be borrowable on Prime');
    assertTrue(_isBorrowableOnHub(spoke, primeHub, AaveV3EthereumAssets.USDC_UNDERLYING), 'USDC should be borrowable on Prime');
    assertTrue(_isBorrowableOnHub(spoke, primeHub, AaveV3EthereumAssets.GHO_UNDERLYING), 'GHO should be borrowable on Prime');

    // Verify cross-hub borrowables on Core Hub
    assertTrue(_isBorrowableOnHub(spoke, coreHub, AaveV3EthereumAssets.USDT_UNDERLYING), 'coreUSDT should be borrowable');
    assertTrue(_isBorrowableOnHub(spoke, coreHub, AaveV3EthereumAssets.USDC_UNDERLYING), 'coreUSDC should be borrowable');
    assertTrue(_isBorrowableOnHub(spoke, coreHub, AaveV3EthereumAssets.EURC_UNDERLYING), 'coreEURC should be borrowable');
  }

  // ---------------------------------------------------------------------------
  // Plus Hub Spokes
  // ---------------------------------------------------------------------------

  function test_ethenaEcosystemSpokeConfiguration() public view {
    address spoke = AaveV4EthereumAddresses.ETHENA_ECOSYSTEM_SPOKE;
    address plusHub = AaveV4EthereumAddresses.PLUS_HUB;
    address coreHub = AaveV4EthereumAddresses.CORE_HUB;

    uint256 totalCount = ISpoke(spoke).getReserveCount();
    assertEq(totalCount, 10, 'Ethena Ecosystem: wrong total reserve count');

    (, uint256 onPlusHub, uint256 plusCollateral, uint256 plusBorrowable) = _countReserves(
      spoke,
      plusHub
    );
    assertEq(onPlusHub, 7, 'Ethena Ecosystem: wrong Plus Hub reserve count');
    assertEq(plusCollateral, 4, 'Ethena Ecosystem: wrong Plus Hub collateral count');
    assertEq(plusBorrowable, 4, 'Ethena Ecosystem: wrong Plus Hub borrowable count');

    (, uint256 onCoreHub, uint256 coreCollateral, uint256 coreBorrowable) = _countReserves(
      spoke,
      coreHub
    );
    assertEq(onCoreHub, 3, 'Ethena Ecosystem: wrong Core Hub reserve count');
    assertEq(coreCollateral, 0, 'Ethena Ecosystem: Core Hub should have no collateral');
    assertEq(coreBorrowable, 3, 'Ethena Ecosystem: wrong Core Hub borrowable count');

    // Verify specific tokens on Plus Hub
    assertTrue(_isCollateralOnHub(spoke, plusHub, AaveV3EthereumAssets.sUSDe_UNDERLYING), 'sUSDe should be collateral on Plus');
    assertTrue(_isCollateralOnHub(spoke, plusHub, AaveV3EthereumAssets.USDe_UNDERLYING), 'USDe should be collateral on Plus');
    assertTrue(_isBorrowableOnHub(spoke, plusHub, AaveV3EthereumAssets.USDe_UNDERLYING), 'USDe should be borrowable on Plus');
    assertTrue(_isBorrowableOnHub(spoke, plusHub, AaveV3EthereumAssets.USDT_UNDERLYING), 'USDT should be borrowable on Plus');
    assertTrue(_isBorrowableOnHub(spoke, plusHub, AaveV3EthereumAssets.USDC_UNDERLYING), 'USDC should be borrowable on Plus');
    assertTrue(_isBorrowableOnHub(spoke, plusHub, AaveV3EthereumAssets.GHO_UNDERLYING), 'GHO should be borrowable on Plus');

    // Verify cross-hub borrowables on Core Hub
    assertTrue(_isBorrowableOnHub(spoke, coreHub, AaveV3EthereumAssets.USDT_UNDERLYING), 'coreUSDT should be borrowable');
    assertTrue(_isBorrowableOnHub(spoke, coreHub, AaveV3EthereumAssets.USDC_UNDERLYING), 'coreUSDC should be borrowable');
  }

  function test_ethenaCorrelatedSpokeConfiguration() public view {
    address spoke = AaveV4EthereumAddresses.ETHENA_CORRELATED_SPOKE;
    address plusHub = AaveV4EthereumAddresses.PLUS_HUB;

    (uint256 total, uint256 onHub, uint256 collateral, uint256 borrowable) = _countReserves(
      spoke,
      plusHub
    );
    assertEq(total, 4, 'Ethena Correlated: wrong total reserve count');
    assertEq(onHub, 4, 'Ethena Correlated: all reserves should be on Plus Hub');
    assertEq(collateral, 4, 'Ethena Correlated: wrong collateral count');
    assertEq(borrowable, 1, 'Ethena Correlated: wrong borrowable count');

    assertTrue(_isCollateralOnHub(spoke, plusHub, AaveV3EthereumAssets.sUSDe_UNDERLYING), 'sUSDe should be collateral');
    assertTrue(_isCollateralOnHub(spoke, plusHub, AaveV3EthereumAssets.USDe_UNDERLYING), 'USDe should be collateral');
    assertTrue(_isBorrowableOnHub(spoke, plusHub, AaveV3EthereumAssets.USDe_UNDERLYING), 'USDe should be borrowable');
    assertFalse(_isBorrowableOnHub(spoke, plusHub, AaveV3EthereumAssets.sUSDe_UNDERLYING), 'sUSDe should not be borrowable');
  }

  // ---------------------------------------------------------------------------
  // Helpers
  // ---------------------------------------------------------------------------

  function _countReserves(
    address spoke,
    address hub
  )
    internal
    view
    returns (uint256 total, uint256 onHub, uint256 collateralCount, uint256 borrowableCount)
  {
    total = ISpoke(spoke).getReserveCount();
    for (uint256 i = 0; i < total; ++i) {
      ISpoke.Reserve memory r = ISpoke(spoke).getReserve(i);
      if (r.hub != hub) continue;
      ++onHub;

      ISpoke.DynamicReserveConfig memory dynCfg = ISpoke(spoke).getDynamicReserveConfig(
        i,
        r.dynamicConfigKey
      );
      if (dynCfg.collateralFactor > 0) ++collateralCount;

      ISpoke.ReserveConfig memory cfg = ISpoke(spoke).getReserveConfig(i);
      if (cfg.borrowable) ++borrowableCount;
    }
  }

  function _findReserve(
    address spoke,
    address hub,
    address underlying
  ) internal view returns (bool found, uint256 reserveId) {
    uint256 count = ISpoke(spoke).getReserveCount();
    for (uint256 i = 0; i < count; ++i) {
      ISpoke.Reserve memory r = ISpoke(spoke).getReserve(i);
      if (r.hub == hub && r.underlying == underlying) {
        return (true, i);
      }
    }
    return (false, 0);
  }

  function _isCollateralOnHub(
    address spoke,
    address hub,
    address underlying
  ) internal view returns (bool) {
    (bool found, uint256 id) = _findReserve(spoke, hub, underlying);
    if (!found) return false;
    ISpoke.Reserve memory r = ISpoke(spoke).getReserve(id);
    ISpoke.DynamicReserveConfig memory dynCfg = ISpoke(spoke).getDynamicReserveConfig(
      id,
      r.dynamicConfigKey
    );
    return dynCfg.collateralFactor > 0;
  }

  function _isBorrowableOnHub(
    address spoke,
    address hub,
    address underlying
  ) internal view returns (bool) {
    (bool found, uint256 id) = _findReserve(spoke, hub, underlying);
    if (!found) return false;
    ISpoke.ReserveConfig memory cfg = ISpoke(spoke).getReserveConfig(id);
    return cfg.borrowable;
  }
}
