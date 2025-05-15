// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {UmbrellaExtendedPayload} from 'aave-umbrella/payloads/UmbrellaExtendedPayload.sol';

/**
 * @title UmbrellaActivation
 * @author BGD Labs (@bgdlabs)
 * - Snapshot: TODO
 * - Discussion: https://governance.aave.com/t/arfc-aave-umbrella-activation/21521
 */
contract AaveV3Ethereum_UmbrellaActivation_20250515 is UmbrellaExtendedPayload {
  // https://etherscan.io/address/0x22740deBa78d5a0c24C58C740e3715ec29de1bFa
  address public constant FINANCIAL_COMMITTEE = 0x22740deBa78d5a0c24C58C740e3715ec29de1bFa;

  function _preExecute() public override {}
}
