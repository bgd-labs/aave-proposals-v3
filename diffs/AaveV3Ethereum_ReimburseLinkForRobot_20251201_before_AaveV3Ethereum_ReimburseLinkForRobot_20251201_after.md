## Reserve changes

### Reserves altered

#### LINK ([0x514910771AF9Ca656af840dff83E8264EcF986CA](https://etherscan.io/address/0x514910771AF9Ca656af840dff83E8264EcF986CA))

| description | value before | value after |
| --- | --- | --- |
| aTokenUnderlyingBalance | 13,215,405.4600 LINK [13215405460038135315590910] | 13,215,285.4600 LINK [13215285460038135315590910] |
| virtualBalance | 13,215,404.4588 LINK [13215404458845723782627922] | 13,215,284.4588 LINK [13215284458845723782627922] |


## Raw diff

```json
{
  "reserves": {
    "0x514910771AF9Ca656af840dff83E8264EcF986CA": {
      "aTokenUnderlyingBalance": {
        "from": "13215405460038135315590910",
        "to": "13215285460038135315590910"
      },
      "virtualBalance": {
        "from": "13215404458845723782627922",
        "to": "13215284458845723782627922"
      }
    }
  },
  "raw": {
    "0x514910771af9ca656af840dff83e8264ecf986ca": {
      "label": "AaveV2Ethereum.ASSETS.LINK.UNDERLYING, AaveV3Ethereum.ASSETS.LINK.UNDERLYING",
      "contract": null,
      "balanceDiff": null,
      "nonceDiff": null,
      "stateDiff": {
        "0x60bef50ce3efaeb19891bb06dcb8bea2ccb99c07904720f28a513b12869cb727": {
          "previousValue": "0x0000000000000000000000000000000000000000000000537bf8deb827c0b8ad",
          "newValue": "0x000000000000000000000000000000000000000000000059fd4e82ee9ea0b8ad"
        },
        "0xdae4082b17861c7d82e21b4a4c7bb9fa7ad9df1c0133f315d870700d9f955f7e": {
          "previousValue": "0x0000000000000000000000000000000000000000000aee7890c4c5b61d326efe",
          "newValue": "0x0000000000000000000000000000000000000000000aee720f6f217fa6526efe"
        }
      }
    },
    "0x5e8c8a7243651db1384c0ddfdbe39761e8e7e51a": {
      "label": "AaveV3Ethereum.ASSETS.LINK.A_TOKEN",
      "contract": "lib/aave-helpers/lib/aave-address-book/lib/aave-v3-origin/lib/solidity-utils/lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/proxy/transparent/TransparentUpgradeableProxy.sol:TransparentUpgradeableProxy",
      "balanceDiff": null,
      "nonceDiff": null,
      "stateDiff": {
        "0x0000000000000000000000000000000000000000000000000000000000000036": {
          "previousValue": "0x0000000000000000000000000000000000000000000b79f1ee0a061261e1b385",
          "newValue": "0x0000000000000000000000000000000000000000000b79eb6e17a24bfda8e839"
        },
        "0x14a553e31736f19e3e380cf55bfb2f82dfd6d880cd07235affb68d8d3e0cac4d": {
          "previousValue": "0x00000000033bdec1fa3225bbdfcf7a10000000000000098c4022e35bc1b4f628",
          "newValue": "0x00000000033bded6e368920fd5fe7e390000000000000985c0307f955d7c2adc"
        },
        "0x7a79d58a6c2c4214189d78e4be4ba21513d55fd0a4b2ac0c119b9394eb289d20": {
          "previousValue": "0x00000000033bd97abc22834a5d93f32c00000000000000000000000000000000",
          "newValue": "0x00000000033bded6e368920fd5fe7e3900000000000000000000000000000000"
        }
      }
    },
    "0x87870bca3f3fd6335c3f4ce8392d69350b4fa4e2": {
      "label": "AaveV3Ethereum.POOL",
      "contract": "lib/aave-helpers/lib/aave-address-book/lib/aave-v3-origin/lib/solidity-utils/lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/proxy/transparent/TransparentUpgradeableProxy.sol:TransparentUpgradeableProxy",
      "balanceDiff": null,
      "nonceDiff": null,
      "stateDiff": {
        "0x171656ac53fe6b4f4afb5485494f9f0ac15c89bb5b5e4dc8918a7e575ea6701e": {
          "previousValue": "0x0000000000003d6557d042dac9c53bca00000000033bded6a4951b34bd762902",
          "newValue": "0x0000000000003d659e41a02a943d28e500000000033bded6e368920fd5fe7e39"
        },
        "0x171656ac53fe6b4f4afb5485494f9f0ac15c89bb5b5e4dc8918a7e575ea6701f": {
          "previousValue": "0x00000000000635f70916b60348f08aef0000000003442db7ba77f10953c82ce6",
          "newValue": "0x00000000000635fa99362a0e6a7781470000000003442dbe25cc5875b7c20ded"
        },
        "0x171656ac53fe6b4f4afb5485494f9f0ac15c89bb5b5e4dc8918a7e575ea67020": {
          "previousValue": "0x000000000000000000000500693adacb00000000000000002cf6b739ecb2a3e6",
          "newValue": "0x000000000000000000000500693adcb700000000000000002cf6b739ecb2a3e6"
        },
        "0x171656ac53fe6b4f4afb5485494f9f0ac15c89bb5b5e4dc8918a7e575ea67025": {
          "previousValue": "0x00000000000aee7882dfd28483f5425200000000000000011234f2cae94130c2",
          "newValue": "0x00000000000aee72018a2e4e0d1542520000000000000001126cb00e192cfc0f"
        },
        "0xf9829112cce780d4a61051cb8a0049abd16e5ef129bad968336a15bba07c032d": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000020082",
          "newValue": "0x0000000000000000000000000000000000000000000000000000000000020082"
        }
      }
    },
    "0xdabad81af85554e9ae636395611c58f7ec1aaec5": {
      "label": "GovernanceV3Ethereum.PAYLOADS_CONTROLLER",
      "contract": "lib/aave-helpers/lib/aave-address-book/lib/aave-v3-origin/lib/solidity-utils/lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/proxy/transparent/TransparentUpgradeableProxy.sol:TransparentUpgradeableProxy",
      "balanceDiff": null,
      "nonceDiff": null,
      "stateDiff": {
        "0xf29a47cc56db769417bfe11e85c712aa9920cdd341de96305d778b58202ad754": {
          "previousValue": "0x00693adcb6000000000002000000000000000000000000000000000000000000",
          "newValue": "0x00693adcb6000000000003000000000000000000000000000000000000000000"
        },
        "0xf29a47cc56db769417bfe11e85c712aa9920cdd341de96305d778b58202ad755": {
          "previousValue": "0x000000000000000000093a800000000000006969013700000000000000000000",
          "newValue": "0x000000000000000000093a8000000000000069690137000000000000693adcb7"
        }
      }
    }
  }
}
```