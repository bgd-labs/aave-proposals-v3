// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IPool, IPoolConfigurator, IAaveOracle, ICollector} from 'aave-address-book/AaveV3.sol';
import {AaveV3Arbitrum, AaveV3ArbitrumAssets} from 'aave-address-book/AaveV3Arbitrum.sol';
import {LiquidateRsETHPositionsSetup} from '../setup/LiquidateRsETHPositionsSetup.sol';
import {LiquidateRsETHConstants} from '../setup/LiquidateRsETHConstants.sol';

abstract contract LiquidateRsETHArbitrumSetup is LiquidateRsETHPositionsSetup {
  function POOL() public pure override returns (IPool) {
    return IPool(AaveV3Arbitrum.POOL);
  }

  function ORACLE() public pure override returns (IAaveOracle) {
    return IAaveOracle(AaveV3Arbitrum.ORACLE);
  }

  function POOL_CONFIGURATOR() public pure override returns (IPoolConfigurator) {
    return IPoolConfigurator(AaveV3Arbitrum.POOL_CONFIGURATOR);
  }

  function COLLECTOR() public pure override returns (ICollector) {
    return ICollector(AaveV3Arbitrum.COLLECTOR);
  }

  function RSETH() public pure override returns (address) {
    return AaveV3ArbitrumAssets.rsETH_UNDERLYING;
  }

  function WETH() public pure override returns (address) {
    return AaveV3ArbitrumAssets.WETH_UNDERLYING;
  }

  function WSTETH() public pure override returns (address) {
    return AaveV3ArbitrumAssets.wstETH_UNDERLYING;
  }

  function FIXED_PRICE_FEED() public pure override returns (address) {
    return LiquidateRsETHConstants.ARB_FIXED_PRICE_FEED;
  }

  function RECOVERY_GUARDIAN() public pure override returns (address) {
    return LiquidateRsETHConstants.ARB_RECOVERY_GUARDIAN;
  }

  function GUARDIAN_ENABLED_FLAG() public pure override returns (address) {
    return LiquidateRsETHConstants.ARB_GUARDIAN_ENABLED_FLAG;
  }

  function _beforeLiquidations(ExecuteState memory) internal virtual override {
    // intentionally left blank
  }

  function _afterLiquidations(ExecuteState memory) internal virtual override {
    if (POOL().ADDRESSES_PROVIDER().getAddress(bytes32('UMBRELLA')) != RECOVERY_GUARDIAN()) {
      POOL().ADDRESSES_PROVIDER().setAddress(bytes32('UMBRELLA'), RECOVERY_GUARDIAN());
    }
  }
}
