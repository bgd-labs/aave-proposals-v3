// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IHub} from './interfaces/IHub.sol';
import {ISpoke} from './interfaces/ISpoke.sol';

library AaveV4EthereumAddresses {
  // https://etherscan.io/address/0x08aE3BE30958cDd1847ec58fFfd4C451a87fDF01
  address internal constant ACCESS_MANAGER = 0x08aE3BE30958cDd1847ec58fFfd4C451a87fDF01;
  // https://etherscan.io/address/0x1F0753480bB03EaA00863224602267B7E0525C3d
  address internal constant HUB_CONFIGURATOR = 0x1F0753480bB03EaA00863224602267B7E0525C3d;
  // https://etherscan.io/address/0x9BFFf48BFb5A7AE70c348d4d4cb97E8DEFa5389a
  address internal constant SPOKE_CONFIGURATOR = 0x9BFFf48BFb5A7AE70c348d4d4cb97E8DEFa5389a;
}

library AaveV4EthereumHubs {
  // https://etherscan.io/address/0xCca852Bc40e560adC3b1Cc58CA5b55638ce826c9
  IHub internal constant CORE_HUB = IHub(0xCca852Bc40e560adC3b1Cc58CA5b55638ce826c9);
  // https://etherscan.io/address/0x06002e9c4412CB7814a791eA3666D905871E536A
  IHub internal constant PLUS_HUB = IHub(0x06002e9c4412CB7814a791eA3666D905871E536A);
  // https://etherscan.io/address/0x943827DCA022D0F354a8a8c332dA1e5Eb9f9F931
  IHub internal constant PRIME_HUB = IHub(0x943827DCA022D0F354a8a8c332dA1e5Eb9f9F931);

  function getHubs() internal pure returns (IHub[] memory) {
    IHub[] memory hubs = new IHub[](3);
    hubs[0] = CORE_HUB;
    hubs[1] = PLUS_HUB;
    hubs[2] = PRIME_HUB;
    return hubs;
  }
}

library AaveV4EthereumSpokes {
  // https://etherscan.io/address/0x94e7A5dCbE816e498b89aB752661904E2F56c485
  ISpoke internal constant MAIN_SPOKE = ISpoke(0x94e7A5dCbE816e498b89aB752661904E2F56c485);
  // https://etherscan.io/address/0x973a023A77420ba610f06b3858aD991Df6d85A08
  ISpoke internal constant BLUECHIP_SPOKE = ISpoke(0x973a023A77420ba610f06b3858aD991Df6d85A08);
  // https://etherscan.io/address/0x58131E79531caB1d52301228d1f7b842F26B9649
  ISpoke internal constant ETHENA_CORRELATED_SPOKE =
    ISpoke(0x58131E79531caB1d52301228d1f7b842F26B9649);
  // https://etherscan.io/address/0xba1B3D55D249692b669A164024A838309B7508AF
  ISpoke internal constant ETHENA_ECOSYSTEM_SPOKE =
    ISpoke(0xba1B3D55D249692b669A164024A838309B7508AF);
  // https://etherscan.io/address/0xbF10BDfE177dE0336aFD7fcCF80A904E15386219
  ISpoke internal constant ETHERFI_ESPOKE = ISpoke(0xbF10BDfE177dE0336aFD7fcCF80A904E15386219);
  // https://etherscan.io/address/0xD8B93635b8C6d0fF98CbE90b5988E3F2d1Cd9da1
  ISpoke internal constant FOREX_SPOKE = ISpoke(0xD8B93635b8C6d0fF98CbE90b5988E3F2d1Cd9da1);
  // https://etherscan.io/address/0x65407b940966954b23dfA3caA5C0702bB42984DC
  ISpoke internal constant GOLD_SPOKE = ISpoke(0x65407b940966954b23dfA3caA5C0702bB42984DC);
  // https://etherscan.io/address/0x3131FE68C4722e726fe6B2819ED68e514395B9a4
  ISpoke internal constant KELP_ESPOKE = ISpoke(0x3131FE68C4722e726fe6B2819ED68e514395B9a4);
  // https://etherscan.io/address/0xe1900480ac69f0B296841Cd01cC37546d92F35Cd
  ISpoke internal constant LIDO_ESPOKE = ISpoke(0xe1900480ac69f0B296841Cd01cC37546d92F35Cd);
  // https://etherscan.io/address/0x7EC68b5695e803e98a21a9A05d744F28b0a7753D
  ISpoke internal constant LOMBARD_BTC_SPOKE = ISpoke(0x7EC68b5695e803e98a21a9A05d744F28b0a7753D);
  // https://etherscan.io/address/0xB9B0b8616f6Bf6841972a52058132BE08d723155
  ISpoke internal constant TREASURY_SPOKE = ISpoke(0xB9B0b8616f6Bf6841972a52058132BE08d723155);

  function getSpokes() internal pure returns (ISpoke[] memory) {
    ISpoke[] memory spokes = new ISpoke[](11);
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

  function getUserSpokes() internal pure returns (ISpoke[] memory) {
    ISpoke[] memory spokes = new ISpoke[](10);
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

library AaveV4EthereumPositionManagers {
  // https://etherscan.io/address/0x51305839CE822a7b4b12AA7D86eA7005052d575c
  address internal constant CONFIG_POSITION_MANAGER = 0x51305839CE822a7b4b12AA7D86eA7005052d575c;
  // https://etherscan.io/address/0x17A54b8d6D9C68e7fa1C7112AC998EA1BA51d11e
  address internal constant GIVER_POSITION_MANAGER = 0x17A54b8d6D9C68e7fa1C7112AC998EA1BA51d11e;
  // https://etherscan.io/address/0x6c044c0D3801499bCAbfAd458B70880bc518e9F7
  address internal constant TAKER_POSITION_MANAGER = 0x6c044c0D3801499bCAbfAd458B70880bc518e9F7;
  // https://etherscan.io/address/0xe68ab4F90Fe026B9873F5F276eD2d7efBbbE42Be
  address internal constant NATIVE_TOKEN_GATEWAY = 0xe68ab4F90Fe026B9873F5F276eD2d7efBbbE42Be;
  // https://etherscan.io/address/0xfbC184337Dc6595D8bf62968Bda46e7De7AF9c3d
  address internal constant SIGNATURE_GATEWAY = 0xfbC184337Dc6595D8bf62968Bda46e7De7AF9c3d;
}

library AaveV4EthereumIRStrategies {
  // https://etherscan.io/address/0xAD88791B0F81D1FA242f637eB05bee0cbc53fe2f
  address internal constant CORE_HUB_IR_STRATEGY = 0xAD88791B0F81D1FA242f637eB05bee0cbc53fe2f;
  // https://etherscan.io/address/0x31280650661b8443723fa9739b3A164E3696af48
  address internal constant PLUS_HUB_IR_STRATEGY = 0x31280650661b8443723fa9739b3A164E3696af48;
  // https://etherscan.io/address/0xDCd924047a4bDBFef9CCDDe845E5D45373Ad276D
  address internal constant PRIME_HUB_IR_STRATEGY = 0xDCd924047a4bDBFef9CCDDe845E5D45373Ad276D;
}

library AaveV4EthereumOracles {
  // https://etherscan.io/address/0x99B2B6CEa9C3D2fd8F4d90f86741C44B212a6127
  address internal constant MAIN_SPOKE_ORACLE = 0x99B2B6CEa9C3D2fd8F4d90f86741C44B212a6127;
  // https://etherscan.io/address/0xdA1266a7b8620819dAE3F8bd6B546Da36e505bB8
  address internal constant BLUECHIP_SPOKE_ORACLE = 0xdA1266a7b8620819dAE3F8bd6B546Da36e505bB8;
  // https://etherscan.io/address/0x9b91a0943CADf554742E8Fb358B1cC4ae4F85F01
  address internal constant ETHENA_CORRELATED_SPOKE_ORACLE =
    0x9b91a0943CADf554742E8Fb358B1cC4ae4F85F01;
  // https://etherscan.io/address/0xc390dbe9fc00D6db73C52d375642b47008C33c90
  address internal constant ETHENA_ECOSYSTEM_SPOKE_ORACLE =
    0xc390dbe9fc00D6db73C52d375642b47008C33c90;
  // https://etherscan.io/address/0xd8B153FaAA8f2b1bC774916FEd333A4F3dE48792
  address internal constant ETHERFI_ESPOKE_ORACLE = 0xd8B153FaAA8f2b1bC774916FEd333A4F3dE48792;
  // https://etherscan.io/address/0xB3CE6E7b6d389a66eA4a3777bA07219d00FB3a9D
  address internal constant FOREX_SPOKE_ORACLE = 0xB3CE6E7b6d389a66eA4a3777bA07219d00FB3a9D;
  // https://etherscan.io/address/0x0083421fd178749af2201ddA5A7C3feB5790B80c
  address internal constant GOLD_SPOKE_ORACLE = 0x0083421fd178749af2201ddA5A7C3feB5790B80c;
  // https://etherscan.io/address/0x37C316996C714Bf906743071e04E62220b3271ac
  address internal constant KELP_ESPOKE_ORACLE = 0x37C316996C714Bf906743071e04E62220b3271ac;
  // https://etherscan.io/address/0x664D73b6C3591333Fd79510f7ce9ef81228824F5
  address internal constant LIDO_ESPOKE_ORACLE = 0x664D73b6C3591333Fd79510f7ce9ef81228824F5;
  // https://etherscan.io/address/0x198Cac7f54FFc7d709Ac0FEc4B6454CE73e21D3D
  address internal constant LOMBARD_BTC_SPOKE_ORACLE = 0x198Cac7f54FFc7d709Ac0FEc4B6454CE73e21D3D;
}

library AaveV4EthereumAssets {
  // https://etherscan.io/address/0x8292Bb45bf1Ee4d140127049757C2E0fF06317eD
  address internal constant RLUSD = 0x8292Bb45bf1Ee4d140127049757C2E0fF06317eD;
  // https://etherscan.io/address/0xe343167631d89B6Ffc58B88d6b7fB0228795491D
  address internal constant USDG = 0xe343167631d89B6Ffc58B88d6b7fB0228795491D;
  // https://etherscan.io/address/0xCAcd6fd266aF91b8AeD52aCCc382b4e165586E29
  address internal constant frxUSD = 0xCAcd6fd266aF91b8AeD52aCCc382b4e165586E29;
  // https://etherscan.io/address/0x68749665FF8D2d112Fa859AA293F07A622782F38
  address internal constant XAUt = 0x68749665FF8D2d112Fa859AA293F07A622782F38;
  // https://etherscan.io/address/0x3de0ff76E8b528C092d47b9DaC775931cef80F49
  address internal constant PT_sUSDE_7MAY2026 = 0x3de0ff76E8b528C092d47b9DaC775931cef80F49;
  // https://etherscan.io/address/0xAeBf0Bb9f57E89260d57f31AF34eB58657d96Ce0
  address internal constant PT_USDe_7MAY2026 = 0xAeBf0Bb9f57E89260d57f31AF34eB58657d96Ce0;
}

library AaveV4EthereumTokenizationSpokes {
  // -------------------------------------------------------------------------
  // Core Hub Tokenization Spokes
  // -------------------------------------------------------------------------
  // https://etherscan.io/address/0x0A65197b16C5969F92672051c9C9C0C75B369135
  address internal constant CORE_AAVE = 0x0A65197b16C5969F92672051c9C9C0C75B369135;
  // https://etherscan.io/address/0x6D9e2Cdd61CaF69af99b275704B6e272C41c6718
  address internal constant CORE_EURC = 0x6D9e2Cdd61CaF69af99b275704B6e272C41c6718;
  // https://etherscan.io/address/0x58C14a5E061c9bC6926c5b853445290F296C2F7B
  address internal constant CORE_GHO = 0x58C14a5E061c9bC6926c5b853445290F296C2F7B;
  // https://etherscan.io/address/0x7961F140B570490849DB878AE222570ea838799d
  address internal constant CORE_LBTC = 0x7961F140B570490849DB878AE222570ea838799d;
  // https://etherscan.io/address/0xE69C2045095C8Ab3E2a7d77de2328faE5baF797c
  address internal constant CORE_LINK = 0xE69C2045095C8Ab3E2a7d77de2328faE5baF797c;
  // https://etherscan.io/address/0xC8a125AE4275a78AADc53B46Ca10566Bc9B249E0
  address internal constant CORE_RLUSD = 0xC8a125AE4275a78AADc53B46Ca10566Bc9B249E0;
  // https://etherscan.io/address/0x531E90a2376902DE8915789Fcc1075e3B0c153E7
  address internal constant CORE_USDC = 0x531E90a2376902DE8915789Fcc1075e3B0c153E7;
  // https://etherscan.io/address/0xAC2435E3C25e8246870D33ce0a26988A46d5DB68
  address internal constant CORE_USDG = 0xAC2435E3C25e8246870D33ce0a26988A46d5DB68;
  // https://etherscan.io/address/0x5eC44a70F309854fe04d495cFE1B5dA63DD1cc73
  address internal constant CORE_USDT = 0x5eC44a70F309854fe04d495cFE1B5dA63DD1cc73;
  // https://etherscan.io/address/0x82A9CC4656784E55Ef2E78F704028B5E1Bfc1732
  address internal constant CORE_WBTC = 0x82A9CC4656784E55Ef2E78F704028B5E1Bfc1732;
  // https://etherscan.io/address/0x7320CF22Ac095bA2a2e0a652F77efB836c2E751b
  address internal constant CORE_WETH = 0x7320CF22Ac095bA2a2e0a652F77efB836c2E751b;
  // https://etherscan.io/address/0x4E712562fcb5337011398B6C630f55b60641cd5e
  address internal constant CORE_XAUt = 0x4E712562fcb5337011398B6C630f55b60641cd5e;
  // https://etherscan.io/address/0x33B41B74366F55327d959FfF6D6b6fBc2853dbB1
  address internal constant CORE_cbBTC = 0x33B41B74366F55327d959FfF6D6b6fBc2853dbB1;
  // https://etherscan.io/address/0x2226749630775ee20230Ad65214fB339087eF30D
  address internal constant CORE_frxUSD = 0x2226749630775ee20230Ad65214fB339087eF30D;
  // https://etherscan.io/address/0x45a04Ca1A5cbEeA4B44356c75EDd29b33eB2527a
  address internal constant CORE_rsETH = 0x45a04Ca1A5cbEeA4B44356c75EDd29b33eB2527a;
  // https://etherscan.io/address/0x559cEc2C840D9DBB18936Afc5E5341D78bfC7Cbe
  address internal constant CORE_weETH = 0x559cEc2C840D9DBB18936Afc5E5341D78bfC7Cbe;
  // https://etherscan.io/address/0xcb0E7dA9c635628f6d4827355AeCa75aB8d3560f
  address internal constant CORE_wstETH = 0xcb0E7dA9c635628f6d4827355AeCa75aB8d3560f;

  // -------------------------------------------------------------------------
  // Plus Hub Tokenization Spokes
  // -------------------------------------------------------------------------
  // https://etherscan.io/address/0xA54382db40EC602c0a173A08f9E86Ed40F9D4D10
  address internal constant PLUS_GHO = 0xA54382db40EC602c0a173A08f9E86Ed40F9D4D10;
  // https://etherscan.io/address/0xdd2Eb78BF9e6aC5068B95aD2d451e8c9Af10ac81
  address internal constant PLUS_PT_USDe_7MAY2026 = 0xdd2Eb78BF9e6aC5068B95aD2d451e8c9Af10ac81;
  // https://etherscan.io/address/0x90774889c22D2F2Adf44da1f04C7c95542590df4
  address internal constant PLUS_PT_sUSDE_7MAY2026 = 0x90774889c22D2F2Adf44da1f04C7c95542590df4;
  // https://etherscan.io/address/0xc94bdd83D2c7655C280655D60954e79E88D4F949
  address internal constant PLUS_USDC = 0xc94bdd83D2c7655C280655D60954e79E88D4F949;
  // https://etherscan.io/address/0x80835EB50694EE0e519743f67e5401e6FD300006
  address internal constant PLUS_USDT = 0x80835EB50694EE0e519743f67e5401e6FD300006;
  // https://etherscan.io/address/0x502Cd81da6a8F1785eb2eEE72713B7388E16A854
  address internal constant PLUS_USDe = 0x502Cd81da6a8F1785eb2eEE72713B7388E16A854;
  // https://etherscan.io/address/0x24f8c062e1E0451736C1D6e023510DA262a41df4
  address internal constant PLUS_sUSDe = 0x24f8c062e1E0451736C1D6E023510DA262a41df4;

  // -------------------------------------------------------------------------
  // Prime Hub Tokenization Spokes
  // -------------------------------------------------------------------------
  // https://etherscan.io/address/0x900fD46d565d1ac8995928c0179052ec02a6D0E1
  address internal constant PRIME_GHO = 0x900fD46d565d1ac8995928c0179052ec02a6D0E1;
  // https://etherscan.io/address/0x486415fb1F8b062c89ED548f871cf64304AACb31
  address internal constant PRIME_USDC = 0x486415fb1F8b062c89ED548f871cf64304AACb31;
  // https://etherscan.io/address/0x46c588DD8453aC259c1f6a54b4C9A93C2aC3762D
  address internal constant PRIME_USDT = 0x46c588DD8453aC259c1f6a54b4C9A93C2aC3762D;
  // https://etherscan.io/address/0x5AE3d87De89CA6Ce501e8317887F71EABED69E18
  address internal constant PRIME_WBTC = 0x5AE3d87De89CA6Ce501e8317887F71EABED69E18;
  // https://etherscan.io/address/0x2087513383330B961A3753B47627Bbf149F31c70
  address internal constant PRIME_WETH = 0x2087513383330B961A3753B47627Bbf149F31c70;
  // https://etherscan.io/address/0xD38098faf52D8E915EdED84fBF30F81C17906938
  address internal constant PRIME_cbBTC = 0xD38098faf52D8E915EdED84fBF30F81C17906938;
  // https://etherscan.io/address/0xFCD3D3C69cd032DE0cc78fE529B7447D2fe7F666
  address internal constant PRIME_wstETH = 0xFCD3D3C69cd032DE0cc78fE529B7447D2fe7F666;

  function getTokenizationSpokes() internal pure returns (address[] memory) {
    address[] memory spokes = new address[](31);
    // Core Hub
    spokes[0] = CORE_WETH;
    spokes[1] = CORE_wstETH;
    spokes[2] = CORE_weETH;
    spokes[3] = CORE_rsETH;
    spokes[4] = CORE_WBTC;
    spokes[5] = CORE_cbBTC;
    spokes[6] = CORE_LBTC;
    spokes[7] = CORE_USDT;
    spokes[8] = CORE_USDC;
    spokes[9] = CORE_LINK;
    spokes[10] = CORE_AAVE;
    spokes[11] = CORE_GHO;
    spokes[12] = CORE_EURC;
    spokes[13] = CORE_RLUSD;
    spokes[14] = CORE_USDG;
    spokes[15] = CORE_frxUSD;
    spokes[16] = CORE_XAUt;
    // Plus Hub
    spokes[17] = PLUS_USDT;
    spokes[18] = PLUS_USDC;
    spokes[19] = PLUS_GHO;
    spokes[20] = PLUS_USDe;
    spokes[21] = PLUS_sUSDe;
    spokes[22] = PLUS_PT_sUSDE_7MAY2026;
    spokes[23] = PLUS_PT_USDe_7MAY2026;
    // Prime Hub
    spokes[24] = PRIME_WETH;
    spokes[25] = PRIME_wstETH;
    spokes[26] = PRIME_WBTC;
    spokes[27] = PRIME_cbBTC;
    spokes[28] = PRIME_USDT;
    spokes[29] = PRIME_USDC;
    spokes[30] = PRIME_GHO;
    return spokes;
  }
}
