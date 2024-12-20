// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Avalanche} from 'aave-address-book/AaveV3Avalanche.sol';
import {GovernanceV3Avalanche} from 'aave-address-book/GovernanceV3Avalanche.sol';
import {AaveV3PayloadAvalanche} from 'aave-helpers/src/v3-config-engine/AaveV3PayloadAvalanche.sol';
import {EngineFlags} from 'aave-v3-origin/contracts/extensions/v3-config-engine/EngineFlags.sol';
import {IAaveV3ConfigEngine} from 'aave-v3-origin/contracts/extensions/v3-config-engine/IAaveV3ConfigEngine.sol';
import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {SafeERC20} from 'solidity-utils/contracts/oz-common/SafeERC20.sol';
import {IEmissionManager} from 'aave-v3-origin/contracts/rewards/interfaces/IEmissionManager.sol';
/**
 * @title Onboard AUSD
 * @author ACI
 * - Snapshot: https://snapshot.org/#/aave.eth/proposal/0x021b40c7042ce770c0ce1ee5ff63591c132a9f0f12e3a1cb92fa209299793dec
 * - Discussion: https://governance.aave.com/t/arfc-onboard-ausd-to-aave-v3-on-avalanche/19689
 */
contract AaveV3Avalanche_OnboardAUSD_20241125 is AaveV3PayloadAvalanche {
  using SafeERC20 for IERC20;

  address public constant AUSD = 0x00000000eFE302BEAA2b3e6e1b18d08D69a9012a;
  uint256 public constant AUSD_SEED_AMOUNT = 100e6;
  address public constant AUSD_ADMIN = 0xac140648435d03f784879cd789130F22Ef588Fcd;

  function _postExecute() internal override {
    // transfer AUSD seed amount from collector to executor (fix the mistakes of wrong AUSD seed amount reicipient)
    AaveV3Avalanche.COLLECTOR.transfer(
      AUSD,
      GovernanceV3Avalanche.EXECUTOR_LVL_1,
      AUSD_SEED_AMOUNT
    );

    IERC20(AUSD).forceApprove(address(AaveV3Avalanche.POOL), AUSD_SEED_AMOUNT);
    AaveV3Avalanche.POOL.supply(AUSD, AUSD_SEED_AMOUNT, address(AaveV3Avalanche.COLLECTOR), 0);

    (address aAUSD, , ) = AaveV3Avalanche.AAVE_PROTOCOL_DATA_PROVIDER.getReserveTokensAddresses(
      AUSD
    );
    IEmissionManager(AaveV3Avalanche.EMISSION_MANAGER).setEmissionAdmin(AUSD, AUSD_ADMIN);
    IEmissionManager(AaveV3Avalanche.EMISSION_MANAGER).setEmissionAdmin(aAUSD, AUSD_ADMIN);
  }

  function newListings() public pure override returns (IAaveV3ConfigEngine.Listing[] memory) {
    IAaveV3ConfigEngine.Listing[] memory listings = new IAaveV3ConfigEngine.Listing[](1);

    listings[0] = IAaveV3ConfigEngine.Listing({
      asset: AUSD,
      assetSymbol: 'AUSD',
      priceFeed: 0x83f32c0882B12Ef16214c417efF11FD9e764bf34,
      enabledToBorrow: EngineFlags.ENABLED,
      borrowableInIsolation: EngineFlags.DISABLED,
      withSiloedBorrowing: EngineFlags.DISABLED,
      flashloanable: EngineFlags.ENABLED,
      ltv: 0,
      liqThreshold: 0,
      liqBonus: 0,
      reserveFactor: 10_00,
      supplyCap: 19_000_000,
      borrowCap: 17_400_000,
      debtCeiling: 0,
      liqProtocolFee: 0,
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
