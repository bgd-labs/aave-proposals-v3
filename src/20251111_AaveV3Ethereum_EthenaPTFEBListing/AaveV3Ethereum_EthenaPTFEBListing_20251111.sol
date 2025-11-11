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
 * @title Ethena PT FEB Listing
 * @author ACI
 * - Snapshot: Direct to AIP
 * - Discussion: https://governance.aave.com/t/direct-to-aip-onboard-usde-susde-february-expiry-pt-tokens-on-aave-v3-core-instance/23358
 */
contract AaveV3Ethereum_EthenaPTFEBListing_20251111 is AaveV3PayloadEthereum {
  using SafeERC20 for IERC20;

  address public constant PT_USDE_5FEB_2026 = 0x1F84a51296691320478c98b8d77f2Bbd17D34350;
  uint256 public constant PT_USDE_5FEB_2026_SEED_AMOUNT = 1e18;
  address public constant PT_USDE_5FEB_2026_LM_ADMIN = 0xac140648435d03f784879cd789130F22Ef588Fcd;

  address public constant PT_sUSDe_5FEB_2026 = 0xE8483517077afa11A9B07f849cee2552f040d7b2;
  uint256 public constant PT_sUSDe_5FEB_2026_SEED_AMOUNT = 1e18;
  address public constant PT_sUSDe_5FEB_2026_LM_ADMIN = 0xac140648435d03f784879cd789130F22Ef588Fcd;

  function _postExecute() internal override {
    _supplyAndConfigureLMAdmin(
      PT_USDE_5FEB_2026,
      PT_USDE_5FEB_2026_SEED_AMOUNT,
      PT_USDE_5FEB_2026_LM_ADMIN
    );

    _supplyAndConfigureLMAdmin(
      PT_sUSDe_5FEB_2026,
      PT_sUSDe_5FEB_2026_SEED_AMOUNT,
      PT_sUSDe_5FEB_2026_LM_ADMIN
    );
  }

  function eModeCategoryCreations()
    public
    pure
    override
    returns (IAaveV3ConfigEngine.EModeCategoryCreation[] memory)
  {
    IAaveV3ConfigEngine.EModeCategoryCreation[]
      memory eModeCreations = new IAaveV3ConfigEngine.EModeCategoryCreation[](4);

    address[] memory collateralAssets_PTUSDe5FEBStablecoins = new address[](2);
    address[] memory borrowableAssets_PTUSDe5FEBStablecoins = new address[](4);

    collateralAssets_PTUSDe5FEBStablecoins[0] = PT_USDE_5FEB_2026;
    collateralAssets_PTUSDe5FEBStablecoins[1] = AaveV3EthereumAssets.PT_USDe_27NOV2025_UNDERLYING;
    borrowableAssets_PTUSDe5FEBStablecoins[0] = AaveV3EthereumAssets.USDC_UNDERLYING;
    borrowableAssets_PTUSDe5FEBStablecoins[1] = AaveV3EthereumAssets.USDT_UNDERLYING;
    borrowableAssets_PTUSDe5FEBStablecoins[2] = AaveV3EthereumAssets.USDe_UNDERLYING;
    borrowableAssets_PTUSDe5FEBStablecoins[3] = AaveV3EthereumAssets.USDtb_UNDERLYING;

    eModeCreations[0] = IAaveV3ConfigEngine.EModeCategoryCreation({
      ltv: 88_50,
      liqThreshold: 90_50,
      liqBonus: 4_10,
      label: 'PTUSDe5FEBStablecoins',
      collaterals: collateralAssets_PTUSDe5FEBStablecoins,
      borrowables: borrowableAssets_PTUSDe5FEBStablecoins
    });

    address[] memory collateralAssets_PTUSDe5FEBUSDe = new address[](2);
    address[] memory borrowableAssets_PTUSDe5FEBUSDe = new address[](1);

    collateralAssets_PTUSDe5FEBUSDe[0] = PT_USDE_5FEB_2026;
    collateralAssets_PTUSDe5FEBUSDe[1] = AaveV3EthereumAssets.PT_USDe_27NOV2025_UNDERLYING;
    borrowableAssets_PTUSDe5FEBUSDe[0] = AaveV3EthereumAssets.USDe_UNDERLYING;

    eModeCreations[1] = IAaveV3ConfigEngine.EModeCategoryCreation({
      ltv: 89_30,
      liqThreshold: 91_30,
      liqBonus: 3_10,
      label: 'PTUSDe5FEBUSDe',
      collaterals: collateralAssets_PTUSDe5FEBUSDe,
      borrowables: borrowableAssets_PTUSDe5FEBUSDe
    });

    address[] memory collateralAssets_PTsUSDe5FEBStablecoins = new address[](2);
    address[] memory borrowableAssets_PTsUSDe5FEBStablecoins = new address[](4);

    collateralAssets_PTsUSDe5FEBStablecoins[0] = PT_sUSDe_5FEB_2026;
    collateralAssets_PTsUSDe5FEBStablecoins[1] = AaveV3EthereumAssets.PT_sUSDE_27NOV2025_UNDERLYING;
    borrowableAssets_PTsUSDe5FEBStablecoins[0] = AaveV3EthereumAssets.USDC_UNDERLYING;
    borrowableAssets_PTsUSDe5FEBStablecoins[1] = AaveV3EthereumAssets.USDT_UNDERLYING;
    borrowableAssets_PTsUSDe5FEBStablecoins[2] = AaveV3EthereumAssets.USDe_UNDERLYING;
    borrowableAssets_PTsUSDe5FEBStablecoins[3] = AaveV3EthereumAssets.USDtb_UNDERLYING;

    eModeCreations[2] = IAaveV3ConfigEngine.EModeCategoryCreation({
      ltv: 87_60,
      liqThreshold: 89_60,
      liqBonus: 5_10,
      label: 'PTsUSDe5FEBStablecoins',
      collaterals: collateralAssets_PTsUSDe5FEBStablecoins,
      borrowables: borrowableAssets_PTsUSDe5FEBStablecoins
    });

    address[] memory collateralAssets_PTsUSDe5FEBUSDe = new address[](2);
    address[] memory borrowableAssets_PTsUSDe5FEBUSDe = new address[](1);

    collateralAssets_PTsUSDe5FEBUSDe[0] = PT_sUSDe_5FEB_2026;
    collateralAssets_PTsUSDe5FEBUSDe[1] = AaveV3EthereumAssets.PT_sUSDE_27NOV2025_UNDERLYING;
    borrowableAssets_PTsUSDe5FEBUSDe[0] = AaveV3EthereumAssets.USDe_UNDERLYING;

    eModeCreations[3] = IAaveV3ConfigEngine.EModeCategoryCreation({
      ltv: 88_50,
      liqThreshold: 90_50,
      liqBonus: 4_10,
      label: 'PTsUSDe5FEBUSDe',
      collaterals: collateralAssets_PTsUSDe5FEBUSDe,
      borrowables: borrowableAssets_PTsUSDe5FEBUSDe
    });

    return eModeCreations;
  }
  function newListings() public pure override returns (IAaveV3ConfigEngine.Listing[] memory) {
    IAaveV3ConfigEngine.Listing[] memory listings = new IAaveV3ConfigEngine.Listing[](2);

    listings[0] = IAaveV3ConfigEngine.Listing({
      asset: PT_USDE_5FEB_2026,
      assetSymbol: 'PT_USDE_5FEB_2026',
      priceFeed: 0xc35D319FA5FEc2BBE0eB4d0a826465b60f821F81,
      enabledToBorrow: EngineFlags.DISABLED,
      borrowableInIsolation: EngineFlags.DISABLED,
      withSiloedBorrowing: EngineFlags.DISABLED,
      flashloanable: EngineFlags.ENABLED,
      ltv: 5,
      liqThreshold: 10,
      liqBonus: 7_50,
      reserveFactor: 45_00,
      supplyCap: 30_000_000,
      borrowCap: 1,
      debtCeiling: 0,
      liqProtocolFee: 10_00,
      rateStrategyParams: IAaveV3ConfigEngine.InterestRateInputData({
        optimalUsageRatio: 45_00,
        baseVariableBorrowRate: 0,
        variableRateSlope1: 10_00,
        variableRateSlope2: 300_00
      })
    });
    listings[1] = IAaveV3ConfigEngine.Listing({
      asset: PT_sUSDe_5FEB_2026,
      assetSymbol: 'PT_sUSDe_5FEB_2026',
      priceFeed: 0x4e89f87F24C13819bBDDb56f99b38746C91677D8,
      enabledToBorrow: EngineFlags.DISABLED,
      borrowableInIsolation: EngineFlags.DISABLED,
      withSiloedBorrowing: EngineFlags.DISABLED,
      flashloanable: EngineFlags.ENABLED,
      ltv: 5,
      liqThreshold: 10,
      liqBonus: 7_50,
      reserveFactor: 45_00,
      supplyCap: 30_000_000,
      borrowCap: 1,
      debtCeiling: 0,
      liqProtocolFee: 10_00,
      rateStrategyParams: IAaveV3ConfigEngine.InterestRateInputData({
        optimalUsageRatio: 45_00,
        baseVariableBorrowRate: 0,
        variableRateSlope1: 10_00,
        variableRateSlope2: 300_00
      })
    });

    return listings;
  }
  function _supplyAndConfigureLMAdmin(address asset, uint256 seedAmount, address lmAdmin) internal {
    IERC20(asset).forceApprove(address(AaveV3Ethereum.POOL), seedAmount);
    AaveV3Ethereum.POOL.supply(asset, seedAmount, address(AaveV3Ethereum.DUST_BIN), 0);

    if (lmAdmin != address(0)) {
      address aToken = AaveV3Ethereum.POOL.getReserveAToken(asset);
      IEmissionManager(AaveV3Ethereum.EMISSION_MANAGER).setEmissionAdmin(asset, lmAdmin);
      IEmissionManager(AaveV3Ethereum.EMISSION_MANAGER).setEmissionAdmin(aToken, lmAdmin);
    }
  }
}
