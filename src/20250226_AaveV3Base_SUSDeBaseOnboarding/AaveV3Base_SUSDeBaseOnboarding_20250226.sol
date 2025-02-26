// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Base} from 'aave-address-book/AaveV3Base.sol';
import {AaveV3PayloadBase} from 'aave-helpers/src/v3-config-engine/AaveV3PayloadBase.sol';
import {EngineFlags} from 'aave-v3-origin/contracts/extensions/v3-config-engine/EngineFlags.sol';
import {IAaveV3ConfigEngine} from 'aave-v3-origin/contracts/extensions/v3-config-engine/IAaveV3ConfigEngine.sol';
import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {SafeERC20} from 'openzeppelin-contracts/contracts/token/ERC20/utils/SafeERC20.sol';
import {IEmissionManager} from 'aave-v3-origin/contracts/rewards/interfaces/IEmissionManager.sol';
/**
 * @title sUSDe Base Onboarding
 * @author sreno
 * - Snapshot: https://snapshot.box/#/s:aave.eth/proposal/0x75caa290c8eefe042d8d3959da08c0f6ebbd6a98e45bbbb9a991531f26bd9899
 * - Discussion: https://governance.aave.com/t/arfc-add-susde-to-aave-v3-base-instance/20842
 */
contract AaveV3Base_SUSDeBaseOnboarding_20250226 is AaveV3PayloadBase {
  using SafeERC20 for IERC20;

  address public constant sUSDe = 0x211Cc4DD073734dA055fbF44a2b4667d5E5fE5d2;
  uint256 public constant sUSDe_SEED_AMOUNT = 100e18;
  address public constant sUSDe_ADMIN = 0xac140648435d03f784879cd789130F22Ef588Fcd;

  function _postExecute() internal override {
    IERC20(sUSDe).forceApprove(address(AaveV3Base.POOL), sUSDe_SEED_AMOUNT);
    AaveV3Base.POOL.supply(sUSDe, sUSDe_SEED_AMOUNT, address(AaveV3Base.COLLECTOR), 0);

    (address asUSDe, , ) = AaveV3Base.AAVE_PROTOCOL_DATA_PROVIDER.getReserveTokensAddresses(sUSDe);
    IEmissionManager(AaveV3Base.EMISSION_MANAGER).setEmissionAdmin(sUSDe, sUSDe_ADMIN);
    IEmissionManager(AaveV3Base.EMISSION_MANAGER).setEmissionAdmin(asUSDe, sUSDe_ADMIN);
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
      eModeCategory: 4,
      ltv: 88_00,
      liqThreshold: 90_00,
      liqBonus: 4_00,
      label: 'sUSDE stablecoins emode'
    });

    return eModeUpdates;
  }
  function newListings() public pure override returns (IAaveV3ConfigEngine.Listing[] memory) {
    IAaveV3ConfigEngine.Listing[] memory listings = new IAaveV3ConfigEngine.Listing[](1);

    listings[0] = IAaveV3ConfigEngine.Listing({
      asset: sUSDe,
      assetSymbol: 'sUSDe',
      priceFeed: 0xf19d560eB8d2ADf07BD6D13ed03e1D11215721F9, // change this to price adapter before merge!
      enabledToBorrow: EngineFlags.DISABLED,
      borrowableInIsolation: EngineFlags.DISABLED,
      withSiloedBorrowing: EngineFlags.DISABLED,
      flashloanable: EngineFlags.DISABLED,
      ltv: 70_00,
      liqThreshold: 73_00,
      liqBonus: 8_50,
      reserveFactor: 20_00,
      supplyCap: 1_200_000,
      borrowCap: 0,
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
