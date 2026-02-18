// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {SafeERC20} from 'openzeppelin-contracts/contracts/token/ERC20/utils/SafeERC20.sol';
import {AaveV3Plasma, AaveV3PlasmaAssets, AaveV3PlasmaEModes} from 'aave-address-book/AaveV3Plasma.sol';
import {AaveV3PayloadPlasma} from 'aave-helpers/src/v3-config-engine/AaveV3PayloadPlasma.sol';
import {GhoPlasma} from 'aave-address-book/GhoPlasma.sol';
import {GovernanceV3Plasma} from 'aave-address-book/GovernanceV3Plasma.sol';
import {EngineFlags} from 'aave-v3-origin/contracts/extensions/v3-config-engine/EngineFlags.sol';
import {IAaveV3ConfigEngine} from 'aave-v3-origin/contracts/extensions/v3-config-engine/IAaveV3ConfigEngine.sol';
import {CCIPChainSelectors} from '../helpers/gho-launch/constants/CCIPChainSelectors.sol';
import {IUpgradeableBurnMintTokenPool, IRateLimiter} from 'src/interfaces/ccip/IUpgradeableBurnMintTokenPool.sol';
import {IEmissionManager} from 'aave-v3-origin/contracts/rewards/interfaces/IEmissionManager.sol';

import {IGhoReserve} from 'src/interfaces/IGhoReserve.sol';
import {IGsm} from 'src/interfaces/IGsm.sol';
import {IGsmRegistry} from 'src/interfaces/IGsmRegistry.sol';

/**
 * @title Add GHO and deploy GSM on Plasma.
 * @author @TokenLogic
 * - Snapshot: https://snapshot.box/#/s:aavedao.eth/proposal/0xeb3572580924976867073ad9c8012cb9e52093c76dafebd7d3aebf318f2576fb
 * - Discussion: https://governance.aave.com/t/arfc-launch-gho-on-plasma-set-aci-as-emissions-manager-for-rewards/22994/6
 */
contract AaveV3Plasma_LaunchGHOOnPlasmaSetACIAsEmissionsManagerForRewards_20250930_Part2 is
  AaveV3PayloadPlasma
{
  using SafeERC20 for IERC20;

  uint128 public constant DEFAULT_RATE_LIMITER_CAPACITY = 1_500_000 ether;
  uint128 public constant DEFAULT_RATE_LIMITER_RATE = 300 ether;

  // https://plasmascan.to/address/0xac140648435d03f784879cd789130F22Ef588Fcd
  address public constant GHO_LM_ADMIN = 0xac140648435d03f784879cd789130F22Ef588Fcd;

  uint256 public constant GHO_SEED_AMOUNT = 10 ether;

  // GhoReserve
  // https://plasmascan.to/address/0x6aC541605b0317dE076C9FeC2842902c844dEa74
  address public constant GHO_RESERVE = 0x6aC541605b0317dE076C9FeC2842902c844dEa74;
  uint256 public constant BRIDGED_AMOUNT = 50_000_000 ether;

  // Capacities
  uint128 public constant RESERVE_LIMIT_GSM_USDT = 50_000_000 ether;
  uint128 public constant INITIAL_EXPOSURE_CAP = 10_000_000e6;

  // https://plasmascan.to/address/0x86992b2E2385E478dd2eeBfaE06369636e0a64E8
  address public constant GHO_GSM_STEWARD = 0x86992b2E2385E478dd2eeBfaE06369636e0a64E8;

  // https://plasmascan.to/address/0xA5Ba213867E175A182a5dd6A9193C6158738105A
  address public constant GHO_AAVE_STEWARD = 0xA5Ba213867E175A182a5dd6A9193C6158738105A;

  // https://plasmascan.to/address/0xc563fc29dD0A7E56D1B5Cc7bbF1DCF044d755303
  address public constant GSM_REGISTRY = 0xc563fc29dD0A7E56D1B5Cc7bbF1DCF044d755303;

  // https://plasmascan.to/address/0xd06114F714beCD6f373e5cE94E07278eF46eBF37
  address public constant NEW_GSM_USDT = 0xd06114F714beCD6f373e5cE94E07278eF46eBF37;

  // https://plasmascan.to/address/0xa9afaE6A53E90f9E4CE0717162DF5Bc3d9aBe7B2
  address public constant USDT_ORACLE_SWAP_FREEZER = 0xa9afaE6A53E90f9E4CE0717162DF5Bc3d9aBe7B2;

  // https://plasmascan.to/address/0xD70BE7e6111EA563226cb8e53B1F195Da4E566E2
  address public constant FEE_STRATEGY = 0xD70BE7e6111EA563226cb8e53B1F195Da4E566E2;

  bytes32 public immutable SWAP_FREEZER_ROLE = IGsm(NEW_GSM_USDT).SWAP_FREEZER_ROLE();

  function _preExecute() internal override {
    AaveV3Plasma.ACL_MANAGER.grantRole(
      AaveV3Plasma.ACL_MANAGER.RISK_ADMIN_ROLE(),
      GHO_AAVE_STEWARD
    );

    _grantAccess();
    IGsm(NEW_GSM_USDT).updateFeeStrategy(FEE_STRATEGY);
  }

  function _grantAccess() internal {
    IGsm(NEW_GSM_USDT).updateGhoReserve(GHO_RESERVE);

    // Enroll GSMs as entities and set limit
    IGhoReserve(GHO_RESERVE).grantRole(
      IGhoReserve(GHO_RESERVE).LIMIT_MANAGER_ROLE(),
      GhoPlasma.RISK_COUNCIL
    );
    IGhoReserve(GHO_RESERVE).addEntity(NEW_GSM_USDT);
    IGhoReserve(GHO_RESERVE).setLimit(NEW_GSM_USDT, RESERVE_LIMIT_GSM_USDT);

    // Add GSM Swap Freezer role to OracleSwapFreezers
    IGsm(NEW_GSM_USDT).grantRole(SWAP_FREEZER_ROLE, USDT_ORACLE_SWAP_FREEZER);
    IGsm(NEW_GSM_USDT).grantRole(SWAP_FREEZER_ROLE, GovernanceV3Plasma.EXECUTOR_LVL_1);

    // Add GSMs to GSM Registry
    IGsmRegistry(GSM_REGISTRY).addGsm(NEW_GSM_USDT);

    // GHO GSM Steward
    IGsm(NEW_GSM_USDT).grantRole(IGsm(NEW_GSM_USDT).CONFIGURATOR_ROLE(), GHO_GSM_STEWARD);

    // Update deployed exposure cap to initial
    IGsm(NEW_GSM_USDT).updateExposureCap(INITIAL_EXPOSURE_CAP);
  }

  function _postExecute() internal override {
    IERC20(GhoPlasma.GHO_TOKEN).forceApprove(address(AaveV3Plasma.POOL), GHO_SEED_AMOUNT);
    AaveV3Plasma.POOL.supply(GhoPlasma.GHO_TOKEN, GHO_SEED_AMOUNT, AaveV3Plasma.DUST_BIN, 0);

    address aGHO = AaveV3Plasma.POOL.getReserveAToken(GhoPlasma.GHO_TOKEN);
    address vGHO = AaveV3Plasma.POOL.getReserveVariableDebtToken(GhoPlasma.GHO_TOKEN);
    IEmissionManager(AaveV3Plasma.EMISSION_MANAGER).setEmissionAdmin(
      GhoPlasma.GHO_TOKEN,
      GHO_LM_ADMIN
    );
    IEmissionManager(AaveV3Plasma.EMISSION_MANAGER).setEmissionAdmin(aGHO, GHO_LM_ADMIN);
    IEmissionManager(AaveV3Plasma.EMISSION_MANAGER).setEmissionAdmin(vGHO, GHO_LM_ADMIN);

    AaveV3Plasma.COLLECTOR.transfer(IERC20(GhoPlasma.GHO_TOKEN), GHO_RESERVE, BRIDGED_AMOUNT);

    // Restore bridge limits after GHO bridging
    IUpgradeableBurnMintTokenPool(GhoPlasma.GHO_CCIP_TOKEN_POOL).setChainRateLimiterConfig(
      CCIPChainSelectors.ETHEREUM,
      IRateLimiter.Config({
        isEnabled: true,
        capacity: DEFAULT_RATE_LIMITER_CAPACITY,
        rate: DEFAULT_RATE_LIMITER_RATE
      }),
      IRateLimiter.Config({
        isEnabled: true,
        capacity: DEFAULT_RATE_LIMITER_CAPACITY,
        rate: DEFAULT_RATE_LIMITER_RATE
      })
    );
  }

  function newListings() public pure override returns (IAaveV3ConfigEngine.Listing[] memory) {
    IAaveV3ConfigEngine.Listing[] memory listings = new IAaveV3ConfigEngine.Listing[](1);

    listings[0] = IAaveV3ConfigEngine.Listing({
      asset: GhoPlasma.GHO_TOKEN,
      assetSymbol: 'GHO',
      priceFeed: GhoPlasma.GHO_ORACLE,
      enabledToBorrow: EngineFlags.ENABLED,
      borrowableInIsolation: EngineFlags.DISABLED,
      withSiloedBorrowing: EngineFlags.DISABLED,
      flashloanable: EngineFlags.ENABLED,
      ltv: 0,
      liqThreshold: 0,
      liqBonus: 0,
      reserveFactor: 5_00,
      supplyCap: 50_000_000,
      borrowCap: 20_000_000,
      debtCeiling: 0,
      liqProtocolFee: 10_00,
      rateStrategyParams: IAaveV3ConfigEngine.InterestRateInputData({
        optimalUsageRatio: 92_00,
        baseVariableBorrowRate: 1_25,
        variableRateSlope1: 3_50,
        variableRateSlope2: 16_50
      })
    });

    return listings;
  }

  function eModeCategoryCreations()
    public
    pure
    override
    returns (IAaveV3ConfigEngine.EModeCategoryCreation[] memory)
  {
    IAaveV3ConfigEngine.EModeCategoryCreation[]
      memory eModeCreations = new IAaveV3ConfigEngine.EModeCategoryCreation[](3);

    address[] memory collateralAssetsOne = new address[](1);
    address[] memory borrowableAssetsOne = new address[](1);

    collateralAssetsOne[0] = GhoPlasma.GHO_TOKEN;
    borrowableAssetsOne[0] = AaveV3PlasmaAssets.USDT0_UNDERLYING;

    eModeCreations[0] = IAaveV3ConfigEngine.EModeCategoryCreation({
      ltv: 94_00,
      liqThreshold: 96_00,
      liqBonus: 2_00,
      label: 'GHO__USDT0',
      collaterals: collateralAssetsOne,
      borrowables: borrowableAssetsOne
    });

    address[] memory collateralAssetsTwo = new address[](1);
    address[] memory borrowableAssetsTwo = new address[](1);

    collateralAssetsTwo[0] = AaveV3PlasmaAssets.syrupUSDT_UNDERLYING;
    borrowableAssetsTwo[0] = GhoPlasma.GHO_TOKEN;

    eModeCreations[1] = IAaveV3ConfigEngine.EModeCategoryCreation({
      ltv: 90_00,
      liqThreshold: 92_00,
      liqBonus: 4_00,
      label: 'syrupUSDT__GHO',
      collaterals: collateralAssetsTwo,
      borrowables: borrowableAssetsTwo
    });

    address[] memory collateralAssets_syrup = new address[](2);
    address[] memory borrowableAssets_syrup = new address[](1);

    collateralAssets_syrup[0] = GhoPlasma.GHO_TOKEN;
    collateralAssets_syrup[1] = AaveV3PlasmaAssets.syrupUSDT_UNDERLYING;
    borrowableAssets_syrup[0] = AaveV3PlasmaAssets.USDT0_UNDERLYING;

    eModeCreations[2] = IAaveV3ConfigEngine.EModeCategoryCreation({
      ltv: 90_00,
      liqThreshold: 92_00,
      liqBonus: 4_00,
      label: 'syrupUSDT_GHO__USDT0',
      collaterals: collateralAssets_syrup,
      borrowables: borrowableAssets_syrup
    });

    return eModeCreations;
  }

  function eModeCategoriesUpdates()
    public
    pure
    override
    returns (IAaveV3ConfigEngine.EModeCategoryUpdate[] memory)
  {
    IAaveV3ConfigEngine.EModeCategoryUpdate[]
      memory eModeUpdates = new IAaveV3ConfigEngine.EModeCategoryUpdate[](2);

    eModeUpdates[0] = IAaveV3ConfigEngine.EModeCategoryUpdate({
      eModeCategory: AaveV3PlasmaEModes.USDe_PT_USDe_15JAN2026_PT_USDe_9APR2026__USDT0_USDe,
      ltv: 85_90,
      liqThreshold: EngineFlags.KEEP_CURRENT,
      liqBonus: 4_90,
      label: EngineFlags.KEEP_CURRENT_STRING
    });

    eModeUpdates[1] = IAaveV3ConfigEngine.EModeCategoryUpdate({
      eModeCategory: AaveV3PlasmaEModes.sUSDe_PT_sUSDE_15JAN2026_PT_sUSDE_9APR2026__USDT0_USDe,
      ltv: 84_40,
      liqThreshold: EngineFlags.KEEP_CURRENT,
      liqBonus: 6_00,
      label: EngineFlags.KEEP_CURRENT_STRING
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
      memory assetEModeUpdates = new IAaveV3ConfigEngine.AssetEModeUpdate[](3);

    assetEModeUpdates[0] = IAaveV3ConfigEngine.AssetEModeUpdate({
      asset: GhoPlasma.GHO_TOKEN,
      eModeCategory: 2,
      borrowable: EngineFlags.ENABLED,
      collateral: EngineFlags.DISABLED,
      ltvzero: EngineFlags.KEEP_CURRENT
    });
    assetEModeUpdates[1] = IAaveV3ConfigEngine.AssetEModeUpdate({
      asset: GhoPlasma.GHO_TOKEN,
      eModeCategory: 5,
      borrowable: EngineFlags.ENABLED,
      collateral: EngineFlags.DISABLED,
      ltvzero: EngineFlags.KEEP_CURRENT
    });
    assetEModeUpdates[2] = IAaveV3ConfigEngine.AssetEModeUpdate({
      asset: GhoPlasma.GHO_TOKEN,
      eModeCategory: 7,
      borrowable: EngineFlags.ENABLED,
      collateral: EngineFlags.DISABLED,
      ltvzero: EngineFlags.KEEP_CURRENT
    });

    return assetEModeUpdates;
  }
}
