// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {AaveV3PayloadEthereum} from 'aave-helpers/src/v3-config-engine/AaveV3PayloadEthereum.sol';
import {EngineFlags} from 'aave-v3-origin/contracts/extensions/v3-config-engine/EngineFlags.sol';
import {IAaveV3ConfigEngine} from 'aave-v3-origin/contracts/extensions/v3-config-engine/IAaveV3ConfigEngine.sol';
import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {IEmissionManager} from 'aave-v3-origin/contracts/rewards/interfaces/IEmissionManager.sol';
import {SafeERC20} from 'openzeppelin-contracts/contracts/token/ERC20/utils/SafeERC20.sol';

/**
 * @title Onboard PT sUSDe July on Core Instance
 * @author BGD Labs (@bgdlabs)
 * - Snapshot: https://snapshot.box/#/s:aavedao.eth/proposal/0xc039953e4f18804bb017876d27621da1ab3e4de53acd3b32d0f1fe94d4bbb6a0
 * - Discussion: https://governance.aave.com/t/arfc-onboard-susde-july-expiry-pt-tokens-on-aave-v3-core-instance/21878
 */
contract AaveV3Ethereum_OnboardPTSUSDeJulyOnCoreInstance_20250428 is AaveV3PayloadEthereum {
  using SafeERC20 for IERC20;

  address public constant PT_sUSDE_31JUL2025 = 0x3b3fB9C57858EF816833dC91565EFcd85D96f634;
  address public constant LM_ADMIN = 0xac140648435d03f784879cd789130F22Ef588Fcd;
  uint256 public constant SEED_AMOUNT = 10e18;

  function _postExecute() internal override {
    IERC20(PT_sUSDE_31JUL2025).forceApprove(address(AaveV3Ethereum.POOL), SEED_AMOUNT);
    AaveV3Ethereum.POOL.supply(PT_sUSDE_31JUL2025, SEED_AMOUNT, AaveV3Ethereum.DUST_BIN, 0);

    address aPT_sUSDE_31JUL2025 = AaveV3Ethereum.POOL.getReserveAToken(PT_sUSDE_31JUL2025);
    IEmissionManager(AaveV3Ethereum.EMISSION_MANAGER).setEmissionAdmin(
      PT_sUSDE_31JUL2025,
      LM_ADMIN
    );
    IEmissionManager(AaveV3Ethereum.EMISSION_MANAGER).setEmissionAdmin(
      aPT_sUSDE_31JUL2025,
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
      eModeCategory: 8,
      ltv: 87_40,
      liqThreshold: 89_40,
      liqBonus: 4_60,
      label: 'PT-sUSDe Stablecoins Jul 2025'
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
      asset: PT_sUSDE_31JUL2025,
      eModeCategory: 8,
      borrowable: EngineFlags.DISABLED,
      collateral: EngineFlags.ENABLED
    });
    assetEModeUpdates[1] = IAaveV3ConfigEngine.AssetEModeUpdate({
      asset: AaveV3EthereumAssets.USDC_UNDERLYING,
      eModeCategory: 8,
      borrowable: EngineFlags.ENABLED,
      collateral: EngineFlags.DISABLED
    });
    assetEModeUpdates[2] = IAaveV3ConfigEngine.AssetEModeUpdate({
      asset: AaveV3EthereumAssets.USDT_UNDERLYING,
      eModeCategory: 8,
      borrowable: EngineFlags.ENABLED,
      collateral: EngineFlags.DISABLED
    });
    assetEModeUpdates[3] = IAaveV3ConfigEngine.AssetEModeUpdate({
      asset: AaveV3EthereumAssets.USDS_UNDERLYING,
      eModeCategory: 8,
      borrowable: EngineFlags.ENABLED,
      collateral: EngineFlags.DISABLED
    });

    return assetEModeUpdates;
  }

  function newListings() public pure override returns (IAaveV3ConfigEngine.Listing[] memory) {
    IAaveV3ConfigEngine.Listing[] memory listings = new IAaveV3ConfigEngine.Listing[](1);

    listings[0] = IAaveV3ConfigEngine.Listing({
      asset: PT_sUSDE_31JUL2025,
      assetSymbol: 'PT_sUSDE_31JUL2025',
      priceFeed: 0x759B9B72700A129CD7AD8e53F9c99cb48Fd57105,
      enabledToBorrow: EngineFlags.DISABLED,
      borrowableInIsolation: EngineFlags.DISABLED,
      withSiloedBorrowing: EngineFlags.DISABLED,
      flashloanable: EngineFlags.ENABLED,
      ltv: 5,
      liqThreshold: 10,
      liqBonus: 7_50,
      reserveFactor: 20_00,
      supplyCap: 85_000_000,
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
