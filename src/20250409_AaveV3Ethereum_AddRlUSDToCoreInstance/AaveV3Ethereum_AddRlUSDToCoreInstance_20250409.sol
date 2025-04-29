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
 * @title Add rlUSD to Core Instance
 * @author ACI
 * - Snapshot: https://snapshot.box/#/s:aavedao.eth/proposal/0x539ad30f3d3d531702bb7619fc0a9a44dc2da6a8e022eff7ffdc678032e0a8b9
 * - Discussion: https://governance.aave.com/t/arfc-add-rlusd-to-core-instance/20214
 */
contract AaveV3Ethereum_AddRlUSDToCoreInstance_20250409 is AaveV3PayloadEthereum {
  using SafeERC20 for IERC20;

  address public constant RLUSD = 0x8292Bb45bf1Ee4d140127049757C2E0fF06317eD;
  uint256 public constant RLUSD_SEED_AMOUNT = 100e18;
  address public constant RLUSD_LM_ADMIN = 0xac140648435d03f784879cd789130F22Ef588Fcd;

  function _postExecute() internal override {
    IERC20(RLUSD).forceApprove(address(AaveV3Ethereum.POOL), RLUSD_SEED_AMOUNT);
    AaveV3Ethereum.POOL.supply(RLUSD, RLUSD_SEED_AMOUNT, AaveV3Ethereum.DUST_BIN, 0);

    address aRLUSD = AaveV3Ethereum.POOL.getReserveAToken(RLUSD);
    IEmissionManager(AaveV3Ethereum.EMISSION_MANAGER).setEmissionAdmin(RLUSD, RLUSD_LM_ADMIN);
    IEmissionManager(AaveV3Ethereum.EMISSION_MANAGER).setEmissionAdmin(aRLUSD, RLUSD_LM_ADMIN);
  }

  function newListings() public pure override returns (IAaveV3ConfigEngine.Listing[] memory) {
    IAaveV3ConfigEngine.Listing[] memory listings = new IAaveV3ConfigEngine.Listing[](1);

    listings[0] = IAaveV3ConfigEngine.Listing({
      asset: RLUSD,
      assetSymbol: 'RLUSD',
      priceFeed: 0xf0eaC18E908B34770FDEe46d069c846bDa866759,
      enabledToBorrow: EngineFlags.ENABLED,
      borrowableInIsolation: EngineFlags.DISABLED,
      withSiloedBorrowing: EngineFlags.DISABLED,
      flashloanable: EngineFlags.ENABLED,
      ltv: 0,
      liqThreshold: 0,
      liqBonus: 0,
      reserveFactor: 10_00,
      supplyCap: 50_000_000,
      borrowCap: 5_000_000,
      debtCeiling: 0,
      liqProtocolFee: 0,
      rateStrategyParams: IAaveV3ConfigEngine.InterestRateInputData({
        optimalUsageRatio: 80_00,
        baseVariableBorrowRate: 0,
        variableRateSlope1: 6_50,
        variableRateSlope2: 50_00
      })
    });

    return listings;
  }
}
