// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Sonic} from 'aave-address-book/AaveV3Sonic.sol';
import {MiscSonic} from 'aave-address-book/MiscSonic.sol';
import {AaveV3PayloadSonic} from 'aave-helpers/src/v3-config-engine/AaveV3PayloadSonic.sol';
import {EngineFlags} from 'aave-v3-origin/contracts/extensions/v3-config-engine/EngineFlags.sol';
import {IAaveV3ConfigEngine} from 'aave-v3-origin/contracts/extensions/v3-config-engine/IAaveV3ConfigEngine.sol';
import {IEmissionManager} from 'aave-v3-origin/contracts/rewards/interfaces/IEmissionManager.sol';
import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {SafeERC20} from 'openzeppelin-contracts/contracts/token/ERC20/utils/SafeERC20.sol';

/**
 * @title Aave V3.3 Sonic Activation
 * @author BGD Labs (@bgdlabs)
 * - Snapshot: https://snapshot.box/#/s:aave.eth/proposal/0x8d41750cae27326ac50a84a25846747baeb99c57d371c536ec9219ff662f7497
 * - Discussion: https://governance.aave.com/t/arfc-deploy-aave-v3-on-sonic/20543
 */
contract AaveV3Sonic_AaveV33SonicActivation_20250217 is AaveV3PayloadSonic {
  using SafeERC20 for IERC20;

  address public constant WETH = 0x50c42dEAcD8Fc9773493ED674b675bE577f2634b;
  uint256 public constant WETH_SEED_AMOUNT = 0.025e18;

  address public constant USDC = 0x29219dd400f2Bf60E5a23d13Be72B486D4038894;
  uint256 public constant USDC_SEED_AMOUNT = 10e6;

  address public constant wS = 0x039e2fB66102314Ce7b64Ce5Ce3E5183bc94aD38;
  uint256 public constant wS_SEED_AMOUNT = 10e18;

  address public constant LM_ADMIN = 0xac140648435d03f784879cd789130F22Ef588Fcd;

  function _postExecute() internal override {
    _supplyAndConfigureLMAdmin(WETH, WETH_SEED_AMOUNT);
    _supplyAndConfigureLMAdmin(USDC, USDC_SEED_AMOUNT);
    _supplyAndConfigureLMAdmin(wS, wS_SEED_AMOUNT);

    AaveV3Sonic.ACL_MANAGER.addPoolAdmin(MiscSonic.PROTOCOL_GUARDIAN);
    AaveV3Sonic.ACL_MANAGER.addRiskAdmin(AaveV3Sonic.RISK_STEWARD);
  }

  function newListings() public pure override returns (IAaveV3ConfigEngine.Listing[] memory) {
    IAaveV3ConfigEngine.Listing[] memory listings = new IAaveV3ConfigEngine.Listing[](3);

    listings[0] = IAaveV3ConfigEngine.Listing({
      asset: WETH,
      assetSymbol: 'WETH',
      priceFeed: 0x824364077993847f71293B24ccA8567c00c2de11,
      enabledToBorrow: EngineFlags.ENABLED,
      borrowableInIsolation: EngineFlags.DISABLED,
      withSiloedBorrowing: EngineFlags.DISABLED,
      flashloanable: EngineFlags.ENABLED,
      ltv: 80_00,
      liqThreshold: 83_00,
      liqBonus: 6_00,
      reserveFactor: 15_00,
      supplyCap: 3_000,
      borrowCap: 2_750,
      debtCeiling: 0,
      liqProtocolFee: 10_00,
      rateStrategyParams: IAaveV3ConfigEngine.InterestRateInputData({
        optimalUsageRatio: 90_00,
        baseVariableBorrowRate: 0,
        variableRateSlope1: 2_70,
        variableRateSlope2: 80_00
      })
    });
    listings[1] = IAaveV3ConfigEngine.Listing({
      asset: USDC,
      assetSymbol: 'USDC',
      priceFeed: 0x7A8443a2a5D772db7f1E40DeFe32db485108F128,
      enabledToBorrow: EngineFlags.ENABLED,
      borrowableInIsolation: EngineFlags.ENABLED,
      withSiloedBorrowing: EngineFlags.DISABLED,
      flashloanable: EngineFlags.ENABLED,
      ltv: 75_00,
      liqThreshold: 78_00,
      liqBonus: 5_00,
      reserveFactor: 10_00,
      supplyCap: 20_000_000,
      borrowCap: 19_000_000,
      debtCeiling: 0,
      liqProtocolFee: 10_00,
      rateStrategyParams: IAaveV3ConfigEngine.InterestRateInputData({
        optimalUsageRatio: 90_00,
        baseVariableBorrowRate: 0,
        variableRateSlope1: 9_50,
        variableRateSlope2: 40_00
      })
    });
    listings[2] = IAaveV3ConfigEngine.Listing({
      asset: wS,
      assetSymbol: 'wS',
      priceFeed: 0xc76dFb89fF298145b417d221B2c747d84952e01d,
      enabledToBorrow: EngineFlags.ENABLED,
      borrowableInIsolation: EngineFlags.DISABLED,
      withSiloedBorrowing: EngineFlags.DISABLED,
      flashloanable: EngineFlags.ENABLED,
      ltv: 68_00,
      liqThreshold: 70_00,
      liqBonus: 10_00,
      reserveFactor: 15_00,
      supplyCap: 20_000_000,
      borrowCap: 10_000_000,
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

  function _supplyAndConfigureLMAdmin(address asset, uint256 seedAmount) internal {
    IERC20(asset).forceApprove(address(AaveV3Sonic.POOL), seedAmount);
    AaveV3Sonic.POOL.supply(asset, seedAmount, address(AaveV3Sonic.COLLECTOR), 0);

    (address aToken, , ) = AaveV3Sonic.AAVE_PROTOCOL_DATA_PROVIDER.getReserveTokensAddresses(asset);
    IEmissionManager(AaveV3Sonic.EMISSION_MANAGER).setEmissionAdmin(asset, LM_ADMIN);
    IEmissionManager(AaveV3Sonic.EMISSION_MANAGER).setEmissionAdmin(aToken, LM_ADMIN);
  }
}
