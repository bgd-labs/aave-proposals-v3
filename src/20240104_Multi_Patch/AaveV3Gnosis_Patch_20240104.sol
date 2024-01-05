// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';
import {AaveV3Gnosis} from 'aave-address-book/AaveV3Gnosis.sol';
import {PoolAddresses} from './PoolLibrary.sol';
import {Address} from 'solidity-utils/contracts/oz-common/Address.sol';

/**
 * @title Patch
 * @author BGD Labs @bgdlabs
 * - Snapshot: N/A
 * - Discussion: https://governance.aave.com/t/pre-cautionary-measures-on-three-aave-v3-assets/16037
 */
contract AaveV3Gnosis_Patch_20240104 is IProposalGenericExecutor {
  address public constant NEW_POOL_IMPL = address(PoolAddresses.GNOSIS_POOL_IMPL_ADDRESS);

  function execute() external {
    require(Address.isContract(NEW_POOL_IMPL), 'CONTRACT_NON_YET_DEPLOYED');
    AaveV3Gnosis.POOL_ADDRESSES_PROVIDER.setPoolImpl(NEW_POOL_IMPL);
  }
}
