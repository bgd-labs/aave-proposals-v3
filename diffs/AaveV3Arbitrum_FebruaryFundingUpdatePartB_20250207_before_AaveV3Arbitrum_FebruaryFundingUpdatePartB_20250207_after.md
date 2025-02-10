## Reserve changes

### Reserve altered

#### LUSD ([0x93b346b6BC2548dA6A1E7d98E9a421B42541425b](https://arbiscan.io/address/0x93b346b6BC2548dA6A1E7d98E9a421B42541425b))

| description | value before | value after |
| --- | --- | --- |
| aTokenUnderlyingBalance | 144,838.1190 LUSD [144838119063792111769309] | 142,802.8058 LUSD [142802805879956872236422] |
| virtualBalance | 144,837.9599 LUSD [144837959954567888073155] | 142,802.6467 LUSD [142802646770732648540268] |


#### USDC ([0xFF970A61A04b1cA14834A43f5dE4533eBDDB5CC8](https://arbiscan.io/address/0xFF970A61A04b1cA14834A43f5dE4533eBDDB5CC8))

| description | value before | value after |
| --- | --- | --- |
| aTokenUnderlyingBalance | 774,757.4945 USDC [774757494579] | 725,452.8159 USDC [725452815964] |
| virtualBalance | 774,644.9650 USDC [774644965021] | 725,340.2864 USDC [725340286406] |


## Raw diff

```json
{
  "reserves": {
    "0x93b346b6BC2548dA6A1E7d98E9a421B42541425b": {
      "aTokenUnderlyingBalance": {
        "from": "144838119063792111769309",
        "to": "142802805879956872236422"
      },
      "virtualBalance": {
        "from": "144837959954567888073155",
        "to": "142802646770732648540268"
      }
    },
    "0xFF970A61A04b1cA14834A43f5dE4533eBDDB5CC8": {
      "aTokenUnderlyingBalance": {
        "from": "774757494579",
        "to": "725452815964"
      },
      "virtualBalance": {
        "from": "774644965021",
        "to": "725340286406"
      }
    }
  },
  "raw": {
    "from": null,
    "to": {
      "0x0000000000000000000000000000000000000064": {
        "label": null,
        "balanceDiff": null,
        "stateDiff": {
          "0x0000000000000000000000000000000000000000000000000000000000000000": {
            "previousValue": "0x000000000000000000000000000000000000000000000000000000000001466d",
            "newValue": "0x000000000000000000000000000000000000000000000000000000000001466f"
          }
        }
      },
      "0x0335ffa9af5ce05590d6c9a75b645470e07744a9": {
        "label": null,
        "balanceDiff": null,
        "stateDiff": {}
      },
      "0x053d55f9b5af8694c503eb288a1b7e552f590710": {
        "label": null,
        "balanceDiff": null,
        "stateDiff": {}
      },
      "0x096760f208390250649e3e8763348e783aef5562": {
        "label": null,
        "balanceDiff": null,
        "stateDiff": {}
      },
      "0x09e9222e96e7b4ae2a407b98d48e330053351eee": {
        "label": null,
        "balanceDiff": null,
        "stateDiff": {}
      },
      "0x118dfd5418890c0332042ab05173db4a2c1d283c": {
        "label": null,
        "balanceDiff": null,
        "stateDiff": {
          "0x58c60c4a0bb2d3f34cbaba1a0b564f51356f6627445683dc231bf6b72193af3c": {
            "previousValue": "0x0067a605b2000000000002000000000000000000000000000000000000000000",
            "newValue": "0x0067a605b2000000000003000000000000000000000000000000000000000000"
          },
          "0x58c60c4a0bb2d3f34cbaba1a0b564f51356f6627445683dc231bf6b72193af3d": {
            "previousValue": "0x000000000000000000093a8000000000000067d42a3300000000000000000000",
            "newValue": "0x000000000000000000093a8000000000000067d42a3300000000000067a605b3"
          }
        }
      },
      "0x190274fea8f30e3f48ce43adcbd9a74110118284": {
        "label": null,
        "balanceDiff": null,
        "stateDiff": {
          "0x0000000000000000000000000000000000000000000000000000000000000002": {
            "previousValue": "0x000000000000000000000000000000000000000000000000000000000000482e",
            "newValue": "0x000000000000000000000000000000000000000000000000000000000000482f"
          }
        }
      },
      "0x1be1798b70aee431c2986f7ff48d9d1fa350786a": {
        "label": null,
        "balanceDiff": null,
        "stateDiff": {
          "0x0000000000000000000000000000000000000000000000000000000000000036": {
            "previousValue": "0x0000000000000000000000000000000000000000000060b5cd95194ed5448ffd",
            "newValue": "0x000000000000000000000000000000000000000000000000000003114175de59"
          },
          "0x246d7438c5a99950099e92f45a9221b48a1cfd540bed5c21d95ec94fe3175064": {
            "previousValue": "0x00000000039269c874babe9de9ed13790000000000000063da6f05b899c669c1",
            "newValue": "0x0000000003a48e4de01e12859d18fef7000000000000000000000000000d88dc"
          },
          "0x899e1caaa390f20ec2d52993cc326c8e9214843553c6f3f2f7dc7bc150307265": {
            "previousValue": "0x000000000384d122c26c14e48219d68a00000000000000000000000000000000",
            "newValue": "0x0000000003a48e4de01e12859d18fef700000000000000000000000000000000"
          }
        }
      },
      "0x1dcf7d03574fbc7c205f41f2e116ee094a652e93": {
        "label": null,
        "balanceDiff": null,
        "stateDiff": {
          "0x0000000000000000000000000000000000000000000000000000000000000002": {
            "previousValue": "0x00000000000000000000000000000000000000000000000000000000000075b0",
            "newValue": "0x00000000000000000000000000000000000000000000000000000000000075b1"
          }
        }
      },
      "0x1efb3f88bc88f03fd1804a5c53b7141bbef5ded8": {
        "label": null,
        "balanceDiff": null,
        "stateDiff": {
          "0x0000000000000000000000000000000000000000000000000000000000000035": {
            "previousValue": "0x00000000000000000000000000000000000000000000000000006fb71faed35e",
            "newValue": "0x00000000000000000000000000000000000000000000000000006faba4e52287"
          },
          "0x20cab5ee2df02c3b4ec852d89c5c008303c8be76aa80a96a7a4eb7dc49dac52d": {
            "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
            "newValue": "0x0000000000000000000000000000000000000000000000000000000000000000"
          },
          "0x56a93f423698c5aa8a500fda90a538300d0a15d6a153feb13a1c95db37c59990": {
            "previousValue": "0x000000000000000000000000000000000000000000000000000000b463252f33",
            "newValue": "0x000000000000000000000000000000000000000000000000000000a8e85b7e5c"
          },
          "0xaa96c5185a42c8041cdc5b63da641eb0b308ff83db6f7a92e955625985bfedd1": {
            "previousValue": "0x00000000000000000000000000000000000000000000000000000011db6d31ec",
            "newValue": "0x0000000000000000000000000000000000000000000000000000000b7ac9b0d7"
          }
        }
      },
      "0x2b22e425c1322fba0dbf17bb1da25d71811ee7ba": {
        "label": null,
        "balanceDiff": null,
        "stateDiff": {
          "0x55c53001d0df544c3a6d6fa7010e0b101b0ce7f5c4d0177061aa390617e35e85": {
            "previousValue": "0x000000000030605179b9f138718539160000000003926fc8157b725687f9eca3",
            "newValue": "0x000000000030c50a7778d517bd30830e00000000039274d12984caab4d3d932e"
          },
          "0x55c53001d0df544c3a6d6fa7010e0b101b0ce7f5c4d0177061aa390617e35e86": {
            "previousValue": "0x000000000054cbc439774170f6fd25d30000000003c2492a1a0edf00879ccdb9",
            "newValue": "0x00000000005523dcfbadf3aa092ab72b0000000003c25273eec41675c4eb2b4d"
          },
          "0x55c53001d0df544c3a6d6fa7010e0b101b0ce7f5c4d0177061aa390617e35e87": {
            "previousValue": "0x000000000000000000000b0067a5d86400000000000000000000000000000000",
            "newValue": "0x000000000000000000000b0067a605b300000000000000000000000000000000"
          },
          "0x55c53001d0df544c3a6d6fa7010e0b101b0ce7f5c4d0177061aa390617e35e8c": {
            "previousValue": "0x0000000000000000000000000000000000000000000000006a1e9c7a6834708c",
            "newValue": "0x0000000000000000000000000000000000000000000000008c33fe71175839bb"
          },
          "0x55c53001d0df544c3a6d6fa7010e0b101b0ce7f5c4d0177061aa390617e35e8d": {
            "previousValue": "0x0000000000001eabae798a476f6f71c300000000000000000000000000000000",
            "newValue": "0x0000000000001e3d58d48d21deaaa86c00000000000000000000000000000000"
          },
          "0x891ba8f07589a49027e33aaa5d57caf57d8253ad3ac94c2ab7dd8d1f415dd1a5": {
            "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
            "newValue": "0x0000000000000000000000000000000000000000000000000000000000000000"
          },
          "0xaa36895e16bf88054bc9ce1f3803f0ce3c9c129a784656f6747518dc4dcfa168": {
            "previousValue": "0x000000000024a970b52db906e82ac3360000000003a48cf2ddac6592818d5873",
            "newValue": "0x0000000000259e7473266fd18b2772b50000000003a48e4de01e12859d18fef7"
          },
          "0xaa36895e16bf88054bc9ce1f3803f0ce3c9c129a784656f6747518dc4dcfa169": {
            "previousValue": "0x00000000005bc81fd0c5a02fe11550940000000003ffb9f53001db5d0c6ca4d4",
            "newValue": "0x00000000005cf8d756f454a47ace09aa0000000003ffbdaedb3b4b2d119a5db0"
          },
          "0xaa36895e16bf88054bc9ce1f3803f0ce3c9c129a784656f6747518dc4dcfa16a": {
            "previousValue": "0x00000000000000000000020067a5f5eb00000000000000000000000000000000",
            "newValue": "0x00000000000000000000020067a605b300000000000000000000000000000000"
          },
          "0xaa36895e16bf88054bc9ce1f3803f0ce3c9c129a784656f6747518dc4dcfa16f": {
            "previousValue": "0x0000000000000000000000000000000000000000000000000000000006979b56",
            "newValue": "0x0000000000000000000000000000000000000000000000000000000007bf9ef5"
          },
          "0xaa36895e16bf88054bc9ce1f3803f0ce3c9c129a784656f6747518dc4dcfa170": {
            "previousValue": "0x0000000000000000000000b45c701e9d00000000000000000000000000000000",
            "newValue": "0x0000000000000000000000a8e1a66dc600000000000000000000000000000000"
          }
        }
      },
      "0x3f770ac673856f105b586bb393d122721265ad46": {
        "label": null,
        "balanceDiff": null,
        "stateDiff": {
          "0x0000000000000000000000000000000000000000000000000000000000000035": {
            "previousValue": "0x00000000000000000000000000000000000000000000378b60d92fe2a37d386a",
            "newValue": "0x00000000000000000000000000000000000000000000371d0b3432bd12b86f13"
          },
          "0x20cab5ee2df02c3b4ec852d89c5c008303c8be76aa80a96a7a4eb7dc49dac52d": {
            "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
            "newValue": "0x0000000000000000000000000000000000000000000000000000000000000000"
          },
          "0x3ac50c341f4c2f4dee6b6435f454c5eb34bd4750c2976acb10c509fa952b0690": {
            "previousValue": "0x00000000000000000000000000000000000000000000032dfc5d6db99b5885fe",
            "newValue": "0x00000000000000000000000000000000000000000000006e55a4fd2590c4c957"
          },
          "0x9fe9e472df24c0973d55f45ce8b645fa4fb021df9b3c6db994a661dfb284cb67": {
            "previousValue": "0x000000000000000000000000000000000000000000001eabb0aecf4685c6d6dd",
            "newValue": "0x000000000000000000000000000000000000000000001e3d5b09d220f5020d86"
          }
        }
      },
      "0x429f16dba3b9e1900087cbaa7b50d38bc60fb73f": {
        "label": null,
        "balanceDiff": null,
        "stateDiff": {}
      },
      "0x5e76e98e0963ecdc6a065d1435f84065b7523f39": {
        "label": null,
        "balanceDiff": null,
        "stateDiff": {}
      },
      "0x5f4d15d761528c57a5c30c43c1dab26fc5452731": {
        "label": null,
        "balanceDiff": null,
        "stateDiff": {}
      },
      "0x625e7708f30ca75bfd92586e17077590c60eb4cd": {
        "label": null,
        "balanceDiff": null,
        "stateDiff": {}
      },
      "0x794a61358d6845594f94dc1db02a252b5b4814ad": {
        "label": null,
        "balanceDiff": null,
        "stateDiff": {}
      },
      "0x7a7ef57479123f26db6a0e3efbf8a3562edd65be": {
        "label": null,
        "balanceDiff": null,
        "stateDiff": {}
      },
      "0x89644ca1bb8064760312ae4f03ea41b05da3637c": {
        "label": null,
        "balanceDiff": null,
        "stateDiff": {}
      },
      "0x8ffdf2de812095b1d19cb146e4c004587c0a0692": {
        "label": null,
        "balanceDiff": null,
        "stateDiff": {}
      },
      "0x929ec64c34a17401f460460d4b9390518e5b473e": {
        "label": null,
        "balanceDiff": null,
        "stateDiff": {}
      },
      "0x93b346b6bc2548da6a1e7d98e9a421b42541425b": {
        "label": null,
        "balanceDiff": null,
        "stateDiff": {}
      },
      "0x981ab570ac289938f296b975c524b66fbf1b8774": {
        "label": null,
        "balanceDiff": null,
        "stateDiff": {}
      },
      "0xa8669021776bc142dfca87c21b4a52595bcbb40a": {
        "label": null,
        "balanceDiff": null,
        "stateDiff": {}
      },
      "0xa97684ead0e402dc232d5a977953df7ecbab3cdb": {
        "label": null,
        "balanceDiff": null,
        "stateDiff": {}
      },
      "0xe72ba9418b5f2ce0a6a40501fe77c6839aa37333": {
        "label": null,
        "balanceDiff": null,
        "stateDiff": {}
      },
      "0xfccf3cabbe80101232d343252614b6a3ee81c989": {
        "label": null,
        "balanceDiff": null,
        "stateDiff": {}
      },
      "0xff1137243698caa18ee364cc966cf0e02a4e6327": {
        "label": null,
        "balanceDiff": null,
        "stateDiff": {}
      },
      "0xff970a61a04b1ca14834a43f5de4533ebddb5cc8": {
        "label": null,
        "balanceDiff": null,
        "stateDiff": {}
      }
    }
  }
}
```