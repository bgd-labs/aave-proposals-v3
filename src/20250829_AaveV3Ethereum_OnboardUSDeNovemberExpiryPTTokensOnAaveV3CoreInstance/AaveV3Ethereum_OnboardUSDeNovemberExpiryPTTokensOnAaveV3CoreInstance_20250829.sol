// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {AaveV3PayloadEthereum} from 'aave-helpers/src/v3-config-engine/AaveV3PayloadEthereum.sol';
import {EngineFlags} from 'aave-v3-origin/contracts/extensions/v3-config-engine/EngineFlags.sol';
import {IAaveV3ConfigEngine, IPool} from 'aave-v3-origin/contracts/extensions/v3-config-engine/IAaveV3ConfigEngine.sol';
import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {SafeERC20} from 'openzeppelin-contracts/contracts/token/ERC20/utils/SafeERC20.sol';
import {IEmissionManager} from 'aave-v3-origin/contracts/rewards/interfaces/IEmissionManager.sol';
import {IAaveStewardInjector} from '../interfaces/IAaveStewardInjector.sol';
/**
 * @title Onboard USDe November expiry PT tokens on Aave V3 Core Instance
 * @author Aave-Chan Initiative
 * - Snapshot: direct-to-AIP
 * - Discussion: https://governance.aave.com/t/direct-to-aip-onboard-usde-november-expiry-pt-tokens-on-aave-v3-core-instance/23013
 */
contract AaveV3Ethereum_OnboardUSDeNovemberExpiryPTTokensOnAaveV3CoreInstance_20250829 is
  AaveV3PayloadEthereum
{
  using SafeERC20 for IERC20;

  address public constant PT_USDe_27NOV2025 = 0x62C6E813b9589C3631Ba0Cdb013acdB8544038B7;
  uint256 public constant PT_USDe_27NOV2025_SEED_AMOUNT = 100e18;
  address public constant PT_USDe_27NOV2025_LM_ADMIN = 0xac140648435d03f784879cd789130F22Ef588Fcd;

  function _postExecute() internal override {
    // we whitelist the two newly created eModeId on the injector
    uint8 nextID = _findFirstUnusedEmodeCategory(AaveV3Ethereum.POOL);
    address[] memory marketsToWhitelist = new address[](2);
    marketsToWhitelist[0] = address(uint160(nextID - 1)); // on the injector we encode eModeId to address
    marketsToWhitelist[1] = address(uint160(nextID - 2)); // on the injector we encode eModeId to address
    IAaveStewardInjector(AaveV3Ethereum.EDGE_INJECTOR_PENDLE_EMODE).addMarkets(marketsToWhitelist);

    address[] memory assetToWhitelist = new address[](1);
    assetToWhitelist[0] = PT_USDe_27NOV2025;
    IAaveStewardInjector(AaveV3Ethereum.EDGE_INJECTOR_DISCOUNT_RATE).addMarkets(assetToWhitelist);
    IERC20(PT_USDe_27NOV2025).forceApprove(
      address(AaveV3Ethereum.POOL),
      PT_USDe_27NOV2025_SEED_AMOUNT
    );

    AaveV3Ethereum.POOL.supply(
      PT_USDe_27NOV2025,
      PT_USDe_27NOV2025_SEED_AMOUNT,
      AaveV3Ethereum.DUST_BIN,
      0
    );

    address aPT_USDe_27NOV2025 = AaveV3Ethereum.POOL.getReserveAToken(PT_USDe_27NOV2025);
    IEmissionManager(AaveV3Ethereum.EMISSION_MANAGER).setEmissionAdmin(
      PT_USDe_27NOV2025,
      PT_USDe_27NOV2025_LM_ADMIN
    );
    IEmissionManager(AaveV3Ethereum.EMISSION_MANAGER).setEmissionAdmin(
      aPT_USDe_27NOV2025,
      PT_USDe_27NOV2025_LM_ADMIN
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

    address[] memory collateralAssets_PTUSDeStablecoinsNov2025 = new address[](2);
    address[] memory borrowableAssets_PTUSDeStablecoinsNov2025 = new address[](5);

    collateralAssets_PTUSDeStablecoinsNov2025[0] = PT_USDe_27NOV2025;
    collateralAssets_PTUSDeStablecoinsNov2025[1] = AaveV3EthereumAssets
      .PT_USDe_25SEP2025_UNDERLYING;
    borrowableAssets_PTUSDeStablecoinsNov2025[0] = AaveV3EthereumAssets.USDC_UNDERLYING;
    borrowableAssets_PTUSDeStablecoinsNov2025[1] = AaveV3EthereumAssets.USDT_UNDERLYING;
    borrowableAssets_PTUSDeStablecoinsNov2025[2] = AaveV3EthereumAssets.USDe_UNDERLYING;
    borrowableAssets_PTUSDeStablecoinsNov2025[3] = AaveV3EthereumAssets.USDS_UNDERLYING;
    borrowableAssets_PTUSDeStablecoinsNov2025[4] = AaveV3EthereumAssets.USDtb_UNDERLYING;

    eModeCreations[0] = IAaveV3ConfigEngine.EModeCategoryCreation({
      ltv: 87_80,
      liqThreshold: 89_80,
      liqBonus: 4_20,
      label: 'PT-USDe Stablecoins Nov 2025',
      collaterals: collateralAssets_PTUSDeStablecoinsNov2025,
      borrowables: borrowableAssets_PTUSDeStablecoinsNov2025
    });

    address[] memory collateralAssets_PTUSDeUSDeNov2025 = new address[](2);
    address[] memory borrowableAssets_PTUSDeUSDeNov2025 = new address[](1);

    collateralAssets_PTUSDeUSDeNov2025[0] = PT_USDe_27NOV2025;
    collateralAssets_PTUSDeUSDeNov2025[1] = AaveV3EthereumAssets.PT_USDe_25SEP2025_UNDERLYING;
    borrowableAssets_PTUSDeUSDeNov2025[0] = AaveV3EthereumAssets.USDe_UNDERLYING;

    eModeCreations[1] = IAaveV3ConfigEngine.EModeCategoryCreation({
      ltv: 88_60,
      liqThreshold: 90_60,
      liqBonus: 3_20,
      label: 'PT-USDe USDe Nov 2025',
      collaterals: collateralAssets_PTUSDeUSDeNov2025,
      borrowables: borrowableAssets_PTUSDeUSDeNov2025
    });

    return eModeCreations;
  }
  function newListings() public pure override returns (IAaveV3ConfigEngine.Listing[] memory) {
    IAaveV3ConfigEngine.Listing[] memory listings = new IAaveV3ConfigEngine.Listing[](1);

    listings[0] = IAaveV3ConfigEngine.Listing({
      asset: PT_USDe_27NOV2025,
      assetSymbol: 'PT_USDe_27NOV2025',
      priceFeed: 0x6A196A7B498C4EFBFEfB55364106EC80CceF0C3F,
      enabledToBorrow: EngineFlags.DISABLED,
      borrowableInIsolation: EngineFlags.DISABLED,
      withSiloedBorrowing: EngineFlags.DISABLED,
      flashloanable: EngineFlags.ENABLED,
      ltv: 5,
      liqThreshold: 10,
      liqBonus: 7_50,
      reserveFactor: 45_00,
      supplyCap: 50_000_000,
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
