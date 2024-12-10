// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {CollectorUtils, ICollector} from 'aave-helpers/src/CollectorUtils.sol';
import {AaveSwapper} from 'aave-helpers/src/swaps/AaveSwapper.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {AaveV2Ethereum, AaveV2EthereumAssets} from 'aave-address-book/AaveV2Ethereum.sol';
import {MiscEthereum} from 'aave-address-book/MiscEthereum.sol';
import {AaveV3EthereumLido, AaveV3EthereumLidoEModes} from 'aave-address-book/AaveV3EthereumLido.sol';
import {AaveV3PayloadEthereumLido} from 'aave-helpers/src/v3-config-engine/AaveV3PayloadEthereumLido.sol';
import {EngineFlags} from 'aave-v3-origin/contracts/extensions/v3-config-engine/EngineFlags.sol';
import {IAaveV3ConfigEngine} from 'aave-v3-origin/contracts/extensions/v3-config-engine/IAaveV3ConfigEngine.sol';
import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {SafeERC20} from 'solidity-utils/contracts/oz-common/SafeERC20.sol';

/**
 * @title Onboard GHO and Migrate Streams to Lido Instance
 * @author karpatkey_TokenLogic
 * - Snapshot: https://snapshot.org/#/aave.eth/proposal/0x5c27aa8f1de66a3e56f535d60e4c1666a5617a36f8f81c09df2b0ea184a90290
 * - Discussion: https://governance.aave.com/t/arfc-onboard-gho-and-migrate-streams-to-lido-instance/19686
 */
contract AaveV3EthereumLido_OnboardGHOAndMigrateStreamsToLidoInstance_20241104 is
  AaveV3PayloadEthereumLido
{
  using SafeERC20 for IERC20;
  using CollectorUtils for ICollector;

  uint256 public constant INITIAL_GHO_SUPPLY = 3_000_000e18;

  uint256 public constant A_USDT_WITHDRAW_AMOUNT = 1_500_000e6;
  uint256 public constant A_ETH_USDT_WITHDRAW_AMOUNT = 500_000e6;
  uint256 public constant A_ETH_USDC_WITHDRAW_AMOUNT = 1_000_000e6;

  // https://etherscan.io/address/0x060373D064d0168931dE2AB8DDA7410923d06E88
  address public constant MILKMAN = 0x060373D064d0168931dE2AB8DDA7410923d06E88;
  // https://etherscan.io/address/0xe80a1C615F75AFF7Ed8F08c9F21f9d00982D666c
  address public constant PRICE_CHECKER = 0xe80a1C615F75AFF7Ed8F08c9F21f9d00982D666c;
  // https://etherscan.io/address/0x3f12643D3f6f874d39C2a4c9f2Cd6f2DbAC877FC
  address public constant GHO_USD_FEED = 0x3f12643D3f6f874d39C2a4c9f2Cd6f2DbAC877FC;

  address public constant AGD_MULTISIG = 0x89C51828427F70D77875C6747759fB17Ba10Ceb0;
  address public constant MERIT_MULTISIG = 0xdeadD8aB03075b7FBA81864202a2f59EE25B312b;

  function _postExecute() internal override {
    // agd
    if (
      IERC20(AaveV3EthereumAssets.GHO_UNDERLYING).allowance(
        address(AaveV3EthereumLido.COLLECTOR),
        AGD_MULTISIG
      ) > 0
    ) {
      AaveV3EthereumLido.COLLECTOR.approve(AaveV3EthereumAssets.GHO_UNDERLYING, AGD_MULTISIG, 0);
    }

    // merit
    uint256 meritAllowance = IERC20(AaveV3EthereumAssets.GHO_UNDERLYING).allowance(
      address(AaveV3EthereumLido.COLLECTOR),
      MERIT_MULTISIG
    );
    if (meritAllowance > 0) {
      (address aTokenAddress, , ) = AaveV3EthereumLido
        .AAVE_PROTOCOL_DATA_PROVIDER
        .getReserveTokensAddresses(AaveV3EthereumAssets.GHO_UNDERLYING);
      AaveV3EthereumLido.COLLECTOR.approve(AaveV3EthereumAssets.GHO_UNDERLYING, MERIT_MULTISIG, 0);
      AaveV3EthereumLido.COLLECTOR.approve(aTokenAddress, MERIT_MULTISIG, meritAllowance);
    }

    AaveV3EthereumLido.COLLECTOR.depositToV3(
      CollectorUtils.IOInput({
        pool: address(AaveV3EthereumLido.POOL),
        underlying: AaveV3EthereumAssets.GHO_UNDERLYING,
        amount: INITIAL_GHO_SUPPLY
      })
    );

    // swap
    // usdt
    AaveV3Ethereum.COLLECTOR.withdrawFromV2(
      CollectorUtils.IOInput({
        pool: address(AaveV2Ethereum.POOL),
        underlying: AaveV3EthereumAssets.USDT_UNDERLYING,
        amount: A_USDT_WITHDRAW_AMOUNT
      }),
      MiscEthereum.AAVE_SWAPPER
    );
    AaveV3Ethereum.COLLECTOR.withdrawFromV3(
      CollectorUtils.IOInput({
        pool: address(AaveV3Ethereum.POOL),
        underlying: AaveV3EthereumAssets.USDT_UNDERLYING,
        amount: A_ETH_USDT_WITHDRAW_AMOUNT
      }),
      MiscEthereum.AAVE_SWAPPER
    );

    AaveSwapper(MiscEthereum.AAVE_SWAPPER).swap(
      MILKMAN,
      PRICE_CHECKER,
      AaveV3EthereumAssets.USDT_UNDERLYING,
      AaveV3EthereumAssets.GHO_UNDERLYING,
      AaveV3EthereumAssets.USDT_ORACLE,
      GHO_USD_FEED,
      address(AaveV3EthereumLido.COLLECTOR),
      IERC20(AaveV3EthereumAssets.USDT_UNDERLYING).balanceOf(MiscEthereum.AAVE_SWAPPER),
      100
    );

    // usdc
    AaveV3Ethereum.COLLECTOR.withdrawFromV3(
      CollectorUtils.IOInput({
        pool: address(AaveV3Ethereum.POOL),
        underlying: AaveV3EthereumAssets.USDC_UNDERLYING,
        amount: A_ETH_USDC_WITHDRAW_AMOUNT
      }),
      MiscEthereum.AAVE_SWAPPER
    );

    AaveSwapper(MiscEthereum.AAVE_SWAPPER).swap(
      MILKMAN,
      PRICE_CHECKER,
      AaveV3EthereumAssets.USDC_UNDERLYING,
      AaveV3EthereumAssets.GHO_UNDERLYING,
      AaveV3EthereumAssets.USDC_ORACLE,
      GHO_USD_FEED,
      address(AaveV3EthereumLido.COLLECTOR),
      IERC20(AaveV3EthereumAssets.USDC_UNDERLYING).balanceOf(MiscEthereum.AAVE_SWAPPER),
      100
    );
  }

  function newListings() public pure override returns (IAaveV3ConfigEngine.Listing[] memory) {
    IAaveV3ConfigEngine.Listing[] memory listings = new IAaveV3ConfigEngine.Listing[](1);

    listings[0] = IAaveV3ConfigEngine.Listing({
      asset: AaveV3EthereumAssets.GHO_UNDERLYING,
      assetSymbol: 'GHO',
      priceFeed: AaveV3EthereumAssets.GHO_ORACLE,
      enabledToBorrow: EngineFlags.ENABLED,
      borrowableInIsolation: EngineFlags.DISABLED,
      withSiloedBorrowing: EngineFlags.DISABLED,
      flashloanable: EngineFlags.ENABLED,
      ltv: 0,
      liqThreshold: 0,
      liqBonus: 0,
      reserveFactor: 10_00,
      supplyCap: 20_000_000,
      borrowCap: 2_500_000,
      debtCeiling: 0,
      liqProtocolFee: 0,
      rateStrategyParams: IAaveV3ConfigEngine.InterestRateInputData({
        optimalUsageRatio: 92_00,
        baseVariableBorrowRate: 10_50,
        variableRateSlope1: 3_00,
        variableRateSlope2: 50_00
      })
    });

    return listings;
  }

  function assetsEModeUpdates()
    public
    pure
    override
    returns (IAaveV3ConfigEngine.AssetEModeUpdate[] memory)
  {
    IAaveV3ConfigEngine.AssetEModeUpdate[]
      memory assetEModeUpdates = new IAaveV3ConfigEngine.AssetEModeUpdate[](3);

    assetEModeUpdates[0] = IAaveV3ConfigEngine.AssetEModeUpdate({
      asset: AaveV3EthereumAssets.GHO_UNDERLYING,
      eModeCategory: AaveV3EthereumLidoEModes.SUSDE_STABLECOINS,
      borrowable: EngineFlags.ENABLED,
      collateral: EngineFlags.DISABLED
    });

    assetEModeUpdates[1] = IAaveV3ConfigEngine.AssetEModeUpdate({
      asset: AaveV3EthereumAssets.USDC_UNDERLYING,
      eModeCategory: AaveV3EthereumLidoEModes.LRT_STABLECOINS_MAIN,
      borrowable: EngineFlags.ENABLED,
      collateral: EngineFlags.DISABLED
    });

    assetEModeUpdates[2] = IAaveV3ConfigEngine.AssetEModeUpdate({
      asset: AaveV3EthereumAssets.GHO_UNDERLYING,
      eModeCategory: AaveV3EthereumLidoEModes.LRT_STABLECOINS_MAIN,
      borrowable: EngineFlags.ENABLED,
      collateral: EngineFlags.DISABLED
    });

    return assetEModeUpdates;
  }
}
