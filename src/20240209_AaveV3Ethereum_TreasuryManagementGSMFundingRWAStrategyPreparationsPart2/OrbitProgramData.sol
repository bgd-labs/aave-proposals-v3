// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

library OrbitProgramData {
  struct GasUsage {
    address account;
    uint256 usage;
  }

  uint256 public constant STREAM_DURATION = 90 days;
  uint256 public constant RETRO_PAYMENT = 5_000 ether;
  uint256 public constant STREAM_AMOUNT = 15_000 ether;
  uint256 public constant TOTAL_WETH_REBATE = 4.9273 ether;
  address public constant EZREAL = 0x8659D0BB123Da6D16D9394C7838BA286c2207d0E;
  address public constant STABLE_LABS = 0xECC2a9240268BC7a26386ecB49E1Befca2706AC9;
  address public constant LBS = 0x8b37a5Af68D315cf5A64097D96621F64b5502a22;
  address public constant MICHIGAN = 0x0579A616689f7ed748dC07692A3F150D44b0CA09;
  address public constant ACI = 0x57ab7ee15cE5ECacB1aB84EE42D5A9d0d8112922;
  address public constant TOKEN_LOGIC = 0x2cc1ADE245020FC5AAE66Ad443e1F66e01c54Df1;
  address public constant WINTERMUTE = 0xB933AEe47C438f22DE0747D57fc239FE37878Dd1;

  function getGasUsageData() internal pure returns (GasUsage[] memory) {
    GasUsage[] memory usage = new GasUsage[](7);
    usage[0] = GasUsage(ACI, 3.365 ether);
    usage[1] = GasUsage(TOKEN_LOGIC, 0.586 ether);
    usage[2] = GasUsage(MICHIGAN, 0.276 ether);
    usage[3] = GasUsage(WINTERMUTE, 0.2518 ether);
    usage[4] = GasUsage(LBS, 0.031 ether);
    usage[5] = GasUsage(STABLE_LABS, 0.0342 ether);
    usage[6] = GasUsage(EZREAL, 0.3833 ether);

    return usage;
  }

  function getOrbitAddresses() internal pure returns (address[] memory) {
    address[] memory streamAddresses = new address[](4);
    streamAddresses[0] = EZREAL;
    streamAddresses[1] = STABLE_LABS;
    streamAddresses[2] = MICHIGAN;
    streamAddresses[3] = LBS;

    return streamAddresses;
  }
}
