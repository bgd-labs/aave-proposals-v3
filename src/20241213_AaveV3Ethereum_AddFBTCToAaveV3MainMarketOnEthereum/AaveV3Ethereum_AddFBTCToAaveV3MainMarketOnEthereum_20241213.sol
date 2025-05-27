// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {ChainlinkEthereum} from 'aave-address-book/ChainlinkEthereum.sol';
import {AaveV3PayloadEthereum} from 'aave-helpers/src/v3-config-engine/AaveV3PayloadEthereum.sol';
import {EngineFlags} from 'aave-v3-origin/contracts/extensions/v3-config-engine/EngineFlags.sol';
import {IAaveV3ConfigEngine} from 'aave-v3-origin/contracts/extensions/v3-config-engine/IAaveV3ConfigEngine.sol';
import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {SafeERC20} from 'openzeppelin-contracts/contracts/token/ERC20/utils/SafeERC20.sol';
import {IEmissionManager} from 'aave-v3-origin/contracts/rewards/interfaces/IEmissionManager.sol';
/**
 * @title Add FBTC to Aave v3 Main Market on Ethereum
 * @author Aave Chan Initiative
 * - Snapshot: https://snapshot.box/#/s:aave.eth/proposal/0x2ca8db490e132cebfec25ddbf460b89abd710456c5177bca784abaae9d6009d9
 * - Discussion: https://governance.aave.com/t/arfc-add-fbtc-to-aave-v3-main-market-on-ethereum/19937
 */
contract AaveV3Ethereum_AddFBTCToAaveV3MainMarketOnEthereum_20241213 is AaveV3PayloadEthereum {
  using SafeERC20 for IERC20;

  address public constant FBTC = 0xC96dE26018A54D51c097160568752c4E3BD6C364;
  uint256 public constant FBTC_SEED_AMOUNT = 1e5;
  address public constant FBTC_LM_ADMIN = 0xac140648435d03f784879cd789130F22Ef588Fcd;

  function _postExecute() internal override {
    IERC20(FBTC).forceApprove(address(AaveV3Ethereum.POOL), FBTC_SEED_AMOUNT);
    AaveV3Ethereum.POOL.supply(FBTC, FBTC_SEED_AMOUNT, AaveV3Ethereum.DUST_BIN, 0);

    address aFBTC = AaveV3Ethereum.POOL.getReserveAToken(FBTC);
    IEmissionManager(AaveV3Ethereum.EMISSION_MANAGER).setEmissionAdmin(FBTC, FBTC_LM_ADMIN);
    IEmissionManager(AaveV3Ethereum.EMISSION_MANAGER).setEmissionAdmin(aFBTC, FBTC_LM_ADMIN);
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
      eModeCategory: 16,
      ltv: 84_00,
      liqThreshold: 86_00,
      liqBonus: 3_00,
      label: 'FBTC/WBTC'
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
      memory assetEModeUpdates = new IAaveV3ConfigEngine.AssetEModeUpdate[](2);

    assetEModeUpdates[0] = IAaveV3ConfigEngine.AssetEModeUpdate({
      asset: FBTC,
      eModeCategory: 16,
      borrowable: EngineFlags.DISABLED,
      collateral: EngineFlags.ENABLED
    });
    assetEModeUpdates[1] = IAaveV3ConfigEngine.AssetEModeUpdate({
      asset: AaveV3EthereumAssets.WBTC_UNDERLYING,
      eModeCategory: 16,
      borrowable: EngineFlags.ENABLED,
      collateral: EngineFlags.DISABLED
    });

    return assetEModeUpdates;
  }
  function newListings() public pure override returns (IAaveV3ConfigEngine.Listing[] memory) {
    IAaveV3ConfigEngine.Listing[] memory listings = new IAaveV3ConfigEngine.Listing[](1);

    listings[0] = IAaveV3ConfigEngine.Listing({
      asset: FBTC,
      assetSymbol: 'FBTC',
      priceFeed: ChainlinkEthereum.SVR_BTC_USD,
      enabledToBorrow: EngineFlags.ENABLED,
      borrowableInIsolation: EngineFlags.DISABLED,
      withSiloedBorrowing: EngineFlags.DISABLED,
      flashloanable: EngineFlags.ENABLED,
      ltv: 73_00,
      liqThreshold: 78_00,
      liqBonus: 7_50,
      reserveFactor: 50_00,
      supplyCap: 200,
      borrowCap: 100,
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
