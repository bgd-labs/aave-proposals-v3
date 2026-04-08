// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {GovernanceV3Ethereum} from 'aave-address-book/GovernanceV3Ethereum.sol';
import {AaveV3PayloadEthereum} from 'aave-helpers/src/v3-config-engine/AaveV3PayloadEthereum.sol';
import {EngineFlags} from 'aave-v3-origin/contracts/extensions/v3-config-engine/EngineFlags.sol';
import {IAaveV3ConfigEngine} from 'aave-v3-origin/contracts/extensions/v3-config-engine/IAaveV3ConfigEngine.sol';
import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {SafeERC20} from 'openzeppelin-contracts/contracts/token/ERC20/utils/SafeERC20.sol';
import {IEmissionManager} from 'aave-v3-origin/contracts/rewards/interfaces/IEmissionManager.sol';

/**
 * @title Onboard PT-USDG 28MAY2026 on V3 Core
 * @author Aave Labs
 * - Snapshot: https://snapshot.org/#/s:aavedao.eth/proposal/0xaa29094accbcccd70088fb77dfd2800a4488319a0942b226c5699ea35d1c9e19
 * - Discussion: https://governance.aave.com/t/arfc-onboard-pt-usdg-28may2026-to-aave-v3-core-instance/24345/4
 */
contract AaveV3Ethereum_OnboardPTUSDG28MAY2026OnV3Core_20260407 is AaveV3PayloadEthereum {
  using SafeERC20 for IERC20;

  address public constant PT_USDG_28MAY2026 = 0x9db38D74a0D29380899aD354121DfB521aDb0548;
  uint256 public constant PT_USDG_28MAY2026_SEED_AMOUNT = 100e6;
  address public constant PT_USDG_28MAY2026_LM_ADMIN = 0xac140648435d03f784879cd789130F22Ef588Fcd;

  function newListings() public pure override returns (IAaveV3ConfigEngine.Listing[] memory) {
    IAaveV3ConfigEngine.Listing[] memory listings = new IAaveV3ConfigEngine.Listing[](1);

    listings[0] = IAaveV3ConfigEngine.Listing({
      asset: PT_USDG_28MAY2026,
      assetSymbol: 'PT_USDG_28MAY2026',
      priceFeed: 0x90498d4334259FA769830ccA9114D8bcF3745F6c,
      enabledToBorrow: EngineFlags.DISABLED,
      borrowableInIsolation: EngineFlags.DISABLED,
      withSiloedBorrowing: EngineFlags.DISABLED,
      flashloanable: EngineFlags.DISABLED,
      ltv: 0,
      liqThreshold: 0,
      liqBonus: 0,
      reserveFactor: 45_00,
      supplyCap: 80_000_000,
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

  function eModeCategoryCreations()
    public
    pure
    override
    returns (IAaveV3ConfigEngine.EModeCategoryCreation[] memory)
  {
    IAaveV3ConfigEngine.EModeCategoryCreation[]
      memory eModeCreations = new IAaveV3ConfigEngine.EModeCategoryCreation[](1);

    {
      address[] memory collaterals = new address[](1);
      address[] memory borrowables = new address[](4);

      collaterals[0] = PT_USDG_28MAY2026;

      borrowables[0] = AaveV3EthereumAssets.USDT_UNDERLYING;
      borrowables[1] = AaveV3EthereumAssets.USDe_UNDERLYING;
      borrowables[2] = AaveV3EthereumAssets.USDC_UNDERLYING;
      borrowables[3] = AaveV3EthereumAssets.USDG_UNDERLYING;

      eModeCreations[0] = IAaveV3ConfigEngine.EModeCategoryCreation({
        ltv: 93_50,
        liqThreshold: 95_50,
        liqBonus: 2_00,
        label: 'PT_USDG_28MAY2026__Stablecoins',
        collaterals: collaterals,
        borrowables: borrowables
      });
    }

    return eModeCreations;
  }

  function _preExecute() internal override {
    AaveV3Ethereum.COLLECTOR.transfer(
      IERC20(PT_USDG_28MAY2026),
      GovernanceV3Ethereum.EXECUTOR_LVL_1,
      PT_USDG_28MAY2026_SEED_AMOUNT
    );
  }

  function _postExecute() internal override {
    _supplyAndConfigureLMAdmin(
      PT_USDG_28MAY2026,
      PT_USDG_28MAY2026_SEED_AMOUNT,
      PT_USDG_28MAY2026_LM_ADMIN
    );
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
}
