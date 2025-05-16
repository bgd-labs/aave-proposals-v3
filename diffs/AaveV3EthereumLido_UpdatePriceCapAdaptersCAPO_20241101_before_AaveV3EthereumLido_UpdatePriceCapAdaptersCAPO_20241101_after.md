## Reserve changes

### Reserves altered

#### USDS ([0xdC035D45d973E3EC169d2276DDab16f1e407384F](https://etherscan.io/address/0xdC035D45d973E3EC169d2276DDab16f1e407384F))

| description | value before | value after |
| --- | --- | --- |
| oracle | [0x4F01b76391A05d32B20FA2d05dD5963eE8db20E6](https://etherscan.io/address/0x4F01b76391A05d32B20FA2d05dD5963eE8db20E6) | [0x94C7FD62fd0506e71d8142E9D36687fC72A86B02](https://etherscan.io/address/0x94C7FD62fd0506e71d8142E9D36687fC72A86B02) |
| oracleDescription | Capped USDS <-> DAI / USD | Capped USDS/USD |
| oracleLatestAnswer | 0.9999924 | 0.99987067 |


## Raw diff

```json
{
  "reserves": {
    "0xdC035D45d973E3EC169d2276DDab16f1e407384F": {
      "oracle": {
        "from": "0x4F01b76391A05d32B20FA2d05dD5963eE8db20E6",
        "to": "0x94C7FD62fd0506e71d8142E9D36687fC72A86B02"
      },
      "oracleDescription": {
        "from": "Capped USDS <-> DAI / USD",
        "to": "Capped USDS/USD"
      },
      "oracleLatestAnswer": {
        "from": "99999240",
        "to": "99987067"
      }
    }
  },
  "raw": {
    "0xdabad81af85554e9ae636395611c58f7ec1aaec5": {
      "label": "GovernanceV3Ethereum.PAYLOADS_CONTROLLER",
      "balanceDiff": null,
      "stateDiff": {
        "0x4a2902bfb46543e72c4657286af52ec18a5d8fc4fdf76d87427f788b2d73d3d2": {
          "previousValue": "0x00682353d6000000000002000000000000000000000000000000000000000000",
          "newValue": "0x00682353d6000000000003000000000000000000000000000000000000000000"
        },
        "0x4a2902bfb46543e72c4657286af52ec18a5d8fc4fdf76d87427f788b2d73d3d3": {
          "previousValue": "0x000000000000000000093a800000000000006851785700000000000000000000",
          "newValue": "0x000000000000000000093a8000000000000068517857000000000000682353d7"
        }
      }
    },
    "0xe3c061981870c0c7b1f3c4f4bb36b95f1f260be6": {
      "label": "AaveV3EthereumLido.ORACLE",
      "balanceDiff": null,
      "stateDiff": {
        "0x8172978433a0fcf5efd57c53d724a94f303cc6b76aee037f692f7050f5d07c5d": {
          "previousValue": "0x0000000000000000000000004f01b76391a05d32b20fa2d05dd5963ee8db20e6",
          "newValue": "0x00000000000000000000000094c7fd62fd0506e71d8142e9d36687fc72a86b02"
        }
      }
    }
  }
}
```