// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/**
 * @title GHOLaunchConstants
 * @notice Library containing all constants used across the GHO Gnosis Launch proposal
 */
library GHOLaunchConstants {
  // Common Addresses
  address internal constant RISK_COUNCIL = 0x8513e6F37dBc52De87b166980Fa3F50639694B60;

  // CCIP Rate Limits
  uint128 internal constant CCIP_RATE_LIMIT_CAPACITY = 1_000_000e18;
  uint128 internal constant CCIP_RATE_LIMIT_REFILL_RATE = 200e18;

  // Arbitrum Addresses
  address internal constant ARB_TOKEN_POOL = 0xB94Ab28c6869466a46a42abA834ca2B3cECCA5eB;
  address internal constant ARB_TOKEN_ADMIN_REGISTRY = 0x39AE1032cF4B334a1Ed41cdD0833bdD7c7E7751E;

  // Arbitrum ON_RAMPs
  address internal constant ARB_GNO_ON_RAMP = 0xc7d6B885d8A4286E6311F79227430b7862311cd3;
  address internal constant ARB_ETH_ON_RAMP = 0x67761742ac8A21Ec4D76CA18cbd701e5A6F3Bef3;
  address internal constant ARB_BASE_ON_RAMP = 0xc1b6287A3292d6469F2D8545877E40A2f75CA9a6;

  // Arbitrum OFF_RAMPs
  address internal constant ARB_GNO_OFF_RAMP = 0xeE53872d1C695933B34cE0a11B58613CBBf37e20;
  address internal constant ARB_ETH_OFF_RAMP = 0x91e46cc5590A4B9182e47f40006140A7077Dec31;
  address internal constant ARB_BASE_OFF_RAMP = 0xb62178f8198905D0Fa6d640Bdb188E4E8143Ac4b;

  // Base Addresses
  address internal constant BASE_TOKEN_POOL = 0x98217A06721Ebf727f2C8d9aD7718ec28b7aAe34;
  address internal constant BASE_TOKEN_ADMIN_REGISTRY = 0x6f6C373d09C07425BaAE72317863d7F6bb731e37;

  // Base ON_RAMPs
  address internal constant BASE_ARB_ON_RAMP = 0x9D0ffA76C7F82C34Be313b5bFc6d42A72dA8CA69;
  address internal constant BASE_ETH_ON_RAMP = 0x56b30A0Dcd8dc87Ec08b80FA09502bAB801fa78e;
  address internal constant BASE_GNO_ON_RAMP = 0xDcFB24AEbcB9Edfb6746a045DDcae402381F984B;

  // Base OFF_RAMPs
  address internal constant BASE_ARB_OFF_RAMP = 0x7D38c6363d5E4DFD500a691Bc34878b383F58d93;
  address internal constant BASE_ETH_OFF_RAMP = 0xCA04169671A81E4fB8768cfaD46c347ae65371F1;
  address internal constant BASE_GNO_OFF_RAMP = 0x300977dBA924af14E166B31F4926892B1f310661;

  // Ethereum Addresses
  address internal constant ETH_TOKEN_POOL = 0x06179f7C1be40863405f374E7f5F8806c728660A;
  address internal constant ETH_TOKEN_ADMIN_REGISTRY = 0xb22764f98dD05c789929716D677382Df22C05Cb6;

  // Ethereum ON_RAMPs
  address internal constant ETH_ARB_ON_RAMP = 0x69eCC4E2D8ea56E2d0a05bF57f4Fd6aEE7f2c284;
  address internal constant ETH_GNO_ON_RAMP = 0xf50B9A46C394bD98491ce163d420222d8030F6F0;
  address internal constant ETH_BASE_ON_RAMP = 0xb8a882f3B88bd52D1Ff56A873bfDB84b70431937;

  // Ethereum OFF_RAMPs
  address internal constant ETH_ARB_OFF_RAMP = 0xdf615eF8D4C64d0ED8Fd7824BBEd2f6a10245aC9;
  address internal constant ETH_GNO_OFF_RAMP = 0x70C705ff3eCAA04c8c61d581a59a168a1c49c2ec;
  address internal constant ETH_BASE_OFF_RAMP = 0x6B4B6359Dd5B47Cdb030E5921456D2a0625a9EbD;

  // Gnosis Addresses
  address internal constant GNO_TOKEN_POOL = 0xDe6539018B095353A40753Dc54C91C68c9487D4E;
  address internal constant GNO_TOKEN_ADMIN_REGISTRY = 0x73BC11423CBF14914998C23B0aFC9BE0cb5B2229;
  address internal constant RMN_PROXY_GNOSIS = 0xf5e5e1676942520995c1e39aFaC58A75Fe1cd2bB;
  address internal constant ROUTER_GNOSIS = 0x4aAD6071085df840abD9Baf1697d5D5992bDadce;
  address internal constant GHO_TOKEN_IMPL_GNOSIS = 0xb0e1c7830aA781362f79225559Aa068E6bDaF1d1;
  address internal constant GHO_TOKEN_GNOSIS = 0xfc421aD3C883Bf9E7C4f42dE845C4e4405799e73;

  // Gnosis ON_RAMPs
  address internal constant GNO_ARB_ON_RAMP = 0x140E6D5ba903F684944Dd27369d767DdEf958c9B;
  address internal constant GNO_ETH_ON_RAMP = 0x014ABcfDbCe9F67d0Df34574664a6C0A241Ec03A;
  address internal constant GNO_BASE_ON_RAMP = 0xAAb6D9fc00aAc37373206e91789CcDE1E851b3E4;

  // Gnosis OFF_RAMPs
  address internal constant GNO_ARB_OFF_RAMP = 0x2C1539696E29012806a15Bcd9845Ed1278a9fd63;
  address internal constant GNO_BASE_OFF_RAMP = 0xbeEDd1C5C13C5886c3d600e94Ff9e82C04A53C38;
  address internal constant GNO_ETH_OFF_RAMP = 0x658d9ae41A9c291De423d3B4B6C064f6dD0e7Ed2;
}
