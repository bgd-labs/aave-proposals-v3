// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

library OrbitProgramData {
  struct GasUsage {
    address account;
    uint256 usage;
  }

  // stream information
  uint256 public constant STREAM_DURATION = 90 days;
  uint256 public constant STREAM_AMOUNT = 15_000 ether;
  uint256 public constant OVERDUE_AMOUNT = 2_200 ether;
  // stream receivers
  address public constant EZREAL = 0x8659D0BB123Da6D16D9394C7838BA286c2207d0E;
  address public constant STABLE_LABS = 0xECC2a9240268BC7a26386ecB49E1Befca2706AC9;
  address public constant SAUCY_BLOCK = 0x08651EeE3b78254653062BA89035b8F8AdF924CE;
  address public constant ARETA = 0x8b37a5Af68D315cf5A64097D96621F64b5502a22;

  // fee rebate information
  uint256 public constant TOTAL_WETH_REBATE = 4.3 ether;
  // fee rebate receivers
  address public constant ACI = 0x57ab7ee15cE5ECacB1aB84EE42D5A9d0d8112922;
  address public constant TOKEN_LOGIC = 0x2cc1ADE245020FC5AAE66Ad443e1F66e01c54Df1;
  address public constant CATAPULTA = 0x020E4359255f907DF480EbFfc8a7b7beac0c0216;

  function getGasUsageData() internal pure returns (GasUsage[] memory) {
    GasUsage[] memory usage = new GasUsage[](3);
    usage[0] = GasUsage(ACI, 2.91 ether);
    usage[1] = GasUsage(TOKEN_LOGIC, 0.72 ether);
    usage[2] = GasUsage(CATAPULTA, 0.67 ether);

    return usage;
  }

  function getOrbitAddresses() internal pure returns (address[] memory) {
    address[] memory streamAddresses = new address[](4);
    streamAddresses[0] = EZREAL;
    streamAddresses[1] = STABLE_LABS;
    streamAddresses[2] = SAUCY_BLOCK;
    streamAddresses[3] = ARETA;

    return streamAddresses;
  }
}
