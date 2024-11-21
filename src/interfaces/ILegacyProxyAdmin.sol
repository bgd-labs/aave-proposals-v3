// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

import {ITransparentUpgradeableProxy} from 'solidity-utils/contracts/transparent-proxy/TransparentUpgradeableProxy.sol';

interface ILegacyProxyAdmin {
  function changeProxyAdmin(ITransparentUpgradeableProxy proxy, address newAdmin) external;

  function upgrade(ITransparentUpgradeableProxy proxy, address implementation) external;

  function upgradeAndCall(
    ITransparentUpgradeableProxy proxy,
    address implementation,
    bytes memory data
  ) external;
}
