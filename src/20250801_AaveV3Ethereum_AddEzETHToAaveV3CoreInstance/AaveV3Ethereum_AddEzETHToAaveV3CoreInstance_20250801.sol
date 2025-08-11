// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {AaveV3EthereumLido, AaveV3EthereumLidoAssets} from 'aave-address-book/AaveV3EthereumLido.sol';
import {AaveV3PayloadEthereum} from 'aave-helpers/src/v3-config-engine/AaveV3PayloadEthereum.sol';
import {EngineFlags} from 'aave-v3-origin/contracts/extensions/v3-config-engine/EngineFlags.sol';
import {IAaveV3ConfigEngine} from 'aave-v3-origin/contracts/extensions/v3-config-engine/IAaveV3ConfigEngine.sol';
import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {SafeERC20} from 'openzeppelin-contracts/contracts/token/ERC20/utils/SafeERC20.sol';

/**
 * @title Add ezETH to Aave v3 Core Instance
 * @author @TokenLogic
 * - Snapshot: Direct-to-AIP
 * - Discussion: https://governance.aave.com/t/direct-to-aip-add-ezeth-to-aave-v3-core-instance/22732
 */
contract AaveV3Ethereum_AddEzETHToAaveV3CoreInstance_20250801 is AaveV3PayloadEthereum {
  using SafeERC20 for IERC20;
  using AaveV3EthereumLido for IERC20;

  uint256 public constant ezETH_SEED_AMOUNT = 0.025 ether;

  function _postExecute() internal override {
    IERC20(AaveV3EthereumLidoAssets.ezETH_UNDERLYING).forceApprove(
      address(AaveV3Ethereum.POOL),
      ezETH_SEED_AMOUNT
    );
    AaveV3Ethereum.POOL.supply(
      AaveV3EthereumLidoAssets.ezETH_UNDERLYING,
      ezETH_SEED_AMOUNT,
      AaveV3Ethereum.DUST_BIN,
      0
    );
  }

  function eModeCategoryCreations()
    public
    pure
    override
    returns (IAaveV3ConfigEngine.EModeCategoryCreation[] memory)
  {
    IAaveV3ConfigEngine.EModeCategoryCreation[]
      memory eModeCreations = new IAaveV3ConfigEngine.EModeCategoryCreation[](2);

    address[] memory collateralAssets_EzETHWstETH = new address[](1);
    address[] memory borrowableAssets_EzETHWstETH = new address[](1);

    collateralAssets_EzETHWstETH[0] = AaveV3EthereumLidoAssets.ezETH_UNDERLYING;
    borrowableAssets_EzETHWstETH[0] = AaveV3EthereumAssets.wstETH_UNDERLYING;

    eModeCreations[0] = IAaveV3ConfigEngine.EModeCategoryCreation({
      ltv: 93_00,
      liqThreshold: 95_00,
      liqBonus: 1_00,
      label: 'ezETH/wstETH',
      collaterals: collateralAssets_EzETHWstETH,
      borrowables: borrowableAssets_EzETHWstETH
    });

    address[] memory collateralAssets_EzETHStablecoin = new address[](1);
    address[] memory borrowableAssets_EzETHStablecoin = new address[](2);

    collateralAssets_EzETHStablecoin[0] = AaveV3EthereumLidoAssets.ezETH_UNDERLYING;
    borrowableAssets_EzETHStablecoin[0] = AaveV3EthereumAssets.USDC_UNDERLYING;
    borrowableAssets_EzETHStablecoin[1] = AaveV3EthereumAssets.USDT_UNDERLYING;

    eModeCreations[1] = IAaveV3ConfigEngine.EModeCategoryCreation({
      ltv: 75_00,
      liqThreshold: 78_00,
      liqBonus: 7_50,
      label: 'ezETH/Stablecoins',
      collaterals: collateralAssets_EzETHStablecoin,
      borrowables: borrowableAssets_EzETHStablecoin
    });

    return eModeCreations;
  }

  function newListings() public pure override returns (IAaveV3ConfigEngine.Listing[] memory) {
    IAaveV3ConfigEngine.Listing[] memory listings = new IAaveV3ConfigEngine.Listing[](1);

    listings[0] = IAaveV3ConfigEngine.Listing({
      asset: AaveV3EthereumLidoAssets.ezETH_UNDERLYING,
      assetSymbol: 'ezETH',
      priceFeed: AaveV3EthereumLidoAssets.ezETH_ORACLE,
      enabledToBorrow: EngineFlags.DISABLED,
      borrowableInIsolation: EngineFlags.DISABLED,
      withSiloedBorrowing: EngineFlags.DISABLED,
      flashloanable: EngineFlags.ENABLED,
      ltv: 5,
      liqThreshold: 10,
      liqBonus: 7_50,
      reserveFactor: 15_00,
      supplyCap: 50_000,
      borrowCap: 0,
      debtCeiling: 0,
      liqProtocolFee: 10_00,
      rateStrategyParams: IAaveV3ConfigEngine.InterestRateInputData({
        optimalUsageRatio: 45_00,
        baseVariableBorrowRate: 0,
        variableRateSlope1: 0,
        variableRateSlope2: 0
      })
    });

    return listings;
  }
}
