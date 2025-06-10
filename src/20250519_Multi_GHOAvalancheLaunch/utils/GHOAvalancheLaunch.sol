// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// @todo rename to GhoAvalancheLaunch to make it consistent with GhoBase, GhoArbitrum, etc.
// @todo align constant names to GhoArbitrum, GhoBase
/**
 * @title GHOLaunchConstants
 * @notice Library containing all constants used across the GHO Avalanche Launch proposal
 */
library GHOAvalancheLaunch {
  // Common Addresses
  address internal constant RISK_COUNCIL = 0x8513e6F37dBc52De87b166980Fa3F50639694B60;

  // COMMON /////////////////////////////////////////////////////
  // Block Numbers //
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
  address internal constant GHO_TOKEN = 0xfc421aD3C883Bf9E7C4f42dE845C4e4405799e73; //  AVALANCHE_TOKEN
  address internal constant GHO_CCIP_TOKEN_POOL = 0xDe6539018B095353A40753Dc54C91C68c9487D4E; // AVALANCHE_TOKEN_POOL
  address internal constant GHO_TOKEN_IMPL = 0xb0e1c7830aA781362f79225559Aa068E6bDaF1d1; //  AVALANCHE_TOKEN_IMPL
  address internal constant GHO_PRICE_FEED = 0x360d8aa8F6b09B7BC57aF34db2Eb84dD87bf4d12; //  AVALANCHE_PRICE_FEED
  address internal constant GHO_AAVE_CORE_STEWARD = 0xA5Ba213867E175A182a5dd6A9193C6158738105A; //  AVALANCHE_AAVE_STEWARD
  address internal constant GHO_BUCKET_STEWARD = 0x2Ce400703dAcc37b7edFA99D228b8E70a4d3831B; //  AVALANCHE_BUCKET_STEWARD
  address internal constant GHO_CCIP_STEWARD = 0x20fd5f3FCac8883a3A0A2bBcD658A2d2c6EFa6B6; //  AVALANCHE_CCIP_STEWARD

  // CCIP Rate Limits //
  // @todo pending updated by ChaosLabs
  uint128 internal constant CCIP_RATE_LIMIT_CAPACITY = 300_000e18;
  uint128 internal constant CCIP_RATE_LIMIT_REFILL_RATE = 60e18;
  uint128 internal constant CCIP_BUCKET_CAPACITY = 4_500_000e18;

  // CCIP Adresses //
  // https://docs.chain.link/ccip/directory/mainnet/chain/avalanche-mainnet
  address internal constant AVAX_TOKEN_ADMIN_REGISTRY = 0xc8df5D618c6a59Cc6A311E96a39450381001464F; // AVALANCHE_TOKEN_ADMIN_REGISTRY
  address internal constant AVAX_CCIP_ROUTER = 0xF4c7E640EdA248ef95972845a62bdC74237805dB; // AVALANCHE_CCIP_ROUTER
  address internal constant AVAX_RMN_PROXY = 0xcBD48A8eB077381c3c4Eb36b402d7283aB2b11Bc; // AVALANCHE_RMN_PROXY

  // CCIP Lanes //
  // https://docs.chain.link/ccip/directory/mainnet/chain/avalanche-mainnet (Outbound = ON_RAMP, Inbound = OFF_RAMP)
  address internal constant AVAX_ARB_ON_RAMP = 0x4e910c8Bbe88DaDF90baa6c1B7850DbeA32c5B29; // AVALANCHE_ARBITRUM_ON_RAMP
  address internal constant AVAX_ETH_ON_RAMP = 0xe8784c29c583C52FA89144b9e5DD91Df2a1C2587; // AVALANCHE_ETHEREUM_ON_RAMP
  address internal constant AVAX_BASE_ON_RAMP = 0x139D4108C23e66745Eda4ab47c25C83494b7C14d; // AVALANCHE_BASE_ON_RAMP
  address internal constant AVAX_ARB_OFF_RAMP = 0x508Ea280D46E4796Ce0f1Acf8BEDa610c4238dB3; // AVALANCHE_ARBITRUM_OFF_RAMP
  address internal constant AVAX_ETH_OFF_RAMP = 0xE5F21F43937199D4D57876A83077b3923F68EB76; // AVALANCHE_ETHEREUM_OFF_RAMP
  address internal constant AVAX_BASE_OFF_RAMP = 0x37879EBFCb807f8C397fCe2f42DC0F5329AD6823; // AVALANCHE_BASE_OFF_RAMP

  // ARBITRUM /////////////////////////////////////////////////////
  // CCIP Adresses //
  // https://docs.chain.link/ccip/directory/mainnet/chain/ethereum-mainnet-arbitrum-1
  address internal constant ARB_TOKEN_ADMIN_REGISTRY = 0x39AE1032cF4B334a1Ed41cdD0833bdD7c7E7751E; // ARBITRUM_TOKEN_ADMIN_REGISTRY
  address internal constant ARB_CCIP_ROUTER = 0x141fa059441E0ca23ce184B6A78bafD2A517DdE8; // ARBITRUM_CCIP_ROUTER

  // CCIP Lanes //
  // https://docs.chain.link/ccip/directory/mainnet/chain/ethereum-mainnet-arbitrum-1 (Outbound = ON_RAMP, Inbound = OFF_RAMP)
  address internal constant ARB_AVAX_ON_RAMP = 0xe80cC83B895ada027b722b78949b296Bd1fC5639; // ARBITRUM_AVALANCHE_ON_RAMP
  address internal constant ARB_ETH_ON_RAMP = 0x67761742ac8A21Ec4D76CA18cbd701e5A6F3Bef3; // ARBITRUM_ETHEREUM_ON_RAMP
  address internal constant ARB_BASE_ON_RAMP = 0xc1b6287A3292d6469F2D8545877E40A2f75CA9a6; // ARBITRUM_BASE_ON_RAMP
  address internal constant ARB_AVAX_OFF_RAMP = 0x95095007d5Cc3E7517A1A03c9e228adA5D0bc376; // ARBITRUM_AVALANCHE_OFF_RAMP
  address internal constant ARB_ETH_OFF_RAMP = 0x91e46cc5590A4B9182e47f40006140A7077Dec31; // ARBITRUM_ETHEREUM_OFF_RAMP
  address internal constant ARB_BASE_OFF_RAMP = 0xb62178f8198905D0Fa6d640Bdb188E4E8143Ac4b; // ARBITRUM_BASE_OFF_RAMP

  // BASE /////////////////////////////////////////////////////
  // CCIP Adresses //
  // https://docs.chain.link/ccip/directory/mainnet/chain/ethereum-mainnet-base-1
  address internal constant BASE_TOKEN_ADMIN_REGISTRY = 0x6f6C373d09C07425BaAE72317863d7F6bb731e37;
  address internal constant BASE_CCIP_ROUTER = 0x881e3A65B4d4a04dD529061dd0071cf975F58bCD;

  // CCIP Lanes //
  // https://docs.chain.link/ccip/directory/mainnet/chain/ethereum-mainnet-base-1 (Outbound = ON_RAMP, Inbound = OFF_RAMP)
  address internal constant BASE_AVAX_ON_RAMP = 0x4be6E0F97EA849FF80773af7a317356E6c646FD7;
  address internal constant BASE_ETH_ON_RAMP = 0x56b30A0Dcd8dc87Ec08b80FA09502bAB801fa78e;
  address internal constant BASE_ARB_ON_RAMP = 0x9D0ffA76C7F82C34Be313b5bFc6d42A72dA8CA69;
  address internal constant BASE_AVAX_OFF_RAMP = 0x61C3f6d72c80A3D1790b213c4cB58c3d4aaFccDF;
  address internal constant BASE_ETH_OFF_RAMP = 0xCA04169671A81E4fB8768cfaD46c347ae65371F1;
  address internal constant BASE_ARB_OFF_RAMP = 0x7D38c6363d5E4DFD500a691Bc34878b383F58d93;

  // ETHEREUM /////////////////////////////////////////////////////
  // CCIP Adresses //
  // https://docs.chain.link/ccip/directory/mainnet/chain/mainnet
  address internal constant ETH_TOKEN_ADMIN_REGISTRY = 0xb22764f98dD05c789929716D677382Df22C05Cb6; // ETHEREUM_TOKEN_ADMIN_REGISTRY
  address internal constant ETH_CCIP_ROUTER = 0x80226fc0Ee2b096224EeAc085Bb9a8cba1146f7D; // ETHEREUM_CCIP_ROUTER

  // CCIP Lanes //
  // https://docs.chain.link/ccip/directory/mainnet/chain/mainnet (Outbound = ON_RAMP, Inbound = OFF_RAMP)
  address internal constant ETH_AVAX_ON_RAMP = 0xaFd31C0C78785aDF53E4c185670bfd5376249d8A; // ETHEREUM_AVALANCHE_ON_RAMP
  address internal constant ETH_ARB_ON_RAMP = 0x69eCC4E2D8ea56E2d0a05bF57f4Fd6aEE7f2c284; // ETHEREUM_ARBITRUM_ON_RAMP
  address internal constant ETH_BASE_ON_RAMP = 0xb8a882f3B88bd52D1Ff56A873bfDB84b70431937; // ETHEREUM_BASE_ON_RAMP
  address internal constant ETH_AVAX_OFF_RAMP = 0xd98E80C79a15E4dbaF4C40B6cCDF690fe619BFBb; // ETHEREUM_AVALANCHE_OFF_RAMP
  address internal constant ETH_ARB_OFF_RAMP = 0xdf615eF8D4C64d0ED8Fd7824BBEd2f6a10245aC9; // ETHEREUM_ARBITRUM_OFF_RAMP
  address internal constant ETH_BASE_OFF_RAMP = 0x6B4B6359Dd5B47Cdb030E5921456D2a0625a9EbD; // ETHEREUM_BASE_OFF_RAMP
}
