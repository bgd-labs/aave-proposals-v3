## Reserve changes

### Reserve altered

#### PYUSD ([0x6c3ea9036406852006290770BEdFcAbA0e23A0e8](https://etherscan.io/address/0x6c3ea9036406852006290770BEdFcAbA0e23A0e8))

| description | value before | value after |
| --- | --- | --- |
| oracle | [0x150bAe7Ce224555D39AfdBc6Cb4B8204E594E022](https://etherscan.io/address/0x150bAe7Ce224555D39AfdBc6Cb4B8204E594E022) | [0x36964C0579D02E0a5AaAb89E24Cf8d7CDF3549EE](https://etherscan.io/address/0x36964C0579D02E0a5AaAb89E24Cf8d7CDF3549EE) |


#### FRAX ([0x853d955aCEf822Db058eb8505911ED77F175b99e](https://etherscan.io/address/0x853d955aCEf822Db058eb8505911ED77F175b99e))

| description | value before | value after |
| --- | --- | --- |
| oracle | [0x45D270263BBee500CF8adcf2AbC0aC227097b036](https://etherscan.io/address/0x45D270263BBee500CF8adcf2AbC0aC227097b036) | [0xeF50f8DC65402c3019586bc8725fCD0b99B8AAd7](https://etherscan.io/address/0xeF50f8DC65402c3019586bc8725fCD0b99B8AAd7) |


#### USDC ([0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48](https://etherscan.io/address/0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48))

| description | value before | value after |
| --- | --- | --- |
| oracle | [0x736bF902680e68989886e9807CD7Db4B3E015d3C](https://etherscan.io/address/0x736bF902680e68989886e9807CD7Db4B3E015d3C) | [0xB6557F02F0a5dA7b9D3C2d979cc19e00e756F6dA](https://etherscan.io/address/0xB6557F02F0a5dA7b9D3C2d979cc19e00e756F6dA) |


## Raw diff

```json
{
  "reserves": {
    "0x6c3ea9036406852006290770BEdFcAbA0e23A0e8": {
      "oracle": {
        "from": "0x150bAe7Ce224555D39AfdBc6Cb4B8204E594E022",
        "to": "0x36964C0579D02E0a5AaAb89E24Cf8d7CDF3549EE"
      }
    },
    "0x853d955aCEf822Db058eb8505911ED77F175b99e": {
      "oracle": {
        "from": "0x45D270263BBee500CF8adcf2AbC0aC227097b036",
        "to": "0xeF50f8DC65402c3019586bc8725fCD0b99B8AAd7"
      }
    },
    "0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48": {
      "oracle": {
        "from": "0x736bF902680e68989886e9807CD7Db4B3E015d3C",
        "to": "0xB6557F02F0a5dA7b9D3C2d979cc19e00e756F6dA"
      }
    }
  },
  "raw": {
    "0x43b64f28a678944e0655404b0b98e443851cc34f": {
      "label": "AaveV3EthereumEtherFi.ORACLE",
      "balanceDiff": null,
      "stateDiff": {
        "0x27e997bcf7e34b5892c35718d72ca8a4d44f6f77265e19fe4feb6a8ebb16cc7b": {
          "previousValue": "0x00000000000000000000000045d270263bbee500cf8adcf2abc0ac227097b036",
          "newValue": "0x000000000000000000000000ef50f8dc65402c3019586bc8725fcd0b99b8aad7"
        },
        "0xc6521c8ea4247e8beb499344e591b9401fb2807ff9997dd598fd9e56c73a264d": {
          "previousValue": "0x000000000000000000000000736bf902680e68989886e9807cd7db4b3e015d3c",
          "newValue": "0x000000000000000000000000b6557f02f0a5da7b9d3c2d979cc19e00e756f6da"
        },
        "0xd8edcb14f69dd8320a01424733daf8111cb78166f2520bbdb81ff6ae0cf3f5ef": {
          "previousValue": "0x000000000000000000000000150bae7ce224555d39afdbc6cb4b8204e594e022",
          "newValue": "0x00000000000000000000000036964c0579d02e0a5aaab89e24cf8d7cdf3549ee"
        }
      }
    },
    "0xdabad81af85554e9ae636395611c58f7ec1aaec5": {
      "label": "GovernanceV3Ethereum.PAYLOADS_CONTROLLER",
      "balanceDiff": null,
      "stateDiff": {
        "0x31f3c3c26b9f7b2a5e2a988f330d4f0e06c36e0dafa800031083080450670401": {
          "previousValue": "0x006824694a000000000002000000000000000000000000000000000000000000",
          "newValue": "0x006824694a000000000003000000000000000000000000000000000000000000"
        },
        "0x31f3c3c26b9f7b2a5e2a988f330d4f0e06c36e0dafa800031083080450670402": {
          "previousValue": "0x000000000000000000093a8000000000000068528dcb00000000000000000000",
          "newValue": "0x000000000000000000093a8000000000000068528dcb0000000000006824694b"
        }
      }
    }
  }
}
```