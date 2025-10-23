## Reserve changes

### Reserves altered

#### USDT0 (0xB8CE59FC3717ada4C02eaDF9682A9e934F625ebb)

| description | value before | value after |
| --- | --- | --- |
| reserveFactor | 10 % [1000] | 50 % [5000] |


## Raw diff

```json
{
  "reserves": {
    "0xB8CE59FC3717ada4C02eaDF9682A9e934F625ebb": {
      "reserveFactor": {
        "from": 1000,
        "to": 5000
      }
    }
  },
  "raw": {
    "0x5d72a9d9a9510cd8cbdba12ac62593a58930a948": {
      "label": "AaveV3Plasma.ASSETS.USDT0.A_TOKEN",
      "contract": "lib/aave-helpers/lib/aave-address-book/lib/aave-v3-origin/lib/solidity-utils/lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/proxy/transparent/TransparentUpgradeableProxy.sol:TransparentUpgradeableProxy",
      "balanceDiff": null,
      "nonceDiff": null,
      "stateDiff": {
        "0x60b8366e5e3b7c63adec9441e2e45d8d2536748f508be35f9899b59a3fe36a96": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x000000000000000000000000000000000000000000027b46536c66c8e3000000"
        }
      }
    },
    "0x7519403e12111ff6b710877fcd821d0c12caf43a": {
      "label": "AaveV3Plasma.ASSETS.USDe.A_TOKEN",
      "contract": "lib/aave-helpers/lib/aave-address-book/lib/aave-v3-origin/lib/solidity-utils/lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/proxy/transparent/TransparentUpgradeableProxy.sol:TransparentUpgradeableProxy",
      "balanceDiff": null,
      "nonceDiff": null,
      "stateDiff": {
        "0x60b8366e5e3b7c63adec9441e2e45d8d2536748f508be35f9899b59a3fe36a96": {
          "previousValue": "0x0000000000000000000000000000000000000000000000000000000000000000",
          "newValue": "0x00000000000000000000000000000000000000000001a784379d99db42000000"
        }
      }
    },
    "0x925a2a7214ed92428b5b1b090f80b25700095e12": {
      "label": "AaveV3Plasma.POOL",
      "contract": "lib/aave-helpers/lib/aave-address-book/lib/aave-v3-origin/lib/solidity-utils/lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/proxy/transparent/TransparentUpgradeableProxy.sol:TransparentUpgradeableProxy",
      "balanceDiff": null,
      "nonceDiff": null,
      "stateDiff": {
        "0xace1738bd21dfb38ab702aadd1277b4df729315c49e6743bfbebb5a89576504a": {
          "previousValue": "0x100000000000000000000003e8165a0bc0012a05f20003e8a50628d21e781d4c",
          "newValue": "0x100000000000000000000003e8165a0bc0012a05f2001388a50628d21e781d4c"
        },
        "0xace1738bd21dfb38ab702aadd1277b4df729315c49e6743bfbebb5a89576504b": {
          "previousValue": "0x0000000000210b9564074b828495fa2600000000033cfb9542c561c9fbd126ec",
          "newValue": "0x0000000000125bc4ceac81073eed171e00000000033cfb9826bed96dfe251682"
        },
        "0xace1738bd21dfb38ab702aadd1277b4df729315c49e6743bfbebb5a89576504c": {
          "previousValue": "0x0000000000301ef157f90ca02e5a549800000000033e722547604f38f6b848bd",
          "newValue": "0x0000000000301ef1606d12ead42950b000000000033e72297ed663a1fdce318e"
        },
        "0xace1738bd21dfb38ab702aadd1277b4df729315c49e6743bfbebb5a89576504d": {
          "previousValue": "0x00000000000000000000000068f92c3000000000000000000000000000000000",
          "newValue": "0x00000000000000000000000068f92c5a00000000000000000000000000000000"
        },
        "0xace1738bd21dfb38ab702aadd1277b4df729315c49e6743bfbebb5a895765052": {
          "previousValue": "0x00000000000000000001cfcd34a8a12c000000000000000000000003600cad42",
          "newValue": "0x00000000000000000001cfcd34a8a12c00000000000000000000000360ce5c7d"
        }
      }
    },
    "0xe76eb348e65ef163d85ce282125ff5a7f5712a1d": {
      "label": "GovernanceV3Plasma.PAYLOADS_CONTROLLER",
      "contract": "lib/aave-helpers/lib/aave-address-book/lib/aave-v3-origin/lib/solidity-utils/lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/proxy/transparent/TransparentUpgradeableProxy.sol:TransparentUpgradeableProxy",
      "balanceDiff": null,
      "nonceDiff": null,
      "stateDiff": {
        "0xf2c49132ed1cee2a7e75bde50d332a2f81f1d01e5456d8a19d1df09bd561dbd2": {
          "previousValue": "0x0068f92c59000000000002000000000000000000000000000000000000000000",
          "newValue": "0x0068f92c59000000000003000000000000000000000000000000000000000000"
        },
        "0xf2c49132ed1cee2a7e75bde50d332a2f81f1d01e5456d8a19d1df09bd561dbd3": {
          "previousValue": "0x000000000000000000093a80000000000000692750da00000000000000000000",
          "newValue": "0x000000000000000000093a80000000000000692750da00000000000068f92c5a"
        }
      }
    }
  }
}
```