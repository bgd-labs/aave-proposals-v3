// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Base} from 'aave-address-book/AaveV3Base.sol';
import {ChainlinkBase} from 'aave-address-book/ChainlinkBase.sol';
import {AaveV3PayloadBase} from 'aave-helpers/src/v3-config-engine/AaveV3PayloadBase.sol';
import {EngineFlags} from 'aave-v3-origin/contracts/extensions/v3-config-engine/EngineFlags.sol';
import {IAaveV3ConfigEngine} from 'aave-v3-origin/contracts/extensions/v3-config-engine/IAaveV3ConfigEngine.sol';
import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {SafeERC20} from 'openzeppelin-contracts/contracts/token/ERC20/utils/SafeERC20.sol';
import {IEmissionManager} from 'aave-v3-origin/contracts/rewards/interfaces/IEmissionManager.sol';

/**
 * @title Onboard tBTC to Aave v3 on Base
 * @author Aave-Chan Initiative
 * - Snapshot: https://snapshot.box/#/s:aavedao.eth/proposal/0x1c12498028d114d73fd1614a7f5c8ba7e922ff129b5807d35d83f436bf8b4bcd
 * - Discussion: https://governance.aave.com/t/arfc-onboard-tbtc-to-aave-v3-on-base/22226
 */
contract AaveV3Base_OnboardTBTCToAaveV3OnBase_20250818 is AaveV3PayloadBase {
  using SafeERC20 for IERC20;

  address public constant tBTC = 0x236aa50979D5f3De3Bd1Eeb40E81137F22ab794b;
  uint256 public constant tBTC_SEED_AMOUNT = 1e15;
  address public constant tBTC_LM_ADMIN = 0xac140648435d03f784879cd789130F22Ef588Fcd;

  function _postExecute() internal override {
    IERC20(tBTC).forceApprove(address(AaveV3Base.POOL), tBTC_SEED_AMOUNT);
    AaveV3Base.POOL.supply(tBTC, tBTC_SEED_AMOUNT, AaveV3Base.DUST_BIN, 0);

    address atBTC = AaveV3Base.POOL.getReserveAToken(tBTC);
    IEmissionManager(AaveV3Base.EMISSION_MANAGER).setEmissionAdmin(tBTC, tBTC_LM_ADMIN);
    IEmissionManager(AaveV3Base.EMISSION_MANAGER).setEmissionAdmin(atBTC, tBTC_LM_ADMIN);
  }

  function newListings() public pure override returns (IAaveV3ConfigEngine.Listing[] memory) {
    IAaveV3ConfigEngine.Listing[] memory listings = new IAaveV3ConfigEngine.Listing[](1);

    listings[0] = IAaveV3ConfigEngine.Listing({
      asset: tBTC,
      assetSymbol: 'tBTC',
      priceFeed: ChainlinkBase.BTC_USD,
      enabledToBorrow: EngineFlags.ENABLED,
      borrowableInIsolation: EngineFlags.DISABLED,
      withSiloedBorrowing: EngineFlags.DISABLED,
      flashloanable: EngineFlags.ENABLED,
      ltv: 73_00,
      liqThreshold: 78_00,
      liqBonus: 7_50,
      reserveFactor: 20_00,
      supplyCap: 130,
      borrowCap: 13,
      debtCeiling: 0,
      liqProtocolFee: 10_00,
      rateStrategyParams: IAaveV3ConfigEngine.InterestRateInputData({
        optimalUsageRatio: 45_00,
        baseVariableBorrowRate: 0,
        variableRateSlope1: 4_00,
        variableRateSlope2: 60_00
      })
    });

    return listings;
  }
}
