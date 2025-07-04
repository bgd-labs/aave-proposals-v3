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
 * @title Add EURC to Aave V3 Core Instance
 * @author Aave-Chan Initiative
 * - Snapshot: Direct-to-AIP
 * - Discussion: https://governance.aave.com/t/arfc-add-eurc-to-aave-v3-core-instance/21837
 */
contract AaveV3Ethereum_AddEURCToAaveV3CoreInstance_20250622 is AaveV3PayloadEthereum {
  using SafeERC20 for IERC20;

  address public constant EURC = 0x1aBaEA1f7C830bD89Acc67eC4af516284b1bC33c;
  uint256 public constant EURC_SEED_AMOUNT = 100e6;
  address public constant EURC_LM_ADMIN = 0xac140648435d03f784879cd789130F22Ef588Fcd;

  function _postExecute() internal override {
    IERC20(EURC).forceApprove(address(AaveV3Ethereum.POOL), EURC_SEED_AMOUNT);
    AaveV3Ethereum.POOL.supply(EURC, EURC_SEED_AMOUNT, AaveV3Ethereum.DUST_BIN, 0);

    address aEURC = AaveV3Ethereum.POOL.getReserveAToken(EURC);
    IEmissionManager(AaveV3Ethereum.EMISSION_MANAGER).setEmissionAdmin(EURC, EURC_LM_ADMIN);
    IEmissionManager(AaveV3Ethereum.EMISSION_MANAGER).setEmissionAdmin(aEURC, EURC_LM_ADMIN);
  }

  function newListings() public pure override returns (IAaveV3ConfigEngine.Listing[] memory) {
    IAaveV3ConfigEngine.Listing[] memory listings = new IAaveV3ConfigEngine.Listing[](1);

    listings[0] = IAaveV3ConfigEngine.Listing({
      asset: EURC,
      assetSymbol: 'EURC',
      priceFeed: 0xa6aB031A4d189B24628EC9Eb155F0a0f1A0E55a3,
      enabledToBorrow: EngineFlags.ENABLED,
      borrowableInIsolation: EngineFlags.DISABLED,
      withSiloedBorrowing: EngineFlags.DISABLED,
      flashloanable: EngineFlags.ENABLED,
      ltv: 75_00,
      liqThreshold: 78_00,
      liqBonus: 5_00,
      reserveFactor: 10_00,
      supplyCap: 7_000_000,
      borrowCap: 6_500_000,
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
