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
 * @title Aave V1 Deprecation
 * @author BGD Labs @bgdlabs
 * - Snapshot: https://snapshot.org/#/aave.eth/proposal/0x7451f00809986c7cb8cce7ef4587efdfedad06089ebf2851d64122d00b035d9c
 * - Discussion: https://governance.aave.com/t/temp-check-bgd-further-aave-v1-deprecation-strategy/15893
 */
contract AaveV1Ethereum_AaveV1Deprecation_20240115 is IProposalGenericExecutor {
  ILendingPoolAddressesProvider public constant ADDRESSES_PROVIDER =
    ILendingPoolAddressesProvider(0x24a42fD28C976A61Df5D00D0599C34c4f90748c8);

  ILendingPoolCore public constant CORE =
    ILendingPoolCore(0x3dfd23A6c5E8BbcFc9581d2E864a68feb6a076d3);

  IPoolConfigurator public constant CONFIGURATOR =
    IPoolConfigurator(0x4965f6FA20fE9728deCf5165016fc338a5a85aBF);

  address public constant LIQUIDATION_MANAGER_IMPL =
    address(0x1a7Dde6344d5F2888209DdB446756FE292e1325e);

  address public constant POOL_IMPL = address(0x89A943BAc327c9e217d70E57DCD57C7f2a8C3fA9);

  address public constant MINIMAL_IR = address(0x9Bf9df78b1f7c76a473588c41321B5059b62981e);

  function execute() external {
    ADDRESSES_PROVIDER.setLendingPoolLiquidationManager(LIQUIDATION_MANAGER_IMPL);
    ADDRESSES_PROVIDER.setLendingPoolImpl(POOL_IMPL);
    address[] memory reserves = CORE.getReserves();
    for (uint256 i = 0; i < reserves.length; i++) {
      CONFIGURATOR.setReserveInterestRateStrategyAddress(reserves[i], MINIMAL_IR);
    }
  }
}
