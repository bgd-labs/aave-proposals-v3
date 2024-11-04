// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3BNB, AaveV3BNBAssets} from 'aave-address-book/AaveV3BNB.sol';
import {AaveV3PayloadBNB} from 'aave-helpers/src/v3-config-engine/AaveV3PayloadBNB.sol';
import {EngineFlags} from 'aave-v3-origin/contracts/extensions/v3-config-engine/EngineFlags.sol';
import {IAaveV3ConfigEngine} from 'aave-v3-origin/contracts/extensions/v3-config-engine/IAaveV3ConfigEngine.sol';
import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {SafeERC20} from 'solidity-utils/contracts/oz-common/SafeERC20.sol';
import {IEmissionManager} from 'aave-v3-origin/contracts/rewards/interfaces/IEmissionManager.sol';
/**
 * @title Onboard wstETH to Aave V3 on BNB Chain
 * @author ACI
 * - Snapshot: https://snapshot.org/#/aave.eth/proposal/0x752c396a86f1f9b60d3e43b7ed223d9d2f66014e03b6b3eb7ac59e8a169d1fe5
 * - Discussion: https://governance.aave.com/t/arfc-onboard-wsteth-to-aave-v3-on-bnb-chain/18501
 */
contract AaveV3BNB_OnboardWstETHToAaveV3OnBNBChain_20241030 is AaveV3PayloadBNB {
  using SafeERC20 for IERC20;

  address public constant wstETH = 0x26c5e01524d2E6280A48F2c50fF6De7e52E9611C;
  uint256 public constant wstETH_SEED_AMOUNT = 4e16;
  address public constant wstETH_LM_ADMIN = 0xac140648435d03f784879cd789130F22Ef588Fcd;

  function _postExecute() internal override {
    IERC20(wstETH).forceApprove(address(AaveV3BNB.POOL), wstETH_SEED_AMOUNT);
    AaveV3BNB.POOL.supply(wstETH, wstETH_SEED_AMOUNT, address(AaveV3BNB.COLLECTOR), 0);

    (address awstETH, , ) = AaveV3BNB.AAVE_PROTOCOL_DATA_PROVIDER.getReserveTokensAddresses(wstETH);
    IEmissionManager(AaveV3BNB.EMISSION_MANAGER).setEmissionAdmin(wstETH, wstETH_LM_ADMIN);
    IEmissionManager(AaveV3BNB.EMISSION_MANAGER).setEmissionAdmin(awstETH, wstETH_LM_ADMIN);
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
      eModeCategory: 1,
      ltv: 93_00,
      liqThreshold: 95_00,
      liqBonus: 1_00,
      label: 'ETH-Correlated'
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
      asset: AaveV3BNBAssets.ETH_UNDERLYING,
      eModeCategory: 1,
      borrowable: EngineFlags.ENABLED,
      collateral: EngineFlags.DISABLED
    });

    assetEModeUpdates[1] = IAaveV3ConfigEngine.AssetEModeUpdate({
      asset: wstETH,
      eModeCategory: 1,
      borrowable: EngineFlags.DISABLED,
      collateral: EngineFlags.ENABLED
    });

    return assetEModeUpdates;
  }
  function newListings() public pure override returns (IAaveV3ConfigEngine.Listing[] memory) {
    IAaveV3ConfigEngine.Listing[] memory listings = new IAaveV3ConfigEngine.Listing[](1);

    listings[0] = IAaveV3ConfigEngine.Listing({
      asset: wstETH,
      assetSymbol: 'wstETH',
      priceFeed: 0xc1377B4cdF9116bf7b3d7F72A4f8A7Be8506cE80,
      enabledToBorrow: EngineFlags.ENABLED,
      borrowableInIsolation: EngineFlags.DISABLED,
      withSiloedBorrowing: EngineFlags.DISABLED,
      flashloanable: EngineFlags.ENABLED,
      ltv: 72_00,
      liqThreshold: 75_00,
      liqBonus: 7_50,
      reserveFactor: 15_00,
      supplyCap: 1_900,
      borrowCap: 190,
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
