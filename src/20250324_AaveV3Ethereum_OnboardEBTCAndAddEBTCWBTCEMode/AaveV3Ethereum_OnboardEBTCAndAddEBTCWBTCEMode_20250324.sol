// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {AaveV3PayloadEthereum} from 'aave-helpers/src/v3-config-engine/AaveV3PayloadEthereum.sol';
import {EngineFlags} from 'aave-v3-origin/contracts/extensions/v3-config-engine/EngineFlags.sol';
import {IAaveV3ConfigEngine} from 'aave-v3-origin/contracts/extensions/v3-config-engine/IAaveV3ConfigEngine.sol';
import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {SafeERC20} from 'openzeppelin-contracts/contracts/token/ERC20/utils/SafeERC20.sol';
import {IEmissionManager} from 'aave-v3-origin/contracts/rewards/interfaces/IEmissionManager.sol';
/**
 * @title Onboard eBTC and Add eBTC/WBTC E-Mode
 * @author ACI
 * - Snapshot: https://snapshot.box/#/s:aave.eth/proposal/0x564a45f0a2855799d9be329942fa1f5e849058ff4b950f4027ec4666f4b61d9c
 * - Discussion: https://governance.aave.com/t/arfc-enable-ebtc-wbtc-liquid-e-mode-on-aave-v3-core-instance/20141
 */
contract AaveV3Ethereum_OnboardEBTCAndAddEBTCWBTCEMode_20250324 is AaveV3PayloadEthereum {
  using SafeERC20 for IERC20;

  address public constant eBTC = 0x657e8C867D8B37dCC18fA4Caead9C45EB088C642;
  uint256 public constant eBTC_SEED_AMOUNT = 2e5;
  address public constant eBTC_LM_ADMIN = 0xac140648435d03f784879cd789130F22Ef588Fcd;

  function _postExecute() internal override {
    IERC20(eBTC).forceApprove(address(AaveV3Ethereum.POOL), eBTC_SEED_AMOUNT);
    AaveV3Ethereum.POOL.supply(eBTC, eBTC_SEED_AMOUNT, AaveV3Ethereum.DUST_BIN, 0);

    address aeBTC = AaveV3Ethereum.POOL.getReserveAToken(eBTC);
    IEmissionManager(AaveV3Ethereum.EMISSION_MANAGER).setEmissionAdmin(eBTC, eBTC_LM_ADMIN);
    IEmissionManager(AaveV3Ethereum.EMISSION_MANAGER).setEmissionAdmin(aeBTC, eBTC_LM_ADMIN);
  }

  function eModeCategoriesUpdates()
    public
    pure
    override
    returns (IAaveV3ConfigEngine.EModeCategoryUpdate[] memory)
  {
    IAaveV3ConfigEngine.EModeCategoryUpdate[]
      memory eModeUpdates = new IAaveV3ConfigEngine.EModeCategoryUpdate[](1);

    eModeUpdates[0] = IAaveV3ConfigEngine.EModeCategoryUpdate({
      eModeCategory: 7,
      ltv: 83_00,
      liqThreshold: 85_00,
      liqBonus: 3_00,
      label: 'eBTC/WBTC'
    });

    return eModeUpdates;
  }
  function assetsEModeUpdates()
    public
    pure
    override
    returns (IAaveV3ConfigEngine.AssetEModeUpdate[] memory)
  {
    IAaveV3ConfigEngine.AssetEModeUpdate[]
      memory assetEModeUpdates = new IAaveV3ConfigEngine.AssetEModeUpdate[](2);

    assetEModeUpdates[0] = IAaveV3ConfigEngine.AssetEModeUpdate({
      asset: eBTC,
      eModeCategory: 7,
      borrowable: EngineFlags.DISABLED,
      collateral: EngineFlags.ENABLED
    });
    assetEModeUpdates[1] = IAaveV3ConfigEngine.AssetEModeUpdate({
      asset: AaveV3EthereumAssets.WBTC_UNDERLYING,
      eModeCategory: 7,
      borrowable: EngineFlags.ENABLED,
      collateral: EngineFlags.DISABLED
    });

    return assetEModeUpdates;
  }
  function newListings() public pure override returns (IAaveV3ConfigEngine.Listing[] memory) {
    IAaveV3ConfigEngine.Listing[] memory listings = new IAaveV3ConfigEngine.Listing[](1);

    listings[0] = IAaveV3ConfigEngine.Listing({
      asset: eBTC,
      assetSymbol: 'eBTC',
      priceFeed: 0x95a85D0d2f3115702d813549a80040387738A430,
      enabledToBorrow: EngineFlags.DISABLED,
      borrowableInIsolation: EngineFlags.DISABLED,
      withSiloedBorrowing: EngineFlags.DISABLED,
      flashloanable: EngineFlags.ENABLED,
      ltv: 67_00,
      liqThreshold: 72_00,
      liqBonus: 10_00,
      reserveFactor: 50_00,
      supplyCap: 750,
      borrowCap: 1,
      debtCeiling: 0,
      liqProtocolFee: 10_00,
      rateStrategyParams: IAaveV3ConfigEngine.InterestRateInputData({
        optimalUsageRatio: 45_00,
        baseVariableBorrowRate: 0,
        variableRateSlope1: 4_00,
        variableRateSlope2: 300_00
      })
    });

    return listings;
  }
}
