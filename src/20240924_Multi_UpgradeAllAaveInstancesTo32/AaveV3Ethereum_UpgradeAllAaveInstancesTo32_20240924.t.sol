// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Ethereum_UpgradeAllAaveInstancesTo32_20240924} from './AaveV3Ethereum_UpgradeAllAaveInstancesTo32_20240924.sol';

/**
 * @dev Test for AaveV3Ethereum_GHOBorrowRateUpdate_20240814
 * command: FOUNDRY_PROFILE=mainnet forge test --match-path=src/20240924_Multi_UpgradeAllAaveInstancesTo32/AaveV3Ethereum_UpgradeAllAaveInstancesTo32_20240924.t.sol -vv
 */
contract AaveV3Ethereum_UpgradeAllAaveInstancesTo32_20240924_Test is ProtocolV3TestBase {
  address public constant BGD_RECEIVER = 0xb812d0944f8F581DfAA3a93Dda0d22EcEf51A9CF;
  uint256 public constant AUDIT_COST = 76_000 ether;
  AaveV3Ethereum_UpgradeAllAaveInstancesTo32_20240924 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 20872348);
    proposal = new AaveV3Ethereum_UpgradeAllAaveInstancesTo32_20240924();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    uint256 collectorBalanceBefore = IERC20(AaveV3EthereumAssets.GHO_UNDERLYING).balanceOf(
      address(AaveV3Ethereum.COLLECTOR)
    );
    uint256 bgdBalanceBefore = IERC20(AaveV3EthereumAssets.GHO_UNDERLYING).balanceOf(BGD_RECEIVER);
    defaultTest(
      'AaveV3Ethereum_UpgradeAllAaveInstancesTo32_20240924',
      AaveV3Ethereum.POOL,
      address(proposal)
    );
    uint256 collectorBalanceAfter = IERC20(AaveV3EthereumAssets.GHO_UNDERLYING).balanceOf(
      address(AaveV3Ethereum.COLLECTOR)
    );
    uint256 bgdBalanceAfter = IERC20(AaveV3EthereumAssets.GHO_UNDERLYING).balanceOf(BGD_RECEIVER);
    assertEq(collectorBalanceBefore - AUDIT_COST, collectorBalanceAfter);
    assertEq(bgdBalanceBefore + AUDIT_COST, bgdBalanceAfter);
  }
}
