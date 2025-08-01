// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {AaveV3PayloadEthereum} from 'aave-helpers/src/v3-config-engine/AaveV3PayloadEthereum.sol';
import {EngineFlags} from 'aave-v3-origin/contracts/extensions/v3-config-engine/EngineFlags.sol';
import {IAaveV3ConfigEngine} from 'aave-v3-origin/contracts/extensions/v3-config-engine/IAaveV3ConfigEngine.sol';

/**
 * @title Add EzETH to Aave V3 Core Instance
 * @author @TokenLogic
 * - Snapshot: https://snapshot.box/#/s:aavedao.eth/proposal/0x65e12ce7784f12fbed9731d4cdbc826a8a5d4804439dc6d55d6e31c0b069a048
 * - Discussion: https://governance.aave.com/t/direct-to-aip-add-ezeth-to-aave-v3-core-instance/22732
 */
contract AddEzETHToAaveV3CoreInstance_20250729 is AaveV3PayloadEthereum {
  address public constant EZETH_UNDERLYING = 0xbf5495Efe5DB9ce00f80364C8B423567e58d2110;
  address public constant EZETH_PRICE_FEED = 0xF3d49021fF3bbBFDfC1992A4b09E5D1d141D044C;
  string public constant EZETH_SYMBOL = 'ezETH';

  function eModeCategoryCreations()
    public
    pure
    override
    returns (IAaveV3ConfigEngine.EModeCategoryCreation[] memory)
  {
    IAaveV3ConfigEngine.EModeCategoryCreation[]
      memory eModeCreations = new IAaveV3ConfigEngine.EModeCategoryCreation[](2);

    // ezETH/stablecoins eMode category
    address[] memory collateralAssets_EzETHStablecoins = new address[](1);
    address[] memory borrowableAssets_EzETHStablecoins = new address[](2);

    collateralAssets_EzETHStablecoins[0] = EZETH_UNDERLYING;
    borrowableAssets_EzETHStablecoins[0] = AaveV3EthereumAssets.USDC_UNDERLYING;
    borrowableAssets_EzETHStablecoins[1] = AaveV3EthereumAssets.USDT_UNDERLYING;

    eModeCreations[0] = IAaveV3ConfigEngine.EModeCategoryCreation({
      ltv: 90_00, // 90%
      liqThreshold: 92_00, // 92%
      liqBonus: 3_00, // 3%
      label: 'ezETH/stablecoins',
      collaterals: collateralAssets_EzETHStablecoins,
      borrowables: borrowableAssets_EzETHStablecoins
    });

    // ezETH/wstETH eMode category
    address[] memory collateralAssets_EzETHWstETH = new address[](1);
    address[] memory borrowableAssets_EzETHWstETH = new address[](1);

    collateralAssets_EzETHWstETH[0] = EZETH_UNDERLYING;
    borrowableAssets_EzETHWstETH[0] = AaveV3EthereumAssets.wstETH_UNDERLYING;

    eModeCreations[1] = IAaveV3ConfigEngine.EModeCategoryCreation({
      ltv: 92_00, // 92%
      liqThreshold: 94_00, // 94%
      liqBonus: 2_00, // 2%
      label: 'ezETH/wstETH',
      collaterals: collateralAssets_EzETHWstETH,
      borrowables: borrowableAssets_EzETHWstETH
    });

    return eModeCreations;
  }

  function newListings() public pure override returns (IAaveV3ConfigEngine.Listing[] memory) {
    IAaveV3ConfigEngine.Listing[] memory listings = new IAaveV3ConfigEngine.Listing[](1);

    listings[0] = IAaveV3ConfigEngine.Listing({
      asset: EZETH_UNDERLYING,
      assetSymbol: EZETH_SYMBOL,
      priceFeed: EZETH_PRICE_FEED,
      rateStrategyParams: IAaveV3ConfigEngine.InterestRateInputData({
        optimalUsageRatio: 80_00,
        baseVariableBorrowRate: 0,
        variableRateSlope1: 0,
        variableRateSlope2: 0
      }),
      enabledToBorrow: EngineFlags.DISABLED,
      borrowableInIsolation: EngineFlags.DISABLED,
      withSiloedBorrowing: EngineFlags.DISABLED,
      flashloanable: EngineFlags.ENABLED,
      ltv: 5, // 0.05%
      liqThreshold: 10, // 0.10%
      liqBonus: 750, // 7.5%
      reserveFactor: 1500, // 15%
      supplyCap: 50000,
      borrowCap: 0,
      debtCeiling: 0,
      liqProtocolFee: 1000 // 10%
    });

    return listings;
  }
}
