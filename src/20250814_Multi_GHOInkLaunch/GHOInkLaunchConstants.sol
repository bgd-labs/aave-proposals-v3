// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/**
 * @title GHOInkLaunchConstants
 * @notice Library containing extra constants needed across the GHO Ink Launch proposal
 */
library GHOInkLaunchConstants {
  // Common Addresses
  address internal constant RISK_COUNCIL = 0x8513e6F37dBc52De87b166980Fa3F50639694B60;

  // ACI multisig address
  // https://governance.aave.com/t/arfc-launch-gho-on-ink-set-aci-as-emissions-manager-for-rewards/22664
  address internal constant EMISSION_ADMIN = 0xac140648435d03f784879cd789130F22Ef588Fcd;

  // https://docs.chain.link/ccip/directory/mainnet/chain/ethereum-mainnet-ink-1
  address internal constant RMN = 0x3A293fa336E118900AD0f2EcfeC0DAa6A4DeDaA1;
}
