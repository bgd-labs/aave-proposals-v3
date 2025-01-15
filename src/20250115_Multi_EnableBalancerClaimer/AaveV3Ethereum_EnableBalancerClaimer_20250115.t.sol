// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Ethereum} from 'aave-address-book/AaveV3Ethereum.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Ethereum_EnableBalancerClaimer_20250115} from './AaveV3Ethereum_EnableBalancerClaimer_20250115.sol';
import {AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {IERC20AaveLM} from 'aave-v3-origin/contracts/extensions/stata-token/interfaces/IERC20AaveLM.sol';

/**
 * @dev Test for AaveV3Ethereum_EnableBalancerClaimer_20250115
 * command: FOUNDRY_PROFILE=mainnet forge test --match-path=src/20250115_Multi_EnableBalancerClaimer/AaveV3Ethereum_EnableBalancerClaimer_20250115.t.sol -vv
 */
contract AaveV3Ethereum_EnableBalancerClaimer_20250115_Test is ProtocolV3TestBase {
  AaveV3Ethereum_EnableBalancerClaimer_20250115 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 21632595);
    proposal = new AaveV3Ethereum_EnableBalancerClaimer_20250115();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Ethereum_EnableBalancerClaimer_20250115',
      AaveV3Ethereum.POOL,
      address(proposal)
    );
    vm.startPrank(proposal.CLAIMER());
    address[] memory assets = new address[](1);
    assets[0] = 0xfA1fDbBD71B0aA16162D76914d69cD8CB3Ef92da;
    IERC20AaveLM(0x0FE906e030a44eF24CA8c7dC7B7c53A6C4F00ce9).claimRewardsOnBehalf(
      proposal.BALANCER_VAULT(),
      address(this),
      assets
    );
  }
}
