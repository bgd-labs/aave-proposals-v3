// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/**
 * @title GHOLaunchConstants
 * @notice Library containing all constants used across the GHO Avalanche Launch proposal
 */
library GHOLaunchConstants {
  // Common Addresses
  address internal constant RISK_COUNCIL = 0x8513e6F37dBc52De87b166980Fa3F50639694B60;

  // AVALANCHE //
  // GHO Addresses -> https://avascan.info/blockchain/all/address/
  address internal constant AVALANCHE_TOKEN = 0xfc421aD3C883Bf9E7C4f42dE845C4e4405799e73; // GNO_GHO_TOKEN @todo standardize to AVALANCHE_GHO_TOKEN?
  address internal constant AVALANCHE_TOKEN_POOL = 0xDe6539018B095353A40753Dc54C91C68c9487D4E; // GNO_TOKEN_POOL @todo standardize to AVALANCHE_GHO_TOKEN_POOL?
  // address internal constant AVALANCHE_TOKEN_IMPL = 0x0; // @todo what's this??? GNO_GHO_TOKEN_IMPL
  address internal constant AVALANCHE_PRICE_FEED = 0x360d8aa8F6b09B7BC57aF34db2Eb84dD87bf4d12; // GNO_GHO_PRICE_FEED
  address internal constant AVALANCHE_AAVE_STEWARD = 0xA5Ba213867E175A182a5dd6A9193C6158738105A; // GNO_AAVE_STEWARD
  address internal constant AVALANCHE_BUCKET_STEWARD = 0x2Ce400703dAcc37b7edFA99D228b8E70a4d3831B; // GNO_BUCKET_STEWARD
  address internal constant AVALANCHE_CCIP_STEWARD = 0x20fd5f3FCac8883a3A0A2bBcD658A2d2c6EFa6B6; // GNO_CCIP_STEWARD

  // CCIP Rate Limits -> set and updated by ChaosLabs
  uint128 internal constant CCIP_RATE_LIMIT_CAPACITY = 300_000e18; // @todo update from ChaosLabs input
  uint128 internal constant CCIP_RATE_LIMIT_REFILL_RATE = 60e18; // @todo update from ChaosLabs input
  uint128 internal constant CCIP_BUCKET_CAPACITY = 25_000_000e18; // @todo bridge cap?

  // CCIP Adresses -> https://docs.chain.link/ccip/directory/mainnet (Outbound = ON_RAMP, Inbound = OFF_RAMP)
  address internal constant AVALANCHE_TOKEN_ADMIN_REGISTRY =
    0xc8df5D618c6a59Cc6A311E96a39450381001464F; // GNO_TOKEN_ADMIN_REGISTRY
  address internal constant AVALANCHE_CCIP_ROUTER = 0xF4c7E640EdA248ef95972845a62bdC74237805dB; // GNO_CCIP_ROUTER
  address internal constant AVALANCHE_RMN_PROXY = 0xcBD48A8eB077381c3c4Eb36b402d7283aB2b11Bc; // GNO_RMN_PROXY

  address internal constant AVALANCHE_ARBITRUM_ON_RAMP = 0x4e910c8Bbe88DaDF90baa6c1B7850DbeA32c5B29; // GNO_ARB_ON_RAMP
  address internal constant AVALANCHE_ETHEREUM_ON_RAMP = 0xe8784c29c583C52FA89144b9e5DD91Df2a1C2587; // GNO_ETH_ON_RAMP
  address internal constant AVALANCHE_BASE_ON_RAMP = 0x139D4108C23e66745Eda4ab47c25C83494b7C14d; // GNO_BASE_ON_RAMP
  // address internal constant AVALANCHE_GNOSIS_ON_RAMP = 0x38fd0DF16F6fD0a2C3Ec6615c73e50F5d027b8bA; // GNO_GNO_ON_RAMP

  address internal constant AVALANCHE_ARBITRUM_OFF_RAMP =
    0x508Ea280D46E4796Ce0f1Acf8BEDa610c4238dB3; // GNO_ARB_OFF_RAMP
  address internal constant AVALANCHE_ETHEREUM_OFF_RAMP =
    0xE5F21F43937199D4D57876A83077b3923F68EB76; // GNO_ETH_OFF_RAMP
  address internal constant AVALANCHE_BASE_OFF_RAMP = 0x37879EBFCb807f8C397fCe2f42DC0F5329AD6823; // GNO_BASE_OFF_RAMP
  // address internal constant AVALANCHE_GNOSIS_OFF_RAMP = 0x1181A59FF0BAEd1E0EA77e919185cB8C3D5D3125; // GNO_GNO_OFF_RAMP

  // ARBITRUM //
  // CCIP Adresses -> https://docs.chain.link/ccip/directory/mainnet (Outbound = ON_RAMP, Inbound = OFF_RAMP)
  address internal constant ARBITRUM_TOKEN_ADMIN_REGISTRY =
    0x39AE1032cF4B334a1Ed41cdD0833bdD7c7E7751E; // ARB_TOKEN_ADMIN_REGISTRY
  address internal constant ARBITRUM_CCIP_ROUTER = 0x141fa059441E0ca23ce184B6A78bafD2A517DdE8; // ARB_CCIP_ROUTER

  address internal constant ARBITRUM_AVALANCHE_ON_RAMP = 0xe80cC83B895ada027b722b78949b296Bd1fC5639; // ARB_GNO_ON_RAMP
  address internal constant ARBITRUM_ETHEREUM_ON_RAMP = 0x67761742ac8A21Ec4D76CA18cbd701e5A6F3Bef3; // ARB_ETH_ON_RAMP

  address internal constant ARBITRUM_AVALANCHE_OFF_RAMP =
    0x95095007d5Cc3E7517A1A03c9e228adA5D0bc376; // ARB_GNO_OFF_RAMP
  address internal constant ARBITRUM_ETHEREUM_OFF_RAMP = 0x91e46cc5590A4B9182e47f40006140A7077Dec31; // ARB_ETH_OFF_RAMP

  // BASE //
  // CCIP Adresses -> https://docs.chain.link/ccip/directory/mainnet (Outbound = ON_RAMP, Inbound = OFF_RAMP)
  address internal constant BASE_TOKEN_ADMIN_REGISTRY = 0x6f6C373d09C07425BaAE72317863d7F6bb731e37;
  address internal constant BASE_CCIP_ROUTER = 0x881e3A65B4d4a04dD529061dd0071cf975F58bCD;

  address internal constant BASE_AVALANCHE_ON_RAMP = 0x4be6E0F97EA849FF80773af7a317356E6c646FD7; // BASE_GNO_ON_RAMP
  address internal constant BASE_ETHEREUM_ON_RAMP = 0x56b30A0Dcd8dc87Ec08b80FA09502bAB801fa78e; // BASE_ETH_ON_RAMP

  address internal constant BASE_AVALANCHE_OFF_RAMP = 0x61C3f6d72c80A3D1790b213c4cB58c3d4aaFccDF; // BASE_GNO_OFF_RAMP
  address internal constant BASE_ETHEREUM_OFF_RAMP = 0xCA04169671A81E4fB8768cfaD46c347ae65371F1; // BASE_ETH_OFF_RAMP

  // // GNOSIS //
  // // CCIP Adresses -> https://docs.chain.link/ccip/directory/mainnet (Outbound = ON_RAMP, Inbound = OFF_RAMP)
  // address internal constant GNOSIS_TOKEN_ADMIN_REGISTRY =
  //   0x73BC11423CBF14914998C23B0aFC9BE0cb5B2229;
  // address internal constant GNOSIS_CCIP_ROUTER = 0x4aAD6071085df840abD9Baf1697d5D5992bDadce;

  // address internal constant GNOSIS_AVALANCHE_ON_RAMP = 0xB707a6D1d32CE99D5c669DeE71D30d25a066D32c;
  // address internal constant GNOSIS_ETHEREUM_ON_RAMP = 0x014ABcfDbCe9F67d0Df34574664a6C0A241Ec03A;

  // address internal constant GNOSIS_AVALANCHE_OFF_RAMP = 0xe596D90EF0AEe10257109AC8394a85F8944bF6D0;
  // address internal constant GNOSIS_ETHEREUM_OFF_RAMP = 0x658d9ae41A9c291De423d3B4B6C064f6dD0e7Ed2;

  // ETHEREUM //
  // CCIP Adresses -> https://docs.chain.link/ccip/directory/mainnet (Outbound = ON_RAMP, Inbound = OFF_RAMP)
  address internal constant ETHEREUM_TOKEN_ADMIN_REGISTRY =
    0xb22764f98dD05c789929716D677382Df22C05Cb6; // ETH_TOKEN_ADMIN_REGISTRY
  address internal constant ETHEREUM_CCIP_ROUTER = 0x80226fc0Ee2b096224EeAc085Bb9a8cba1146f7D; // ETH_CCIP_ROUTER

  address internal constant ETHEREUM_AVALANCHE_ON_RAMP = 0xaFd31C0C78785aDF53E4c185670bfd5376249d8A; // ETH_GNO_ON_RAMP
  address internal constant ETHEREUM_ARBITRUM_ON_RAMP = 0x69eCC4E2D8ea56E2d0a05bF57f4Fd6aEE7f2c284; // ETH_ARB_ON_RAMP
  // address internal constant ETHEREUM_GNOSIS_ON_RAMP = 0xf50B9A46C394bD98491ce163d420222d8030F6F0; // new
  address internal constant ETHEREUM_BASE_ON_RAMP = 0xb8a882f3B88bd52D1Ff56A873bfDB84b70431937; // ETH_BASE_ON_RAMP

  address internal constant ETHEREUM_AVALANCHE_OFF_RAMP =
    0xd98E80C79a15E4dbaF4C40B6cCDF690fe619BFBb; // ETH_GNO_OFF_RAMP
  address internal constant ETHEREUM_ARBITRUM_OFF_RAMP = 0xdf615eF8D4C64d0ED8Fd7824BBEd2f6a10245aC9; // ETH_ARB_OFF_RAMP
  // address internal constant ETHEREUM_GNOSIS_OFF_RAMP = 0x70C705ff3eCAA04c8c61d581a59a168a1c49c2ec; // new
  address internal constant ETHEREUM_BASE_OFF_RAMP = 0x6B4B6359Dd5B47Cdb030E5921456D2a0625a9EbD; // ETH_BASE_OFF_RAMP
}
