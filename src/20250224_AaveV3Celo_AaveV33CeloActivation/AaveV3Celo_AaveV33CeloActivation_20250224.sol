// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Celo} from 'aave-address-book/AaveV3Celo.sol';
import {MiscCelo} from 'aave-address-book/MiscCelo.sol';
import {AaveV3PayloadCelo} from 'aave-helpers/src/v3-config-engine/AaveV3PayloadCelo.sol';
import {EngineFlags} from 'aave-v3-origin/contracts/extensions/v3-config-engine/EngineFlags.sol';
import {IAaveV3ConfigEngine} from 'aave-v3-origin/contracts/extensions/v3-config-engine/IAaveV3ConfigEngine.sol';
import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {IEmissionManager} from 'aave-v3-origin/contracts/rewards/interfaces/IEmissionManager.sol';
import {SafeERC20} from 'openzeppelin-contracts/contracts/token/ERC20/utils/SafeERC20.sol';

/**
 * @title Aave V3.3 Celo Activation
 * @author BGD Labs (@bgdlabs)
 * - Snapshot: https://snapshot.box/#/aave.eth/proposal/0x645981c18f5dc61c07324a39d57bcb873ebd8fb9e4a435280cac57cb07a8090b
 * - Discussion: https://governance.aave.com/t/arfc-aave-deployment-on-celo/17636
 */
contract AaveV3Celo_AaveV33CeloActivation_20250224 is AaveV3PayloadCelo {
  using SafeERC20 for IERC20;

  address public constant USDC = 0xcebA9300f2b948710d2653dD7B07f33A8B32118C;
  uint256 public constant USDC_SEED_AMOUNT = 10e6;

  address public constant USDT = 0x48065fbBE25f71C9282ddf5e1cD6D6A887483D5e;
  uint256 public constant USDT_SEED_AMOUNT = 10e6;

  address public constant cEUR = 0xD8763CBa276a3738E6DE85b4b3bF5FDed6D6cA73;
  uint256 public constant cEUR_SEED_AMOUNT = 10e18;

  address public constant cUSD = 0x765DE816845861e75A25fCA122bb6898B8B1282a;
  uint256 public constant cUSD_SEED_AMOUNT = 10e18;

  address public constant CELO = 0x471EcE3750Da237f93B8E339c536989b8978a438;
  uint256 public constant CELO_SEED_AMOUNT = 10e18;

  address public constant LM_ADMIN = 0xac140648435d03f784879cd789130F22Ef588Fcd;

  function _postExecute() internal override {
    _supplyAndConfigureLMAdmin(USDC, USDC_SEED_AMOUNT);
    _supplyAndConfigureLMAdmin(USDT, USDT_SEED_AMOUNT);
    _supplyAndConfigureLMAdmin(cEUR, cEUR_SEED_AMOUNT);
    _supplyAndConfigureLMAdmin(cUSD, cUSD_SEED_AMOUNT);
    _supplyAndConfigureLMAdmin(CELO, CELO_SEED_AMOUNT);

    AaveV3Celo.ACL_MANAGER.addPoolAdmin(MiscCelo.PROTOCOL_GUARDIAN);
    AaveV3Celo.ACL_MANAGER.addRiskAdmin(AaveV3Celo.RISK_STEWARD);
  }

  function newListings() public pure override returns (IAaveV3ConfigEngine.Listing[] memory) {
    IAaveV3ConfigEngine.Listing[] memory listings = new IAaveV3ConfigEngine.Listing[](5);

    listings[0] = IAaveV3ConfigEngine.Listing({
      asset: USDC,
      assetSymbol: 'USDC',
      priceFeed: 0xBF704f2FfdB856805cE64D085cD50427823696D7,
      enabledToBorrow: EngineFlags.ENABLED,
      borrowableInIsolation: EngineFlags.ENABLED,
      withSiloedBorrowing: EngineFlags.DISABLED,
      flashloanable: EngineFlags.ENABLED,
      ltv: 75_00,
      liqThreshold: 78_00,
      liqBonus: 5_00,
      reserveFactor: 10_00,
      supplyCap: 3_500_000,
      borrowCap: 3_150_000,
      debtCeiling: 0,
      liqProtocolFee: 10_00,
      rateStrategyParams: IAaveV3ConfigEngine.InterestRateInputData({
        optimalUsageRatio: 90_00,
        baseVariableBorrowRate: 0,
        variableRateSlope1: 7_50,
        variableRateSlope2: 40_00
      })
    });
    listings[1] = IAaveV3ConfigEngine.Listing({
      asset: USDT,
      assetSymbol: 'USDT',
      priceFeed: 0x6e3d991C965364481796116dE68A8036d1b3Ecd0,
      enabledToBorrow: EngineFlags.ENABLED,
      borrowableInIsolation: EngineFlags.ENABLED,
      withSiloedBorrowing: EngineFlags.DISABLED,
      flashloanable: EngineFlags.ENABLED,
      ltv: 75_00,
      liqThreshold: 78_00,
      liqBonus: 5_00,
      reserveFactor: 10_00,
      supplyCap: 2_000_000,
      borrowCap: 1_800_000,
      debtCeiling: 0,
      liqProtocolFee: 10_00,
      rateStrategyParams: IAaveV3ConfigEngine.InterestRateInputData({
        optimalUsageRatio: 90_00,
        baseVariableBorrowRate: 0,
        variableRateSlope1: 7_50,
        variableRateSlope2: 40_00
      })
    });
    listings[2] = IAaveV3ConfigEngine.Listing({
      asset: cEUR,
      assetSymbol: 'cEUR',
      priceFeed: 0x3D207061Dbe8E2473527611BFecB87Ff12b28dDa,
      enabledToBorrow: EngineFlags.ENABLED,
      borrowableInIsolation: EngineFlags.ENABLED,
      withSiloedBorrowing: EngineFlags.DISABLED,
      flashloanable: EngineFlags.ENABLED,
      ltv: 0,
      liqThreshold: 0,
      liqBonus: 0,
      reserveFactor: 15_00,
      supplyCap: 80_000,
      borrowCap: 72_000,
      debtCeiling: 0,
      liqProtocolFee: 0,
      rateStrategyParams: IAaveV3ConfigEngine.InterestRateInputData({
        optimalUsageRatio: 90_00,
        baseVariableBorrowRate: 0,
        variableRateSlope1: 7_50,
        variableRateSlope2: 75_00
      })
    });
    listings[3] = IAaveV3ConfigEngine.Listing({
      asset: cUSD,
      assetSymbol: 'cUSD',
      priceFeed: 0xdCdA3E7E90fe827776b8FDaEa3C5977F123354DA,
      enabledToBorrow: EngineFlags.ENABLED,
      borrowableInIsolation: EngineFlags.ENABLED,
      withSiloedBorrowing: EngineFlags.DISABLED,
      flashloanable: EngineFlags.ENABLED,
      ltv: 0,
      liqThreshold: 0,
      liqBonus: 0,
      reserveFactor: 15_00,
      supplyCap: 1_300_000,
      borrowCap: 1_170_000,
      debtCeiling: 0,
      liqProtocolFee: 0,
      rateStrategyParams: IAaveV3ConfigEngine.InterestRateInputData({
        optimalUsageRatio: 90_00,
        baseVariableBorrowRate: 0,
        variableRateSlope1: 7_50,
        variableRateSlope2: 75_00
      })
    });
    listings[4] = IAaveV3ConfigEngine.Listing({
      asset: CELO,
      assetSymbol: 'CELO',
      priceFeed: 0x0568fD19986748cEfF3301e55c0eb1E729E0Ab7e,
      enabledToBorrow: EngineFlags.ENABLED,
      borrowableInIsolation: EngineFlags.DISABLED,
      withSiloedBorrowing: EngineFlags.DISABLED,
      flashloanable: EngineFlags.ENABLED,
      ltv: 55_00,
      liqThreshold: 61_00,
      liqBonus: 10_00,
      reserveFactor: 20_00,
      supplyCap: 1_000_000,
      borrowCap: 100_000,
      debtCeiling: 500_000,
      liqProtocolFee: 10_00,
      rateStrategyParams: IAaveV3ConfigEngine.InterestRateInputData({
        optimalUsageRatio: 45_00,
        baseVariableBorrowRate: 0,
        variableRateSlope1: 10_00,
        variableRateSlope2: 150_00
      })
    });

    return listings;
  }

  function _supplyAndConfigureLMAdmin(address asset, uint256 seedAmount) internal {
    IERC20(asset).forceApprove(address(AaveV3Celo.POOL), seedAmount);
    AaveV3Celo.POOL.supply(asset, seedAmount, address(AaveV3Celo.DUST_BIN), 0);

    address aToken = AaveV3Celo.POOL.getReserveAToken(asset);
    IEmissionManager(AaveV3Celo.EMISSION_MANAGER).setEmissionAdmin(asset, LM_ADMIN);
    IEmissionManager(AaveV3Celo.EMISSION_MANAGER).setEmissionAdmin(aToken, LM_ADMIN);
  }
}
