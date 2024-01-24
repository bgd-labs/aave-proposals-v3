// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';

interface ILendingPoolAddressesProvider {
  function setLendingPoolImpl(address _pool) external;

  function setLendingPoolLiquidationManager(address _manager) external;
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

  address public constant LIQUIDATION_MANAGER_IMPL =
    address(0x1a7Dde6344d5F2888209DdB446756FE292e1325e);

  address public constant POOL_IMPL = address(0x89A943BAc327c9e217d70E57DCD57C7f2a8C3fA9);

  function execute() external {
    ADDRESSES_PROVIDER.setLendingPoolLiquidationManager(LIQUIDATION_MANAGER_IMPL);
    ADDRESSES_PROVIDER.setLendingPoolImpl(POOL_IMPL);
  }
}
