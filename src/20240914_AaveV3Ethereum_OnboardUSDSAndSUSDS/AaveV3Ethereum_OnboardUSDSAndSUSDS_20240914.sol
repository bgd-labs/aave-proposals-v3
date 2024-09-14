// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Ethereum, AaveV3EthereumEModes} from 'aave-address-book/AaveV3Ethereum.sol';
import {AaveV3PayloadEthereum} from 'aave-helpers/src/v3-config-engine/AaveV3PayloadEthereum.sol';
import {EngineFlags} from 'aave-v3-periphery/contracts/v3-config-engine/EngineFlags.sol';
import {IAaveV3ConfigEngine} from 'aave-v3-periphery/contracts/v3-config-engine/IAaveV3ConfigEngine.sol';
import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {SafeERC20} from 'solidity-utils/contracts/oz-common/SafeERC20.sol';
import {IPoolAddressesProviderRegistry} from 'aave-v3-core/contracts/interfaces/IPoolAddressesProviderRegistry.sol';
import {IEmissionManager} from 'aave-v3-periphery/contracts/rewards/interfaces/IEmissionManager.sol';
/**
 * @title Onboard USDS and SUSDS
 * @author ACI
 * - Snapshot: Direct-to-AIP
 * - Discussion: https://governance.aave.com/t/arfc-onboard-usds-and-susds-to-aave-v3/18987
 */
contract AaveV3Ethereum_OnboardUSDSAndSUSDS_20240914 is AaveV3PayloadEthereum {
  using SafeERC20 for IERC20;

  address public constant USDS = 0x1923DfeE706A8E78157416C29cBCCFDe7cdF4102;
  uint256 public constant USDS_SEED_AMOUNT = 100e18;
  address public constant sUSDS = 0x4e7991e5C547ce825BdEb665EE14a3274f9F61e0;
  uint256 public constant sUSDS_SEED_AMOUNT = 100e18;

  function _postExecute() internal override {
    IERC20(USDS).forceApprove(address(AaveV3Ethereum.POOL), USDS_SEED_AMOUNT);
    AaveV3Ethereum.POOL.supply(USDS, USDS_SEED_AMOUNT, address(AaveV3Ethereum.COLLECTOR), 0);
    IERC20(sUSDS).forceApprove(address(AaveV3Ethereum.POOL), sUSDS_SEED_AMOUNT);
    AaveV3Ethereum.POOL.supply(sUSDS, sUSDS_SEED_AMOUNT, address(AaveV3Ethereum.COLLECTOR), 0);
  }

  function newListings() public pure override returns (IAaveV3ConfigEngine.Listing[] memory) {
    IAaveV3ConfigEngine.Listing[] memory listings = new IAaveV3ConfigEngine.Listing[](2);

    listings[0] = IAaveV3ConfigEngine.Listing({
      asset: USDS,
      assetSymbol: 'USDS',
      priceFeed: 0x4F01b76391A05d32B20FA2d05dD5963eE8db20E6,
      eModeCategory: AaveV3EthereumEModes.NONE,
      enabledToBorrow: EngineFlags.ENABLED,
      stableRateModeEnabled: EngineFlags.DISABLED,
      borrowableInIsolation: EngineFlags.DISABLED,
      withSiloedBorrowing: EngineFlags.DISABLED,
      flashloanable: EngineFlags.ENABLED,
      ltv: 63_00,
      liqThreshold: 72_00,
      liqBonus: 7_50,
      reserveFactor: 25_00,
      supplyCap: 50_000_000,
      borrowCap: 45_000_000,
      debtCeiling: 0,
      liqProtocolFee: 10_00,
      rateStrategyParams: IAaveV3ConfigEngine.InterestRateInputData({
        optimalUsageRatio: 90_00,
        baseVariableBorrowRate: 0,
        variableRateSlope1: 5_50,
        variableRateSlope2: 75_00
      })
    });
    listings[1] = IAaveV3ConfigEngine.Listing({
      asset: sUSDS,
      assetSymbol: 'sUSDS',
      priceFeed: 0x408e905577653430Bb80d91e0ca433b338CEA7C6,
      eModeCategory: AaveV3EthereumEModes.NONE,
      enabledToBorrow: EngineFlags.DISABLED,
      stableRateModeEnabled: EngineFlags.DISABLED,
      borrowableInIsolation: EngineFlags.DISABLED,
      withSiloedBorrowing: EngineFlags.DISABLED,
      flashloanable: EngineFlags.ENABLED,
      ltv: 75_00,
      liqThreshold: 78_00,
      liqBonus: 7_50,
      reserveFactor: 25_00,
      supplyCap: 35_000_000,
      borrowCap: 0,
      debtCeiling: 0,
      liqProtocolFee: 10_00,
      rateStrategyParams: IAaveV3ConfigEngine.InterestRateInputData({
        optimalUsageRatio: 90_00,
        baseVariableBorrowRate: 0,
        variableRateSlope1: 5_50,
        variableRateSlope2: 75_00
      })
    });

    return listings;
  }
}
