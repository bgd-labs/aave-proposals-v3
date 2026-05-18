// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface ICLSynchronicityPriceAdapter {
  /**
   * @notice Returns the address of the peg-to-base Chainlink aggregator.
   */
  function PEG_TO_BASE() external view returns (address);
}
