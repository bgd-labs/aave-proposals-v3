// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {AaveV3EthereumLidoAssets} from 'aave-address-book/AaveV3EthereumLido.sol';
import {AaveV3PayloadEthereum} from 'aave-helpers/src/v3-config-engine/AaveV3PayloadEthereum.sol';
import {EngineFlags} from 'aave-v3-origin/contracts/extensions/v3-config-engine/EngineFlags.sol';
import {IAaveV3ConfigEngine} from 'aave-v3-origin/contracts/extensions/v3-config-engine/IAaveV3ConfigEngine.sol';
import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {SafeERC20} from 'openzeppelin-contracts/contracts/token/ERC20/utils/SafeERC20.sol';

/**
 * @title Add tETH to Core Instance Ethereum
 * @author @TokenLogic
 * - Snapshot: Direct-to-AIP
 * - Discussion: https://governance.aave.com/t/direct-to-aip-add-teth-to-core-instance-ethereum/22594/3
 */
contract AaveV3Ethereum_AddTETHToCoreInstanceEthereum_20250801 is AaveV3PayloadEthereum {
  using SafeERC20 for IERC20;

  uint256 public constant tETH_SEED_AMOUNT = 0.025 ether;

  function _postExecute() internal override {
    IERC20(address(AaveV3EthereumLidoAssets.tETH_UNDERLYING)).forceApprove(
      address(AaveV3Ethereum.POOL),
      tETH_SEED_AMOUNT
    );
    AaveV3Ethereum.POOL.supply(
      AaveV3EthereumLidoAssets.tETH_UNDERLYING,
      tETH_SEED_AMOUNT,
      AaveV3Ethereum.DUST_BIN,
      0
    );
  }

  function eModeCategoryCreations()
    public
    pure
    override
    returns (IAaveV3ConfigEngine.EModeCategoryCreation[] memory)
  {
    IAaveV3ConfigEngine.EModeCategoryCreation[]
      memory eModeCreations = new IAaveV3ConfigEngine.EModeCategoryCreation[](1);

    address[] memory collateralAssets_tETHStablecoin = new address[](1);
    address[] memory borrowableAssets_tETHStablecoin = new address[](2);

    collateralAssets_tETHStablecoin[0] = AaveV3EthereumLidoAssets.tETH_UNDERLYING;
    borrowableAssets_tETHStablecoin[0] = AaveV3EthereumAssets.USDC_UNDERLYING;
    borrowableAssets_tETHStablecoin[1] = AaveV3EthereumAssets.USDT_UNDERLYING;

    eModeCreations[0] = IAaveV3ConfigEngine.EModeCategoryCreation({
      ltv: 72_00,
      liqThreshold: 75_00,
      liqBonus: 7_50,
      label: 'tETH/Stablecoins',
      collaterals: collateralAssets_tETHStablecoin,
      borrowables: borrowableAssets_tETHStablecoin
    });

    return eModeCreations;
  }

  function newListings() public pure override returns (IAaveV3ConfigEngine.Listing[] memory) {
    IAaveV3ConfigEngine.Listing[] memory listings = new IAaveV3ConfigEngine.Listing[](1);

    listings[0] = IAaveV3ConfigEngine.Listing({
      asset: AaveV3EthereumLidoAssets.tETH_UNDERLYING,
      assetSymbol: 'tETH',
      priceFeed: AaveV3EthereumLidoAssets.tETH_ORACLE,
      enabledToBorrow: EngineFlags.DISABLED,
      borrowableInIsolation: EngineFlags.DISABLED,
      withSiloedBorrowing: EngineFlags.DISABLED,
      flashloanable: EngineFlags.ENABLED,
      ltv: 5,
      liqThreshold: 10,
      liqBonus: 7_50,
      reserveFactor: 15_00,
      supplyCap: 10_000,
      borrowCap: 0,
      debtCeiling: 0,
      liqProtocolFee: 10_00,
      rateStrategyParams: IAaveV3ConfigEngine.InterestRateInputData({
        optimalUsageRatio: 45_00,
        baseVariableBorrowRate: 0,
        variableRateSlope1: 0,
        variableRateSlope2: 0
      })
    });

    return listings;
  }
}
