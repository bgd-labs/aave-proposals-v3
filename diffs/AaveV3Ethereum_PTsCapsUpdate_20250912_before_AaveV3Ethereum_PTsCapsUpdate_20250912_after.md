## Reserve changes

### Reserve altered

#### PT-USDe-27NOV2025 ([0x62C6E813b9589C3631Ba0Cdb013acdB8544038B7](https://etherscan.io/address/0x62C6E813b9589C3631Ba0Cdb013acdB8544038B7))

| description | value before | value after |
| --- | --- | --- |
| supplyCap | 100,000,000 PT-USDe-27NOV2025 | 1,000,000,000 PT-USDe-27NOV2025 |


#### PT-sUSDE-27NOV2025 ([0xe6A934089BBEe34F832060CE98848359883749B3](https://etherscan.io/address/0xe6A934089BBEe34F832060CE98848359883749B3))

| description | value before | value after |
| --- | --- | --- |
| supplyCap | 150,000,000 PT-sUSDE-27NOV2025 | 1,200,000,000 PT-sUSDE-27NOV2025 |


## Raw diff

```json
{
  "reserves": {
    "0x62C6E813b9589C3631Ba0Cdb013acdB8544038B7": {
      "supplyCap": {
        "from": 100000000,
        "to": 1000000000
      }
    },
    "0xe6A934089BBEe34F832060CE98848359883749B3": {
      "supplyCap": {
        "from": 150000000,
        "to": 1200000000
      }
    }
  },
  "raw": {
    "0x87870bca3f3fd6335c3f4ce8392d69350b4fa4e2": {
      "label": "AaveV3Ethereum.POOL",
      "balanceDiff": null,
      "stateDiff": {
        "0x88dc10a9a74995324bdefa597a4e0480304a7cedf24dfadd1a7328607633455c": {
          "previousValue": "0x100000000000000000000003e8008f0d1800000000011194811229fe000a0005",
          "newValue": "0x100000000000000000000003e8047868c000000000011194811229fe000a0005"
        },
        "0xa3ab4f2b2c7db8ca3235a5dfc80645a993685706256b7554a21e6796cf03b75b": {
          "previousValue": "0x100000000000000000000003e8005f5e1000000000011194811229fe000a0005",
          "newValue": "0x100000000000000000000003e803b9aca000000000011194811229fe000a0005"
        }
      }
    },
    "0xdabad81af85554e9ae636395611c58f7ec1aaec5": {
      "label": "GovernanceV3Ethereum.PAYLOADS_CONTROLLER",
      "balanceDiff": null,
      "stateDiff": {
        "0x0d48f401b7ac790e53298797743a35a6065f831a447ad8d65b2c6f1a664a677f": {
          "previousValue": "0x0068c4567a000000000002000000000000000000000000000000000000000000",
          "newValue": "0x0068c4567a000000000003000000000000000000000000000000000000000000"
        },
        "0x0d48f401b7ac790e53298797743a35a6065f831a447ad8d65b2c6f1a664a6780": {
          "previousValue": "0x000000000000000000093a8000000000000068f27afb00000000000000000000",
          "newValue": "0x000000000000000000093a8000000000000068f27afb00000000000068c4567b"
        }
      }
    }
  }
}
```