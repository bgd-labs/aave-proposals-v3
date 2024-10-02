// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3EthereumLido, AaveV3EthereumLidoEModes} from 'aave-address-book/AaveV3EthereumLido.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {AaveV3PayloadEthereumLido} from 'aave-helpers/src/v3-config-engine/AaveV3PayloadEthereumLido.sol';
import {EngineFlags} from 'aave-v3-periphery/contracts/v3-config-engine/EngineFlags.sol';
import {IAaveV3ConfigEngine} from 'aave-v3-periphery/contracts/v3-config-engine/IAaveV3ConfigEngine.sol';
import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {SafeERC20} from 'solidity-utils/contracts/oz-common/SafeERC20.sol';
/**
 * @title Onboard USDC to Aave V3 Lido Instance
 * @author ACI
 * - Snapshot: https://snapshot.org/#/aave.eth/proposal/0x6146daa40066e4000333f628f94263101ae03731ccd9a64303013a26172c9eef
 * - Discussion: https://governance.aave.com/t/arfc-onboard-usdc-to-aave-v3-lido-instance/19201
 */
contract AaveV3EthereumLido_OnboardUSDCToAaveV3LidoInstance_20241002 is AaveV3PayloadEthereumLido {
  using SafeERC20 for IERC20;

  address public constant USDC = 0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48;
  uint256 public constant USDC_SEED_AMOUNT = 100e6;

  function _postExecute() internal override {
    IERC20(USDC).forceApprove(address(AaveV3EthereumLido.POOL), USDC_SEED_AMOUNT);
    AaveV3EthereumLido.POOL.supply(
      USDC,
      USDC_SEED_AMOUNT,
      address(AaveV3EthereumLido.COLLECTOR),
      0
    );
  }

  function newListings() public pure override returns (IAaveV3ConfigEngine.Listing[] memory) {
    IAaveV3ConfigEngine.Listing[] memory listings = new IAaveV3ConfigEngine.Listing[](1);

    listings[0] = IAaveV3ConfigEngine.Listing({
      asset: USDC,
      assetSymbol: 'USDC',
      priceFeed: AaveV3EthereumAssets.USDC_ORACLE,
      eModeCategory: AaveV3EthereumLidoEModes.NONE,
      enabledToBorrow: EngineFlags.ENABLED,
      stableRateModeEnabled: EngineFlags.DISABLED,
      borrowableInIsolation: EngineFlags.ENABLED,
      withSiloedBorrowing: EngineFlags.DISABLED,
      flashloanable: EngineFlags.ENABLED,
      ltv: 0,
      liqThreshold: 0,
      liqBonus: 0,
      reserveFactor: 10_00,
      supplyCap: 30_000_000,
      borrowCap: 27_600_000,
      debtCeiling: 0,
      liqProtocolFee: 10_00,
      rateStrategyParams: IAaveV3ConfigEngine.InterestRateInputData({
        optimalUsageRatio: 92_00,
        baseVariableBorrowRate: 0,
        variableRateSlope1: 5_50,
        variableRateSlope2: 60_00
      })
    });

    return listings;
  }
}
