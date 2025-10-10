// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Plasma, AaveV3PlasmaAssets} from 'aave-address-book/AaveV3Plasma.sol';
import {AaveV3PayloadPlasma} from 'aave-helpers/src/v3-config-engine/AaveV3PayloadPlasma.sol';
import {EngineFlags} from 'aave-v3-origin/contracts/extensions/v3-config-engine/EngineFlags.sol';
import {IAaveV3ConfigEngine, IPool} from 'aave-v3-origin/contracts/extensions/v3-config-engine/IAaveV3ConfigEngine.sol';
import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {SafeERC20} from 'openzeppelin-contracts/contracts/token/ERC20/utils/SafeERC20.sol';
import {IEmissionManager} from 'aave-v3-origin/contracts/rewards/interfaces/IEmissionManager.sol';
import {IAaveStewardInjector} from '../interfaces/IAaveStewardInjector.sol';
/**
 * @title Onboard sUSDe and USDe January expiry PT tokens on Aave V3 Plasma Instance
 * @author Aave_chan Initiative
 * - Snapshot: direct-to-aip
 * - Discussion: https://governance.aave.com/t/direct-to-aip-onboard-susde-and-usde-january-expiry-pt-tokens-on-aave-v3-plasma-instance/23196
 */
contract AaveV3Plasma_OnboardSUSDeAndUSDeJanuaryExpiryPTTokensOnAaveV3PlasmaInstance_20251007 is
  AaveV3PayloadPlasma
{
  using SafeERC20 for IERC20;
  address public constant EDGE_INJECTOR_PENDLE_EMODE = 0xdD56dE44d2d79eC97cEa1A0049c767A4ce97953e;
  address public constant EDGE_INJECTOR_DISCOUNT_RATE = 0x6E3748B753D38e33CC476aF63C9d220Af65b7fc4;
  address public constant EDGE_RISK_STEWARD_EMODE = 0xe1472037C9f17Ac00bf5336272ab74e423B9254d;
  address public constant EDGE_RISK_STEWARD_DISCOUNT_RATE =
    0x530034d1A739Afd261291B86A5c3b95eC30c4b44;

  address public constant PT_USDe_15JAN2026 = 0x93B544c330F60A2aa05ceD87aEEffB8D38FD8c9a;
  uint256 public constant PT_USDe_15JAN2026_SEED_AMOUNT = 100e18;
  address public constant PT_USDe_15JAN2026_LM_ADMIN = 0xac140648435d03f784879cd789130F22Ef588Fcd;

  address public constant PT_sUSDE_15JAN2026 = 0x02FCC4989B4C9D435b7ceD3fE1Ba4CF77BBb5Dd8;
  uint256 public constant PT_sUSDE_15JAN2026_SEED_AMOUNT = 100e18;
  address public constant PT_sUSDE_15JAN2026_LM_ADMIN = 0xac140648435d03f784879cd789130F22Ef588Fcd;

  function _postExecute() internal override {
    // onboard new risk steward for ARGS
    AaveV3Plasma.ACL_MANAGER.addRiskAdmin(EDGE_RISK_STEWARD_DISCOUNT_RATE); // manual risk-steward
    AaveV3Plasma.ACL_MANAGER.addRiskAdmin(EDGE_RISK_STEWARD_EMODE);
    // we whitelist the four newly created eModeId on the injector
    uint8 nextID = _findFirstUnusedEmodeCategory(AaveV3Plasma.POOL);
    address[] memory marketsToWhitelist = new address[](4);
    marketsToWhitelist[0] = address(uint160(nextID - 1)); // on the injector we encode eModeId to address
    marketsToWhitelist[1] = address(uint160(nextID - 2));
    marketsToWhitelist[2] = address(uint160(nextID - 3));
    marketsToWhitelist[3] = address(uint160(nextID - 4));
    IAaveStewardInjector(EDGE_INJECTOR_PENDLE_EMODE).addMarkets(marketsToWhitelist);

    address[] memory assetToWhitelist = new address[](2);
    assetToWhitelist[0] = PT_USDe_15JAN2026;
    assetToWhitelist[1] = PT_sUSDE_15JAN2026;
    IAaveStewardInjector(EDGE_INJECTOR_DISCOUNT_RATE).addMarkets(assetToWhitelist);

    IERC20(PT_USDe_15JAN2026).forceApprove(
      address(AaveV3Plasma.POOL),
      PT_USDe_15JAN2026_SEED_AMOUNT
    );
    AaveV3Plasma.POOL.supply(
      PT_USDe_15JAN2026,
      PT_USDe_15JAN2026_SEED_AMOUNT,
      AaveV3Plasma.DUST_BIN,
      0
    );

    address aPT_USDe_15JAN2026 = AaveV3Plasma.POOL.getReserveAToken(PT_USDe_15JAN2026);
    IEmissionManager(AaveV3Plasma.EMISSION_MANAGER).setEmissionAdmin(
      PT_USDe_15JAN2026,
      PT_USDe_15JAN2026_LM_ADMIN
    );
    IEmissionManager(AaveV3Plasma.EMISSION_MANAGER).setEmissionAdmin(
      aPT_USDe_15JAN2026,
      PT_USDe_15JAN2026_LM_ADMIN
    );

    IERC20(PT_sUSDE_15JAN2026).forceApprove(
      address(AaveV3Plasma.POOL),
      PT_sUSDE_15JAN2026_SEED_AMOUNT
    );
    AaveV3Plasma.POOL.supply(
      PT_sUSDE_15JAN2026,
      PT_sUSDE_15JAN2026_SEED_AMOUNT,
      AaveV3Plasma.DUST_BIN,
      0
    );

    address aPT_sUSDE_15JAN2026 = AaveV3Plasma.POOL.getReserveAToken(PT_sUSDE_15JAN2026);
    IEmissionManager(AaveV3Plasma.EMISSION_MANAGER).setEmissionAdmin(
      PT_sUSDE_15JAN2026,
      PT_sUSDE_15JAN2026_LM_ADMIN
    );
    IEmissionManager(AaveV3Plasma.EMISSION_MANAGER).setEmissionAdmin(
      aPT_sUSDE_15JAN2026,
      PT_sUSDE_15JAN2026_LM_ADMIN
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

    address[] memory collateralAssets_PT_USDe_15JAN2026Stablecoin = new address[](1);
    address[] memory borrowableAssets_PT_USDe_15JAN2026Stablecoin = new address[](2);

    collateralAssets_PT_USDe_15JAN2026Stablecoin[0] = PT_USDe_15JAN2026;
    borrowableAssets_PT_USDe_15JAN2026Stablecoin[0] = AaveV3PlasmaAssets.USDT0_UNDERLYING;
    borrowableAssets_PT_USDe_15JAN2026Stablecoin[1] = AaveV3PlasmaAssets.USDe_UNDERLYING;

    eModeCreations[0] = IAaveV3ConfigEngine.EModeCategoryCreation({
      ltv: 85_40,
      liqThreshold: 87_40,
      liqBonus: 4_90,
      label: 'PT_USDe_15JAN2026/Stablecoin',
      collaterals: collateralAssets_PT_USDe_15JAN2026Stablecoin,
      borrowables: borrowableAssets_PT_USDe_15JAN2026Stablecoin
    });

    address[] memory collateralAssets_PT_USDe_15JAN2026USDe = new address[](1);
    address[] memory borrowableAssets_PT_USDe_15JAN2026USDe = new address[](1);

    collateralAssets_PT_USDe_15JAN2026USDe[0] = PT_USDe_15JAN2026;
    borrowableAssets_PT_USDe_15JAN2026USDe[0] = AaveV3PlasmaAssets.USDe_UNDERLYING;

    eModeCreations[1] = IAaveV3ConfigEngine.EModeCategoryCreation({
      ltv: 86_20,
      liqThreshold: 88_20,
      liqBonus: 3_90,
      label: 'PT_USDe_15JAN2026/USDe',
      collaterals: collateralAssets_PT_USDe_15JAN2026USDe,
      borrowables: borrowableAssets_PT_USDe_15JAN2026USDe
    });

    address[] memory collateralAssets_PT_sUSDe_15JAN2026Stablecoin = new address[](1);
    address[] memory borrowableAssets_PT_sUSDe_15JAN2026Stablecoin = new address[](2);

    collateralAssets_PT_sUSDe_15JAN2026Stablecoin[0] = PT_sUSDE_15JAN2026;
    borrowableAssets_PT_sUSDe_15JAN2026Stablecoin[0] = AaveV3PlasmaAssets.USDT0_UNDERLYING;
    borrowableAssets_PT_sUSDe_15JAN2026Stablecoin[1] = AaveV3PlasmaAssets.USDe_UNDERLYING;

    eModeCreations[2] = IAaveV3ConfigEngine.EModeCategoryCreation({
      ltv: 83_90,
      liqThreshold: 85_90,
      liqBonus: 6_00,
      label: 'PT_sUSDe_15JAN2026/Stablecoin',
      collaterals: collateralAssets_PT_sUSDe_15JAN2026Stablecoin,
      borrowables: borrowableAssets_PT_sUSDe_15JAN2026Stablecoin
    });

    address[] memory collateralAssets_PT_sUSDe_15JAN2026USDe = new address[](1);
    address[] memory borrowableAssets_PT_sUSDe_15JAN2026USDe = new address[](1);

    collateralAssets_PT_sUSDe_15JAN2026USDe[0] = PT_sUSDE_15JAN2026;
    borrowableAssets_PT_sUSDe_15JAN2026USDe[0] = AaveV3PlasmaAssets.USDe_UNDERLYING;

    eModeCreations[3] = IAaveV3ConfigEngine.EModeCategoryCreation({
      ltv: 84_50,
      liqThreshold: 86_50,
      liqBonus: 5_20,
      label: 'PT_sUSDe_15JAN2026/USDe',
      collaterals: collateralAssets_PT_sUSDe_15JAN2026USDe,
      borrowables: borrowableAssets_PT_sUSDe_15JAN2026USDe
    });

    return eModeCreations;
  }

  function newListings() public pure override returns (IAaveV3ConfigEngine.Listing[] memory) {
    IAaveV3ConfigEngine.Listing[] memory listings = new IAaveV3ConfigEngine.Listing[](2);

    listings[0] = IAaveV3ConfigEngine.Listing({
      asset: PT_USDe_15JAN2026,
      assetSymbol: 'PT_USDe_15JAN2026',
      priceFeed: 0x30cb6ff8649Cc02cEa91971D4730EebeD5A8D2F1,
      enabledToBorrow: EngineFlags.DISABLED,
      borrowableInIsolation: EngineFlags.DISABLED,
      withSiloedBorrowing: EngineFlags.DISABLED,
      flashloanable: EngineFlags.ENABLED,
      ltv: 5,
      liqThreshold: 10,
      liqBonus: 7_50,
      reserveFactor: 45_00,
      supplyCap: 200_000_000,
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
      asset: PT_sUSDE_15JAN2026,
      assetSymbol: 'PT_sUSDE_15JAN2026',
      priceFeed: 0x3eca1c7836eA09DB3dc85be7B5526Ce80E2609a1,
      enabledToBorrow: EngineFlags.DISABLED,
      borrowableInIsolation: EngineFlags.DISABLED,
      withSiloedBorrowing: EngineFlags.DISABLED,
      flashloanable: EngineFlags.ENABLED,
      ltv: 5,
      liqThreshold: 10,
      liqBonus: 7_50,
      reserveFactor: 45_00,
      supplyCap: 200_000_000,
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

  function _findFirstUnusedEmodeCategory(IPool pool) private view returns (uint8) {
    // eMode id 0 is skipped intentially as it is the reserved default
    for (uint8 i = 1; i < 256; i++) {
      if (pool.getEModeCategoryCollateralConfig(i).liquidationThreshold == 0) return i;
    }
    revert('NoAvailableEmodeCategory');
  }
}
