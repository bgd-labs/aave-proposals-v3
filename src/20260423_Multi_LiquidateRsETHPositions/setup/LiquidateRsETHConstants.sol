// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

library LiquidateRsETHConstants {
  // ── Ethereum ──────────────────────────────────────────────────────────────

  // https://etherscan.io/address/0x1F4C1c2e610f089D6914c4448E6F21Cb0db3adeF
  address internal constant ETH_USER_1 = 0x1F4C1c2e610f089D6914c4448E6F21Cb0db3adeF;

  // https://etherscan.io/address/0x8d11AeAC74267DD5C56D371bf4AE1AFA174C2d49
  address internal constant ETH_USER_2 = 0x8d11AeAC74267DD5C56D371bf4AE1AFA174C2d49;

  // https://etherscan.io/address/0xFc34e969F4D26aCDE4B170e2319E41Ce04713eaB
  address internal constant ETH_FIXED_PRICE_FEED = 0xFc34e969F4D26aCDE4B170e2319E41Ce04713eaB;

  // https://etherscan.io/address/0x53cb4BB8F61fa45405dC75F476FaDAd801e653D9
  address internal constant ETH_RECOVERY_GUARDIAN = 0x53cb4BB8F61fa45405dC75F476FaDAd801e653D9;

  // https://etherscan.io/address/0x72Ac46CDFb53f076A7bEFFB355A67e903eCfa946
  address internal constant ETH_GUARDIAN_ENABLED_FLAG = 0x72Ac46CDFb53f076A7bEFFB355A67e903eCfa946;

  // user debts
  uint256 internal constant ETH_USER_1_SCALED_WETH_DEBT = 47_858_634_668_729_089_041_362; // 47,858.634668729089041362
  uint256 internal constant ETH_USER_2_SCALED_WETH_DEBT = 359_497_891_853_128_670_386; // 359.497891853128670386

  // ── Arbitrum ──────────────────────────────────────────────────────────────

  // https://arbiscan.io/address/0x1B748B680373a1dd70A2319261328cAb2a6F644c
  address internal constant ARB_USER_1 = 0x1B748B680373a1dd70A2319261328cAb2a6F644c;

  // https://arbiscan.io/address/0xE9E2F48Bb0018276391AEc240AbB46e8C3caD181
  address internal constant ARB_USER_2 = 0xE9E2F48Bb0018276391AEc240AbB46e8C3caD181;

  // https://arbiscan.io/address/0xeBA786C9517a4823A5cFD9c72e4E80BF8168129B
  address internal constant ARB_USER_3 = 0xeBA786C9517a4823A5cFD9c72e4E80BF8168129B;

  // https://arbiscan.io/address/0xBb6A6006Eb71205e977eCeb19FCaD1C8d631C787
  address internal constant ARB_USER_4 = 0xBb6A6006Eb71205e977eCeb19FCaD1C8d631C787;

  // https://arbiscan.io/address/0xCBb24A6B4DAfaAA1a759A2F413eA0eB6AE1455CC
  address internal constant ARB_USER_5 = 0xCBb24A6B4DAfaAA1a759A2F413eA0eB6AE1455CC;

  // https://arbiscan.io/address/0x8d11AeAC74267DD5C56D371bf4AE1AFA174C2d49
  address internal constant ARB_USER_6 = 0x8d11AeAC74267DD5C56D371bf4AE1AFA174C2d49;

  // https://arbiscan.io/address/0x5c100DF8CC8260B848DbdF1b62e268855E7a6AF1
  address internal constant ARB_FIXED_PRICE_FEED = 0x5c100DF8CC8260B848DbdF1b62e268855E7a6AF1;

  // https://arbiscan.io/address/0x53cb4BB8F61fa45405dC75F476FaDAd801e653D9
  address internal constant ARB_RECOVERY_GUARDIAN = 0x53cb4BB8F61fa45405dC75F476FaDAd801e653D9;

  // https://arbiscan.io/address/0x830878a52c82E713570C4Ed025C6DCAEcF851f6D
  address internal constant ARB_GUARDIAN_ENABLED_FLAG = 0x830878a52c82E713570C4Ed025C6DCAEcF851f6D;

  // user debts
  uint256 internal constant ARB_USER_1_SCALED_WETH_DEBT = 7_073_155_636_569_611_935_655; // 7,073.155636569611935655
  uint256 internal constant ARB_USER_2_SCALED_WETH_DEBT = 3_978_649_726_543_414_956_218; // 3,978.649726543414956218
  uint256 internal constant ARB_USER_3_SCALED_WETH_DEBT = 11_117_044_777_122_668_999_784; // 11,117.044777122668999784
  uint256 internal constant ARB_USER_4_SCALED_WETH_DEBT = 680_790_932_372_564_812_290; // 680.790932372564812290
  uint256 internal constant ARB_USER_5_SCALED_WETH_DEBT = 3_867_748_213_709_117_145_732; // 3,867.748213709117145732
  uint256 internal constant ARB_USER_6_SCALED_WETH_DEBT = 25_750_112_610_398_502_593; // 25.750112610398502593
}
