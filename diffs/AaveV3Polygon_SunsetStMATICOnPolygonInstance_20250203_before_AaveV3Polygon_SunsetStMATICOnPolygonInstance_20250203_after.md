## Reserve changes

### Reserves altered

#### stMATIC ([0x3A58a54C066FdC0f2D55FC9C89F0415C92eBf3C4](https://polygonscan.com/address/0x3A58a54C066FdC0f2D55FC9C89F0415C92eBf3C4))

| description | value before | value after |
| --- | --- | --- |
| isFrozen | false | true |
| ltv | 48 % [4800] | 0 % [0] |


## Raw diff

```json
{
  "reserves": {
    "0x3A58a54C066FdC0f2D55FC9C89F0415C92eBf3C4": {
      "isFrozen": {
        "from": false,
        "to": true
      },
      "ltv": {
        "from": 4800,
        "to": 0
      }
    }
  },
  "raw": {
    "from": null,
    "to": {
      "0x401b5d0294e23637c18fcc38b1bca814cda2637c": {
        "label": null,
        "balanceDiff": null,
        "stateDiff": {}
      },
      "0x4816b2c2895f97fb918f1ae7da403750a0ee372e": {
        "label": null,
        "balanceDiff": null,
        "stateDiff": {
          "0x1183617aec6a4a1c0d3e752953bafdf1139505a48507e0d2896bbaa52408ec50": {
            "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
            "newValue": "0x00000000000000000000000000000000000000000000000000000000000012c0"
          }
        }
      },
      "0x5dfb8c777c19d3cedcdc7398d2eef1fb0b9b05c9": {
        "label": null,
        "balanceDiff": null,
        "stateDiff": {
          "0x475379e27c527238398e15278e7dc727f37d51a0b9441c05bf145844c06f985c": {
            "previousValue": "0x100000000000000000000207d0003a2c94000000000007d081122af816a812c0",
            "newValue": "0x100000000000000000000207d0003a2c94000000000007d083122af816a80000"
          }
        }
      },
      "0x794a61358d6845594f94dc1db02a252b5b4814ad": {
        "label": null,
        "balanceDiff": null,
        "stateDiff": {}
      },
      "0x8145edddf43f50276641b55bd3ad95944510021e": {
        "label": null,
        "balanceDiff": null,
        "stateDiff": {}
      },
      "0xa72636cbcaa8f5ff95b2cc47f3cdee83f3294a0b": {
        "label": null,
        "balanceDiff": null,
        "stateDiff": {}
      },
      "0xa97684ead0e402dc232d5a977953df7ecbab3cdb": {
        "label": null,
        "balanceDiff": null,
        "stateDiff": {}
      },
      "0xb962dcd6d9f0bfb4cb2936c6c5e5c7c3f0d3c778": {
        "label": null,
        "balanceDiff": null,
        "stateDiff": {
          "0x6b9240d7ade1f051aed76811ad8dd613b8df4c244b38ce53081de0fea8fec673": {
            "previousValue": "0x0067a0f91f000000000002000000000000000000000000000000000000000000",
            "newValue": "0x0067a0f91f000000000003000000000000000000000000000000000000000000"
          },
          "0x6b9240d7ade1f051aed76811ad8dd613b8df4c244b38ce53081de0fea8fec674": {
            "previousValue": "0x000000000000000000093a8000000000000067cf1da000000000000000000000",
            "newValue": "0x000000000000000000093a8000000000000067cf1da000000000000067a0f920"
          }
        }
      },
      "0xdf7d0e6454db638881302729f5ba99936eaab233": {
        "label": null,
        "balanceDiff": null,
        "stateDiff": {}
      }
    }
  }
}
```