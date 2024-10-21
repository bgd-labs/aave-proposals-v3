// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {MiscArbitrum} from 'aave-address-book/MiscArbitrum.sol';
import {TransparentUpgradeableProxy} from 'solidity-utils/contracts/transparent-proxy/TransparentUpgradeableProxy.sol';
import {ProxyAdmin} from 'solidity-utils/contracts/transparent-proxy/ProxyAdmin.sol';
import {UpgradeableBurnMintTokenPool} from 'aave-ccip/v0.8/ccip/pools/GHO/UpgradeableBurnMintTokenPool.sol';

/**
 * @title GHO CCIP 1.50 Upgrade
 * @author Aave Labs
 * - Snapshot: TODO
 * - Discussion: https://governance.aave.com/t/bgd-technical-maintenance-proposals/15274/51
 */
contract AaveV3Arbitrum_GHOCCIP150Upgrade_20241021 is IProposalGenericExecutor {
  address public constant GHO_CCIP_PROXY_POOL = address(1337); // placeholder: pending chainlink deployment

  function execute() external {
    UpgradeableBurnMintTokenPool tokenPoolProxy = UpgradeableBurnMintTokenPool(
      MiscArbitrum.GHO_CCIP_TOKEN_POOL
    );

    // Deploy new tokenPool implementation, retain existing immutable configuration
    address tokenPoolImpl = address(
      new UpgradeableBurnMintTokenPool(
        address(tokenPoolProxy.getToken()),
        tokenPoolProxy.getArmProxy(),
        tokenPoolProxy.getAllowListEnabled()
      )
    );

    ProxyAdmin(MiscArbitrum.PROXY_ADMIN).upgrade(
      TransparentUpgradeableProxy(payable(address(tokenPoolProxy))),
      tokenPoolImpl
    );

    // Update proxyPool address
    tokenPoolProxy.setProxyPool(GHO_CCIP_PROXY_POOL);
  }
}
