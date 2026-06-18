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
 * @title OnBoardPTsrUSDe22Oct2026EthereumCore
 * @author Aave Labs
 * - Snapshot: direct-to-aip
 * - Discussion: https://governance.aave.com/t/direct-to-aip-onboard-strata-srusde-22oct2026-pt-tokens-to-v3-core-instance/25113
 */
contract AaveV3Ethereum_OnBoardPTsrUSDe22Oct2026EthereumCore_20260617 is AaveV3PayloadEthereum {
  using SafeERC20 for IERC20;

  // https://etherscan.io/address/0x59bC9FaE5D62B19d4f8d07D758047aCb9EE19d34
  address public constant PT_srUSDe_22OCT2026 = 0x59bC9FaE5D62B19d4f8d07D758047aCb9EE19d34;
  uint256 public constant PT_srUSDe_22OCT2026_SEED_AMOUNT = 1e18;
  // https://etherscan.io/address/0xBD1bc41479D0b58167584980fE57fDA913d4fB73
  address public constant PT_srUSDe_22OCT2026_PRICE_FEED =
    0xBD1bc41479D0b58167584980fE57fDA913d4fB73;

  function _postExecute() internal override {
    _supplyAndConfigureLMAdmin(PT_srUSDe_22OCT2026, PT_srUSDe_22OCT2026_SEED_AMOUNT, address(0));
  }

  function newListings() public pure override returns (IAaveV3ConfigEngine.Listing[] memory) {
    IAaveV3ConfigEngine.Listing[] memory listings = new IAaveV3ConfigEngine.Listing[](1);

    listings[0] = IAaveV3ConfigEngine.Listing({
      asset: PT_srUSDe_22OCT2026,
      assetSymbol: 'PT_srUSDe_22OCT2026',
      priceFeed: PT_srUSDe_22OCT2026_PRICE_FEED,
      enabledToBorrow: EngineFlags.DISABLED,
      flashloanable: EngineFlags.DISABLED,
      ltv: 0,
      liqThreshold: 0,
      liqBonus: 0,
      reserveFactor: 45_00,
      supplyCap: 25_000_000,
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
    IERC20(asset).forceApprove(address(AaveV3Ethereum.POOL), seedAmount);
    AaveV3Ethereum.POOL.supply(asset, seedAmount, address(AaveV3Ethereum.DUST_BIN), 0);

    if (lmAdmin != address(0)) {
      address aToken = AaveV3Ethereum.POOL.getReserveAToken(asset);
      address vToken = AaveV3Ethereum.POOL.getReserveVariableDebtToken(asset);
      IEmissionManager(AaveV3Ethereum.EMISSION_MANAGER).setEmissionAdmin(asset, lmAdmin);
      IEmissionManager(AaveV3Ethereum.EMISSION_MANAGER).setEmissionAdmin(aToken, lmAdmin);
      IEmissionManager(AaveV3Ethereum.EMISSION_MANAGER).setEmissionAdmin(vToken, lmAdmin);
    }
  }
  function eModeCategoryCreations()
    public
    pure
    override
    returns (IAaveV3ConfigEngine.EModeCategoryCreation[] memory)
  {
    IAaveV3ConfigEngine.EModeCategoryCreation[]
      memory eModeCreations = new IAaveV3ConfigEngine.EModeCategoryCreation[](2);

    address[] memory collateralAssets_PTSrUSDeStablecoins = new address[](2);
    address[] memory borrowableAssets_PTSrUSDeStablecoins = new address[](3);

    collateralAssets_PTSrUSDeStablecoins[0] = AaveV3EthereumAssets.sUSDe_UNDERLYING;
    collateralAssets_PTSrUSDeStablecoins[1] = PT_srUSDe_22OCT2026;
    borrowableAssets_PTSrUSDeStablecoins[0] = AaveV3EthereumAssets.USDC_UNDERLYING;
    borrowableAssets_PTSrUSDeStablecoins[1] = AaveV3EthereumAssets.USDT_UNDERLYING;
    borrowableAssets_PTSrUSDeStablecoins[2] = AaveV3EthereumAssets.USDe_UNDERLYING;

    eModeCreations[0] = IAaveV3ConfigEngine.EModeCategoryCreation({
      ltv: 88_42,
      liqThreshold: 90_42,
      liqBonus: 5_68,
      label: 'PT-srUSDe Stablecoins',
      isolated: true,
      collaterals: collateralAssets_PTSrUSDeStablecoins,
      borrowables: borrowableAssets_PTSrUSDeStablecoins
    });

    address[] memory collateralAssets_PTSrUSDeUSDe = new address[](2);
    address[] memory borrowableAssets_PTSrUSDeUSDe = new address[](1);

    collateralAssets_PTSrUSDeUSDe[0] = AaveV3EthereumAssets.sUSDe_UNDERLYING;
    collateralAssets_PTSrUSDeUSDe[1] = PT_srUSDe_22OCT2026;
    borrowableAssets_PTSrUSDeUSDe[0] = AaveV3EthereumAssets.USDe_UNDERLYING;

    eModeCreations[1] = IAaveV3ConfigEngine.EModeCategoryCreation({
      ltv: 91_06,
      liqThreshold: 93_06,
      liqBonus: 2_68,
      label: 'PT-srUSDe USDe',
      isolated: true,
      collaterals: collateralAssets_PTSrUSDeUSDe,
      borrowables: borrowableAssets_PTSrUSDeUSDe
    });

    return eModeCreations;
  }
}
