// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Arbitrum} from 'aave-address-book/AaveV3Arbitrum.sol';
import {AaveV3PayloadArbitrum} from 'aave-helpers/src/v3-config-engine/AaveV3PayloadArbitrum.sol';
import {EngineFlags} from 'aave-v3-origin/contracts/extensions/v3-config-engine/EngineFlags.sol';
import {IAaveV3ConfigEngine} from 'aave-v3-origin/contracts/extensions/v3-config-engine/IAaveV3ConfigEngine.sol';
import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {SafeERC20} from 'openzeppelin-contracts/contracts/token/ERC20/utils/SafeERC20.sol';
import {IEmissionManager} from 'aave-v3-origin/contracts/rewards/interfaces/IEmissionManager.sol';
/**
 * @title Onboard tBTC to Aave v3 on Arbitrum
 * @author Aave-Chan Initiative
 * - Snapshot: https://snapshot.box/#/s:aave.eth/proposal/0xb55325cab6b35918810443de265b8cf2f5908acdde935f3e5b57e6625c4615d5
 * - Discussion: https://governance.aave.com/t/arfc-onboard-tbtc-to-aave-v3-on-arbitrum/19756
 */
contract AaveV3Arbitrum_OnboardTBTCToAaveV3OnArbitrum_20250317 is AaveV3PayloadArbitrum {
  using SafeERC20 for IERC20;

  address public constant tBTC = 0x6c84a8f1c29108F47a79964b5Fe888D4f4D0dE40;
  uint256 public constant tBTC_SEED_AMOUNT = 1e15;
  address public constant tBTC_LM_ADMIN = 0xac140648435d03f784879cd789130F22Ef588Fcd;

  function _postExecute() internal override {
    IERC20(tBTC).forceApprove(address(AaveV3Arbitrum.POOL), tBTC_SEED_AMOUNT);
    AaveV3Arbitrum.POOL.supply(tBTC, tBTC_SEED_AMOUNT, AaveV3Arbitrum.DUST_BIN, 0);

    address atBTC = AaveV3Arbitrum.POOL.getReserveAToken(tBTC);
    IEmissionManager(AaveV3Arbitrum.EMISSION_MANAGER).setEmissionAdmin(tBTC, tBTC_LM_ADMIN);
    IEmissionManager(AaveV3Arbitrum.EMISSION_MANAGER).setEmissionAdmin(atBTC, tBTC_LM_ADMIN);
  }

  function newListings() public pure override returns (IAaveV3ConfigEngine.Listing[] memory) {
    IAaveV3ConfigEngine.Listing[] memory listings = new IAaveV3ConfigEngine.Listing[](1);

    listings[0] = IAaveV3ConfigEngine.Listing({
      asset: tBTC,
      assetSymbol: 'tBTC',
      priceFeed: 0x6ce185860a4963106506C203335A2910413708e9,
      enabledToBorrow: EngineFlags.DISABLED,
      borrowableInIsolation: EngineFlags.DISABLED,
      withSiloedBorrowing: EngineFlags.DISABLED,
      flashloanable: EngineFlags.DISABLED,
      ltv: 73_00,
      liqThreshold: 78_00,
      liqBonus: 7_50,
      reserveFactor: 20_00,
      supplyCap: 50,
      borrowCap: 25,
      debtCeiling: 0,
      liqProtocolFee: 10_00,
      rateStrategyParams: IAaveV3ConfigEngine.InterestRateInputData({
        optimalUsageRatio: 45_00,
        baseVariableBorrowRate: 0,
        variableRateSlope1: 4_00,
        variableRateSlope2: 300_00
      })
    });

    return listings;
  }
}
