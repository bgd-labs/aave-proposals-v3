// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

library AaveV4EthereumAddresses {
  address internal constant ACCESS_MANAGER = 0x4940dB23bD0f02de91ffC620508a44F46fDead37;
  address internal constant HUB_CONFIGURATOR = 0x022B3f60a58efaef200fF0B5D599B9b18223EE1F;
  address internal constant SPOKE_CONFIGURATOR = 0x5B45da42DF121aD69502f3E6BC32F129F7549782;

  address internal constant CORE_HUB = 0xDA21DF2D9297f3E1CB564A54190a2984DF42B934;
  address internal constant PLUS_HUB = 0x85F9b1d60f9F6fbD51006EA2E20Cde1A670A8eB4;
  address internal constant PRIME_HUB = 0x502B96A1A31572264e27474C2f1439E7FB69b6E8;

  address internal constant MAIN_SPOKE = 0x47b880030329821412d614EAe2da68856E87C3fb;
  address internal constant BLUECHIP_SPOKE = 0x20f09138d51a85B075659ec325c66Da4Ca663Dea;
  address internal constant ETHENA_CORRELATED_SPOKE = 0xA76fdE0bFF53ffcd5f3FbE84133C22F37C9E6Cf3;
  address internal constant ETHENA_ECOSYSTEM_SPOKE = 0x7c7C23bEe25ba4B12Bf1e11d12257A42030C6E04;
  address internal constant ETHERFI_ESPOKE = 0xDfdf5272E13F01Fa3D7590aB059589f0Ec1D4B02;
  address internal constant FOREX_SPOKE = 0x71e9339F9E8F0d1EFaf73C2823B7Bf7c0202D2aF;
  address internal constant GOLD_SPOKE = 0x84aFeef66c1456244659e7F98705cA904aE5ebef;
  address internal constant KELP_ESPOKE = 0xF3D54610227480Fc94D5C4677C2cf906901dac81;
  address internal constant LIDO_ESPOKE = 0x39299bc53cff6EA0bf9183EfCC4074e4b57504b1;
  address internal constant LOMBARD_BTC_SPOKE = 0x9A93D44e38c8505f24cCDFaEb2FbdfC1eba25c1C;
  address internal constant TREASURY_SPOKE = 0x4f3647C9675723822BC618ad9b15802f6c893f06;
  // TODO: Add tokenization spoke address once available
  address internal constant TOKENIZATION_SPOKE = address(0);

  address internal constant CONFIG_POSITION_MANAGER = 0x9D1C7d6f920f8915677B276b6AB6bD63e3E4baC8;
  address internal constant GIVER_POSITION_MANAGER = 0x8C774A8C22e66aC06E71a28d75dc265EC2509756;
  address internal constant TAKER_POSITION_MANAGER = 0x786BA4BD4D5aDDda85E1F44A397D60b9D6B0e778;
  address internal constant NATIVE_TOKEN_GATEWAY = 0xDb99165DB5Fff01694ec90f79948a3DE75E29bDE;
  address internal constant SIGNATURE_GATEWAY = 0x4769F7c79b23d111a5e55b248867F25e6Edae51e;

  address internal constant CORE_HUB_IR_STRATEGY = 0x7E1FF7c41590bd6da9B3533CaC5c3CEbB9EDB125;
  address internal constant PLUS_HUB_IR_STRATEGY = 0x09ee0b03F7643c09533913848dd5e1A3cA5Cf38c;
  address internal constant PRIME_HUB_IR_STRATEGY = 0xAf15a24B34606F029839d398f1c4a26671E29Bb3;

  address internal constant MAIN_SPOKE_ORACLE = 0xE0A6f410BC26f80825332b9D95Fa8c2D01393e0c;
  address internal constant BLUECHIP_SPOKE_ORACLE = 0xc9d3721dbe8521d897b2bB1507CBAd4D2332B8Fa;
  address internal constant ETHENA_CORRELATED_SPOKE_ORACLE =
    0x4fe69aC37FEA7f084E367Dea3129EC5577E295E6;
  address internal constant ETHENA_ECOSYSTEM_SPOKE_ORACLE =
    0x28014ee8a9B7606B7ad23E2318f6901cF44ce137;
  address internal constant ETHERFI_ESPOKE_ORACLE = 0x127A56eB5FCCb4242dAC35186f4e488194b2b692;
  address internal constant FOREX_SPOKE_ORACLE = 0x4e23b4041d4BB45f2703BD4C319886163D082ae1;
  address internal constant GOLD_SPOKE_ORACLE = 0x2039AA935fB2E93694d5108003F8CE65305b8DDe;
  address internal constant KELP_ESPOKE_ORACLE = 0x3d4E05Cf6348a6D9575DE739eAcf2F4B327120EC;
  address internal constant LIDO_ESPOKE_ORACLE = 0x06b5Ed7D3A277b64b69F8694fC2073aE3b59ea3D;
  address internal constant LOMBARD_BTC_SPOKE_ORACLE = 0x4596a9CF34412e583660b28838bcEeE5Ff4Fc6dC;

  // Underlying assets not in AaveV3EthereumAssets
  address internal constant RLUSD = 0x8292Bb45bf1Ee4d140127049757C2E0fF06317eD;
  address internal constant USDG = 0xe343167631d89B6Ffc58B88d6b7fB0228795491D;
  address internal constant frxUSD = 0xCAcd6fd266aF91b8AeD52aCCc382b4e165586E29;
  address internal constant XAUt = 0x68749665FF8D2d112Fa859AA293F07A622782F38;
  address internal constant PT_sUSDE_7MAY2026 = 0x3de0ff76E8b528C092d47b9DaC775931cef80F49;
  address internal constant PT_USDe_7MAY2026 = 0xAeBf0Bb9f57E89260d57f31AF34eB58657d96Ce0;

  function getHubs() internal pure returns (address[] memory hubs) {
    hubs = new address[](3);
    hubs[0] = CORE_HUB;
    hubs[1] = PLUS_HUB;
    hubs[2] = PRIME_HUB;
    return hubs;
  }

  function getTokenizationSpokes() internal pure returns (address[] memory spokes) {
    spokes = new address[](1);
    spokes[0] = TOKENIZATION_SPOKE;
    return spokes;
  }

  function getSpokes() internal pure returns (address[] memory spokes) {
    spokes = new address[](11);
    spokes[0] = MAIN_SPOKE;
    spokes[1] = BLUECHIP_SPOKE;
    spokes[2] = ETHENA_CORRELATED_SPOKE;
    spokes[3] = ETHENA_ECOSYSTEM_SPOKE;
    spokes[4] = ETHERFI_ESPOKE;
    spokes[5] = FOREX_SPOKE;
    spokes[6] = GOLD_SPOKE;
    spokes[7] = KELP_ESPOKE;
    spokes[8] = LIDO_ESPOKE;
    spokes[9] = LOMBARD_BTC_SPOKE;
    spokes[10] = TREASURY_SPOKE;
    return spokes;
  }

  function getUserSpokes() internal pure returns (address[] memory spokes) {
    spokes = new address[](10);
    spokes[0] = MAIN_SPOKE;
    spokes[1] = BLUECHIP_SPOKE;
    spokes[2] = ETHENA_CORRELATED_SPOKE;
    spokes[3] = ETHENA_ECOSYSTEM_SPOKE;
    spokes[4] = ETHERFI_ESPOKE;
    spokes[5] = FOREX_SPOKE;
    spokes[6] = GOLD_SPOKE;
    spokes[7] = KELP_ESPOKE;
    spokes[8] = LIDO_ESPOKE;
    spokes[9] = LOMBARD_BTC_SPOKE;
    return spokes;
  }
}
