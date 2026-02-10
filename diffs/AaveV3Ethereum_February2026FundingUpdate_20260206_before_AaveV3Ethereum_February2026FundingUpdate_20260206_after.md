## Reserve changes

### Reserves altered

#### WETH ([0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2](https://etherscan.io/address/0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2))

| description | value before | value after |
| --- | --- | --- |
| aTokenUnderlyingBalance | 465,818.5315 WETH [465818531593163649573434] | 466,059.3609 WETH [466059360902075263319434] |
| virtualBalance | 465,818.5251 WETH [465818525137379362043843] | 466,059.3544 WETH [466059354446290975789843] |


## Raw diff

```json
{
  "reserves": {
    "0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2": {
      "aTokenUnderlyingBalance": {
        "from": "465818531593163649573434",
        "to": "466059360902075263319434"
      },
      "virtualBalance": {
        "from": "465818525137379362043843",
        "to": "466059354446290975789843"
      }
    }
  },
  "raw": {
    "0x00907f9921424583e7ffbfedf84f92b7b2be4977": {
      "label": "AaveV3Ethereum.ASSETS.GHO.A_TOKEN",
      "contract": "lib/aave-umbrella/lib/aave-v3-origin/lib/solidity-utils/lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/proxy/transparent/TransparentUpgradeableProxy.sol:TransparentUpgradeableProxy",
      "balanceDiff": null,
      "nonceDiff": null,
      "stateDiff": {
        "0xaf64e0677d2cd0fbb2684524612bdc1bb6ace133e9dcf5b09e70b33dd6b72262": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x000000000000000000000000000000000000000000000581767ba6189c400000"
        }
      }
    },
    "0x0b925ed163218f6662a35e0f0371ac234f9e9371": {
      "label": "AaveV3Ethereum.ASSETS.wstETH.A_TOKEN",
      "contract": "lib/aave-umbrella/lib/aave-v3-origin/lib/solidity-utils/lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/proxy/transparent/TransparentUpgradeableProxy.sol:TransparentUpgradeableProxy",
      "balanceDiff": null,
      "nonceDiff": null,
      "stateDiff": {
        "0x1c9219960928272f24f6428ef210f3b2b07d28d1a5e724b7119ecc245cce49b9": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x00000000000000000000000000000000000000000000003ba1910bf341b00000"
        }
      }
    },
    "0x464c71f6c2f760dda6093dcb91c24c39e5d6e18c": {
      "label": "AaveV2Ethereum.COLLECTOR, AaveV2EthereumAMM.COLLECTOR, AaveV2EthereumArc.COLLECTOR, AaveV3Ethereum.COLLECTOR, AaveV3EthereumEtherFi.COLLECTOR, AaveV3EthereumLido.COLLECTOR",
      "contract": "lib/aave-umbrella/lib/aave-v3-origin/lib/solidity-utils/lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/proxy/transparent/TransparentUpgradeableProxy.sol:TransparentUpgradeableProxy",
      "balanceDiff": {
        "previousValue": "0xd0e2d947c9b8d9b50",
        "newValue": "0x0"
      },
      "nonceDiff": null,
      "stateDiff": {}
    },
    "0x4c9edd5852cd905f086c759e8383e09bff1e68b3": {
      "label": "AaveV3Ethereum.ASSETS.USDe.UNDERLYING",
      "contract": null,
      "balanceDiff": null,
      "nonceDiff": null,
      "stateDiff": {
        "0x3fa26c82dc3e1ec09096699fca3dd121d89f1d3a0489037b7c5ca42d5270473d": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x00000000000000000000000000000000000000000004f68ca6d8cd91c6000000"
        }
      }
    },
    "0x4d5f47fa6a74757f35c14fd3a6ef8e3c9bc514e8": {
      "label": "AaveV3Ethereum.ASSETS.WETH.A_TOKEN",
      "contract": "lib/aave-umbrella/lib/aave-v3-origin/lib/solidity-utils/lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/proxy/transparent/TransparentUpgradeableProxy.sol:TransparentUpgradeableProxy",
      "balanceDiff": null,
      "nonceDiff": null,
      "stateDiff": {
        "0x0000000000000000000000000000000000000000000000000000000000000036": {
          "previousValue": "0x00000000000000000000000000000000000000000002ae4d99272625c63f6a5b",
          "newValue": "0x00000000000000000000000000000000000000000002ae59ee5b5b6cabba193e"
        },
        "0x14a553e31736f19e3e380cf55bfb2f82dfd6d880cd07235affb68d8d3e0cac4d": {
          "previousValue": "0x00000000036ba36a96ed5c26c7cb43d500000000000000a2f1c90ac48b87a2ec",
          "newValue": "0x00000000036ba4b7cd5a1e2a74873dd300000000000000af46fd400b710251cf"
        },
        "0x1c9219960928272f24f6428ef210f3b2b07d28d1a5e724b7119ecc245cce49b9": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000000000000000000000000000000d8d726b7177a800000"
        },
        "0x58f95ca91fd1d7ad8e1df368e75bfba7975724c2026cab27afdbf7b348fe0d85": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x00000000000000000000000000000000000000000000005150ae84a8cdf00000"
        },
        "0x81a96f7239fbb9f1975dde1bdaa5fb36a96a5292e38f3196e56065b41300efcf": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000000000000000000000000000000001400ea8bb00f5432"
        }
      }
    },
    "0x5300a1a15135ea4dc7ad5a167152c01efc9b192a": {
      "label": "AaveV2Ethereum.POOL_ADMIN, AaveV2EthereumAMM.POOL_ADMIN, AaveV3Ethereum.ACL_ADMIN, AaveV3EthereumEtherFi.ACL_ADMIN, AaveV3EthereumHorizon.ACL_ADMIN, AaveV3EthereumLido.ACL_ADMIN, GovernanceV3Ethereum.EXECUTOR_LVL_1",
      "contract": null,
      "balanceDiff": {
        "previousValue": "0x0",
        "newValue": "0xd0e2d947c9b8d9b50"
      },
      "nonceDiff": null,
      "stateDiff": {}
    },
    "0x7fc66500c84a76ad7e9c93437bfc5ac33e2ddae9": {
      "label": "AaveV2Ethereum.ASSETS.AAVE.UNDERLYING, AaveV2EthereumArc.ASSETS.AAVE.UNDERLYING, AaveV3Ethereum.ASSETS.AAVE.UNDERLYING",
      "contract": "lib/aave-umbrella/lib/aave-v3-origin/lib/solidity-utils/lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/proxy/transparent/TransparentUpgradeableProxy.sol:TransparentUpgradeableProxy",
      "balanceDiff": null,
      "nonceDiff": null,
      "stateDiff": {
        "0x010d1e6d67e35ff9895674088574ee9a4e5814771afead87821c6a8c7c6ca99c": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x000000000000000000000000000000000000000000000878678326eac9000000"
        },
        "0x1d3752e906bd35d7dfefd5e8086064fad83192c9757512d068e6cf9fd1352eba": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x00000000000000000000000000000000000000000000152d02c7e14af6800000"
        }
      }
    },
    "0x83b7ce402a0e756e901c4a9d1cafa27ca9572afc": {
      "label": null,
      "contract": null,
      "balanceDiff": {
        "previousValue": "0xd0e2d947c9b8d9b50",
        "newValue": "0x0"
      },
      "nonceDiff": null,
      "stateDiff": {}
    },
    "0x87870bca3f3fd6335c3f4ce8392d69350b4fa4e2": {
      "label": "AaveV3Ethereum.POOL",
      "contract": "lib/aave-umbrella/lib/aave-v3-origin/lib/solidity-utils/lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/proxy/transparent/TransparentUpgradeableProxy.sol:TransparentUpgradeableProxy",
      "balanceDiff": null,
      "nonceDiff": null,
      "stateDiff": {
        "0xf81d8d79f42adb4c73cc3aa0c78e25d3343882d0313c0b80ece3d3a103ef1ec0": {
          "previousValue": "0x00000000000d6a0d9283de6faf87217d00000000036ba4b7180b1b14d932f357",
          "newValue": "0x00000000000d69922e9a96efef6751de00000000036ba4b7cd5a1e2a74873dd3"
        },
        "0xf81d8d79f42adb4c73cc3aa0c78e25d3343882d0313c0b80ece3d3a103ef1ec1": {
          "previousValue": "0x00000000001242b5e3f8f27640f2e0db000000000385a0925609cfa0423792de",
          "newValue": "0x0000000000124261e72f0711c03e2587000000000385a093542c97df3335a0c4"
        },
        "0xf81d8d79f42adb4c73cc3aa0c78e25d3343882d0313c0b80ece3d3a103ef1ec2": {
          "previousValue": "0x000000000000000000000000697ee7e30000000000000000707c2fb9116c843e",
          "newValue": "0x000000000000000000000000697ee7fb0000000000000000707c2fb9116c843e"
        },
        "0xf81d8d79f42adb4c73cc3aa0c78e25d3343882d0313c0b80ece3d3a103ef1ec7": {
          "previousValue": "0x00000000000062a412a61820494f77c300000000000000119400c03f531948d6",
          "newValue": "0x00000000000062b120d3ac9ce4dd131300000000000000119419d4a8d50b389d"
        }
      }
    },
    "0xb7d402138cb01bfe97d95181c849379d6ad14d19": {
      "label": "AaveV3Ethereum.COLLECTOR_SWAP_STEWARD",
      "contract": null,
      "balanceDiff": null,
      "nonceDiff": null,
      "stateDiff": {
        "0x353c2eb9e53a4a4a6d45d72082ff2e9dc829d1125618772a83eb0e7f86632c42": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000000000000000000000000000000a2a15d09519be00000"
        },
        "0x4893cf5c907516f83ef34156fd395161ad9d14791654d84497fd7f6645792716": {
          "previousValue": "0x000000000000000000000000000000000000000000020fd7ea52f6d01d47e7ef",
          "newValue": "0x00000000000000000000000000000000000000000003b75c21f090ab5f47e7ef"
        },
        "0x5155b87032287020835fd30a2714968505cc2c1a9438fb05bb946b3b22c4111f": {
          "previousValue": "0x00000000000000000000000000000000000000000000000000000323c69b2a1c",
          "newValue": "0x000000000000000000000000000000000000000000000000000007afedd47a1c"
        },
        "0x75c6dfed6c5416e2fce951b27fe1b69a3bd6f4b11908f83cbc6c9319c50193a9": {
          "previousValue": "0x0000000000000000000000000000000000000000000422ca8b0a00a425000000",
          "newValue": "0x000000000000000000000000000000000000000000084595161401484a000000"
        },
        "0xa197b6ae0044c90610b63b51392eb7144f4390bba5cb14eeeb9a37521cf0dd8a": {
          "previousValue": "0x000000000000000000000000000000000000000000000000000000000000002c",
          "newValue": "0x0000000000000000000000000000000000000000000000000000048c2739502c"
        },
        "0xde97efb42af46a9d42baf2978100f17875214a4fc6e471c8edc0bf9b2d0c8696": {
          "previousValue": "0x000000000000000000000000000000000000000000039f822c521f8867c70c34",
          "newValue": "0x00000000000000000000000000000000000000000005470663efb963a9c70c34"
        }
      }
    },
    "0xc02aaa39b223fe8d0a0e5c4f27ead9083c756cc2": {
      "label": "AaveV2Ethereum.ASSETS.WETH.UNDERLYING, AaveV2EthereumAMM.ASSETS.WETH.UNDERLYING, AaveV2EthereumArc.ASSETS.WETH.UNDERLYING, AaveV3Ethereum.ASSETS.WETH.UNDERLYING, AaveV3EthereumLido.ASSETS.WETH.UNDERLYING",
      "contract": null,
      "balanceDiff": {
        "previousValue": "0x1d97e84b6732c73ab22c9",
        "newValue": "0x1d98b92e407a90f38be19"
      },
      "nonceDiff": null,
      "stateDiff": {
        "0x543ab8e6e10ec4e6ab4a5e1f294e0d226bad622baeefc2af96c474a541e359e8": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000000000000000000000000000000000000000000000000"
        },
        "0x89f4444109b1ce2fe5265477fa09b0f44061c82a9ba98ba4e60d1136a0dfc015": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x0000000000000000000000000000000000000000000000000000000000000000"
        },
        "0xb064600732a82908427d092d333e607598a6238a59aeb45e1288cb0bac7161cf": {
          "previousValue": "0x0000000000000000000000000000000000000000000062a412bd07a0b283e23a",
          "newValue": "0x0000000000000000000000000000000000000000000062b120ea9c1d4e117d8a"
        }
      }
    },
    "0xdabad81af85554e9ae636395611c58f7ec1aaec5": {
      "label": "GovernanceV3Ethereum.PAYLOADS_CONTROLLER",
      "contract": "lib/aave-umbrella/lib/aave-v3-origin/lib/solidity-utils/lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/proxy/transparent/TransparentUpgradeableProxy.sol:TransparentUpgradeableProxy",
      "balanceDiff": null,
      "nonceDiff": null,
      "stateDiff": {
        "0x467141648302ea5d466230ed533451b9ebe1216f283ee97a43768a07b33c9c73": {
          "previousValue": "0x00697ee7fa000000000002000000000000000000000000000000000000000000",
          "newValue": "0x00697ee7fa000000000003000000000000000000000000000000000000000000"
        },
        "0x467141648302ea5d466230ed533451b9ebe1216f283ee97a43768a07b33c9c74": {
          "previousValue": "0x000000000000000000093a8000000000000069ad0c7b00000000000000000000",
          "newValue": "0x000000000000000000093a8000000000000069ad0c7b000000000000697ee7fb"
        }
      }
    }
  }
}
```