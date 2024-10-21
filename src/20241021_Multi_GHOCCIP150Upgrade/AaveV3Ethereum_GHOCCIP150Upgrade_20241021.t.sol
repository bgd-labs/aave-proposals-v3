// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import 'forge-std/Test.sol';
import {AaveV3Ethereum} from 'aave-address-book/AaveV3Ethereum.sol';
import {ProtocolV3TestBase} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {UpgradeableLockReleaseTokenPool} from 'aave-ccip/v0.8/ccip/pools/GHO/UpgradeableLockReleaseTokenPool.sol';
import {MiscEthereum} from 'aave-address-book/MiscEthereum.sol';
import {AaveV3Ethereum_GHOCCIP150Upgrade_20241021} from './AaveV3Ethereum_GHOCCIP150Upgrade_20241021.sol';

/**
 * @dev Test for AaveV3Ethereum_GHOCCIP150Upgrade_20241021
 * command: FOUNDRY_PROFILE=mainnet forge test --match-path=src/20241021_Multi_GHOCCIP150Upgrade/AaveV3Ethereum_GHOCCIP150Upgrade_20241021.t.sol -vv
 */
contract AaveV3Ethereum_GHOCCIP150Upgrade_20241021_Test is ProtocolV3TestBase {
  AaveV3Ethereum_GHOCCIP150Upgrade_20241021 internal proposal;
  UpgradeableLockReleaseTokenPool internal tokenPoolProxy;
  address internal proxyPool;

  uint64 internal constant ETH_ARB_CHAIN_SELECTOR = 4949039107694359620;

  event Locked(address indexed sender, uint256 amount);

  error CallerIsNotARampOnRouter(address caller);

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 21015645);
    proposal = new AaveV3Ethereum_GHOCCIP150Upgrade_20241021();
    tokenPoolProxy = UpgradeableLockReleaseTokenPool(MiscEthereum.GHO_CCIP_TOKEN_POOL);
    proxyPool = proposal.GHO_CCIP_PROXY_POOL();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Ethereum_GHOCCIP150Upgrade_20241021',
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
