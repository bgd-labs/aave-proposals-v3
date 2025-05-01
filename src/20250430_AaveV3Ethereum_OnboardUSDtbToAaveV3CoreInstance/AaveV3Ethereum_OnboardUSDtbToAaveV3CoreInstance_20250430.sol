// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Ethereum} from 'aave-address-book/AaveV3Ethereum.sol';
import {AaveV3PayloadEthereum} from 'aave-helpers/src/v3-config-engine/AaveV3PayloadEthereum.sol';
import {EngineFlags} from 'aave-v3-origin/contracts/extensions/v3-config-engine/EngineFlags.sol';
import {IAaveV3ConfigEngine} from 'aave-v3-origin/contracts/extensions/v3-config-engine/IAaveV3ConfigEngine.sol';
import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {SafeERC20} from 'openzeppelin-contracts/contracts/token/ERC20/utils/SafeERC20.sol';
import {IEmissionManager} from 'aave-v3-origin/contracts/rewards/interfaces/IEmissionManager.sol';
/**
 * @title Onboard USDtb to Aave v3 Core Instance
 * @author Aave-Chan Initiative
 * - Snapshot: https://snapshot.box/#/s:aavedao.eth/proposal/0xf7ff963e0572d684bfd0c6d572a070d1b6ea60f4bcebbd6f68fc2af9c1e46659
 * - Discussion: https://governance.aave.com/t/arfc-onboard-usdtb-to-aave-v3-core-instance/21746
 */
contract AaveV3Ethereum_OnboardUSDtbToAaveV3CoreInstance_20250430 is AaveV3PayloadEthereum {
  using SafeERC20 for IERC20;

  address public constant USDtb = 0xC139190F447e929f090Edeb554D95AbB8b18aC1C;
  uint256 public constant USDtb_SEED_AMOUNT = 100e18;
  address public constant USDtb_LM_ADMIN = 0xac140648435d03f784879cd789130F22Ef588Fcd;

  function _postExecute() internal override {
    IERC20(USDtb).forceApprove(address(AaveV3Ethereum.POOL), USDtb_SEED_AMOUNT);
    AaveV3Ethereum.POOL.supply(USDtb, USDtb_SEED_AMOUNT, AaveV3Ethereum.DUST_BIN, 0);

    address aUSDtb = AaveV3Ethereum.POOL.getReserveAToken(USDtb);
    IEmissionManager(AaveV3Ethereum.EMISSION_MANAGER).setEmissionAdmin(USDtb, USDtb_LM_ADMIN);
    IEmissionManager(AaveV3Ethereum.EMISSION_MANAGER).setEmissionAdmin(aUSDtb, USDtb_LM_ADMIN);
  }

  function newListings() public pure override returns (IAaveV3ConfigEngine.Listing[] memory) {
    IAaveV3ConfigEngine.Listing[] memory listings = new IAaveV3ConfigEngine.Listing[](1);

    listings[0] = IAaveV3ConfigEngine.Listing({
      asset: USDtb,
      assetSymbol: 'USDtb',
      priceFeed: 0x2FA6A78E3d617c1013a22938411602dc9Da98dBa,
      enabledToBorrow: EngineFlags.ENABLED,
      borrowableInIsolation: EngineFlags.DISABLED,
      withSiloedBorrowing: EngineFlags.DISABLED,
      flashloanable: EngineFlags.ENABLED,
      ltv: 0,
      liqThreshold: 0,
      liqBonus: 0,
      reserveFactor: 10_00,
      supplyCap: 50_000_000,
      borrowCap: 40_000_000,
      debtCeiling: 0,
      liqProtocolFee: 0,
      rateStrategyParams: IAaveV3ConfigEngine.InterestRateInputData({
        optimalUsageRatio: 80_00,
        baseVariableBorrowRate: 0,
        variableRateSlope1: 6_00,
        variableRateSlope2: 50_00
      })
    });

    return listings;
  }
}
