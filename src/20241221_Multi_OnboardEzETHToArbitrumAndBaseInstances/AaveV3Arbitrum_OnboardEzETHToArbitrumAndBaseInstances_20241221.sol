// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Arbitrum, AaveV3ArbitrumAssets, AaveV3ArbitrumEModes} from 'aave-address-book/AaveV3Arbitrum.sol';
import {AaveV3PayloadArbitrum} from 'aave-helpers/src/v3-config-engine/AaveV3PayloadArbitrum.sol';
import {EngineFlags} from 'aave-v3-origin/contracts/extensions/v3-config-engine/EngineFlags.sol';
import {IAaveV3ConfigEngine} from 'aave-v3-origin/contracts/extensions/v3-config-engine/IAaveV3ConfigEngine.sol';
import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {SafeERC20} from 'solidity-utils/contracts/oz-common/SafeERC20.sol';
import {IEmissionManager} from 'aave-v3-origin/contracts/rewards/interfaces/IEmissionManager.sol';
/**
 * @title Onboard ezETH to Arbitrum and Base Instances
 * @author Aave Chan Initiative
 * - Snapshot: https://snapshot.box/#/s:aave.eth/proposal/0xf9fa710414237636cba11187111773fac04f74eb1a562d2b50fca86cb72a778e
 * - Discussion: https://governance.aave.com/t/arfc-onboard-ezeth-to-arbitrum-and-base-instances/19622
 */
contract AaveV3Arbitrum_OnboardEzETHToArbitrumAndBaseInstances_20241221 is AaveV3PayloadArbitrum {
  using SafeERC20 for IERC20;

  address public constant ezETH = 0x2416092f143378750bb29b79eD961ab195CcEea5;
  uint256 public constant ezETH_SEED_AMOUNT = 3e16;
  address public constant ezETH_LM_ADMIN = 0xac140648435d03f784879cd789130F22Ef588Fcd;

  function _postExecute() internal override {
    IERC20(ezETH).forceApprove(address(AaveV3Arbitrum.POOL), ezETH_SEED_AMOUNT);
    AaveV3Arbitrum.POOL.supply(ezETH, ezETH_SEED_AMOUNT, address(AaveV3Arbitrum.COLLECTOR), 0);

    (address aezETH, , ) = AaveV3Arbitrum.AAVE_PROTOCOL_DATA_PROVIDER.getReserveTokensAddresses(
      ezETH
    );
    IEmissionManager(AaveV3Arbitrum.EMISSION_MANAGER).setEmissionAdmin(ezETH, ezETH_LM_ADMIN);
    IEmissionManager(AaveV3Arbitrum.EMISSION_MANAGER).setEmissionAdmin(aezETH, ezETH_LM_ADMIN);
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
      eModeCategory: 3,
      ltv: 93_00,
      liqThreshold: 95_00,
      liqBonus: 1_00,
      label: 'ezETH wstETH'
    });

    eModeUpdates[1] = IAaveV3ConfigEngine.EModeCategoryUpdate({
      eModeCategory: 4,
      ltv: 72_00,
      liqThreshold: 75_00,
      liqBonus: 7_50,
      label: 'ezETH Stablecoins'
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
      memory assetEModeUpdates = new IAaveV3ConfigEngine.AssetEModeUpdate[](5);

    assetEModeUpdates[0] = IAaveV3ConfigEngine.AssetEModeUpdate({
      asset: ezETH,
      eModeCategory: 3,
      borrowable: EngineFlags.DISABLED,
      collateral: EngineFlags.ENABLED
    });
    assetEModeUpdates[1] = IAaveV3ConfigEngine.AssetEModeUpdate({
      asset: ezETH,
      eModeCategory: 4,
      borrowable: EngineFlags.DISABLED,
      collateral: EngineFlags.ENABLED
    });
    assetEModeUpdates[2] = IAaveV3ConfigEngine.AssetEModeUpdate({
      asset: AaveV3ArbitrumAssets.wstETH_UNDERLYING,
      eModeCategory: 3,
      borrowable: EngineFlags.ENABLED,
      collateral: EngineFlags.DISABLED
    });
    assetEModeUpdates[3] = IAaveV3ConfigEngine.AssetEModeUpdate({
      asset: AaveV3ArbitrumAssets.USDT_UNDERLYING,
      eModeCategory: 4,
      borrowable: EngineFlags.ENABLED,
      collateral: EngineFlags.DISABLED
    });
    assetEModeUpdates[4] = IAaveV3ConfigEngine.AssetEModeUpdate({
      asset: AaveV3ArbitrumAssets.USDCn_UNDERLYING,
      eModeCategory: 4,
      borrowable: EngineFlags.ENABLED,
      collateral: EngineFlags.DISABLED
    });

    return assetEModeUpdates;
  }
  function newListings() public pure override returns (IAaveV3ConfigEngine.Listing[] memory) {
    IAaveV3ConfigEngine.Listing[] memory listings = new IAaveV3ConfigEngine.Listing[](1);

    listings[0] = IAaveV3ConfigEngine.Listing({
      asset: ezETH,
      assetSymbol: 'ezETH',
      priceFeed: 0x8Ed37B72300683c0482A595bfa80fFb793874b15,
      enabledToBorrow: EngineFlags.DISABLED,
      borrowableInIsolation: EngineFlags.DISABLED,
      withSiloedBorrowing: EngineFlags.DISABLED,
      flashloanable: EngineFlags.ENABLED,
      ltv: 5,
      liqThreshold: 10,
      liqBonus: 7_50,
      reserveFactor: 15_00,
      supplyCap: 1_750,
      borrowCap: 1,
      debtCeiling: 0,
      liqProtocolFee: 10_00,
      rateStrategyParams: IAaveV3ConfigEngine.InterestRateInputData({
        optimalUsageRatio: 45_00,
        baseVariableBorrowRate: 0,
        variableRateSlope1: 7_00,
        variableRateSlope2: 300_00
      })
    });

    return listings;
  }
}
