// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/**
 * @title GHOInkLaunchConstants
 * @notice Library containing extra constants needed across the GHO Ink Launch proposal
 */
library GHOInkLaunchConstants {
  // Block Numbers for forking, below values to match /config.ts
  uint256 internal constant INK_BLOCK_NUMBER = 22045090;
  uint256 internal constant AVAX_BLOCK_NUMBER = 67272548;
  uint256 internal constant ARB_BLOCK_NUMBER = 369812065;
  uint256 internal constant BASE_BLOCK_NUMBER = 34377046;
  uint256 internal constant ETH_BLOCK_NUMBER = 23169876;
  uint256 internal constant GNOSIS_BLOCK_NUMBER = 41670939;

  // Common Addresses
  address internal constant RISK_COUNCIL = 0x8513e6F37dBc52De87b166980Fa3F50639694B60;

  address internal constant POOL = 0x2816cf15F6d2A220E789aA011D5EE4eB6c47FEbA;

  address internal constant POOL_ADDRESSES_PROVIDER = 0x4172E6aAEC070ACB31aaCE343A58c93E4C70f44D;

  address internal constant AAVE_PROTOCOL_DATA_PROVIDER =
    0x96086C25d13943C80Ff9a19791a40Df6aFC08328;

  address internal constant EMISSION_MANAGER = 0x9CbcEf2c44cF28ff2aa36Bff7BaB315398209A79;

  // ACI multisig address
  // https://governance.aave.com/t/arfc-launch-gho-on-ink-set-aci-as-emissions-manager-for-rewards/22664
  address internal constant EMISSION_ADMIN = 0xac140648435d03f784879cd789130F22Ef588Fcd;

  // https://docs.chain.link/ccip/directory/mainnet/chain/ethereum-mainnet-ink-1
  address internal constant RMN = 0x3A293fa336E118900AD0f2EcfeC0DAa6A4DeDaA1;
}
