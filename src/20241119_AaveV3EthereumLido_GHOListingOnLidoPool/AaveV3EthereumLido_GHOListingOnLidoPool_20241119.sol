// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3EthereumLido} from 'aave-address-book/AaveV3EthereumLido.sol';
import {AaveV3PayloadEthereumLido} from 'aave-helpers/src/v3-config-engine/AaveV3PayloadEthereumLido.sol';
import {EngineFlags} from 'aave-v3-origin/contracts/extensions/v3-config-engine/EngineFlags.sol';
import {IAaveV3ConfigEngine} from 'aave-v3-origin/contracts/extensions/v3-config-engine/IAaveV3ConfigEngine.sol';
import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {SafeERC20} from 'solidity-utils/contracts/oz-common/SafeERC20.sol';
import {IGhoToken} from '../interfaces/IGhoToken.sol';

/**
 * @title GHO listing on Lido pool
 * @author BGD Labs @bgdlabs
 * - Snapshot: TODO
 * - Discussion: https://governance.aave.com/t/arfc-mint-deploy-10m-gho-into-aave-v3-lido-instance/19700/3
 */
contract AaveV3EthereumLido_GHOListingOnLidoPool_20241119 is AaveV3PayloadEthereumLido {
  using SafeERC20 for IERC20;

  address public constant GHO = 0x40D16FC0246aD3160Ccc09B8D0D3A2cD28aE6C2f;
  uint128 public constant GHO_AMOUNT = 10_000_000e18;

  function _preExecute() internal override {
    IGhoToken(GHO).addFacilitator(address(this), 'DDM', GHO_AMOUNT);
    IGhoToken(GHO).mint(address(this), GHO_AMOUNT);
  }

  function _postExecute() internal override {
    IERC20(GHO).forceApprove(address(AaveV3EthereumLido.POOL), GHO_AMOUNT);
    AaveV3EthereumLido.POOL.supply(GHO, GHO_AMOUNT, address(AaveV3EthereumLido.COLLECTOR), 0);
    // after supplying, set the supply cap close to zero (not zero as zero means no cap)
    // to prevent supply even if aTokens are burned
    AaveV3EthereumLido.POOL_CONFIGURATOR.setSupplyCap(GHO, 1);
  }

  function newListings() public pure override returns (IAaveV3ConfigEngine.Listing[] memory) {
    IAaveV3ConfigEngine.Listing[] memory listings = new IAaveV3ConfigEngine.Listing[](1);

    listings[0] = IAaveV3ConfigEngine.Listing({
      asset: GHO,
      assetSymbol: 'GHO',
      priceFeed: 0xD110cac5d8682A3b045D5524a9903E031d70FCCd,
      enabledToBorrow: EngineFlags.ENABLED,
      borrowableInIsolation: EngineFlags.DISABLED,
      withSiloedBorrowing: EngineFlags.DISABLED,
      flashloanable: EngineFlags.ENABLED,
      ltv: 0,
      liqThreshold: 0,
      liqBonus: 0,
      // reserveFactor is arbitrary, as all GHO is supplied by the DAO
      // setting it to 100_00 will prevent index growth on the aToken
      reserveFactor: 100_00,
      supplyCap: 0,
      borrowCap: GHO_AMOUNT / 1e18,
      debtCeiling: 0,
      liqProtocolFee: 20_00,
      rateStrategyParams: IAaveV3ConfigEngine.InterestRateInputData({
        optimalUsageRatio: 50_00,
        baseVariableBorrowRate: 4_00,
        variableRateSlope1: 0,
        variableRateSlope2: 0
      })
    });

    return listings;
  }
}
