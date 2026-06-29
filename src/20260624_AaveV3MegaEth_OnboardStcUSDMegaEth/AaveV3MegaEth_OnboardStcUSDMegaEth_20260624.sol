// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3MegaEth, AaveV3MegaEthAssets} from 'aave-address-book/AaveV3MegaEth.sol';
import {AaveV3PayloadMegaEth} from 'aave-helpers/src/v3-config-engine/AaveV3PayloadMegaEth.sol';
import {EngineFlags} from 'aave-v3-origin/contracts/extensions/v3-config-engine/EngineFlags.sol';
import {IAaveV3ConfigEngine} from 'aave-v3-origin/contracts/extensions/v3-config-engine/IAaveV3ConfigEngine.sol';
import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {SafeERC20} from 'openzeppelin-contracts/contracts/token/ERC20/utils/SafeERC20.sol';
import {IEmissionManager} from 'aave-v3-origin/contracts/rewards/interfaces/IEmissionManager.sol';

/**
 * @title OnboardStcUSDMegaEth
 * @author Aave Labs
 * - Snapshot: https://snapshot.org/#/s:aavedao.eth/proposal/0x84ccc14e104b18a74ef47375ccd59f7f7aeeb61716dbb2c362ea7a538da3e08f
 * - Discussion: https://governance.aave.com/t/arfc-onboard-stcusd-to-aave-v3-megaeth/25018
 */
contract AaveV3MegaEth_OnboardStcUSDMegaEth_20260624 is AaveV3PayloadMegaEth {
  using SafeERC20 for IERC20;

  // https://mega.etherscan.io/address/0x88887bE419578051FF9F4eb6C858A951921D8888
  address public constant stcUSD = 0x88887bE419578051FF9F4eb6C858A951921D8888;
  uint256 public constant stcUSD_SEED_AMOUNT = 1e18;
  // https://mega.etherscan.io/address/0xBBC579Ee0A3fD6E9240965C5f57b7e5b3e3809A8
  address public constant stcUSD_PRICE_FEED = 0xBBC579Ee0A3fD6E9240965C5f57b7e5b3e3809A8;

  function _postExecute() internal override {
    _supplyAndConfigureLMAdmin(stcUSD, stcUSD_SEED_AMOUNT, address(0));
  }

  function newListings() public pure override returns (IAaveV3ConfigEngine.Listing[] memory) {
    IAaveV3ConfigEngine.Listing[] memory listings = new IAaveV3ConfigEngine.Listing[](1);

    listings[0] = IAaveV3ConfigEngine.Listing({
      asset: stcUSD,
      assetSymbol: 'stcUSD',
      priceFeed: stcUSD_PRICE_FEED,
      enabledToBorrow: EngineFlags.DISABLED,
      flashloanable: EngineFlags.DISABLED,
      ltv: 0,
      liqThreshold: 0,
      liqBonus: 0,
      reserveFactor: EngineFlags.KEEP_CURRENT,
      supplyCap: 10_000_000,
      borrowCap: 1,
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
    IERC20(asset).forceApprove(address(AaveV3MegaEth.POOL), seedAmount);
    AaveV3MegaEth.POOL.supply(asset, seedAmount, address(AaveV3MegaEth.DUST_BIN), 0);

    if (lmAdmin != address(0)) {
      address aToken = AaveV3MegaEth.POOL.getReserveAToken(asset);
      address vToken = AaveV3MegaEth.POOL.getReserveVariableDebtToken(asset);
      IEmissionManager(AaveV3MegaEth.EMISSION_MANAGER).setEmissionAdmin(asset, lmAdmin);
      IEmissionManager(AaveV3MegaEth.EMISSION_MANAGER).setEmissionAdmin(aToken, lmAdmin);
      IEmissionManager(AaveV3MegaEth.EMISSION_MANAGER).setEmissionAdmin(vToken, lmAdmin);
    }
  }
  function eModeCategoryCreations()
    public
    pure
    override
    returns (IAaveV3ConfigEngine.EModeCategoryCreation[] memory)
  {
    IAaveV3ConfigEngine.EModeCategoryCreation[]
      memory eModeCreations = new IAaveV3ConfigEngine.EModeCategoryCreation[](1);

    address[] memory collateralAssets_StcUSD__Stablecoins = new address[](1);
    address[] memory borrowableAssets_StcUSD__Stablecoins = new address[](2);

    collateralAssets_StcUSD__Stablecoins[0] = stcUSD;
    borrowableAssets_StcUSD__Stablecoins[0] = AaveV3MegaEthAssets.USDT0_UNDERLYING;
    borrowableAssets_StcUSD__Stablecoins[1] = AaveV3MegaEthAssets.USDm_UNDERLYING;

    eModeCreations[0] = IAaveV3ConfigEngine.EModeCategoryCreation({
      ltv: 88_00,
      liqThreshold: 90_00,
      liqBonus: 4_00,
      label: 'stcUSD__Stablecoins',
      isolated: true,
      collaterals: collateralAssets_StcUSD__Stablecoins,
      borrowables: borrowableAssets_StcUSD__Stablecoins
    });

    return eModeCreations;
  }
}
