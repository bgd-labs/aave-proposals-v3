// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {MiscArbitrum} from 'aave-address-book/MiscArbitrum.sol';
import {TransparentUpgradeableProxy} from 'solidity-utils/contracts/transparent-proxy/TransparentUpgradeableProxy.sol';
import {ProxyAdmin} from 'solidity-utils/contracts/transparent-proxy/ProxyAdmin.sol';
import {UpgradeableBurnMintTokenPool} from 'aave-ccip/v0.8/ccip/pools/GHO/UpgradeableBurnMintTokenPool.sol';

/**
 * @title GHO CCIP Integration Maintenance (CCIP v1.5 upgrade)
 * @author Aave Labs
 * - Snapshot: TODO
 * - Discussion: TODO
 */
contract AaveV3Arbitrum_GHOCCIPIntegrationMaintenanceCCIPV15Upgrade_20241017 is
  IProposalGenericExecutor
{
  function execute() external override {
    // ProxyPool deployed by chainlink
    address proxyPool = address(1337); // todo: MiscArbitrum.GHO_CCIP_PROXY_POOL

    UpgradeableBurnMintTokenPool tokenPoolProxy = UpgradeableBurnMintTokenPool(
      MiscArbitrum.GHO_CCIP_TOKEN_POOL
    );

    // Deploy new tokenPool implementation, retain existing immutable configuration
    address tokenPool = address(
      new UpgradeableBurnMintTokenPool(
        address(tokenPoolProxy.getToken()),
        tokenPoolProxy.getArmProxy(),
        tokenPoolProxy.getAllowListEnabled()
      )
    );

    ProxyAdmin(MiscArbitrum.PROXY_ADMIN).upgrade(
      TransparentUpgradeableProxy(payable(address(tokenPoolProxy))),
      tokenPool
    );

    // Update proxyPool address
    tokenPoolProxy.setProxyPool(proxyPool);
  }
}
