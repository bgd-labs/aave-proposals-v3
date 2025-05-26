// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Celo} from 'aave-address-book/AaveV3Celo.sol';
import {ChainlinkCelo} from 'aave-address-book/ChainlinkCelo.sol';
import {AaveV3PayloadCelo} from 'aave-helpers/src/v3-config-engine/AaveV3PayloadCelo.sol';
import {EngineFlags} from 'aave-v3-origin/contracts/extensions/v3-config-engine/EngineFlags.sol';
import {IAaveV3ConfigEngine} from 'aave-v3-origin/contracts/extensions/v3-config-engine/IAaveV3ConfigEngine.sol';
import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {SafeERC20} from 'openzeppelin-contracts/contracts/token/ERC20/utils/SafeERC20.sol';
import {IEmissionManager} from 'aave-v3-origin/contracts/rewards/interfaces/IEmissionManager.sol';
/**
 * @title  Onboarding wETH to Aave V3 Celo Instance
 * @author Aave-Chan Initiative
 * - Snapshot: https://snapshot.box/#/s:aavedao.eth/proposal/0xcf4e56350b6dc4615f4206a02d41c8f5958bc9a71594bed975e2657c9bc0b9b8
 * - Discussion: https://governance.aave.com/t/arfc-onboarding-weth-to-aave-v3-celo-instance/21750
 */
contract AaveV3Celo_OnboardingWETHToAaveV3CeloInstance_20250515 is AaveV3PayloadCelo {
  using SafeERC20 for IERC20;

  address public constant WETH = 0xD221812de1BD094f35587EE8E174B07B6167D9Af;
  uint256 public constant WETH_SEED_AMOUNT = 5e16;
  address public constant WETH_LM_ADMIN = 0xac140648435d03f784879cd789130F22Ef588Fcd;

  function _postExecute() internal override {
    IERC20(WETH).forceApprove(address(AaveV3Celo.POOL), WETH_SEED_AMOUNT);
    AaveV3Celo.POOL.supply(WETH, WETH_SEED_AMOUNT, AaveV3Celo.DUST_BIN, 0);

    address aWETH = AaveV3Celo.POOL.getReserveAToken(WETH);
    IEmissionManager(AaveV3Celo.EMISSION_MANAGER).setEmissionAdmin(WETH, WETH_LM_ADMIN);
    IEmissionManager(AaveV3Celo.EMISSION_MANAGER).setEmissionAdmin(aWETH, WETH_LM_ADMIN);
  }

  function newListings() public pure override returns (IAaveV3ConfigEngine.Listing[] memory) {
    IAaveV3ConfigEngine.Listing[] memory listings = new IAaveV3ConfigEngine.Listing[](1);

    listings[0] = IAaveV3ConfigEngine.Listing({
      asset: WETH,
      assetSymbol: 'WETH',
      priceFeed: ChainlinkCelo.ETH_USD,
      enabledToBorrow: EngineFlags.ENABLED,
      borrowableInIsolation: EngineFlags.DISABLED,
      withSiloedBorrowing: EngineFlags.DISABLED,
      flashloanable: EngineFlags.ENABLED,
      ltv: 78_00,
      liqThreshold: 80_00,
      liqBonus: 7_50,
      reserveFactor: 15_00,
      supplyCap: 500,
      borrowCap: 450,
      debtCeiling: 0,
      liqProtocolFee: 10_00,
      rateStrategyParams: IAaveV3ConfigEngine.InterestRateInputData({
        optimalUsageRatio: 90_00,
        baseVariableBorrowRate: 0,
        variableRateSlope1: 2_70,
        variableRateSlope2: 80_00
      })
    });

    return listings;
  }
}
