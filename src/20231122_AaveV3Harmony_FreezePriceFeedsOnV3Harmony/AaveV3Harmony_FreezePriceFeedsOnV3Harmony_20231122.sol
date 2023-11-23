// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Harmony, AaveV3HarmonyAssets} from 'aave-address-book/AaveV3Harmony.sol';

import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';
import {StewardBase} from './StewardBase.sol';

/**
 * @title Freeze price feeds on v3 Harmony
 * @author BGD Labs (@bgdlabs)
 * - Discussion: https://governance.aave.com/t/bgd-technical-maintenance-proposals/15274/6
 */
contract AaveV3Harmony_FreezePriceFeedsOnV3Harmony_20231122 is
  StewardBase,
  IProposalGenericExecutor
{
  address public constant ZERO_IR_STRATEGY = 0x230E0321Cf38F09e247e50Afc7801EA2351fe56F;

  constructor(address newOwner) {
    _transferOwnership(newOwner);
  }

  function execute()
    external
    withRennounceOfAllAavePermissions(AaveV3Harmony.ACL_MANAGER)
    withOwnershipBurning
    onlyOwner
  {
    address[] memory assets = new address[](8);
    assets[0] = AaveV3HarmonyAssets.ONE_DAI_UNDERLYING;
    assets[1] = AaveV3HarmonyAssets.ONE_USDC_UNDERLYING;
    assets[2] = AaveV3HarmonyAssets.ONE_USDT_UNDERLYING;
    assets[3] = AaveV3HarmonyAssets.WONE_UNDERLYING;
    assets[4] = AaveV3HarmonyAssets.LINK_UNDERLYING;
    assets[5] = AaveV3HarmonyAssets.ONE_WBTC_UNDERLYING;
    assets[6] = AaveV3HarmonyAssets.ONE_ETH_UNDERLYING;
    assets[7] = AaveV3HarmonyAssets.ONE_AAVE_UNDERLYING;

    address[] memory priceAdapters = new address[](8);
    priceAdapters[0] = 0x981AB570aC289938F296b975C524B66FBF1B8774;
    priceAdapters[1] = 0xA9F30e6ED4098e9439B2ac8aEA2d3fc26BcEbb45;
    priceAdapters[2] = 0x05225Cd708bCa9253789C1374e4337a019e99D56;
    priceAdapters[3] = 0x3105C276558Dd4cf7E7be71d73Be8D33bD18F211;
    priceAdapters[4] = 0x80f2c02224a2E548FC67c0bF705eBFA825dd5439;
    priceAdapters[5] = 0x945fD405773973d286De54E44649cc0d9e264F78;
    priceAdapters[6] = 0x7fc3FCb14eF04A48Bb0c12f0c39CD74C249c37d8;
    priceAdapters[7] = 0xFD858c8bC5ac5e10f01018bC78471bb0DC392247;

    // set new asset price sources
    AaveV3Harmony.ORACLE.setAssetSources(assets, priceAdapters);

    // set zero interest rate strategy
    for (uint256 i = 0; i < assets.length; i++) {
      AaveV3Harmony.POOL_CONFIGURATOR.setReserveInterestRateStrategyAddress(
        assets[i],
        ZERO_IR_STRATEGY
      );
    }
  }
}
