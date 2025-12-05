// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {IACLManager} from 'aave-address-book/AaveV3.sol';
import {SafeERC20} from 'openzeppelin-contracts/contracts/token/ERC20/utils/SafeERC20.sol';
import {AaveV3Plasma, AaveV3PlasmaAssets} from 'aave-address-book/AaveV3Plasma.sol';
import {AaveV3PayloadPlasma} from 'aave-helpers/src/v3-config-engine/AaveV3PayloadPlasma.sol';
import {GhoPlasma} from 'aave-address-book/GhoPlasma.sol';
import {MiscPlasma} from 'aave-address-book/MiscPlasma.sol';
import {GovernanceV3Plasma} from 'aave-address-book/GovernanceV3Plasma.sol';
import {EngineFlags} from 'aave-v3-origin/contracts/extensions/v3-config-engine/EngineFlags.sol';
import {IAaveV3ConfigEngine} from 'aave-v3-origin/contracts/extensions/v3-config-engine/IAaveV3ConfigEngine.sol';
import {CCIPChainSelectors} from '../helpers/gho-launch/constants/CCIPChainSelectors.sol';
import {IUpgradeableBurnMintTokenPool, IRateLimiter} from 'src/interfaces/ccip/IUpgradeableBurnMintTokenPool.sol';
import {IEmissionManager} from 'aave-v3-origin/contracts/rewards/interfaces/IEmissionManager.sol';

import {IGhoBucketSteward} from 'src/interfaces/IGhoBucketSteward.sol';
import {IGhoToken} from 'src/interfaces/IGhoToken.sol';
import {IGsm} from 'src/interfaces/IGsm.sol';
import {IGsmRegistry} from 'src/interfaces/IGsmRegistry.sol';
import {IAaveCLRobotOperator} from 'src/interfaces/IAaveCLRobotOperator.sol';

interface IGhoReserve {
  function addEntity(address entity) external;
  function setLimit(address entity, uint256 limit) external;
  function totalEntities() external view returns (uint256);
}

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

  uint128 public constant DEFAULT_RATE_LIMITER_CAPACITY = 1_500_000e18;
  uint128 public constant DEFAULT_RATE_LIMITER_RATE = 300e18;

  // https://plasmascan.to/address/0xac140648435d03f784879cd789130F22Ef588Fcd
  address public constant GHO_LM_ADMIN = 0xac140648435d03f784879cd789130F22Ef588Fcd;

  uint256 public constant GHO_SEED_AMOUNT = 10e18;

  // GhoReserve
  // https://plasmascan.to/address/0xBAdA742e7Ff54595F9049eeF1Cc5AaF4364988B9
  address public constant GHO_RESERVE = 0xBAdA742e7Ff54595F9049eeF1Cc5AaF4364988B9;
  uint256 public constant BRIDGED_AMOUNT = 50_000_000 ether;

  // Capacities
  uint128 public constant USDT_CAPACITY = 50_000_000 ether;

  // https://plasmascan.to/address/0x86992b2E2385E478dd2eeBfaE06369636e0a64E8
  address public constant GHO_GSM_STEWARD = 0x86992b2E2385E478dd2eeBfaE06369636e0a64E8;

  // https://plasmascan.to/address/0xA5Ba213867E175A182a5dd6A9193C6158738105A
  address public constant GHO_AAVE_STEWARD = 0xA5Ba213867E175A182a5dd6A9193C6158738105A;

  // https://plasmascan.to/address/0xc563fc29dD0A7E56D1B5Cc7bbF1DCF044d755303
  address public constant GSM_REGISTRY = 0xc563fc29dD0A7E56D1B5Cc7bbF1DCF044d755303;

  // https://plasmascan.to/address/0xd06114F714beCD6f373e5cE94E07278eF46eBF37
  address public constant NEW_GSM_USDT = 0xd06114F714beCD6f373e5cE94E07278eF46eBF37;

  // https://plasmascan.to/address/0x0B60713B53Cf01Ff53111D0BC29743eF1E03C296
  address public constant USDT_ORACLE_SWAP_FREEZER = 0x0B60713B53Cf01Ff53111D0BC29743eF1E03C296;

  // https://plasmascan.to/address/0xD70BE7e6111EA563226cb8e53B1F195Da4E566E2
  address public constant FEE_STRATEGY = 0xD70BE7e6111EA563226cb8e53B1F195Da4E566E2;

  bytes32 public immutable LIQUIDATOR_ROLE = IGsm(NEW_GSM_USDT).LIQUIDATOR_ROLE();
  bytes32 public immutable SWAP_FREEZER_ROLE = IGsm(NEW_GSM_USDT).SWAP_FREEZER_ROLE();

  function _preExecute() internal override {
    AaveV3Plasma.ACL_MANAGER.grantRole(
      AaveV3Plasma.ACL_MANAGER.RISK_ADMIN_ROLE(),
      GHO_AAVE_STEWARD
    );

    _grantAccess();
    _updateFeeStrategy();
  }

  function _grantAccess() internal {
    // Enroll GSMs as entities and set limit
    IGhoReserve(GHO_RESERVE).addEntity(NEW_GSM_USDT);
    IGhoReserve(GHO_RESERVE).setLimit(NEW_GSM_USDT, USDT_CAPACITY);

    // Add GSM Swap Freezer role to OracleSwapFreezers
    IGsm(NEW_GSM_USDT).grantRole(SWAP_FREEZER_ROLE, USDT_ORACLE_SWAP_FREEZER);
    IGsm(NEW_GSM_USDT).grantRole(SWAP_FREEZER_ROLE, GovernanceV3Plasma.EXECUTOR_LVL_1);

    // Add GSMs to GSM Registry
    IGsmRegistry(GSM_REGISTRY).addGsm(NEW_GSM_USDT);

    // GHO GSM Steward
    IGsm(NEW_GSM_USDT).grantRole(IGsm(NEW_GSM_USDT).CONFIGURATOR_ROLE(), GHO_GSM_STEWARD);
  }

  function _updateFeeStrategy() internal {
    IGsm(NEW_GSM_USDT).updateFeeStrategy(FEE_STRATEGY);
  }

  function _postExecute() internal override {
    AaveV3Plasma.COLLECTOR.transfer(IERC20(GhoPlasma.GHO_TOKEN), address(this), GHO_SEED_AMOUNT);
    IERC20(GhoPlasma.GHO_TOKEN).forceApprove(address(AaveV3Plasma.POOL), GHO_SEED_AMOUNT);
    AaveV3Plasma.POOL.supply(GhoPlasma.GHO_TOKEN, GHO_SEED_AMOUNT, AaveV3Plasma.DUST_BIN, 0);

    address aGHO = AaveV3Plasma.POOL.getReserveAToken(GhoPlasma.GHO_TOKEN);
    IEmissionManager(AaveV3Plasma.EMISSION_MANAGER).setEmissionAdmin(
      GhoPlasma.GHO_TOKEN,
      GHO_LM_ADMIN
    );
    IEmissionManager(AaveV3Plasma.EMISSION_MANAGER).setEmissionAdmin(aGHO, GHO_LM_ADMIN);

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
      ltv: 75_00,
      liqThreshold: 78_00,
      liqBonus: 4_50,
      reserveFactor: 10_00,
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

    address[] memory collateralAssets = new address[](1);
    address[] memory borrowableAssets = new address[](1);

    collateralAssets[0] = GhoPlasma.GHO_TOKEN;
    borrowableAssets[0] = AaveV3PlasmaAssets.USDT0_UNDERLYING;

    eModeCreations[0] = IAaveV3ConfigEngine.EModeCategoryCreation({
      ltv: 94_00,
      liqThreshold: 96_00,
      liqBonus: 2_00,
      label: 'GHO/USDT0',
      collaterals: collateralAssets,
      borrowables: borrowableAssets
    });

    collateralAssets[0] = AaveV3PlasmaAssets.syrupUSDT_UNDERLYING;
    borrowableAssets[0] = GhoPlasma.GHO_TOKEN;

    eModeCreations[1] = IAaveV3ConfigEngine.EModeCategoryCreation({
      ltv: 90_00,
      liqThreshold: 92_00,
      liqBonus: 4_00,
      label: 'syrupUSDT/GHO',
      collaterals: collateralAssets,
      borrowables: borrowableAssets
    });

    address[] memory collateralAssets_syrup = new address[](2);

    collateralAssets_syrup[0] = GhoPlasma.GHO_TOKEN;
    collateralAssets_syrup[1] = AaveV3PlasmaAssets.syrupUSDT_UNDERLYING;
    borrowableAssets[0] = AaveV3PlasmaAssets.USDT0_UNDERLYING;

    eModeCreations[2] = IAaveV3ConfigEngine.EModeCategoryCreation({
      ltv: 90_00,
      liqThreshold: 92_00,
      liqBonus: 4_00,
      label: 'syrupUSDT Stables',
      collaterals: collateralAssets_syrup,
      borrowables: borrowableAssets
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
      eModeCategory: 5,
      ltv: 85_90,
      liqThreshold: 87_90,
      liqBonus: EngineFlags.KEEP_CURRENT,
      label: EngineFlags.KEEP_CURRENT_STRING
    });

    eModeUpdates[1] = IAaveV3ConfigEngine.EModeCategoryUpdate({
      eModeCategory: 7,
      ltv: 84_40,
      liqThreshold: 86_40,
      liqBonus: EngineFlags.KEEP_CURRENT,
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
      collateral: EngineFlags.DISABLED
    });
    assetEModeUpdates[1] = IAaveV3ConfigEngine.AssetEModeUpdate({
      asset: GhoPlasma.GHO_TOKEN,
      eModeCategory: 5,
      borrowable: EngineFlags.ENABLED,
      collateral: EngineFlags.DISABLED
    });
    assetEModeUpdates[2] = IAaveV3ConfigEngine.AssetEModeUpdate({
      asset: GhoPlasma.GHO_TOKEN,
      eModeCategory: 7,
      borrowable: EngineFlags.ENABLED,
      collateral: EngineFlags.DISABLED
    });

    return assetEModeUpdates;
  }
}
