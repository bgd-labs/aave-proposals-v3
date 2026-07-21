## Reserve changes

### Reserve altered

#### RLUSD ([0x8292Bb45bf1Ee4d140127049757C2E0fF06317eD](https://etherscan.io/address/0x8292Bb45bf1Ee4d140127049757C2E0fF06317eD))

| description | value before | value after |
| --- | --- | --- |
| oracle | [0x26C46B7aD0012cA71F2298ada567dC9Af14E7f2A](https://etherscan.io/address/0x26C46B7aD0012cA71F2298ada567dC9Af14E7f2A) | [0x9E7c31e9b3C76Ea759D9f7464210353862F0c957](https://etherscan.io/address/0x9E7c31e9b3C76Ea759D9f7464210353862F0c957) |
| oracleDescription | RLUSD / USD | Capped RLUSD / USD |


#### USDC ([0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48](https://etherscan.io/address/0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48))

| description | value before | value after |
| --- | --- | --- |
| oracle | [0x8fFfFfd4AfB6115b954Bd326cbe7B4BA576818f6](https://etherscan.io/address/0x8fFfFfd4AfB6115b954Bd326cbe7B4BA576818f6) | [0x46f94aff8cF7DdC8557eF69f7276087b01C8f363](https://etherscan.io/address/0x46f94aff8cF7DdC8557eF69f7276087b01C8f363) |
| oracleDescription | USDC / USD | Capped USDC / USD |


## Raw diff

```json
{
  "reserves": {
    "0x8292Bb45bf1Ee4d140127049757C2E0fF06317eD": {
      "oracle": {
        "from": "0x26C46B7aD0012cA71F2298ada567dC9Af14E7f2A",
        "to": "0x9E7c31e9b3C76Ea759D9f7464210353862F0c957"
      },
      "oracleDescription": {
        "from": "RLUSD / USD",
        "to": "Capped RLUSD / USD"
      }
    },
    "0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48": {
      "oracle": {
        "from": "0x8fFfFfd4AfB6115b954Bd326cbe7B4BA576818f6",
        "to": "0x46f94aff8cF7DdC8557eF69f7276087b01C8f363"
      },
      "oracleDescription": {
        "from": "USDC / USD",
        "to": "Capped USDC / USD"
      }
    }
  },
  "raw": {
    "0x985bcfab7e0f4ef2606cc5b64fc1a16311880442": {
      "label": null,
      "contract": null,
      "balanceDiff": null,
      "nonceDiff": null,
      "stateDiff": {
        "0x4e4f22273bf5bc307ce4d44de9b696fde788cba6119ef3bd24dc8a4ace26ced8": {
          "previousValue": "0x00000000000000000000000026c46b7ad0012ca71f2298ada567dc9af14e7f2a",
          "newValue": "0x0000000000000000000000009e7c31e9b3c76ea759d9f7464210353862f0c957"
        },
        "0xc6521c8ea4247e8beb499344e591b9401fb2807ff9997dd598fd9e56c73a264d": {
          "previousValue": "0x0000000000000000000000008fffffd4afb6115b954bd326cbe7b4ba576818f6",
          "newValue": "0x00000000000000000000000046f94aff8cf7ddc8557ef69f7276087b01c8f363"
        }
      }
    }
  }
}
```