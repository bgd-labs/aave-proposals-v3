## Reserve changes

### Reserve altered

#### wstETH ([0x1F32b1c2345538c0c6f582fCB022739c4A194Ebb](https://optimistic.etherscan.io/address/0x1F32b1c2345538c0c6f582fCB022739c4A194Ebb))

| description | value before | value after |
| --- | --- | --- |
| ltv | 71 % [7100] | 75 % [7500] |
| liquidationThreshold | 80 % [8000] | 79 % [7900] |


#### LINK ([0x350a791Bfc2C21F9Ed5d10980Dad2e2638ffa7f6](https://optimistic.etherscan.io/address/0x350a791Bfc2C21F9Ed5d10980Dad2e2638ffa7f6))

| description | value before | value after |
| --- | --- | --- |
| ltv | 70 % [7000] | 66 % [6600] |
| liquidationThreshold | 75 % [7500] | 71 % [7100] |


#### WETH ([0x4200000000000000000000000000000000000006](https://optimistic.etherscan.io/address/0x4200000000000000000000000000000000000006))

| description | value before | value after |
| --- | --- | --- |
| liquidationThreshold | 82.5 % [8250] | 83 % [8300] |


#### AAVE ([0x76FB31fb4af56892A25e32cFC43De717950c9278](https://optimistic.etherscan.io/address/0x76FB31fb4af56892A25e32cFC43De717950c9278))

| description | value before | value after |
| --- | --- | --- |
| ltv | 50 % [5000] | 63 % [6300] |
| liquidationThreshold | 65 % [6500] | 70 % [7000] |


#### USDC ([0x7F5c764cBc14f9669B88837ca1490cCa17c31607](https://optimistic.etherscan.io/address/0x7F5c764cBc14f9669B88837ca1490cCa17c31607))

| description | value before | value after |
| --- | --- | --- |
| liquidationThreshold | 80 % [8000] | 78.5 % [7850] |


#### rETH ([0x9Bcef72be871e61ED4fBbc7630889beE758eb81D](https://optimistic.etherscan.io/address/0x9Bcef72be871e61ED4fBbc7630889beE758eb81D))

| description | value before | value after |
| --- | --- | --- |
| ltv | 67 % [6700] | 69 % [6900] |


## Raw diff

```json
{
  "reserves": {
    "0x1F32b1c2345538c0c6f582fCB022739c4A194Ebb": {
      "liquidationThreshold": {
        "from": 8000,
        "to": 7900
      },
      "ltv": {
        "from": 7100,
        "to": 7500
      }
    },
    "0x350a791Bfc2C21F9Ed5d10980Dad2e2638ffa7f6": {
      "liquidationThreshold": {
        "from": 7500,
        "to": 7100
      },
      "ltv": {
        "from": 7000,
        "to": 6600
      }
    },
    "0x4200000000000000000000000000000000000006": {
      "liquidationThreshold": {
        "from": 8250,
        "to": 8300
      }
    },
    "0x76FB31fb4af56892A25e32cFC43De717950c9278": {
      "liquidationThreshold": {
        "from": 6500,
        "to": 7000
      },
      "ltv": {
        "from": 5000,
        "to": 6300
      }
    },
    "0x7F5c764cBc14f9669B88837ca1490cCa17c31607": {
      "liquidationThreshold": {
        "from": 8000,
        "to": 7850
      }
    },
    "0x9Bcef72be871e61ED4fBbc7630889beE758eb81D": {
      "ltv": {
        "from": 6700,
        "to": 6900
      }
    }
  }
}
```