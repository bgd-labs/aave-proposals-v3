// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {AaveV3EthereumLido} from 'aave-address-book/AaveV3EthereumLido.sol';
import {AaveV3PayloadEthereumLido} from 'aave-helpers/src/v3-config-engine/AaveV3PayloadEthereumLido.sol';
import {EngineFlags} from 'aave-v3-origin/contracts/extensions/v3-config-engine/EngineFlags.sol';
import {IAaveV3ConfigEngine} from 'aave-v3-origin/contracts/extensions/v3-config-engine/IAaveV3ConfigEngine.sol';
import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {SafeERC20} from 'solidity-utils/contracts/oz-common/SafeERC20.sol';

import {IGhoToken} from '../interfaces/IGhoToken.sol';
import {GHODirectMinter} from './GHODirectMinter.sol';

/**
 * @title GHO listing on Lido pool
 * @author BGD Labs @bgdlabs
 * - Snapshot: TODO
 * - Discussion: https://governance.aave.com/t/arfc-mint-deploy-10m-gho-into-aave-v3-lido-instance/19700/3
 */
contract AaveV3EthereumLido_GHOListingOnLidoPool_20241119 is AaveV3PayloadEthereumLido {
  using SafeERC20 for IERC20;

  // could be significantly more
  uint128 public constant GHO_MINT_AMOUNT = 100_000_000e18;
  uint256 public constant GHO_BORROW_CAP = 10_000_000e18;
  address public immutable VAULT;

  constructor(address vault) {
    VAULT = vault;
  }

  function _postExecute() internal override {
    IGhoToken(AaveV3EthereumAssets.GHO_UNDERLYING).addFacilitator(
      VAULT,
      'LidoGHODirectMinter',
      GHO_MINT_AMOUNT
    );
    GHODirectMinter(VAULT).mintAndSupply(GHO_MINT_AMOUNT);
  }

  function newListings() public pure override returns (IAaveV3ConfigEngine.Listing[] memory) {
    IAaveV3ConfigEngine.Listing[] memory listings = new IAaveV3ConfigEngine.Listing[](1);

    listings[0] = IAaveV3ConfigEngine.Listing({
      asset: AaveV3EthereumAssets.GHO_UNDERLYING,
      assetSymbol: 'GHO',
      // using hardcoded 1:1 oracle, same as on proto
      priceFeed: AaveV3EthereumAssets.GHO_ORACLE,
      enabledToBorrow: EngineFlags.ENABLED,
      borrowableInIsolation: EngineFlags.DISABLED,
      withSiloedBorrowing: EngineFlags.DISABLED,
      flashloanable: EngineFlags.ENABLED,
      ltv: 0,
      liqThreshold: 0,
      liqBonus: 0,
      // TODO: consult risk teams
      reserveFactor: 20_00,
      supplyCap: GHO_MINT_AMOUNT / 1e18,
      borrowCap: GHO_BORROW_CAP / 1e18,
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
