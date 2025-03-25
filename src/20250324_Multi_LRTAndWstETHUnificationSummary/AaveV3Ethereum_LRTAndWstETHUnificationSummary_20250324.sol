// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Ethereum, AaveV3EthereumAssets, AaveV3EthereumEModes} from 'aave-address-book/AaveV3Ethereum.sol';
import {AaveV3PayloadEthereum} from 'aave-helpers/src/v3-config-engine/AaveV3PayloadEthereum.sol';
import {EngineFlags} from 'aave-v3-origin/contracts/extensions/v3-config-engine/EngineFlags.sol';
import {IAaveV3ConfigEngine} from 'aave-v3-origin/contracts/extensions/v3-config-engine/IAaveV3ConfigEngine.sol';
import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {SafeERC20} from 'openzeppelin-contracts/contracts/token/ERC20/utils/SafeERC20.sol';

/**
 * @title LRT and wstETH Unification Summary
 * @author TokenLogic
 * - Snapshot: Direct-to-AIP
 * - Discussion: https://governance.aave.com/t/arfc-core-instance-add-ezeth-and-update-rseth-emode-parameters/21505
 */
contract AaveV3Ethereum_LRTAndWstETHUnificationSummary_20250324 is AaveV3PayloadEthereum {
  using SafeERC20 for IERC20;

  // https://etherscan.io/address/0xbf5495Efe5DB9ce00f80364C8B423567e58d2110
  address public constant ezETH = 0xbf5495Efe5DB9ce00f80364C8B423567e58d2110;
  uint256 public constant ezETH_SEED_AMOUNT = 1e18;
  uint256 public constant DUST_AMOUNT = 1e16;

  function _postExecute() internal override {
    IERC20(ezETH).forceApprove(address(AaveV3Ethereum.POOL), ezETH_SEED_AMOUNT);
    AaveV3Ethereum.POOL.supply(ezETH, ezETH_SEED_AMOUNT, address(AaveV3Ethereum.COLLECTOR), 0);
    address aEthEzETH = AaveV3Ethereum.POOL.getReserveAToken(ezETH);
    AaveV3Ethereum.COLLECTOR.transfer(IERC20(aEthEzETH), AaveV3Ethereum.DUST_BIN, DUST_AMOUNT);
  }

  function capsUpdates() public pure override returns (IAaveV3ConfigEngine.CapsUpdate[] memory) {
    IAaveV3ConfigEngine.CapsUpdate[] memory capsUpdate = new IAaveV3ConfigEngine.CapsUpdate[](1);

    capsUpdate[0] = IAaveV3ConfigEngine.CapsUpdate({
      asset: AaveV3EthereumAssets.rsETH_UNDERLYING,
      supplyCap: 550_000,
      borrowCap: EngineFlags.KEEP_CURRENT
    });

    return capsUpdate;
  }
  function eModeCategoriesUpdates()
    public
    pure
    override
    returns (IAaveV3ConfigEngine.EModeCategoryUpdate[] memory)
  {
    IAaveV3ConfigEngine.EModeCategoryUpdate[]
      memory eModeUpdates = new IAaveV3ConfigEngine.EModeCategoryUpdate[](6);

    eModeUpdates[0] = IAaveV3ConfigEngine.EModeCategoryUpdate({
      eModeCategory: 7,
      ltv: 93_00,
      liqThreshold: 95_00,
      liqBonus: 1_00,
      label: 'ezETH_WETH'
    });
    eModeUpdates[1] = IAaveV3ConfigEngine.EModeCategoryUpdate({
      eModeCategory: 8,
      ltv: 93_00,
      liqThreshold: 95_00,
      liqBonus: 1_00,
      label: 'ezETH_wstETH'
    });
    eModeUpdates[2] = IAaveV3ConfigEngine.EModeCategoryUpdate({
      eModeCategory: 9,
      ltv: 93_00,
      liqThreshold: 95_00,
      liqBonus: 1_00,
      label: 'rsETH_WETH'
    });
    eModeUpdates[3] = IAaveV3ConfigEngine.EModeCategoryUpdate({
      eModeCategory: 10,
      ltv: 93_00,
      liqThreshold: 95_00,
      liqBonus: 1_00,
      label: 'weETH_WETH'
    });
    eModeUpdates[4] = IAaveV3ConfigEngine.EModeCategoryUpdate({
      eModeCategory: 11,
      ltv: 94_50,
      liqThreshold: 96_00,
      liqBonus: 1_00,
      label: 'wstETH_WETH'
    });
    eModeUpdates[5] = IAaveV3ConfigEngine.EModeCategoryUpdate({
      eModeCategory: 12,
      ltv: 93_00,
      liqThreshold: 95_00,
      liqBonus: 1_00,
      label: 'rsETH_wstETH'
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
      memory assetEModeUpdates = new IAaveV3ConfigEngine.AssetEModeUpdate[](13);

    // ezETH_WETH
    assetEModeUpdates[0] = IAaveV3ConfigEngine.AssetEModeUpdate({
      asset: ezETH,
      eModeCategory: 7,
      borrowable: EngineFlags.DISABLED,
      collateral: EngineFlags.ENABLED
    });
    assetEModeUpdates[1] = IAaveV3ConfigEngine.AssetEModeUpdate({
      asset: AaveV3EthereumAssets.WETH_UNDERLYING,
      eModeCategory: 7,
      borrowable: EngineFlags.ENABLED,
      collateral: EngineFlags.DISABLED
    });

    // ezETH_wstETH
    assetEModeUpdates[2] = IAaveV3ConfigEngine.AssetEModeUpdate({
      asset: ezETH,
      eModeCategory: 8,
      borrowable: EngineFlags.DISABLED,
      collateral: EngineFlags.ENABLED
    });
    assetEModeUpdates[3] = IAaveV3ConfigEngine.AssetEModeUpdate({
      asset: AaveV3EthereumAssets.wstETH_UNDERLYING,
      eModeCategory: 8,
      borrowable: EngineFlags.ENABLED,
      collateral: EngineFlags.DISABLED
    });

    // rsETH_WETH
    assetEModeUpdates[4] = IAaveV3ConfigEngine.AssetEModeUpdate({
      asset: AaveV3EthereumAssets.rsETH_UNDERLYING,
      eModeCategory: 9,
      borrowable: EngineFlags.DISABLED,
      collateral: EngineFlags.ENABLED
    });
    assetEModeUpdates[5] = IAaveV3ConfigEngine.AssetEModeUpdate({
      asset: AaveV3EthereumAssets.WETH_UNDERLYING,
      eModeCategory: 9,
      borrowable: EngineFlags.ENABLED,
      collateral: EngineFlags.DISABLED
    });

    // weETH_WETH
    assetEModeUpdates[6] = IAaveV3ConfigEngine.AssetEModeUpdate({
      asset: AaveV3EthereumAssets.weETH_UNDERLYING,
      eModeCategory: 10,
      borrowable: EngineFlags.DISABLED,
      collateral: EngineFlags.ENABLED
    });
    assetEModeUpdates[7] = IAaveV3ConfigEngine.AssetEModeUpdate({
      asset: AaveV3EthereumAssets.WETH_UNDERLYING,
      eModeCategory: 10,
      borrowable: EngineFlags.ENABLED,
      collateral: EngineFlags.DISABLED
    });

    // wstETH_WETH
    assetEModeUpdates[8] = IAaveV3ConfigEngine.AssetEModeUpdate({
      asset: AaveV3EthereumAssets.wstETH_UNDERLYING,
      eModeCategory: 11,
      borrowable: EngineFlags.DISABLED,
      collateral: EngineFlags.ENABLED
    });
    assetEModeUpdates[9] = IAaveV3ConfigEngine.AssetEModeUpdate({
      asset: AaveV3EthereumAssets.WETH_UNDERLYING,
      eModeCategory: 11,
      borrowable: EngineFlags.ENABLED,
      collateral: EngineFlags.DISABLED
    });

    // rsETH_wstETH
    assetEModeUpdates[10] = IAaveV3ConfigEngine.AssetEModeUpdate({
      asset: AaveV3EthereumAssets.rsETH_UNDERLYING,
      eModeCategory: 12,
      borrowable: EngineFlags.DISABLED,
      collateral: EngineFlags.ENABLED
    });
    assetEModeUpdates[11] = IAaveV3ConfigEngine.AssetEModeUpdate({
      asset: AaveV3EthereumAssets.wstETH_UNDERLYING,
      eModeCategory: 12,
      borrowable: EngineFlags.ENABLED,
      collateral: EngineFlags.DISABLED
    });

    // remove wstETH from RSETH_LST_MAIN
    assetEModeUpdates[12] = IAaveV3ConfigEngine.AssetEModeUpdate({
      asset: AaveV3EthereumAssets.wstETH_UNDERLYING,
      eModeCategory: AaveV3EthereumEModes.RSETH_LST_MAIN,
      borrowable: EngineFlags.DISABLED,
      collateral: EngineFlags.DISABLED
    });

    return assetEModeUpdates;
  }
  function newListings() public pure override returns (IAaveV3ConfigEngine.Listing[] memory) {
    IAaveV3ConfigEngine.Listing[] memory listings = new IAaveV3ConfigEngine.Listing[](1);

    listings[0] = IAaveV3ConfigEngine.Listing({
      asset: ezETH,
      assetSymbol: 'ezETH',
      priceFeed: 0x68C9c7Bf43DBd0EBab102116bc7C3C9f7d9297Ee,
      enabledToBorrow: EngineFlags.ENABLED,
      borrowableInIsolation: EngineFlags.DISABLED,
      withSiloedBorrowing: EngineFlags.DISABLED,
      flashloanable: EngineFlags.ENABLED,
      ltv: 75_00,
      liqThreshold: 78_00,
      liqBonus: 7_50,
      reserveFactor: 15_00,
      supplyCap: 150_000,
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
