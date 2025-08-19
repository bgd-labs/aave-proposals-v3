// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Ethereum} from 'aave-address-book/AaveV3Ethereum.sol';
import {ChainlinkEthereum} from 'aave-address-book/ChainlinkEthereum.sol';
import {AaveV3PayloadEthereum} from 'aave-helpers/src/v3-config-engine/AaveV3PayloadEthereum.sol';
import {EngineFlags} from 'aave-v3-origin/contracts/extensions/v3-config-engine/EngineFlags.sol';
import {IAaveV3ConfigEngine} from 'aave-v3-origin/contracts/extensions/v3-config-engine/IAaveV3ConfigEngine.sol';
import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {SafeERC20} from 'openzeppelin-contracts/contracts/token/ERC20/utils/SafeERC20.sol';
import {IEmissionManager} from 'aave-v3-origin/contracts/rewards/interfaces/IEmissionManager.sol';

/**
 * @title Add XAUt to Aave v3 Core Instance
 * @author Aave-Chan Initiative
 * - Snapshot: https://snapshot.box/#/s:aavedao.eth/proposal/0x71290ec88466d70c071d0dcb93c230c298f69e8c7688af94cedcc1236bf14876
 * - Discussion: https://governance.aave.com/t/arfc-add-xaut-to-aave-v3-core-instance/22385
 */
contract AaveV3Ethereum_AddXAUtToAaveV3CoreInstance_20250818 is AaveV3PayloadEthereum {
  using SafeERC20 for IERC20;

  address public constant XAUt = 0x68749665FF8D2d112Fa859AA293F07A622782F38;
  uint256 public constant XAUt_SEED_AMOUNT = 4e4;
  address public constant XAUt_LM_ADMIN = 0xac140648435d03f784879cd789130F22Ef588Fcd;

  function _postExecute() internal override {
    IERC20(XAUt).forceApprove(address(AaveV3Ethereum.POOL), XAUt_SEED_AMOUNT);
    AaveV3Ethereum.POOL.supply(XAUt, XAUt_SEED_AMOUNT, AaveV3Ethereum.DUST_BIN, 0);

    address aXAUt = AaveV3Ethereum.POOL.getReserveAToken(XAUt);
    IEmissionManager(AaveV3Ethereum.EMISSION_MANAGER).setEmissionAdmin(XAUt, XAUt_LM_ADMIN);
    IEmissionManager(AaveV3Ethereum.EMISSION_MANAGER).setEmissionAdmin(aXAUt, XAUt_LM_ADMIN);
  }

  function newListings() public pure override returns (IAaveV3ConfigEngine.Listing[] memory) {
    IAaveV3ConfigEngine.Listing[] memory listings = new IAaveV3ConfigEngine.Listing[](1);

    listings[0] = IAaveV3ConfigEngine.Listing({
      asset: XAUt,
      assetSymbol: 'XAUt',
      priceFeed: ChainlinkEthereum.XAU_USD,
      enabledToBorrow: EngineFlags.DISABLED,
      borrowableInIsolation: EngineFlags.DISABLED,
      withSiloedBorrowing: EngineFlags.DISABLED,
      flashloanable: EngineFlags.ENABLED,
      ltv: 70_00,
      liqThreshold: 75_00,
      liqBonus: 6_00,
      reserveFactor: 20_00,
      supplyCap: 5_000,
      borrowCap: 1,
      debtCeiling: 3_000_000,
      liqProtocolFee: 10_00,
      rateStrategyParams: IAaveV3ConfigEngine.InterestRateInputData({
        optimalUsageRatio: 45_00,
        baseVariableBorrowRate: 0,
        variableRateSlope1: 10_00,
        variableRateSlope2: 300_00
      })
    });

    return listings;
  }
}
