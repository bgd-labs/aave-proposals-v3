// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Avalanche} from 'aave-address-book/AaveV3Avalanche.sol';
import {ChainlinkAvalanche} from 'aave-address-book/ChainlinkAvalanche.sol';
import {AaveV3PayloadAvalanche} from 'aave-helpers/src/v3-config-engine/AaveV3PayloadAvalanche.sol';
import {EngineFlags} from 'aave-v3-origin/contracts/extensions/v3-config-engine/EngineFlags.sol';
import {IAaveV3ConfigEngine} from 'aave-v3-origin/contracts/extensions/v3-config-engine/IAaveV3ConfigEngine.sol';
import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {SafeERC20} from 'openzeppelin-contracts/contracts/token/ERC20/utils/SafeERC20.sol';
import {IEmissionManager} from 'aave-v3-origin/contracts/rewards/interfaces/IEmissionManager.sol';

/**
 * @title Add EURC to Avalanche V3 Instance
 * @author Aave-Chan Initiative
 * - Snapshot: direct-to-AIP
 * - Discussion: https://governance.aave.com/t/arfc-add-eurc-to-avalanche-v3-instance/21734
 */
contract AaveV3Avalanche_AddEURCToAvalancheV3Instance_20250821 is AaveV3PayloadAvalanche {
  using SafeERC20 for IERC20;

  address public constant EURC = 0xC891EB4cbdEFf6e073e859e987815Ed1505c2ACD;
  uint256 public constant EURC_SEED_AMOUNT = 100e6;
  address public constant EURC_LM_ADMIN = 0xac140648435d03f784879cd789130F22Ef588Fcd;

  function _postExecute() internal override {
    IERC20(EURC).forceApprove(address(AaveV3Avalanche.POOL), EURC_SEED_AMOUNT);
    AaveV3Avalanche.POOL.supply(EURC, EURC_SEED_AMOUNT, AaveV3Avalanche.DUST_BIN, 0);

    address aEURC = AaveV3Avalanche.POOL.getReserveAToken(EURC);
    IEmissionManager(AaveV3Avalanche.EMISSION_MANAGER).setEmissionAdmin(EURC, EURC_LM_ADMIN);
    IEmissionManager(AaveV3Avalanche.EMISSION_MANAGER).setEmissionAdmin(aEURC, EURC_LM_ADMIN);
  }

  function newListings() public pure override returns (IAaveV3ConfigEngine.Listing[] memory) {
    IAaveV3ConfigEngine.Listing[] memory listings = new IAaveV3ConfigEngine.Listing[](1);

    listings[0] = IAaveV3ConfigEngine.Listing({
      asset: EURC,
      assetSymbol: 'EURC',
      priceFeed: ChainlinkAvalanche.EURC_USD,
      enabledToBorrow: EngineFlags.ENABLED,
      borrowableInIsolation: EngineFlags.DISABLED,
      withSiloedBorrowing: EngineFlags.DISABLED,
      flashloanable: EngineFlags.ENABLED,
      ltv: 75_00,
      liqThreshold: 78_00,
      liqBonus: 5_00,
      reserveFactor: 10_00,
      supplyCap: 3_000_000,
      borrowCap: 2_800_000,
      debtCeiling: 0,
      liqProtocolFee: 10_00,
      rateStrategyParams: IAaveV3ConfigEngine.InterestRateInputData({
        optimalUsageRatio: 90_00,
        baseVariableBorrowRate: 0,
        variableRateSlope1: 6_00,
        variableRateSlope2: 50_00
      })
    });

    return listings;
  }
}
