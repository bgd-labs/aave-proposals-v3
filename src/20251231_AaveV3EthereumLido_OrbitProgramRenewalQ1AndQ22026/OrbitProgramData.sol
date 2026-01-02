// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

library OrbitProgramData {
  // stream information
  // budgets (total budget: 150,000 GHO)
  uint256 public constant STREAM_AMOUNT = 30000 ether;
  // End date timestamp; Tuesday, June 30, 2026 11:59:59 PM
  uint256 public constant END_DATE = 1782863999;
  // stream receivers
  address public constant EZREAL = 0x8659D0BB123Da6D16D9394C7838BA286c2207d0E;
  address public constant STABLE_LABS = 0xECC2a9240268BC7a26386ecB49E1Befca2706AC9;
  address public constant IGNAS_DEFI = 0x3DDC7d25c7a1dc381443e491Bbf1Caa8928A05B0;
  address public constant ARETA = 0x8b37a5Af68D315cf5A64097D96621F64b5502a22;

  function getOrbitAddresses() internal pure returns (address[] memory) {
    address[] memory streamAddresses = new address[](4);
    streamAddresses[0] = EZREAL;
    streamAddresses[1] = STABLE_LABS;
    streamAddresses[2] = IGNAS_DEFI;
    streamAddresses[3] = ARETA;

    return streamAddresses;
  }
}
