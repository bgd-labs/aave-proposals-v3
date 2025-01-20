// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {AaveV3PayloadEthereum} from 'aave-helpers/src/v3-config-engine/AaveV3PayloadEthereum.sol';
import {EngineFlags} from 'aave-v3-origin/contracts/extensions/v3-config-engine/EngineFlags.sol';
import {IAaveV3ConfigEngine} from 'aave-v3-origin/contracts/extensions/v3-config-engine/IAaveV3ConfigEngine.sol';
import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {SafeERC20} from 'solidity-utils/contracts/oz-common/SafeERC20.sol';
import {IEmissionManager} from 'aave-v3-origin/contracts/rewards/interfaces/IEmissionManager.sol';
/**
 * @title Onboard LBTC & Enable LBTC/WBTC liquid E-Mode on Aave v3 Core Instance
 * @author Aave Chan Initiative
 * - Snapshot: https://snapshot.box/#/s:aave.eth/proposal/0x61f027ea797763c9e01736693570141a27a0a5d4517a6b63d0fd84474e8be995
 * - Discussion: https://governance.aave.com/t/arfc-enable-lbtc-wbtc-liquid-e-mode-on-aave-v3-core-instance/20142
 */
contract AaveV3Ethereum_EnableLBTCWBTCLiquidEModeOnAavev3CoreInstance_20241223 is
  AaveV3PayloadEthereum
{
  using SafeERC20 for IERC20;

  address public constant LBTC = 0x8236a87084f8B84306f72007F36F2618A5634494;
  uint256 public constant LBTC_SEED_AMOUNT = 1e5;
  address public constant LBTC_LM_ADMIN = 0xac140648435d03f784879cd789130F22Ef588Fcd;

  function _postExecute() internal override {
    IERC20(LBTC).forceApprove(address(AaveV3Ethereum.POOL), LBTC_SEED_AMOUNT);
    AaveV3Ethereum.POOL.supply(LBTC, LBTC_SEED_AMOUNT, address(AaveV3Ethereum.COLLECTOR), 0);

    (address aLBTC, , ) = AaveV3Ethereum.AAVE_PROTOCOL_DATA_PROVIDER.getReserveTokensAddresses(
      LBTC
    );
    IEmissionManager(AaveV3Ethereum.EMISSION_MANAGER).setEmissionAdmin(LBTC, LBTC_LM_ADMIN);
    IEmissionManager(AaveV3Ethereum.EMISSION_MANAGER).setEmissionAdmin(aLBTC, LBTC_LM_ADMIN);
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
      ltv: 84_00,
      liqThreshold: 86_00,
      liqBonus: 3_00,
      label: 'LBTC / WBTC'
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
      asset: LBTC,
      eModeCategory: 4,
      borrowable: EngineFlags.DISABLED,
      collateral: EngineFlags.ENABLED
    });
    assetEModeUpdates[1] = IAaveV3ConfigEngine.AssetEModeUpdate({
      asset: AaveV3EthereumAssets.WBTC_UNDERLYING,
      eModeCategory: 4,
      borrowable: EngineFlags.ENABLED,
      collateral: EngineFlags.DISABLED
    });

    return assetEModeUpdates;
  }
  function newListings() public pure override returns (IAaveV3ConfigEngine.Listing[] memory) {
    IAaveV3ConfigEngine.Listing[] memory listings = new IAaveV3ConfigEngine.Listing[](1);

    listings[0] = IAaveV3ConfigEngine.Listing({
      asset: LBTC,
      assetSymbol: 'LBTC',
      priceFeed: 0xF4030086522a5bEEa4988F8cA5B36dbC97BeE88c,
      enabledToBorrow: EngineFlags.ENABLED,
      borrowableInIsolation: EngineFlags.DISABLED,
      withSiloedBorrowing: EngineFlags.DISABLED,
      flashloanable: EngineFlags.ENABLED,
      ltv: 70_00,
      liqThreshold: 75_00,
      liqBonus: 8_50,
      reserveFactor: 50_00,
      supplyCap: 800,
      borrowCap: 80,
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
