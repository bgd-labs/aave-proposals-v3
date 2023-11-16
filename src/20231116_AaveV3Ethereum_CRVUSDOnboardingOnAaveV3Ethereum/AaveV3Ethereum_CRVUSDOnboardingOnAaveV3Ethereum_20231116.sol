// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Ethereum, AaveV3EthereumEModes} from 'aave-address-book/AaveV3Ethereum.sol';
import {AaveV3PayloadEthereum} from 'aave-helpers/v3-config-engine/AaveV3PayloadEthereum.sol';
import {EngineFlags} from 'aave-helpers/v3-config-engine/EngineFlags.sol';
import {IAaveV3ConfigEngine} from 'aave-helpers/v3-config-engine/IAaveV3ConfigEngine.sol';
import {IV3RateStrategyFactory} from 'aave-helpers/v3-config-engine/IV3RateStrategyFactory.sol';
import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {SafeERC20} from 'solidity-utils/contracts/oz-common/SafeERC20.sol';

/**
 * @title CRVUSD onboarding on Aave V3 Ethereum
 * @author @Marczeller - Aave-chan Initiative
 * - Snapshot: https://snapshot.org/#/aave.eth/proposal/0xbc10b43fccd3954f02c9df774ba6f8335268727b999660738ae37a1b9d5b969e
 * - Discussion: https://governance.aave.com/t/arfc-crvusd-onboarding-on-aave-v3-ethereum-pool/15161
 */
contract AaveV3Ethereum_CRVUSDOnboardingOnAaveV3Ethereum_20231116 is AaveV3PayloadEthereum {
  using SafeERC20 for IERC20;

  address public constant crvUSD = 0xf939E0A03FB07F59A73314E73794Be0E57ac1b4E;
  uint256 internal constant crvUSD_SEED_AMOUNT = 11e18;

  function _postExecute() internal override {
    IERC20(crvUSD).forceApprove(address(AaveV3Ethereum.POOL), crvUSD_SEED_AMOUNT);
    AaveV3Ethereum.POOL.supply(crvUSD, crvUSD_SEED_AMOUNT, address(AaveV3Ethereum.COLLECTOR), 0);
  }

  function newListings() public pure override returns (IAaveV3ConfigEngine.Listing[] memory) {
    IAaveV3ConfigEngine.Listing[] memory listings = new IAaveV3ConfigEngine.Listing[](1);

    listings[0] = IAaveV3ConfigEngine.Listing({
      asset: crvUSD,
      assetSymbol: 'crvUSD',
      priceFeed: 0xEEf0C605546958c1f899b6fB336C20671f9cD49F,
      eModeCategory: AaveV3EthereumEModes.NONE,
      enabledToBorrow: EngineFlags.ENABLED,
      stableRateModeEnabled: EngineFlags.DISABLED,
      borrowableInIsolation: EngineFlags.DISABLED,
      withSiloedBorrowing: EngineFlags.DISABLED,
      flashloanable: EngineFlags.ENABLED,
      ltv: 0,
      liqThreshold: 0,
      liqBonus: 0,
      reserveFactor: 10_00,
      supplyCap: 60_000_000,
      borrowCap: 50_000_000,
      debtCeiling: 0,
      liqProtocolFee: 10_00,
      rateStrategyParams: IV3RateStrategyFactory.RateStrategyParams({
        optimalUsageRatio: _bpsToRay(80_00),
        baseVariableBorrowRate: _bpsToRay(0),
        variableRateSlope1: _bpsToRay(5_00),
        variableRateSlope2: _bpsToRay(80_00),
        stableRateSlope1: _bpsToRay(13_00),
        stableRateSlope2: _bpsToRay(300_00),
        baseStableRateOffset: _bpsToRay(3_00),
        stableRateExcessOffset: _bpsToRay(8_00),
        optimalStableToTotalDebtRatio: _bpsToRay(20_00)
      })
    });

    return listings;
  }
}
