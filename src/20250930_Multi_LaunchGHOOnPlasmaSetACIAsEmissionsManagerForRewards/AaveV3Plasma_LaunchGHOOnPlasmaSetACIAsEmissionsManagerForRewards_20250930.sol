// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {SafeERC20} from 'openzeppelin-contracts/contracts/token/ERC20/utils/SafeERC20.sol';
import {AaveV3Plasma, AaveV3PlasmaAssets} from 'aave-address-book/AaveV3Plasma.sol';
import {AaveV3PayloadPlasma} from 'aave-helpers/src/v3-config-engine/AaveV3PayloadPlasma.sol';
// import {GhoPlasma} from 'aave-address-book/GhoPlasma.sol';
import {MiscPlasma} from 'aave-address-book/MiscPlasma.sol';
import {GovernanceV3Plasma} from 'aave-address-book/GovernanceV3Plasma.sol';
import {EngineFlags} from 'aave-v3-origin/contracts/extensions/v3-config-engine/EngineFlags.sol';
import {IAaveV3ConfigEngine} from 'aave-v3-origin/contracts/extensions/v3-config-engine/IAaveV3ConfigEngine.sol';
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
 * @title Add GHO and deploy GSM on Plasma. Migrate to new GSM on Ethereum
 * @author @TokenLogic
 * - Snapshot: https://snapshot.box/#/s:aavedao.eth/proposal/0xeb3572580924976867073ad9c8012cb9e52093c76dafebd7d3aebf318f2576fb
 * - Discussion: https://governance.aave.com/t/arfc-launch-gho-on-plasma-set-aci-as-emissions-manager-for-rewards/22994/6
 */
contract AaveV3Plasma_LaunchGHOOnPlasmaSetACIAsEmissionsManagerForRewards_20250930 is
  AaveV3PayloadPlasma
{
  using SafeERC20 for IERC20;

  // New GHO Token
  // https://plasmascan.to/address/0xb77E872A68C62CfC0dFb02C067Ecc3DA23B4bbf3
  address public constant GHO = 0xb77E872A68C62CfC0dFb02C067Ecc3DA23B4bbf3;

  // https://plasmascan.to/address/0xac140648435d03f784879cd789130F22Ef588Fcd
  address public constant GHO_LM_ADMIN = 0xac140648435d03f784879cd789130F22Ef588Fcd;

  // https://plasmascan.to/address/0xb0e1c7830aA781362f79225559Aa068E6bDaF1d1
  address public constant GHO_ORACLE = 0xb0e1c7830aA781362f79225559Aa068E6bDaF1d1;

  uint256 public constant GHO_SEED_AMOUNT = 1e18;

  // GhoReserve
  // https://plasmascan.to/address/0xBAdA742e7Ff54595F9049eeF1Cc5AaF4364988B9
  address public constant GHO_RESERVE = 0xBAdA742e7Ff54595F9049eeF1Cc5AaF4364988B9;
  uint256 public constant BRIDGED_AMOUNT = 50_000_000 ether;

  // Capacities
  uint128 public constant USDT_CAPACITY = 50_000_000 ether;

  // https://plasmascan.to/address/0x7cCC8a3DF66a2cDEa6c0629412378752Db5014EA
  address public constant NEW_GSM_USDT = 0x7cCC8a3DF66a2cDEa6c0629412378752Db5014EA;

  // https://plasmascan.to/address/0x2CF06F6116DE4da4f6d5541dF09981825820CE20
  address public constant USDT_ORACLE_SWAP_FREEZER = 0x2CF06F6116DE4da4f6d5541dF09981825820CE20;

  // https://plasmascan.to/address/0xD70BE7e6111EA563226cb8e53B1F195Da4E566E2
  address public constant FEE_STRATEGY = 0xD70BE7e6111EA563226cb8e53B1F195Da4E566E2;

  // https://etherscan.io/address/0x1cDF8879eC8bE012bA959EB515b11008E0cb6323
  address public constant ROBOT_OPERATOR = 0x1cDF8879eC8bE012bA959EB515b11008E0cb6323;
  uint96 public constant LINK_AMOUNT_ORACLE_FREEZER_KEEPER = 80 ether;
  uint32 public constant KEEPER_GAS_LIMIT = 150_000;

  bytes32 public immutable LIQUIDATOR_ROLE = IGsm(NEW_GSM_USDT).LIQUIDATOR_ROLE();
  bytes32 public immutable SWAP_FREEZER_ROLE = IGsm(NEW_GSM_USDT).SWAP_FREEZER_ROLE();

  function _preExecute() internal override {
    _grantAccess();
    _updateFeeStrategy();
    _registerOracles();

    IERC20(AaveV3PlasmaAssets.GHO).transfer(GHO_RESERVE, BRIDGED_AMOUNT);
  }

  function _grantAccess() internal {
    // Enroll GSMs as entities and set limit
    IGhoReserve(GHO_RESERVE).addEntity(NEW_GSM_USDT);
    IGhoReserve(GHO_RESERVE).setLimit(NEW_GSM_USDT, USDT_CAPACITY);

    // Allow risk council to control the bucket capacity
    address[] memory vaults = new address[](1);
    vaults[1] = NEW_GSM_USDT;
    IGhoBucketSteward(GhoPlasma.GHO_BUCKET_STEWARD).setControlledFacilitator(vaults, true);

    // Add GSM Swap Freezer role to OracleSwapFreezers
    IGsm(NEW_GSM_USDT).grantRole(SWAP_FREEZER_ROLE, USDT_ORACLE_SWAP_FREEZER);
    IGsm(NEW_GSM_USDT).grantRole(SWAP_FREEZER_ROLE, GovernanceV3Plasma.EXECUTOR_LVL_1);

    // Add GSMs to GSM Registry
    IGsmRegistry(GhoPlasma.GSM_REGISTRY).addGsm(NEW_GSM_USDT);

    // GHO GSM Steward
    IGsm(NEW_GSM_USDT).grantRole(IGsm(NEW_GSM_USDT).CONFIGURATOR_ROLE(), GhoPlasma.GHO_GSM_STEWARD);
  }

  function _updateFeeStrategy() internal {
    IGsm(NEW_GSM_USDT).updateFeeStrategy(FEE_STRATEGY);
  }

  function _registerOracles() internal {
    AaveV3Plasma.COLLECTOR.withdrawFromV3(
      CollectorUtils.IOInput({
        pool: address(AaveV3Plasma.POOL),
        underlying: AaveV3PlasmaAssets.LINK_UNDERLYING,
        amount: LINK_AMOUNT_ORACLE_FREEZER_KEEPER
      }),
      address(this)
    );
    IERC20(AaveV3PlasmaAssets.LINK_UNDERLYING).forceApprove(
      MiscPlasma.AAVE_CL_ROBOT_OPERATOR,
      LINK_AMOUNT_ORACLE_FREEZER_KEEPER
    );

    IAaveCLRobotOperator(MiscPlasma.AAVE_CL_ROBOT_OPERATOR).register(
      'GHO GSM 4626 stataUSDT OracleSwapFreezer',
      USDT_ORACLE_SWAP_FREEZER,
      '',
      KEEPER_GAS_LIMIT,
      LINK_AMOUNT_ORACLE_FREEZER_KEEPER,
      0,
      ''
    );
  }

  function _postExecute() internal override {
    IERC20(GHO).forceApprove(address(AaveV3Plasma.POOL), GHO_SEED_AMOUNT);
    AaveV3Plasma.POOL.supply(GHO, GHO_SEED_AMOUNT, AaveV3Plasma.DUST_BIN, 0);

    address aGHO = AaveV3Plasma.POOL.getReserveAToken(GHO);
    IEmissionManager(AaveV3Plasma.EMISSION_MANAGER).setEmissionAdmin(GHO, GHO_LM_ADMIN);
    IEmissionManager(AaveV3Plasma.EMISSION_MANAGER).setEmissionAdmin(aGHO, GHO_LM_ADMIN);
  }

  function newListings() public pure override returns (IAaveV3ConfigEngine.Listing[] memory) {
    IAaveV3ConfigEngine.Listing[] memory listings = new IAaveV3ConfigEngine.Listing[](1);

    listings[0] = IAaveV3ConfigEngine.Listing({
      asset: GHO,
      assetSymbol: 'GHO',
      priceFeed: GHO_ORACLE,
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

    collateralAssets[0] = GHO;
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
    borrowableAssets[0] = GHO;

    eModeCreations[0] = IAaveV3ConfigEngine.EModeCategoryCreation({
      ltv: 90_00,
      liqThreshold: 92_00,
      liqBonus: 4_00,
      label: 'syrupUSDT/GHO',
      collaterals: collateralAssets,
      borrowables: borrowableAssets
    });

    address[] memory collateralAssets_syrup = new address[](1);

    collateralAssets_syrup[0] = GHO;
    collateralAssets_syrup[1] = AaveV3PlasmaAssets.syrupUSDT_UNDERLYING;
    borrowableAssets[0] = AaveV3PlasmaAssets.USDT0_UNDERLYING;

    eModeCreations[0] = IAaveV3ConfigEngine.EModeCategoryCreation({
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
      asset: GHO,
      eModeCategory: 2,
      borrowable: EngineFlags.ENABLED,
      collateral: EngineFlags.DISABLED
    });
    assetEModeUpdates[1] = IAaveV3ConfigEngine.AssetEModeUpdate({
      asset: GHO,
      eModeCategory: 5,
      borrowable: EngineFlags.ENABLED,
      collateral: EngineFlags.DISABLED
    });
    assetEModeUpdates[2] = IAaveV3ConfigEngine.AssetEModeUpdate({
      asset: GHO,
      eModeCategory: 7,
      borrowable: EngineFlags.ENABLED,
      collateral: EngineFlags.DISABLED
    });

    return assetEModeUpdates;
  }
}
