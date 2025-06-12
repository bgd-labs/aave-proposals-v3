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
 * @title Onboard PT sUSDe July and PT eUSDe May on Core Instance
 * @author BGD Labs (@bgdlabs)
 * - Snapshot: https://snapshot.box/#/s:aavedao.eth/proposal/0xc039953e4f18804bb017876d27621da1ab3e4de53acd3b32d0f1fe94d4bbb6a0
 * - Discussion: https://governance.aave.com/t/arfc-onboard-eusde-pt-tokens-to-aave-v3-core-instance/21767
 */
contract AaveV3Ethereum_OnboardPTEUSDeMayOnCoreInstance_20250423 is AaveV3PayloadEthereum {
  using SafeERC20 for IERC20;

  address public constant PT_eUSDE_29MAY2025 = 0x50D2C7992b802Eef16c04FeADAB310f31866a545;
  address public constant PT_eUSDE_29MAY2025_PRICE_FEED =
    0x5292AB3292D076271f853Ed8e05e61cc02F0A2C6;

  address public constant LM_ADMIN = 0xac140648435d03f784879cd789130F22Ef588Fcd;
  uint256 public constant SEED_AMOUNT = 10e18;

  function _postExecute() internal override {
    IERC20(PT_eUSDE_29MAY2025).forceApprove(address(AaveV3Ethereum.POOL), SEED_AMOUNT);
    AaveV3Ethereum.POOL.supply(PT_eUSDE_29MAY2025, SEED_AMOUNT, AaveV3Ethereum.DUST_BIN, 0);

    address aPT_eUSDE_29MAY2025 = AaveV3Ethereum.POOL.getReserveAToken(PT_eUSDE_29MAY2025);
    IEmissionManager(AaveV3Ethereum.EMISSION_MANAGER).setEmissionAdmin(
      PT_eUSDE_29MAY2025,
      LM_ADMIN
    );
    IEmissionManager(AaveV3Ethereum.EMISSION_MANAGER).setEmissionAdmin(
      aPT_eUSDE_29MAY2025,
      LM_ADMIN
    );
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
      eModeCategory: 9,
      ltv: 91_00,
      liqThreshold: 93_00,
      liqBonus: 3_30,
      label: 'PT-eUSDe Stablecoins May 2025'
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
      memory assetEModeUpdates = new IAaveV3ConfigEngine.AssetEModeUpdate[](4);

    assetEModeUpdates[0] = IAaveV3ConfigEngine.AssetEModeUpdate({
      asset: PT_eUSDE_29MAY2025,
      eModeCategory: 9,
      borrowable: EngineFlags.DISABLED,
      collateral: EngineFlags.ENABLED
    });
    assetEModeUpdates[1] = IAaveV3ConfigEngine.AssetEModeUpdate({
      asset: AaveV3EthereumAssets.USDC_UNDERLYING,
      eModeCategory: 9,
      borrowable: EngineFlags.ENABLED,
      collateral: EngineFlags.DISABLED
    });
    assetEModeUpdates[2] = IAaveV3ConfigEngine.AssetEModeUpdate({
      asset: AaveV3EthereumAssets.USDT_UNDERLYING,
      eModeCategory: 9,
      borrowable: EngineFlags.ENABLED,
      collateral: EngineFlags.DISABLED
    });
    assetEModeUpdates[3] = IAaveV3ConfigEngine.AssetEModeUpdate({
      asset: AaveV3EthereumAssets.USDS_UNDERLYING,
      eModeCategory: 9,
      borrowable: EngineFlags.ENABLED,
      collateral: EngineFlags.DISABLED
    });

    return assetEModeUpdates;
  }

  function newListings() public pure override returns (IAaveV3ConfigEngine.Listing[] memory) {
    IAaveV3ConfigEngine.Listing[] memory listings = new IAaveV3ConfigEngine.Listing[](1);

    listings[0] = IAaveV3ConfigEngine.Listing({
      asset: PT_eUSDE_29MAY2025,
      assetSymbol: 'PT_eUSDE_29MAY2025',
      priceFeed: PT_eUSDE_29MAY2025_PRICE_FEED,
      enabledToBorrow: EngineFlags.DISABLED,
      borrowableInIsolation: EngineFlags.DISABLED,
      withSiloedBorrowing: EngineFlags.DISABLED,
      flashloanable: EngineFlags.ENABLED,
      ltv: 5,
      liqThreshold: 10,
      liqBonus: 7_50,
      reserveFactor: 20_00,
      supplyCap: 150_000_000,
      borrowCap: 1,
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
