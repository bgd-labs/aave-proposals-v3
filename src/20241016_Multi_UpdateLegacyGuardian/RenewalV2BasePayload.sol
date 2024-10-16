// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {ILendingPoolAddressesProvider} from 'aave-address-book/AaveV2.sol';

struct RenewalV2Params {
  ILendingPoolAddressesProvider addressesProvider;
  address guardian;
}

contract RenewalV2BasePayload is IProposalGenericExecutor {
  ILendingPoolAddressesProvider public immutable ADDRESSES_PROVIDER;
  address public immutable GUARDIAN;
  constructor(RenewalV2Params memory params) {
    ADDRESSES_PROVIDER = params.addressesProvider;
    GUARDIAN = params.guardian;
  }
  function execute() external {
    ADDRESSES_PROVIDER.setEmergencyAdmin(GUARDIAN);
  }
}
