// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';
import {IPoolAddressesProvider} from 'aave-address-book/AaveV3.sol';
import {Address} from 'solidity-utils/contracts/oz-common/Address.sol';

contract AaveV3GenericPatch_20240104 is IProposalGenericExecutor {
  address public immutable NEW_POOL_IMPL;
  IPoolAddressesProvider public immutable POOL_ADDRESSES_PROVIDER;

  constructor(address newPoolImpl, IPoolAddressesProvider poolAddressesProvider) {
    NEW_POOL_IMPL = newPoolImpl;
    POOL_ADDRESSES_PROVIDER = poolAddressesProvider;
  }

  function execute() external {
    require(Address.isContract(NEW_POOL_IMPL), 'CONTRACT_NON_YET_DEPLOYED');
    POOL_ADDRESSES_PROVIDER.setPoolImpl(NEW_POOL_IMPL);
  }
}
