// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Ethereum} from 'aave-address-book/AaveV3Ethereum.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Ethereum_GHOCCIPIntegrationMaintenanceCCIPV15Upgrade_20241017} from './AaveV3Ethereum_GHOCCIPIntegrationMaintenanceCCIPV15Upgrade_20241017.sol';
import {UpgradeableLockReleaseTokenPool} from 'aave-ccip/v0.8/ccip/pools/GHO/UpgradeableLockReleaseTokenPool.sol';
import {MiscEthereum} from 'aave-address-book/MiscEthereum.sol';

/**
 * @dev Test for AaveV3Ethereum_GHOCCIPIntegrationMaintenanceCCIPV15Upgrade_20241017
 * command: FOUNDRY_PROFILE=mainnet forge test --match-path=src/20241017_Multi_GHOCCIPIntegrationMaintenanceCCIPV15Upgrade/AaveV3Ethereum_GHOCCIPIntegrationMaintenanceCCIPV15Upgrade_20241017.t.sol -vv --contracts src/20241017_Multi_GHOCCIPIntegrationMaintenanceCCIPV15Upgrade
 */
contract AaveV3Ethereum_GHOCCIPIntegrationMaintenanceCCIPV15Upgrade_20241017_Test is
  ProtocolV3TestBase
{
  AaveV3Ethereum_GHOCCIPIntegrationMaintenanceCCIPV15Upgrade_20241017 internal proposal;
  address internal proxyPool;
  UpgradeableLockReleaseTokenPool internal tokenPoolProxy;

  uint64 internal constant ETH_ARB_CHAIN_SELECTOR = 4949039107694359620;

  event Locked(address indexed sender, uint256 amount);

  error CallerIsNotARampOnRouter(address caller);

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 20985823);
    proposal = new AaveV3Ethereum_GHOCCIPIntegrationMaintenanceCCIPV15Upgrade_20241017();

    // ProxyPool deployed by chainlink
    proxyPool = address(1337); // todo: MiscEthereum.GHO_CCIP_PROXY_POOL
    tokenPoolProxy = UpgradeableLockReleaseTokenPool(MiscEthereum.GHO_CCIP_TOKEN_POOL);
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Ethereum_GHOCCIPIntegrationMaintenanceCCIPV15Upgrade_20241017',
      AaveV3Ethereum.POOL,
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

    uint256 bridgedAmount = tokenPoolProxy.getCurrentBridgedAmount();

    vm.expectRevert(abi.encodeWithSelector(CallerIsNotARampOnRouter.selector, proxyPool));
    vm.prank(proxyPool);
    tokenPoolProxy.lockOrBurn(
      alice,
      abi.encode(alice),
      amount,
      ETH_ARB_CHAIN_SELECTOR,
      new bytes(0)
    );

    executePayload(vm, address(proposal));

    vm.expectEmit();
    emit Locked(proxyPool, amount);
    vm.prank(proxyPool);
    tokenPoolProxy.lockOrBurn(
      alice,
      abi.encode(alice),
      amount,
      ETH_ARB_CHAIN_SELECTOR,
      new bytes(0)
    );

    assertEq(tokenPoolProxy.getCurrentBridgedAmount(), bridgedAmount + amount);
  }
}
