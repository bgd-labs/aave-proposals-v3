---
title: "CAPO Adapter Maintenance Update"
author: "BGD Labs (@bgdlabs)"
discussions: "https://governance.aave.com/t/technical-maintenance-proposals/15274/55"
---

## Simple Summary

Maintenance proposal to update stable price cap adapters across all v2 and v3 instances to the latest version.
The sDAI adapters on Ethereum and Gnosis Aave instances are also updated from non-capo to capo adapters, and USDS adapters are updated to use USDS/USD feed from the previous DAI/USD feed, given that liquidity of USDS is perfectly normalized.

## Motivation

With the Aave Generalized Risk Stewards (AGRS) being activated on proposal 197 it is important to update the CAPO adapters for stablecoins across both Aave V2 and V3 instances for it to work seamlessly with the new system. Currently this is not possible, because certain CAPOs are missing a getter method getPriceCap() which prevents the AGRS system from updating the price caps.

The CAPO adapter for sDAI was not activated before due to its un-stability on its growth rate, but with positive signaling from Chaos Labs, it is now to be enabled on Aave V3 Ethereum and Aave V3 Gnosis instances.

USDS asset was listed with a Chainlink DAI/USD underlying feed as given the asset was just released, and its underlying equivalence with DAI. Since USDS is totally stable now, it is reasonable to migrate to an USDS/USD feed.

## Specification

The following stable-coin CAPO feeds are being updated across all networks and instances:

| Aave Instances        | Underlying assets for which CAPO feed is updated         |
| --------------------- | -------------------------------------------------------- |
| AaveV3Ethereum        | USDC, USDT, USDS, DAI, LUSD, FRAX, crvUSD, pyUSD, sDAI   |
| AaveV3EthereumLido    | USDS                                                     |
| AaveV3EthereumEtherFi | USDC, pyUSD, FRAX                                        |
| AaveV2Ethereum        | USDC, USDT, DAI, FRAX, LUSD, USDP, sUSD, BUSD, TUSD, UST |
| AaveV3Polygon         | USDC, USDCn, USDT, DAI, miMATIC,                         |
| AaveV2Polygon         | USDC, USDT, DAI                                          |
| AaveV3Avalanche       | USDC, USDT, DAI, FRAX, MAI                               |
| AaveV2Avalanche       | USDC, USDT, DAI                                          |
| AaveV3Arbitrum        | USDC, USDCn, USDT, DAI, MAI, LUSD, FRAX                  |
| AaveV3Optimism        | USDC, USDCn, USDT, DAI, MAI, LUSD, FRAX                  |
| AaveV3Base            | USDC, USDbC                                              |
| AaveV3BNB             | USDC, USDT, fdUSD                                        |
| AaveV3Gnosis          | USDC, USDCe, wxDAI, sDAI                                 |
| AaveV3Metis           | USDC, USDT, DAI                                          |
| AaveV3Scroll          | USDC                                                     |

Price Feeds will be updated using `AAVE_ORACLE.setAssetSource()` method on Aave V2 Instances and using config-engine on Aave V3 Instances.

_Please note that the configurations for the Price Caps adapters and the underlying chainlink feeds are exactly the same as before. Also, price feeds of AaveV2 instances are updated as their underlying feed used ASSET/USD could also be updated via the Stewards using the AaveV3 ACL_MANAGER contract_

To be more explicit on the code changes between the previous stablecoin CAPO feed and the new one on v3 markets, the following method is being added on the new stablecoin CAPO feed:

```
/// @inheritdoc IPriceCapAdapterStable
function getPriceCap() external view returns (int256) {
	return _priceCap;
}
```

On v2 markets, the code diff between the previous feed and the new feed is zero, however the `ASSET_TO_PEG` underlying feed of the `CLSynchronicityPriceAdapterBaseToPeg` contract uses the new CAPO feed than the previous.

&nbsp;

<details>
<summary>More detailed on-chain code diffs can be found below:</summary>

- Ethereum V3 Core:

  - [CURRENT_SDAI_NEW_SDAI](https://contract-diff.swiss-knife.xyz/?contractOld=0x29081f7aB5a644716EfcDC10D5c926c5fEe9F72B&contractNew=0xf83B85205241c3BCCA0a09D32FaE65c16e0CF236&chainIdOld=1&chainIdNew=1): Big diff as feed changed from non-capo to capo
  - [CURRENT_USDS_NEW_USDS](https://contract-diff.swiss-knife.xyz/?contractOld=0x4F01b76391A05d32B20FA2d05dD5963eE8db20E6&contractNew=0x94C7FD62fd0506e71d8142E9D36687fC72A86B02&chainIdOld=1&chainIdNew=1): Only unrelated dependency changes
  - [CURRENT_USDC_NEW_USDC](https://contract-diff.swiss-knife.xyz/?contractOld=0x736bF902680e68989886e9807CD7Db4B3E015d3C&contractNew=0xB6557F02F0a5dA7b9D3C2d979cc19e00e756F6dA&chainIdOld=1&chainIdNew=1): Addition of `getPriceCap()` method plus unrelated dependency changes
  - [NEW_USDT_NEW_USDC](https://contract-diff.swiss-knife.xyz/?contractOld=0x260326c220E469358846b187eE53328303Efe19C&contractNew=0xB6557F02F0a5dA7b9D3C2d979cc19e00e756F6dA&chainIdOld=1&chainIdNew=1): No diff
  - [CURRENT_USDT_CURRENT_USDC](https://contract-diff.swiss-knife.xyz/?contractOld=0xC26D4a1c46d884cfF6dE9800B6aE7A8Cf48B4Ff8&contractNew=0x736bF902680e68989886e9807CD7Db4B3E015d3C&chainIdOld=1&chainIdNew=1): No diff
  - [NEW_DAI_NEW_USDC](https://contract-diff.swiss-knife.xyz/?contractOld=0x5c66322CA59bB61e867B28195576DbD8dA4b08dE&contractNew=0xB6557F02F0a5dA7b9D3C2d979cc19e00e756F6dA&chainIdOld=1&chainIdNew=1): No diff
  - [CURRENT_DAI_CURRENT_USDC](https://contract-diff.swiss-knife.xyz/?contractOld=0xaEb897E1Dc6BbdceD3B9D551C71a8cf172F27AC4&contractNew=0x736bF902680e68989886e9807CD7Db4B3E015d3C&chainIdOld=1&chainIdNew=1): No diff
  - [NEW_LUSD_NEW_USDC](https://contract-diff.swiss-knife.xyz/?contractOld=0xEbb721daf3DA9f1b3dcEc590cDf648137172d7CB&contractNew=0xB6557F02F0a5dA7b9D3C2d979cc19e00e756F6dA&chainIdOld=1&chainIdNew=1): No diff
  - [CURRENT_LUSD_CURRENT_USDC](https://contract-diff.swiss-knife.xyz/?contractOld=0x9eCdfaCca946614cc32aF63F3DBe50959244F3af&contractNew=0x736bF902680e68989886e9807CD7Db4B3E015d3C&chainIdOld=1&chainIdNew=1): No diff
  - [NEW_FRAX_NEW_USDC](https://contract-diff.swiss-knife.xyz/?contractOld=0xeF50f8DC65402c3019586bc8725fCD0b99B8AAd7&contractNew=0xB6557F02F0a5dA7b9D3C2d979cc19e00e756F6dA&chainIdOld=1&chainIdNew=1): No diff
  - [CURRENT_FRAX_CURRENT_USDC](https://contract-diff.swiss-knife.xyz/?contractOld=0x45D270263BBee500CF8adcf2AbC0aC227097b036&contractNew=0x736bF902680e68989886e9807CD7Db4B3E015d3C&chainIdOld=1&chainIdNew=1): No diff
  - [NEW_CRVUSD_NEW_USDC](https://contract-diff.swiss-knife.xyz/?contractOld=0x9Dc30dc58c72f5B669aEa01d02A2e4da194eE893&contractNew=0xB6557F02F0a5dA7b9D3C2d979cc19e00e756F6dA&chainIdOld=1&chainIdNew=1): No diff
  - [CURRENT_CRVUSD_CURRENT_USDC](https://contract-diff.swiss-knife.xyz/?contractOld=0x02AeE5b225366302339748951E1a924617b8814F&contractNew=0x736bF902680e68989886e9807CD7Db4B3E015d3C&chainIdOld=1&chainIdNew=1): No diff
  - [NEW_PYUSD_NEW_USDC](https://contract-diff.swiss-knife.xyz/?contractOld=0x36964C0579D02E0a5AaAb89E24Cf8d7CDF3549EE&contractNew=0xB6557F02F0a5dA7b9D3C2d979cc19e00e756F6dA&chainIdOld=1&chainIdNew=1): No diff
  - [CURRENT_PYUSD_CURRENT_USDC](https://contract-diff.swiss-knife.xyz/?contractOld=0x150bAe7Ce224555D39AfdBc6Cb4B8204E594E022&contractNew=0x736bF902680e68989886e9807CD7Db4B3E015d3C&chainIdOld=1&chainIdNew=1): No diff

- Ethereum V3 Prime:

  - [CURRENT_USDS_NEW_USDS](https://contract-diff.swiss-knife.xyz/?contractOld=0x4F01b76391A05d32B20FA2d05dD5963eE8db20E6&contractNew=0x94C7FD62fd0506e71d8142E9D36687fC72A86B02&chainIdOld=1&chainIdNew=1): Only unrelated dependency changes

- Ethereum V3 EtherFi:

  - [CURRENT_USDC_NEW_USDC](https://contract-diff.swiss-knife.xyz/?contractOld=0x736bF902680e68989886e9807CD7Db4B3E015d3C&contractNew=0xB6557F02F0a5dA7b9D3C2d979cc19e00e756F6dA&chainIdOld=1&chainIdNew=1): Addition of `getPriceCap()` method plus unrelated dependency changes
  - [NEW_PYUSD_NEW_USDC](https://contract-diff.swiss-knife.xyz/?contractOld=0x36964C0579D02E0a5AaAb89E24Cf8d7CDF3549EE&contractNew=0xB6557F02F0a5dA7b9D3C2d979cc19e00e756F6dA&chainIdOld=1&chainIdNew=1): No diff
  - [CURRENT_PYUSD_CURRENT_USDC](https://contract-diff.swiss-knife.xyz/?contractOld=0x150bAe7Ce224555D39AfdBc6Cb4B8204E594E022&contractNew=0x736bF902680e68989886e9807CD7Db4B3E015d3C&chainIdOld=1&chainIdNew=1): No diff
  - [NEW_FRAX_NEW_USDC](https://contract-diff.swiss-knife.xyz/?contractOld=0xeF50f8DC65402c3019586bc8725fCD0b99B8AAd7&contractNew=0xB6557F02F0a5dA7b9D3C2d979cc19e00e756F6dA&chainIdOld=1&chainIdNew=1): No diff
  - [CURRENT_FRAX_CURRENT_USDC](https://contract-diff.swiss-knife.xyz/?contractOld=0x45D270263BBee500CF8adcf2AbC0aC227097b036&contractNew=0x736bF902680e68989886e9807CD7Db4B3E015d3C&chainIdOld=1&chainIdNew=1): No diff

- Ethereum V2:

  - [CURRENT_USDC_NEW_USDC](https://contract-diff.swiss-knife.xyz/?contractOld=0x9f2817536Cfd48BF59243d9D8802a5670F5Be05d&contractNew=0x0B9a09cc52afc0d38ACcbd649aca1Da299d34454&chainIdOld=1&chainIdNew=1): No diff
  - [CURRENT_USDT_NEW_USDT](https://contract-diff.swiss-knife.xyz/?contractOld=0xEfF57B0c8987eea8C491bdDD2F64c1c21297Cf74&contractNew=0xCB45B5c861a6468145b1720A620C38f55f736B74&chainIdOld=1&chainIdNew=1): No diff
  - [CURRENT_DAI_NEW_DAI](https://contract-diff.swiss-knife.xyz/?contractOld=0xd486FE27AAB0b3CAd1462D767292dd7a84F06E58&contractNew=0x53a7856Cb3092E9c7C2c50e05E5b24462B7B9698&chainIdOld=1&chainIdNew=1): No diff
  - [CURRENT_FRAX_NEW_FRAX](https://contract-diff.swiss-knife.xyz/?contractOld=0x1f7e2ccd6702a5c587160390A52111aF6020ac92&contractNew=0xfD4A67F3c42CCA8ab4De6fba35dc11ffc87EE65e&chainIdOld=1&chainIdNew=1): No diff
  - [CURRENT_LUSD_NEW_LUSD](https://contract-diff.swiss-knife.xyz/?contractOld=0x3a1b874ec865c466046cf131516d26Cc228dF0b3&contractNew=0xd44d9a2E4643d55c1FA503C01a6cbB874a48Ae2E&chainIdOld=1&chainIdNew=1): No diff
  - [CURRENT_USDP_NEW_USDP](https://contract-diff.swiss-knife.xyz/?contractOld=0x776292E6eb3eD2D28C0CFa77BaB9378A771424Be&contractNew=0x09e57964e9F314c61aA3614f9DdE037779Fc9ff1&chainIdOld=1&chainIdNew=1): No diff
  - [CURRENT_SUSD_NEW_SUSD](https://contract-diff.swiss-knife.xyz/?contractOld=0x00753D870Ceda60b38A9efeb47a724160BD8A749&contractNew=0xC3c79aa824373c793E60901428e11884BFeD83Ed&chainIdOld=1&chainIdNew=1): No diff
  - [CURRENT_BUSD_NEW_BUSD](https://contract-diff.swiss-knife.xyz/?contractOld=0x378E959C0eCBbA793217913cE1D8745f6d6B7aC7&contractNew=0x190be7269f53b4C3d8057b8c7a058A750ded1356&chainIdOld=1&chainIdNew=1): No diff
  - [CURRENT_TUSD_NEW_TUSD](https://contract-diff.swiss-knife.xyz/?contractOld=0x65f05c3bC078bf24EdeaCFD48D6312c103AC4a61&contractNew=0x34A99cE5B513Baa1e27af7eED8E9E190e0F92ce1&chainIdOld=1&chainIdNew=1): No diff
  - [CURRENT_UST_NEW_UST](https://contract-diff.swiss-knife.xyz/?contractOld=0x51d08b4912d33d051b57d784c7CAfC0cD42c0f45&contractNew=0x774a7BC8b395A3F9879197D21cF6e7c6a2639937&chainIdOld=1&chainIdNew=1): No diff

- Polygon V3:

  - [CURRENT_USDC_NEW_USDC](https://contract-diff.swiss-knife.xyz/?contractOld=0x17E33D122FC34c7ad8FBd4a1995Dff9c8aE675eb&contractNew=0x31Ebeb03223AaC82C8EB24C77624Ea40F4D849Fb&chainIdOld=137&chainIdNew=137): Addition of `getPriceCap()` method plus unrelated dependency changes
  - [NEW_USDT_NEW_USDC](https://contract-diff.swiss-knife.xyz/?contractOld=0x01Aba1Fe7D72a3490bEef7CD0C09e1Ba2dD88D83&contractNew=0x31Ebeb03223AaC82C8EB24C77624Ea40F4D849Fb&chainIdOld=137&chainIdNew=137): No diff
  - [CURRENT_USDT_CURRENT_USDC](https://contract-diff.swiss-knife.xyz/?contractOld=0xaA574f4f6E124E77a7a1B5Ed91c8b407000A7730&contractNew=0x17E33D122FC34c7ad8FBd4a1995Dff9c8aE675eb&chainIdOld=137&chainIdNew=137): No diff
  - [NEW_DAI_NEW_USDC](https://contract-diff.swiss-knife.xyz/?contractOld=0xa1913Df228db08F02F3F3Dc0f397Af3A2d2f96A1&contractNew=0x31Ebeb03223AaC82C8EB24C77624Ea40F4D849Fb&chainIdOld=137&chainIdNew=137): No diff
  - [CURRENT_DAI_CURRENT_USDC](https://contract-diff.swiss-knife.xyz/?contractOld=0xF86577E7d27Ed35b85A7645c58bAaA64453fe32B&contractNew=0x17E33D122FC34c7ad8FBd4a1995Dff9c8aE675eb&chainIdOld=137&chainIdNew=137): No diff
  - [NEW_MIMATIC_NEW_USDC](https://contract-diff.swiss-knife.xyz/?contractOld=0x1e2Ba4725c6847dC8304466c4eA25A872A7D43a8&contractNew=0x31Ebeb03223AaC82C8EB24C77624Ea40F4D849Fb&chainIdOld=137&chainIdNew=137): No diff
  - [CURRENT_MIMATIC_CURRENT_USDC](https://contract-diff.swiss-knife.xyz/?contractOld=0x4ae2Ab1af7e3b0092dbF3A4B20ec3de8fC834873&contractNew=0x17E33D122FC34c7ad8FBd4a1995Dff9c8aE675eb&chainIdOld=137&chainIdNew=137): No diff

- Polygon V2:

  - [CURRENT_USDC_NEW_USDC](https://contract-diff.swiss-knife.xyz/?contractOld=0xB611AA5E98112C7c3711Ca3a5187dC025B83C8e4&contractNew=0xeAa310d63670b8C36699cE53E3e926b23355F3df&chainIdOld=137&chainIdNew=137): No diff
  - [CURRENT_USDT_NEW_USDT](https://contract-diff.swiss-knife.xyz/?contractOld=0xf840c80932908EF206056dF0882bC595e7150607&contractNew=0xf44Fee6877F2f1a0b84c8bC49ff4Ec35DF089Ea0&chainIdOld=137&chainIdNew=137): No diff
  - [CURRENT_DAI_NEW_DAI](https://contract-diff.swiss-knife.xyz/?contractOld=0x08EDd9E1DF3b0b8498864C60a2FD6cDb13148885&contractNew=0xC368bAB13A2b46D02c20c28AeBaB79bbE7E067AA&chainIdOld=137&chainIdNew=137): No diff

- Avalanche V3:

  - [CURRENT_USDC_NEW_USDC](https://contract-diff.swiss-knife.xyz/?contractOld=0xD8277249e871BE9A402fa286C2C5ec16046dC512&contractNew=0xb0D7A8bbDcdb1203850b742bB4d7f57a1F1C8483&chainIdOld=43114&chainIdNew=43114): Addition of `getPriceCap()` method plus unrelated dependency changes
  - [NEW_USDT_NEW_USDC](https://contract-diff.swiss-knife.xyz/?contractOld=0x5b7810a910B4a878AaA4800a824E5E5796838009&contractNew=0xb0D7A8bbDcdb1203850b742bB4d7f57a1F1C8483&chainIdOld=43114&chainIdNew=43114): No diff
  - [CURRENT_USDT_CURRENT_USDC](https://contract-diff.swiss-knife.xyz/?contractOld=0x39185f2236A6022b682e8BB93C040d125DA093CF&contractNew=0xD8277249e871BE9A402fa286C2C5ec16046dC512&chainIdOld=43114&chainIdNew=43114): No diff
  - [NEW_DAI_NEW_USDC](https://contract-diff.swiss-knife.xyz/?contractOld=0x0b47c51CCD4FaDe1D93C750bFCAB0a5ce8734ED0&contractNew=0xb0D7A8bbDcdb1203850b742bB4d7f57a1F1C8483&chainIdOld=43114&chainIdNew=43114): No diff
  - [CURRENT_DAI_CURRENT_USDC](https://contract-diff.swiss-knife.xyz/?contractOld=0xf82da795727633aFA9BB0f1B08A87c0F6A38723f&contractNew=0xD8277249e871BE9A402fa286C2C5ec16046dC512&chainIdOld=43114&chainIdNew=43114): No diff
  - [NEW_FRAX_NEW_USDC](https://contract-diff.swiss-knife.xyz/?contractOld=0x0b7c356de5E68A8A257fcD23Ac1e8204D753A6fb&contractNew=0xb0D7A8bbDcdb1203850b742bB4d7f57a1F1C8483&chainIdOld=43114&chainIdNew=43114): No diff
  - [CURRENT_FRAX_CURRENT_USDC](https://contract-diff.swiss-knife.xyz/?contractOld=0x6208576378D06ce69A27987b7A524A9B15d499a4&contractNew=0xD8277249e871BE9A402fa286C2C5ec16046dC512&chainIdOld=43114&chainIdNew=43114): No diff
  - [NEW_MAI_NEW_USDC](https://contract-diff.swiss-knife.xyz/?contractOld=0x85142981C14D98a4B69B04225ca74b764648D443&contractNew=0xb0D7A8bbDcdb1203850b742bB4d7f57a1F1C8483&chainIdOld=43114&chainIdNew=43114): No diff
  - [CURRENT_MAI_CURRENT_USDC](https://contract-diff.swiss-knife.xyz/?contractOld=0xCcC55Db26B78a19Dba1beE0066F9c1665575439A&contractNew=0xD8277249e871BE9A402fa286C2C5ec16046dC512&chainIdOld=43114&chainIdNew=43114): No diff

- Avalanche V2:

  - [CURRENT_USDC_NEW_USDC](https://contract-diff.swiss-knife.xyz/?contractOld=0xD8277249e871BE9A402fa286C2C5ec16046dC512&contractNew=0xb0D7A8bbDcdb1203850b742bB4d7f57a1F1C8483&chainIdOld=43114&chainIdNew=43114): Addition of `getPriceCap()` method plus unrelated dependency changes
  - [NEW_USDT_NEW_USDC](https://contract-diff.swiss-knife.xyz/?contractOld=0x5b7810a910B4a878AaA4800a824E5E5796838009&contractNew=0xb0D7A8bbDcdb1203850b742bB4d7f57a1F1C8483&chainIdOld=43114&chainIdNew=43114): No diff
  - [NEW_DAI_NEW_USDC](https://contract-diff.swiss-knife.xyz/?contractOld=0x0b47c51CCD4FaDe1D93C750bFCAB0a5ce8734ED0&contractNew=0xb0D7A8bbDcdb1203850b742bB4d7f57a1F1C8483&chainIdOld=43114&chainIdNew=43114): No diff

- Arbitrum V3:

  - [CURRENT_USDC_NEW_USDC](https://contract-diff.swiss-knife.xyz/?contractOld=0xDe25a88F87FEd9F8999fAbF6729dCB121893623C&contractNew=0x6200A5122Af8D5D9e69f4d526311Cd85241ACeC9&chainIdOld=42161&chainIdNew=42161): Addition of `getPriceCap()` method plus unrelated dependency changes
  - [NEW_USDT_NEW_USDC](https://contract-diff.swiss-knife.xyz/?contractOld=0x476494a850eec47301F74C8c9c2652495c47C56c&contractNew=0x6200A5122Af8D5D9e69f4d526311Cd85241ACeC9&chainIdOld=42161&chainIdNew=42161): No diff
  - [CURRENT_USDT_CURRENT_USDC](https://contract-diff.swiss-knife.xyz/?contractOld=0x84dC1C52D7C340AA54B4e8799FBB31C3D28E67aD&contractNew=0xDe25a88F87FEd9F8999fAbF6729dCB121893623C&chainIdOld=42161&chainIdNew=42161): No diff
  - [NEW_DAI_NEW_USDC](https://contract-diff.swiss-knife.xyz/?contractOld=0x9F221bfD2d3F226b187d4419b49117aD7E698977&contractNew=0x6200A5122Af8D5D9e69f4d526311Cd85241ACeC9&chainIdOld=42161&chainIdNew=42161): No diff
  - [CURRENT_DAI_CURRENT_USDC](https://contract-diff.swiss-knife.xyz/?contractOld=0x4a838a3Dac6633bB1fd932B6f356DecFCAf7803D&contractNew=0xDe25a88F87FEd9F8999fAbF6729dCB121893623C&chainIdOld=42161&chainIdNew=42161): No diff
  - [NEW_LUSD_NEW_USDC](https://contract-diff.swiss-knife.xyz/?contractOld=0xc8b3e2776260c7e7A9C158a2344776e65E10ceE8&contractNew=0x6200A5122Af8D5D9e69f4d526311Cd85241ACeC9&chainIdOld=42161&chainIdNew=42161): No diff
  - [CURRENT_LUSD_CURRENT_USDC](https://contract-diff.swiss-knife.xyz/?contractOld=0x341B110bDF665A20F0D5f84A92FcAF5EbeEBC629&contractNew=0xDe25a88F87FEd9F8999fAbF6729dCB121893623C&chainIdOld=42161&chainIdNew=42161): No diff
  - [NEW_FRAX_NEW_USDC](https://contract-diff.swiss-knife.xyz/?contractOld=0xC1d2Faa98935eA2f2eD34Bc84edb00B387061376&contractNew=0x6200A5122Af8D5D9e69f4d526311Cd85241ACeC9&chainIdOld=42161&chainIdNew=42161): No diff
  - [CURRENT_FRAX_CURRENT_USDC](https://contract-diff.swiss-knife.xyz/?contractOld=0x06919EB75Bd6BA817D38CC70C1CA588ac7a01C10&contractNew=0xDe25a88F87FEd9F8999fAbF6729dCB121893623C&chainIdOld=42161&chainIdNew=42161): No diff
  - [NEW_MAI_NEW_USDC](https://contract-diff.swiss-knife.xyz/?contractOld=0xAF92b0A685a15F4E26B6d7DA86F1a9C8C01E2a09&contractNew=0x6200A5122Af8D5D9e69f4d526311Cd85241ACeC9&chainIdOld=42161&chainIdNew=42161): No diff
  - [CURRENT_MAI_CURRENT_USDC](https://contract-diff.swiss-knife.xyz/?contractOld=0x7a7cE08a1057723CCEDeA2462407427Ae33FFEb2&contractNew=0xDe25a88F87FEd9F8999fAbF6729dCB121893623C&chainIdOld=42161&chainIdNew=42161): No diff

- Optimism V3:

  - [CURRENT_USDC_NEW_USDC](https://contract-diff.swiss-knife.xyz/?contractOld=0x2daA7078f78485A708003989cBc9a643e3b4B61f&contractNew=0x6379A975Ef93EC2bE87f56A02CCF8535dFAde201&chainIdOld=10&chainIdNew=10): Addition of `getPriceCap()` method plus unrelated dependency changes
  - [NEW_USDT_NEW_USDC](https://contract-diff.swiss-knife.xyz/?contractOld=0xDb4E371F8dc7D834D3F1359295c669352ECe7D9c&contractNew=0x6379A975Ef93EC2bE87f56A02CCF8535dFAde201&chainIdOld=10&chainIdNew=10): No diff
  - [CURRENT_USDT_CURRENT_USDC](https://contract-diff.swiss-knife.xyz/?contractOld=0x70E6DBBFFc9c3c6fB4a9c349E3101B7dCEE67f4D&contractNew=0x2daA7078f78485A708003989cBc9a643e3b4B61f&chainIdOld=10&chainIdNew=10): No diff
  - [NEW_DAI_NEW_USDC](https://contract-diff.swiss-knife.xyz/?contractOld=0xf116891adaBb21Df94663c8Aa62f87fC1bc19d53&contractNew=0x6379A975Ef93EC2bE87f56A02CCF8535dFAde201&chainIdOld=10&chainIdNew=10): No diff
  - [CURRENT_DAI_CURRENT_USDC](https://contract-diff.swiss-knife.xyz/?contractOld=0x1a96fe91278bcF6F19665F642FE7a88cD5c360bb&contractNew=0x2daA7078f78485A708003989cBc9a643e3b4B61f&chainIdOld=10&chainIdNew=10): No diff
  - [NEW_LUSD_NEW_USDC](https://contract-diff.swiss-knife.xyz/?contractOld=0x5a602E33B935415477550c709a79cDF23E1355d5&contractNew=0x6379A975Ef93EC2bE87f56A02CCF8535dFAde201&chainIdOld=10&chainIdNew=10): No diff
  - [CURRENT_LUSD_CURRENT_USDC](https://contract-diff.swiss-knife.xyz/?contractOld=0x8f4dAFb6Feb190e7846eb7665fD49FFb1177Ff8e&contractNew=0x2daA7078f78485A708003989cBc9a643e3b4B61f&chainIdOld=10&chainIdNew=10): No diff
  - [NEW_SUSD_NEW_USDC](https://contract-diff.swiss-knife.xyz/?contractOld=0x8ea108096AdEA6Ac059cbEaE6862ce9BB52B4E87&contractNew=0x6379A975Ef93EC2bE87f56A02CCF8535dFAde201&chainIdOld=10&chainIdNew=10): No diff
  - [CURRENT_SUSD_CURRENT_USDC](https://contract-diff.swiss-knife.xyz/?contractOld=0xC77E9CF9603F5ef5503213229ABB1Fec3001f312&contractNew=0x2daA7078f78485A708003989cBc9a643e3b4B61f&chainIdOld=10&chainIdNew=10): No diff
  - [NEW_MAI_NEW_USDC](https://contract-diff.swiss-knife.xyz/?contractOld=0x1D85F6eB05f618154ac520D2fDa74C40D21BD93e&contractNew=0x6379A975Ef93EC2bE87f56A02CCF8535dFAde201&chainIdOld=10&chainIdNew=10): No diff
  - [CURRENT_MAI_CURRENT_USDC](https://contract-diff.swiss-knife.xyz/?contractOld=0xc6ac65E8f4F50a6655Efd78A92b6c503B5B625C8&contractNew=0x2daA7078f78485A708003989cBc9a643e3b4B61f&chainIdOld=10&chainIdNew=10): No diff

- Base V3:

  - [CURRENT_USDC_NEW_USDC](https://contract-diff.swiss-knife.xyz/?contractOld=0x978D8878b53Fbe40dab7D4AB47b97AB622FFeF9f&contractNew=0xfcF82bFa2485253263969167583Ea4de09e9993b&chainIdOld=8453&chainIdNew=8453): Addition of `getPriceCap()` method plus unrelated dependency changes

- BNB V3:

  - [CURRENT_USDC_NEW_USDC](https://contract-diff.swiss-knife.xyz/?contractOld=0xaFcFF74AE956f4c23c27Db49659D4a7F350415C1&contractNew=0x9102a9553B470dbD0dC74009a870A5886C92902C&chainIdOld=56&chainIdNew=56): Addition of `getPriceCap()` method plus unrelated dependency changes
  - [NEW_USDT_NEW_USDC](https://contract-diff.swiss-knife.xyz/?contractOld=0xee845A7A40A090Da256420A293803C35B7F436b6&contractNew=0x9102a9553B470dbD0dC74009a870A5886C92902C&chainIdOld=56&chainIdNew=56): No diff
  - [CURRENT_USDT_CURRENT_USDC](https://contract-diff.swiss-knife.xyz/?contractOld=0x0F682319Ed4A240b7a2599A48C965049515D9bC3&contractNew=0xaFcFF74AE956f4c23c27Db49659D4a7F350415C1&chainIdOld=56&chainIdNew=56): No diff
  - [NEW_FDUSD_NEW_USDC](https://contract-diff.swiss-knife.xyz/?contractOld=0x72Cb7a00D439296A6fC3c9face9Eca96bfdEf825&contractNew=0x9102a9553B470dbD0dC74009a870A5886C92902C&chainIdOld=56&chainIdNew=56): No diff
  - [CURRENT_FDUSD_CURRENT_USDC](https://contract-diff.swiss-knife.xyz/?contractOld=0x60a117Fa5bAbee4d645884fB11E413Da4F893b6D&contractNew=0xaFcFF74AE956f4c23c27Db49659D4a7F350415C1&chainIdOld=56&chainIdNew=56): No diff

- Gnosis V3:

  - [CURRENT_SDAI_NEW_SDAI](https://contract-diff.swiss-knife.xyz/?contractOld=0x1D0f881Ce1a646E2f27Dec3c57Fa056cB838BCC2&contractNew=0x620424f393dD413c2F8Dc2980905c4daa3619e61&chainIdOld=100&chainIdNew=100): Big diff as feed changed from non-capo to capo
  - [CURRENT_USDC_NEW_USDC](https://contract-diff.swiss-knife.xyz/?contractOld=0x0a2d05bc646C65A029e602c257DfA14adF8BfAd2&contractNew=0x1450C4BE9dd66889CddAB77e5947B6166ACbfAE2&chainIdOld=100&chainIdNew=100): Addition of `getPriceCap()` method plus unrelated dependency changes
  - [NEW_WXDAI_NEW_USDC](https://contract-diff.swiss-knife.xyz/?contractOld=0x7443afE82986d7475Cea0c5b04C6F1581fdAce87&contractNew=0x1450C4BE9dd66889CddAB77e5947B6166ACbfAE2&chainIdOld=100&chainIdNew=100): No diff
  - [CURRENT_WXDAI_CURRENT_USDC](https://contract-diff.swiss-knife.xyz/?contractOld=0xE5269eF0CE04E509E8134624c7BF043b21e10897&contractNew=0x0a2d05bc646C65A029e602c257DfA14adF8BfAd2&chainIdOld=100&chainIdNew=100): No diff

- Scroll V3:
  - [CURRENT_USDC_NEW_USDC](https://contract-diff.swiss-knife.xyz/?contractOld=0x427Fd98dbD1DbC2D4e792350caBe7c9665F35bee&contractNew=0x1685D81212580DD4cDA287616C2f6F4794927e18&chainIdOld=534352&chainIdNew=534352): Addition of `getPriceCap()` method plus unrelated dependency changes

</details>

&nbsp;

As suggested by Risk Contributors (Chaos Labs), the following configuration for CAPO has been set for sDAI on Aave V3 Ethereum and Gnosis instances:
| maxYearlyRatioGrowthPercent | MINIMUM_SNAPSHOT_DELAY |
| --- | --- |
| 16% | 7 days |

## References

- Implementation: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20241101_Multi_UpdatePriceCapAdaptersCAPO/AaveV3Ethereum_UpdatePriceCapAdaptersCAPO_20241101.sol), [AaveV3Polygon](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20241101_Multi_UpdatePriceCapAdaptersCAPO/AaveV3Polygon_UpdatePriceCapAdaptersCAPO_20241101.sol), [AaveV3Avalanche](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20241101_Multi_UpdatePriceCapAdaptersCAPO/AaveV3Avalanche_UpdatePriceCapAdaptersCAPO_20241101.sol), [AaveV3Optimism](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20241101_Multi_UpdatePriceCapAdaptersCAPO/AaveV3Optimism_UpdatePriceCapAdaptersCAPO_20241101.sol), [AaveV3Arbitrum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20241101_Multi_UpdatePriceCapAdaptersCAPO/AaveV3Arbitrum_UpdatePriceCapAdaptersCAPO_20241101.sol), [AaveV3Metis](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20241101_Multi_UpdatePriceCapAdaptersCAPO/AaveV3Metis_UpdatePriceCapAdaptersCAPO_20241101.sol), [AaveV3Base](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20241101_Multi_UpdatePriceCapAdaptersCAPO/AaveV3Base_UpdatePriceCapAdaptersCAPO_20241101.sol), [AaveV3Gnosis](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20241101_Multi_UpdatePriceCapAdaptersCAPO/AaveV3Gnosis_UpdatePriceCapAdaptersCAPO_20241101.sol), [AaveV3Scroll](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20241101_Multi_UpdatePriceCapAdaptersCAPO/AaveV3Scroll_UpdatePriceCapAdaptersCAPO_20241101.sol), [AaveV3BNB](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20241101_Multi_UpdatePriceCapAdaptersCAPO/AaveV3BNB_UpdatePriceCapAdaptersCAPO_20241101.sol)
- Tests: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20241101_Multi_UpdatePriceCapAdaptersCAPO/AaveV3Ethereum_UpdatePriceCapAdaptersCAPO_20241101.t.sol), [AaveV3Polygon](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20241101_Multi_UpdatePriceCapAdaptersCAPO/AaveV3Polygon_UpdatePriceCapAdaptersCAPO_20241101.t.sol), [AaveV3Avalanche](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20241101_Multi_UpdatePriceCapAdaptersCAPO/AaveV3Avalanche_UpdatePriceCapAdaptersCAPO_20241101.t.sol), [AaveV3Optimism](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20241101_Multi_UpdatePriceCapAdaptersCAPO/AaveV3Optimism_UpdatePriceCapAdaptersCAPO_20241101.t.sol), [AaveV3Arbitrum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20241101_Multi_UpdatePriceCapAdaptersCAPO/AaveV3Arbitrum_UpdatePriceCapAdaptersCAPO_20241101.t.sol), [AaveV3Metis](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20241101_Multi_UpdatePriceCapAdaptersCAPO/AaveV3Metis_UpdatePriceCapAdaptersCAPO_20241101.t.sol), [AaveV3Base](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20241101_Multi_UpdatePriceCapAdaptersCAPO/AaveV3Base_UpdatePriceCapAdaptersCAPO_20241101.t.sol), [AaveV3Gnosis](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20241101_Multi_UpdatePriceCapAdaptersCAPO/AaveV3Gnosis_UpdatePriceCapAdaptersCAPO_20241101.t.sol), [AaveV3Scroll](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20241101_Multi_UpdatePriceCapAdaptersCAPO/AaveV3Scroll_UpdatePriceCapAdaptersCAPO_20241101.t.sol), [AaveV3BNB](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20241101_Multi_UpdatePriceCapAdaptersCAPO/AaveV3BNB_UpdatePriceCapAdaptersCAPO_20241101.t.sol)
- [Discussion](https://governance.aave.com/t/technical-maintenance-proposals/15274/55)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
