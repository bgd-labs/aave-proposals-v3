## Reserve changes

### Reserve altered

#### cbETH ([0x2Ae3F1Ec7F1F5012CFEab0185bfc7aa3cf0DEc22](https://basescan.org/address/0x2Ae3F1Ec7F1F5012CFEab0185bfc7aa3cf0DEc22))

| description | value before | value after |
| --- | --- | --- |
| oracle | [0x80f2c02224a2E548FC67c0bF705eBFA825dd5439](https://basescan.org/address/0x80f2c02224a2E548FC67c0bF705eBFA825dd5439) | [0x8e11Ad4531826ff47BD8157a2c705F5422Da6A61](https://basescan.org/address/0x8e11Ad4531826ff47BD8157a2c705F5422Da6A61) |
| oracleDescription | cbETH/ETH/USD | Capped cbETH / ETH / USD |
| oracleLatestAnswer | 3773.85227086 | 3794.50527887 |


#### USDC ([0x833589fCD6eDb6E08f4c7C32D4f71b54bdA02913](https://basescan.org/address/0x833589fCD6eDb6E08f4c7C32D4f71b54bdA02913))

| description | value before | value after |
| --- | --- | --- |
| oracle | [0x7e860098F58bBFC8648a4311b374B1D669a2bc6B](https://basescan.org/address/0x7e860098F58bBFC8648a4311b374B1D669a2bc6B) | [0x978D8878b53Fbe40dab7D4AB47b97AB622FFeF9f](https://basescan.org/address/0x978D8878b53Fbe40dab7D4AB47b97AB622FFeF9f) |
| oracleDescription | USDC / USD | Capped USDC/USD |


#### wstETH ([0xc1CBa3fCea344f92D9239c08C0568f6F2F0ee452](https://basescan.org/address/0xc1CBa3fCea344f92D9239c08C0568f6F2F0ee452))

| description | value before | value after |
| --- | --- | --- |
| oracle | [0x945fD405773973d286De54E44649cc0d9e264F78](https://basescan.org/address/0x945fD405773973d286De54E44649cc0d9e264F78) | [0x56038D3998C42db18ba3B821bD1EbaB9B678e657](https://basescan.org/address/0x56038D3998C42db18ba3B821bD1EbaB9B678e657) |
| oracleDescription | wstETH/ETH/USD | Capped wstETH / stETH(ETH) / USD |


#### USDbC ([0xd9aAEc86B65D86f6A7B5B1b0c42FFA531710b6CA](https://basescan.org/address/0xd9aAEc86B65D86f6A7B5B1b0c42FFA531710b6CA))

| description | value before | value after |
| --- | --- | --- |
| oracle | [0x7e860098F58bBFC8648a4311b374B1D669a2bc6B](https://basescan.org/address/0x7e860098F58bBFC8648a4311b374B1D669a2bc6B) | [0x978D8878b53Fbe40dab7D4AB47b97AB622FFeF9f](https://basescan.org/address/0x978D8878b53Fbe40dab7D4AB47b97AB622FFeF9f) |
| oracleDescription | USDC / USD | Capped USDC/USD |


## Raw diff

```json
{
  "reserves": {
    "0x2Ae3F1Ec7F1F5012CFEab0185bfc7aa3cf0DEc22": {
      "oracle": {
        "from": "0x80f2c02224a2E548FC67c0bF705eBFA825dd5439",
        "to": "0x8e11Ad4531826ff47BD8157a2c705F5422Da6A61"
      },
      "oracleDescription": {
        "from": "cbETH/ETH/USD",
        "to": "Capped cbETH / ETH / USD"
      },
      "oracleLatestAnswer": {
        "from": 377385227086,
        "to": 379450527887
      }
    },
    "0x833589fCD6eDb6E08f4c7C32D4f71b54bdA02913": {
      "oracle": {
        "from": "0x7e860098F58bBFC8648a4311b374B1D669a2bc6B",
        "to": "0x978D8878b53Fbe40dab7D4AB47b97AB622FFeF9f"
      },
      "oracleDescription": {
        "from": "USDC / USD",
        "to": "Capped USDC/USD"
      }
    },
    "0xc1CBa3fCea344f92D9239c08C0568f6F2F0ee452": {
      "oracle": {
        "from": "0x945fD405773973d286De54E44649cc0d9e264F78",
        "to": "0x56038D3998C42db18ba3B821bD1EbaB9B678e657"
      },
      "oracleDescription": {
        "from": "wstETH/ETH/USD",
        "to": "Capped wstETH / stETH(ETH) / USD"
      }
    },
    "0xd9aAEc86B65D86f6A7B5B1b0c42FFA531710b6CA": {
      "oracle": {
        "from": "0x7e860098F58bBFC8648a4311b374B1D669a2bc6B",
        "to": "0x978D8878b53Fbe40dab7D4AB47b97AB622FFeF9f"
      },
      "oracleDescription": {
        "from": "USDC / USD",
        "to": "Capped USDC/USD"
      }
    }
  }
}
```