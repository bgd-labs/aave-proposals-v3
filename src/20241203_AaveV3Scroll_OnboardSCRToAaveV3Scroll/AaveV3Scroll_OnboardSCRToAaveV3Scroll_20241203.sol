// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Scroll} from 'aave-address-book/AaveV3Scroll.sol';
import {AaveV3PayloadScroll} from 'aave-helpers/src/v3-config-engine/AaveV3PayloadScroll.sol';
import {EngineFlags} from 'aave-v3-origin/contracts/extensions/v3-config-engine/EngineFlags.sol';
import {IAaveV3ConfigEngine} from 'aave-v3-origin/contracts/extensions/v3-config-engine/IAaveV3ConfigEngine.sol';
import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {SafeERC20} from 'solidity-utils/contracts/oz-common/SafeERC20.sol';
import {IEmissionManager} from 'aave-v3-origin/contracts/rewards/interfaces/IEmissionManager.sol';
/**
 * @title Onboard SCR to Aave V3 Scroll
 * @author ACI
 * - Snapshot: https://snapshot.org/#/aave.eth/proposal/0xef7dfa4e96e5f6a7337648d2dd3882f7b10e969c9564c118a34ce99eccec9383
 * - Discussion: https://governance.aave.com/t/arfc-onboard-scr-to-aave-v3-scroll-instance/19688
 */
contract AaveV3Scroll_OnboardSCRToAaveV3Scroll_20241203 is AaveV3PayloadScroll {
  using SafeERC20 for IERC20;

  address public constant SCR = 0xd29687c813D741E2F938F4aC377128810E217b1b;
  uint256 public constant SCR_SEED_AMOUNT = 100 * 1e18;
  address public constant SCR_ADMIN = 0xac140648435d03f784879cd789130F22Ef588Fcd;

  function _postExecute() internal override {
    IERC20(SCR).forceApprove(address(AaveV3Scroll.POOL), SCR_SEED_AMOUNT);
    AaveV3Scroll.POOL.supply(SCR, SCR_SEED_AMOUNT, address(AaveV3Scroll.COLLECTOR), 0);

    (address aSCR, , ) = AaveV3Scroll.AAVE_PROTOCOL_DATA_PROVIDER.getReserveTokensAddresses(SCR);
    IEmissionManager(AaveV3Scroll.EMISSION_MANAGER).setEmissionAdmin(SCR, SCR_ADMIN);
    IEmissionManager(AaveV3Scroll.EMISSION_MANAGER).setEmissionAdmin(aSCR, SCR_ADMIN);
  }

  function newListings() public pure override returns (IAaveV3ConfigEngine.Listing[] memory) {
    IAaveV3ConfigEngine.Listing[] memory listings = new IAaveV3ConfigEngine.Listing[](1);

    listings[0] = IAaveV3ConfigEngine.Listing({
      asset: SCR,
      assetSymbol: 'SCR',
      priceFeed: 0x26f6F7C468EE309115d19Aa2055db5A74F8cE7A5,
      enabledToBorrow: EngineFlags.ENABLED,
      borrowableInIsolation: EngineFlags.DISABLED,
      withSiloedBorrowing: EngineFlags.DISABLED,
      flashloanable: EngineFlags.ENABLED,
      ltv: 0,
      liqThreshold: 0,
      liqBonus: 0,
      reserveFactor: 20_00,
      supplyCap: 360_000,
      borrowCap: 180_000,
      debtCeiling: 0,
      liqProtocolFee: 0,
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
