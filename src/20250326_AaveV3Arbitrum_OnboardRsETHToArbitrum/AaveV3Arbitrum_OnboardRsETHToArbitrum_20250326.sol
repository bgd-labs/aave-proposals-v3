// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Arbitrum, AaveV3ArbitrumAssets} from 'aave-address-book/AaveV3Arbitrum.sol';
import {AaveV3PayloadArbitrum} from 'aave-helpers/src/v3-config-engine/AaveV3PayloadArbitrum.sol';
import {EngineFlags} from 'aave-v3-origin/contracts/extensions/v3-config-engine/EngineFlags.sol';
import {IAaveV3ConfigEngine} from 'aave-v3-origin/contracts/extensions/v3-config-engine/IAaveV3ConfigEngine.sol';
import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {SafeERC20} from 'openzeppelin-contracts/contracts/token/ERC20/utils/SafeERC20.sol';
import {IEmissionManager} from 'aave-v3-origin/contracts/rewards/interfaces/IEmissionManager.sol';
/**
 * @title  Onboard rsETH to Arbitrum
 * @author Aave-Chan Initiative
 * - Snapshot: https://snapshot.box/#/s:aave.eth/proposal/0x598f7057f445813d75404fae68f3501d76c90064f52ca4b9afb6f20859fa2658
 * - Discussion: https://governance.aave.com/t/arfc-onboard-rseth-to-arbitrum-and-base-v3-instances/20741
 */
contract AaveV3Arbitrum_OnboardRsETHToArbitrum_20250326 is AaveV3PayloadArbitrum {
  using SafeERC20 for IERC20;

  address public constant rsETH = 0x4186BFC76E2E237523CBC30FD220FE055156b41F;
  uint256 public constant rsETH_SEED_AMOUNT = 35e15;
  address public constant rsETH_LM_ADMIN = 0xac140648435d03f784879cd789130F22Ef588Fcd;

  function _postExecute() internal override {
    IERC20(rsETH).forceApprove(address(AaveV3Arbitrum.POOL), rsETH_SEED_AMOUNT);
    AaveV3Arbitrum.POOL.supply(rsETH, rsETH_SEED_AMOUNT, AaveV3Arbitrum.DUST_BIN, 0);

    address arsETH = AaveV3Arbitrum.POOL.getReserveAToken(rsETH);
    IEmissionManager(AaveV3Arbitrum.EMISSION_MANAGER).setEmissionAdmin(rsETH, rsETH_LM_ADMIN);
    IEmissionManager(AaveV3Arbitrum.EMISSION_MANAGER).setEmissionAdmin(arsETH, rsETH_LM_ADMIN);
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
      eModeCategory: 5,
      ltv: 92_50,
      liqThreshold: 94_50,
      liqBonus: 1_00,
      label: 'rsETH wstETH'
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
      asset: AaveV3ArbitrumAssets.wstETH_UNDERLYING,
      eModeCategory: 5,
      borrowable: EngineFlags.ENABLED,
      collateral: EngineFlags.DISABLED
    });
    assetEModeUpdates[1] = IAaveV3ConfigEngine.AssetEModeUpdate({
      asset: rsETH,
      eModeCategory: 5,
      borrowable: EngineFlags.DISABLED,
      collateral: EngineFlags.ENABLED
    });

    return assetEModeUpdates;
  }

  function newListings() public pure override returns (IAaveV3ConfigEngine.Listing[] memory) {
    IAaveV3ConfigEngine.Listing[] memory listings = new IAaveV3ConfigEngine.Listing[](1);

    listings[0] = IAaveV3ConfigEngine.Listing({
      asset: rsETH,
      assetSymbol: 'rsETH',
      priceFeed: 0xb4B0cbcA864c2Eb0C0342608D92490C034aC1089,
      enabledToBorrow: EngineFlags.DISABLED,
      borrowableInIsolation: EngineFlags.DISABLED,
      withSiloedBorrowing: EngineFlags.DISABLED,
      flashloanable: EngineFlags.ENABLED,
      ltv: 5,
      liqThreshold: 10,
      liqBonus: 7_50,
      reserveFactor: 20_00,
      supplyCap: 900,
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
