// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Arbitrum} from 'aave-address-book/AaveV3Arbitrum.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Arbitrum_GHOCCIPIntegrationMaintenanceCCIPV15Upgrade_20241017} from './AaveV3Arbitrum_GHOCCIPIntegrationMaintenanceCCIPV15Upgrade_20241017.sol';
import {UpgradeableBurnMintTokenPool} from 'aave-ccip/v0.8/ccip/pools/GHO/UpgradeableBurnMintTokenPool.sol';
import {MiscArbitrum} from 'aave-address-book/MiscArbitrum.sol';

/**
 * @dev Test for AaveV3Arbitrum_GHOCCIPIntegrationMaintenanceCCIPV15Upgrade_20241017
 * command: FOUNDRY_PROFILE=arbitrum forge test --match-path=src/20241017_Multi_GHOCCIPIntegrationMaintenanceCCIPV15Upgrade/AaveV3Arbitrum_GHOCCIPIntegrationMaintenanceCCIPV15Upgrade_20241017.t.sol -vv --contracts src/20241017_Multi_GHOCCIPIntegrationMaintenanceCCIPV15Upgrade
 */
contract AaveV3Arbitrum_GHOCCIPIntegrationMaintenanceCCIPV15Upgrade_20241017_Test is
  ProtocolV3TestBase
{
  AaveV3Arbitrum_GHOCCIPIntegrationMaintenanceCCIPV15Upgrade_20241017 internal proposal;
  address internal proxyPool;
  UpgradeableBurnMintTokenPool internal tokenPoolProxy;

  uint64 internal constant ARB_ETH_CHAIN_SELECTOR = 5009297550715157269;

  event Burned(address indexed sender, uint256 amount);

  error CallerIsNotARampOnRouter(address caller);

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('arbitrum'), 264780207);
    proposal = new AaveV3Arbitrum_GHOCCIPIntegrationMaintenanceCCIPV15Upgrade_20241017();

    // ProxyPool deployed by chainlink
    proxyPool = address(1337); // todo: MiscArbitrum.GHO_CCIP_PROXY_POOL
    tokenPoolProxy = UpgradeableBurnMintTokenPool(MiscArbitrum.GHO_CCIP_TOKEN_POOL);
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Arbitrum_GHOCCIPIntegrationMaintenanceCCIPV15Upgrade_20241017',
      AaveV3Arbitrum.POOL,
      address(proposal)
    );
  }

  function test_getProxyPool() public {
    // proxyPool getter does not exist before the upgrade
    vm.expectRevert();
    tokenPoolProxy.getProxyPool();

    executePayload(vm, address(proposal));

    assertEq(tokenPoolProxy.getProxyPool(), proxyPool);
  }

  function test_proxyPoolCanOnRamp() public {
    address alice = makeAddr('alice');
    uint256 amount = 1337e18;

    // mock previously bridged gho on token pool
    deal(address(tokenPoolProxy.getToken()), address(tokenPoolProxy), amount);

    vm.expectRevert(abi.encodeWithSelector(CallerIsNotARampOnRouter.selector, proxyPool));
    vm.prank(proxyPool);
    tokenPoolProxy.lockOrBurn(
      alice,
      abi.encode(alice),
      amount,
      ARB_ETH_CHAIN_SELECTOR,
      new bytes(0)
    );

    executePayload(vm, address(proposal));

    vm.expectEmit();
    emit Burned(proxyPool, amount);
    vm.prank(proxyPool);
    tokenPoolProxy.lockOrBurn(
      alice,
      abi.encode(alice),
      amount,
      ARB_ETH_CHAIN_SELECTOR,
      new bytes(0)
    );
  }
}
