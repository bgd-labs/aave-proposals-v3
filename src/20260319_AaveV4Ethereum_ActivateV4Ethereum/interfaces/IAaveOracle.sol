// SPDX-License-Identifier: LicenseRef-BUSL
pragma solidity ^0.8.0;

import {IPriceOracle} from './IPriceOracle.sol';

interface IAaveOracle is IPriceOracle {
  event UpdateReserveSource(uint256 indexed reserveId, address indexed source);
  event SetSpoke(address indexed spoke);

  error OnlyDeployer();
  error SpokeAlreadySet();
  error InvalidSourceDecimals(uint256 reserveId);
  error InvalidSource(uint256 reserveId);
  error InvalidPrice(uint256 reserveId);
  error InvalidAddress();
  error OracleMismatch();

  function setSpoke(address spoke) external;
  function setReserveSource(uint256 reserveId, address source) external;
  function getReservesPrices(
    uint256[] calldata reserveIds
  ) external view returns (uint256[] memory);
  function getReserveSource(uint256 reserveId) external view returns (address);
}
