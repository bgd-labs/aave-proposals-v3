// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/**
 * @title GHOAvalancheLaunch
 * @notice Library containing all constants used across the GHO Avalanche Launch proposal
 */
library GHOAvalancheLaunch {
  // Common Addresses
  address internal constant RISK_COUNCIL = 0x8513e6F37dBc52De87b166980Fa3F50639694B60;

  // COMMON /////////////////////////////////////////////////////
  // Block Numbers //
  // below values to match /config.ts
  uint256 internal constant AVAX_BLOCK_NUMBER = 63569943;
  uint256 internal constant ARB_BLOCK_NUMBER = 341142215;
  uint256 internal constant BASE_BLOCK_NUMBER = 30789286;
  uint256 internal constant ETH_BLOCK_NUMBER = 22575695;
  // CCIP Chain Selector //
  uint64 internal constant ARB_CHAIN_SELECTOR = 4949039107694359620;
  uint64 internal constant BASE_CHAIN_SELECTOR = 15971525489660198786;
  uint64 internal constant ETH_CHAIN_SELECTOR = 5009297550715157269;
  uint64 internal constant AVAX_CHAIN_SELECTOR = 6433500567565415381;

  // AVALANCHE /////////////////////////////////////////////////////
  // GHO Launch //
  // https://avascan.info/blockchain/all/address/<address>
  address internal constant GHO_TOKEN = 0xfc421aD3C883Bf9E7C4f42dE845C4e4405799e73;
  address internal constant GHO_CCIP_TOKEN_POOL = 0xDe6539018B095353A40753Dc54C91C68c9487D4E;
  address internal constant GHO_TOKEN_IMPL = 0xb0e1c7830aA781362f79225559Aa068E6bDaF1d1;
  address internal constant GHO_PRICE_FEED = 0x360d8aa8F6b09B7BC57aF34db2Eb84dD87bf4d12;
  address internal constant GHO_AAVE_CORE_STEWARD = 0xA5Ba213867E175A182a5dd6A9193C6158738105A;
  address internal constant GHO_BUCKET_STEWARD = 0x2Ce400703dAcc37b7edFA99D228b8E70a4d3831B;
  address internal constant GHO_CCIP_STEWARD = 0x20fd5f3FCac8883a3A0A2bBcD658A2d2c6EFa6B6;
  address internal constant EMISSION_ADMIN = 0xac140648435d03f784879cd789130F22Ef588Fcd;

  // CCIP Risk Paramaters //
  uint128 internal constant CCIP_RATE_LIMIT_CAPACITY = 1_500_000e18;
  uint128 internal constant CCIP_RATE_LIMIT_REFILL_RATE = 300e18;
  uint128 internal constant CCIP_BUCKET_CAPACITY = 40_000_000e18;

  // CCIP Adresses //
  // https://docs.chain.link/ccip/directory/mainnet/chain/avalanche-mainnet
  address internal constant AVAX_TOKEN_ADMIN_REGISTRY = 0xc8df5D618c6a59Cc6A311E96a39450381001464F;
  address internal constant AVAX_CCIP_ROUTER = 0xF4c7E640EdA248ef95972845a62bdC74237805dB;
  address internal constant AVAX_RMN_PROXY = 0xcBD48A8eB077381c3c4Eb36b402d7283aB2b11Bc;

  // CCIP Lanes //
  // https://docs.chain.link/ccip/directory/mainnet/chain/avalanche-mainnet (Outbound = ON_RAMP, Inbound = OFF_RAMP)
  address internal constant AVAX_ARB_ON_RAMP = 0x4e910c8Bbe88DaDF90baa6c1B7850DbeA32c5B29;
  address internal constant AVAX_ETH_ON_RAMP = 0xe8784c29c583C52FA89144b9e5DD91Df2a1C2587;
  address internal constant AVAX_BASE_ON_RAMP = 0x139D4108C23e66745Eda4ab47c25C83494b7C14d;
  address internal constant AVAX_ARB_OFF_RAMP = 0x508Ea280D46E4796Ce0f1Acf8BEDa610c4238dB3;
  address internal constant AVAX_ETH_OFF_RAMP = 0xE5F21F43937199D4D57876A83077b3923F68EB76;
  address internal constant AVAX_BASE_OFF_RAMP = 0x37879EBFCb807f8C397fCe2f42DC0F5329AD6823;

  // ARBITRUM /////////////////////////////////////////////////////
  // CCIP Adresses //
  // https://docs.chain.link/ccip/directory/mainnet/chain/ethereum-mainnet-arbitrum-1
  address internal constant ARB_GHO_CCIP_TOKEN_POOL = 0xB94Ab28c6869466a46a42abA834ca2B3cECCA5eB;
  address internal constant ARB_TOKEN_ADMIN_REGISTRY = 0x39AE1032cF4B334a1Ed41cdD0833bdD7c7E7751E;
  address internal constant ARB_CCIP_ROUTER = 0x141fa059441E0ca23ce184B6A78bafD2A517DdE8;

  // CCIP Lanes //
  // https://docs.chain.link/ccip/directory/mainnet/chain/ethereum-mainnet-arbitrum-1 (Outbound = ON_RAMP, Inbound = OFF_RAMP)
  address internal constant ARB_AVAX_ON_RAMP = 0xe80cC83B895ada027b722b78949b296Bd1fC5639;
  address internal constant ARB_ETH_ON_RAMP = 0x67761742ac8A21Ec4D76CA18cbd701e5A6F3Bef3;
  address internal constant ARB_AVAX_OFF_RAMP = 0x95095007d5Cc3E7517A1A03c9e228adA5D0bc376;
  address internal constant ARB_ETH_OFF_RAMP = 0x91e46cc5590A4B9182e47f40006140A7077Dec31;
  address internal constant ARB_BASE_OFF_RAMP = 0xb62178f8198905D0Fa6d640Bdb188E4E8143Ac4b;

  // BASE /////////////////////////////////////////////////////
  // CCIP Adresses //
  // https://docs.chain.link/ccip/directory/mainnet/chain/ethereum-mainnet-base-1
  address internal constant BASE_GHO_CCIP_TOKEN_POOL = 0x98217A06721Ebf727f2C8d9aD7718ec28b7aAe34;
  address internal constant BASE_TOKEN_ADMIN_REGISTRY = 0x6f6C373d09C07425BaAE72317863d7F6bb731e37;
  address internal constant BASE_CCIP_ROUTER = 0x881e3A65B4d4a04dD529061dd0071cf975F58bCD;

  // CCIP Lanes //
  // https://docs.chain.link/ccip/directory/mainnet/chain/ethereum-mainnet-base-1 (Outbound = ON_RAMP, Inbound = OFF_RAMP)
  address internal constant BASE_AVAX_ON_RAMP = 0x4be6E0F97EA849FF80773af7a317356E6c646FD7;
  address internal constant BASE_ETH_ON_RAMP = 0x56b30A0Dcd8dc87Ec08b80FA09502bAB801fa78e;
  address internal constant BASE_AVAX_OFF_RAMP = 0x61C3f6d72c80A3D1790b213c4cB58c3d4aaFccDF;
  address internal constant BASE_ETH_OFF_RAMP = 0xCA04169671A81E4fB8768cfaD46c347ae65371F1;
  address internal constant BASE_ARB_OFF_RAMP = 0x7D38c6363d5E4DFD500a691Bc34878b383F58d93;

  // ETHEREUM /////////////////////////////////////////////////////
  // CCIP Adresses //
  // https://docs.chain.link/ccip/directory/mainnet/chain/mainnet
  address internal constant ETH_GHO_CCIP_TOKEN_POOL = 0x06179f7C1be40863405f374E7f5F8806c728660A;
  address internal constant ETH_TOKEN_ADMIN_REGISTRY = 0xb22764f98dD05c789929716D677382Df22C05Cb6;
  address internal constant ETH_CCIP_ROUTER = 0x80226fc0Ee2b096224EeAc085Bb9a8cba1146f7D;

  // CCIP Lanes //
  // https://docs.chain.link/ccip/directory/mainnet/chain/mainnet (Outbound = ON_RAMP, Inbound = OFF_RAMP)
  address internal constant ETH_AVAX_ON_RAMP = 0xaFd31C0C78785aDF53E4c185670bfd5376249d8A;
  address internal constant ETH_BASE_ON_RAMP = 0xb8a882f3B88bd52D1Ff56A873bfDB84b70431937;
  address internal constant ETH_AVAX_OFF_RAMP = 0xd98E80C79a15E4dbaF4C40B6cCDF690fe619BFBb;
  address internal constant ETH_ARB_OFF_RAMP = 0xdf615eF8D4C64d0ED8Fd7824BBEd2f6a10245aC9;
  address internal constant ETH_BASE_OFF_RAMP = 0x6B4B6359Dd5B47Cdb030E5921456D2a0625a9EbD;
}
