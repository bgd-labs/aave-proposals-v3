// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Ethereum} from 'aave-address-book/AaveV3Ethereum.sol';
import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Ethereum_ExtendAhabFunding_20251022} from './AaveV3Ethereum_ExtendAhabFunding_20251022.sol';
import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {MiscEthereum} from 'aave-address-book/MiscEthereum.sol';

interface IMainnetSwapSteward {
  function swapApprovedToken(address from, address to) external view returns (bool);

  function priceOracle(address fromToken) external view returns (address);

  function tokenBudget(address token) external view returns (uint256);
}

/**
 * @dev Test for AaveV3Ethereum_ExtendAhabFunding_20251022
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20251022_Multi_ExtendAhabFunding/AaveV3Ethereum_ExtendAhabFunding_20251022.t.sol -vv
 */
contract AaveV3Ethereum_ExtendAhabFunding_20251022_Test is ProtocolV3TestBase {
  AaveV3Ethereum_ExtendAhabFunding_20251022 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 23635048);
    proposal = new AaveV3Ethereum_ExtendAhabFunding_20251022();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Ethereum_ExtendAhabFunding_20251022',
      AaveV3Ethereum.POOL,
      address(proposal)
    );
  }

  function test_allowancesBeforeAfter() public {
    uint256 wethAllowanceBefore = IERC20(AaveV3EthereumAssets.WETH_A_TOKEN).allowance(
      address(AaveV3Ethereum.COLLECTOR),
      MiscEthereum.AHAB_SAFE
    );
    uint256 ghoAllowanceBefore = IERC20(AaveV3EthereumAssets.GHO_A_TOKEN).allowance(
      address(AaveV3Ethereum.COLLECTOR),
      MiscEthereum.AHAB_SAFE
    );
    uint256 usdsAllowanceBefore = IERC20(AaveV3EthereumAssets.USDS_A_TOKEN).allowance(
      address(AaveV3Ethereum.COLLECTOR),
      MiscEthereum.AFC_SAFE
    );

    assertEq(wethAllowanceBefore, 0, 'WETH allowance should be 0 before');
    assertEq(ghoAllowanceBefore, 0, 'GHO allowance should be 0 before');
    assertEq(usdsAllowanceBefore, 0, 'USDS allowance should be 0 before');

    executePayload(vm, address(proposal));

    uint256 wethAllowanceAfter = IERC20(AaveV3EthereumAssets.WETH_A_TOKEN).allowance(
      address(AaveV3Ethereum.COLLECTOR),
      MiscEthereum.AHAB_SAFE
    );
    uint256 ghoAllowanceAfter = IERC20(AaveV3EthereumAssets.GHO_A_TOKEN).allowance(
      address(AaveV3Ethereum.COLLECTOR),
      MiscEthereum.AHAB_SAFE
    );
    uint256 usdsAllowanceAfter = IERC20(AaveV3EthereumAssets.USDS_A_TOKEN).allowance(
      address(AaveV3Ethereum.COLLECTOR),
      MiscEthereum.AFC_SAFE
    );

    assertEq(wethAllowanceAfter, 6_000 ether, 'WETH allowance mismatch');
    assertEq(ghoAllowanceAfter, 10_000_000 ether, 'GHO allowance mismatch');
    assertEq(usdsAllowanceAfter, 5_000_000 ether, 'USDS allowance mismatch');
  }

  function test_setSwappablePairs() public {
    IMainnetSwapSteward steward = IMainnetSwapSteward(AaveV3Ethereum.COLLECTOR_SWAP_STEWARD);
    assertFalse(
      steward.swapApprovedToken(
        AaveV3EthereumAssets.USDC_UNDERLYING,
        AaveV3EthereumAssets.AAVE_UNDERLYING
      )
    );
    assertFalse(
      steward.swapApprovedToken(
        AaveV3EthereumAssets.USDT_UNDERLYING,
        AaveV3EthereumAssets.AAVE_UNDERLYING
      )
    );
    assertFalse(
      steward.swapApprovedToken(
        AaveV3EthereumAssets.USDS_UNDERLYING,
        AaveV3EthereumAssets.AAVE_UNDERLYING
      )
    );

    executePayload(vm, address(proposal));

    assertTrue(
      steward.swapApprovedToken(
        AaveV3EthereumAssets.USDC_UNDERLYING,
        AaveV3EthereumAssets.AAVE_UNDERLYING
      )
    );
    assertTrue(
      steward.swapApprovedToken(
        AaveV3EthereumAssets.USDT_UNDERLYING,
        AaveV3EthereumAssets.AAVE_UNDERLYING
      )
    );
    assertTrue(
      steward.swapApprovedToken(
        AaveV3EthereumAssets.USDS_UNDERLYING,
        AaveV3EthereumAssets.AAVE_UNDERLYING
      )
    );
  }
}
