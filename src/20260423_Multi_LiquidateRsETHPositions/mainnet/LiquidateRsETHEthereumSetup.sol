// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IAccessControl} from 'openzeppelin-contracts/contracts/access/IAccessControl.sol';
import {IPool, IPoolConfigurator, IAaveOracle, ICollector} from 'aave-address-book/AaveV3.sol';
import {IUmbrella} from 'aave-address-book/common/IUmbrella.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {UmbrellaEthereum} from 'aave-address-book/UmbrellaEthereum.sol';
import {LiquidateRsETHPositionsSetup} from '../setup/LiquidateRsETHPositionsSetup.sol';
import {LiquidateRsETHConstants} from '../setup/LiquidateRsETHConstants.sol';

abstract contract LiquidateRsETHEthereumSetup is LiquidateRsETHPositionsSetup {
  bytes32 internal constant DEFAULT_ADMIN_ROLE = 0x00;

  function POOL() public pure override returns (IPool) {
    return IPool(AaveV3Ethereum.POOL);
  }

  function ORACLE() public pure override returns (IAaveOracle) {
    return IAaveOracle(AaveV3Ethereum.ORACLE);
  }

  function POOL_CONFIGURATOR() public pure override returns (IPoolConfigurator) {
    return IPoolConfigurator(AaveV3Ethereum.POOL_CONFIGURATOR);
  }

  function COLLECTOR() public pure override returns (ICollector) {
    return ICollector(AaveV3Ethereum.COLLECTOR);
  }

  function RSETH() public pure override returns (address) {
    return AaveV3EthereumAssets.rsETH_UNDERLYING;
  }

  function WETH() public pure override returns (address) {
    return AaveV3EthereumAssets.WETH_UNDERLYING;
  }

  function WSTETH() public pure override returns (address) {
    return AaveV3EthereumAssets.wstETH_UNDERLYING;
  }

  function FIXED_PRICE_FEED() public pure override returns (address) {
    return LiquidateRsETHConstants.ETH_FIXED_PRICE_FEED;
  }

  function RECOVERY_GUARDIAN() public pure override returns (address) {
    return LiquidateRsETHConstants.ETH_RECOVERY_GUARDIAN;
  }

  function GUARDIAN_ENABLED_FLAG() public pure override returns (address) {
    return LiquidateRsETHConstants.ETH_GUARDIAN_ENABLED_FLAG;
  }

  function UMBRELLA() public pure returns (IUmbrella) {
    return IUmbrella(UmbrellaEthereum.UMBRELLA);
  }

  function _beforeLiquidations(ExecuteState memory s) internal virtual override {
    IUmbrella umbrella = UMBRELLA();
    umbrella.setDeficitOffset(WETH(), umbrella.getDeficitOffset(WETH()) + s.staticWethDebt);
  }

  function _afterLiquidations(ExecuteState memory) internal virtual override {
    IAccessControl umbrellaAccessControl = IAccessControl(address(UMBRELLA()));
    if (!umbrellaAccessControl.hasRole(DEFAULT_ADMIN_ROLE, RECOVERY_GUARDIAN())) {
      umbrellaAccessControl.grantRole(DEFAULT_ADMIN_ROLE, RECOVERY_GUARDIAN());
    }
  }
}
