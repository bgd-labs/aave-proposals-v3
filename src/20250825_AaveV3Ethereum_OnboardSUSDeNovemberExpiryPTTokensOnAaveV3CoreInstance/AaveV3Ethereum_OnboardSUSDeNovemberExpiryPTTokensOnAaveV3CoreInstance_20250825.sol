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
 * @title Onboard sUSDe November expiry PT tokens on Aave V3 Core Instance
 * @author Aave-Chan Initiative
 * - Snapshot: direct-to-AIP
 * - Discussion: https://governance.aave.com/t/direct-to-aip-onboard-susde-november-expiry-pt-tokens-on-aave-v3-core-instance/22894
 */
contract AaveV3Ethereum_OnboardSUSDeNovemberExpiryPTTokensOnAaveV3CoreInstance_20250825 is
  AaveV3PayloadEthereum
{
  using SafeERC20 for IERC20;

  address public constant PT_sUSDe_27NOV2025 = 0xe6A934089BBEe34F832060CE98848359883749B3;
  uint256 public constant PT_sUSDe_27NOV2025_SEED_AMOUNT = 100e18;
  address public constant PT_sUSDe_27NOV2025_LM_ADMIN = 0xac140648435d03f784879cd789130F22Ef588Fcd;

  function _postExecute() internal override {
    IERC20(PT_sUSDe_27NOV2025).forceApprove(
      address(AaveV3Ethereum.POOL),
      PT_sUSDe_27NOV2025_SEED_AMOUNT
    );
    AaveV3Ethereum.POOL.supply(
      PT_sUSDe_27NOV2025,
      PT_sUSDe_27NOV2025_SEED_AMOUNT,
      AaveV3Ethereum.DUST_BIN,
      0
    );

    address aPT_sUSDe_27NOV2025 = AaveV3Ethereum.POOL.getReserveAToken(PT_sUSDe_27NOV2025);
    IEmissionManager(AaveV3Ethereum.EMISSION_MANAGER).setEmissionAdmin(
      PT_sUSDe_27NOV2025,
      PT_sUSDe_27NOV2025_LM_ADMIN
    );
    IEmissionManager(AaveV3Ethereum.EMISSION_MANAGER).setEmissionAdmin(
      aPT_sUSDe_27NOV2025,
      PT_sUSDe_27NOV2025_LM_ADMIN
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

    address[] memory collateralAssets_PTSUSDeStablecoinsNov2025 = new address[](3);
    address[] memory borrowableAssets_PTSUSDeStablecoinsNov2025 = new address[](5);

    collateralAssets_PTSUSDeStablecoinsNov2025[0] = PT_sUSDe_27NOV2025;
    collateralAssets_PTSUSDeStablecoinsNov2025[1] = AaveV3EthereumAssets.sUSDe_UNDERLYING;
    collateralAssets_PTSUSDeStablecoinsNov2025[2] = AaveV3EthereumAssets
      .PT_sUSDE_25SEP2025_UNDERLYING;
    borrowableAssets_PTSUSDeStablecoinsNov2025[0] = AaveV3EthereumAssets.USDC_UNDERLYING;
    borrowableAssets_PTSUSDeStablecoinsNov2025[1] = AaveV3EthereumAssets.USDT_UNDERLYING;
    borrowableAssets_PTSUSDeStablecoinsNov2025[2] = AaveV3EthereumAssets.USDe_UNDERLYING;
    borrowableAssets_PTSUSDeStablecoinsNov2025[3] = AaveV3EthereumAssets.USDS_UNDERLYING;
    borrowableAssets_PTSUSDeStablecoinsNov2025[4] = AaveV3EthereumAssets.USDtb_UNDERLYING;

    eModeCreations[0] = IAaveV3ConfigEngine.EModeCategoryCreation({
      ltv: 86_10,
      liqThreshold: 88_10,
      liqBonus: 5_40,
      label: 'PT-sUSDe Stablecoins Nov 2025',
      collaterals: collateralAssets_PTSUSDeStablecoinsNov2025,
      borrowables: borrowableAssets_PTSUSDeStablecoinsNov2025
    });

    address[] memory collateralAssets_PTSUSDeUSDeNov2025 = new address[](2);
    address[] memory borrowableAssets_PTSUSDeUSDeNov2025 = new address[](1);

    collateralAssets_PTSUSDeUSDeNov2025[0] = PT_sUSDe_27NOV2025;
    collateralAssets_PTSUSDeUSDeNov2025[1] = AaveV3EthereumAssets.PT_sUSDE_25SEP2025_UNDERLYING;
    borrowableAssets_PTSUSDeUSDeNov2025[0] = AaveV3EthereumAssets.USDe_UNDERLYING;

    eModeCreations[1] = IAaveV3ConfigEngine.EModeCategoryCreation({
      ltv: 87_80,
      liqThreshold: 89_80,
      liqBonus: 3_40,
      label: 'PT-sUSDe USDe Nov 2025',
      collaterals: collateralAssets_PTSUSDeUSDeNov2025,
      borrowables: borrowableAssets_PTSUSDeUSDeNov2025
    });

    return eModeCreations;
  }
  function newListings() public pure override returns (IAaveV3ConfigEngine.Listing[] memory) {
    IAaveV3ConfigEngine.Listing[] memory listings = new IAaveV3ConfigEngine.Listing[](1);

    listings[0] = IAaveV3ConfigEngine.Listing({
      asset: PT_sUSDe_27NOV2025,
      assetSymbol: 'PT_sUSDe_27NOV2025',
      priceFeed: 0x8B8B73598a2c4b1de6d3b075618434CfC4826632,
      enabledToBorrow: EngineFlags.DISABLED,
      borrowableInIsolation: EngineFlags.DISABLED,
      withSiloedBorrowing: EngineFlags.DISABLED,
      flashloanable: EngineFlags.ENABLED,
      ltv: 5,
      liqThreshold: 10,
      liqBonus: 7_50,
      reserveFactor: 45_00,
      supplyCap: 75_000_000,
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
}
