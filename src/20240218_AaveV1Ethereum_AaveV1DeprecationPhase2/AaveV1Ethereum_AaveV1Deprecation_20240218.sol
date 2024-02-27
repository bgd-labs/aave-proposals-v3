// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';

interface ILendingPoolAddressesProvider {
  function getLendingPoolCore() external view returns (address);

  function getLendingPool() external view returns (address);

  function getLendingPoolLiquidationManager() external view returns (address);

  function setLendingPoolImpl(address _pool) external;

  function setLendingPoolLiquidationManager(address _manager) external;
}

interface ILendingPoolCore {
  function getReserves() external view returns (address[] memory);

  function getReserveInterestRateStrategyAddress(address) external view returns (address);

  function getReserveATokenAddress(address) external view returns (address);
}

interface IPoolConfigurator {
  function setReserveInterestRateStrategyAddress(
    address _reserve,
    address _rateStrategyAddress
  ) external;
}

/**
 * @title Aave V1 Deprecation Phase 2
 * @author BGD Labs @bgdlabs
 * - Snapshot: https://snapshot.org/#/aave.eth/proposal/0x7451f00809986c7cb8cce7ef4587efdfedad06089ebf2851d64122d00b035d9c
 * - Discussion: https://governance.aave.com/t/temp-check-bgd-further-aave-v1-deprecation-strategy/15893/5
 */
contract AaveV1Ethereum_AaveV1Deprecation_20240218 is IProposalGenericExecutor {
  ILendingPoolAddressesProvider public constant ADDRESSES_PROVIDER =
    ILendingPoolAddressesProvider(0x24a42fD28C976A61Df5D00D0599C34c4f90748c8);

  address public constant LIQUIDATION_MANAGER_IMPL =
    address(0x60eE8b61a13c67d0191c851BEC8F0bc850160710);

  function execute() external {
    ADDRESSES_PROVIDER.setLendingPoolLiquidationManager(LIQUIDATION_MANAGER_IMPL);
  }
}
