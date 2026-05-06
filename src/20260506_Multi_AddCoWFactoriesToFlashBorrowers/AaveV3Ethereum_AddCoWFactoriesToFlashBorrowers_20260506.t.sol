// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers} from 'aave-helpers/src/GovV3Helpers.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {IPool} from 'aave-address-book/AaveV3.sol';

import {AaveV3Ethereum_AddCoWFactoriesToFlashBorrowers_20260506} from './AaveV3Ethereum_AddCoWFactoriesToFlashBorrowers_20260506.sol';
import {CoWFlashBorrowerBaseTest} from './setup/CoWFlashBorrowerBaseTest.t.sol';

/**
 * @dev Test for AaveV3Ethereum_AddCoWFactoriesToFlashBorrowers_20260506
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20260506_Multi_AddCoWFactoriesToFlashBorrowers/AaveV3Ethereum_AddCoWFactoriesToFlashBorrowers_20260506.t.sol -vv
 */
contract AaveV3Ethereum_AddCoWFactoriesToFlashBorrowers_20260506_Test is CoWFlashBorrowerBaseTest {
  AaveV3Ethereum_AddCoWFactoriesToFlashBorrowers_20260506 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 25035497);
    proposal = new AaveV3Ethereum_AddCoWFactoriesToFlashBorrowers_20260506();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Ethereum_AddCoWFactoriesToFlashBorrowers_20260506',
      AaveV3Ethereum.POOL,
      address(proposal)
    );
  }

  function test_isFlashBorrower() external {
    GovV3Helpers.executePayload(vm, address(proposal));
    bool isFlashBorrower = AaveV3Ethereum.ACL_MANAGER.isFlashBorrower(
      proposal.NEW_FLASH_BORROWER()
    );
    assertEq(isFlashBorrower, true);
  }

  function _pool() internal pure override returns (IPool) {
    return AaveV3Ethereum.POOL;
  }

  function _flashBorrower() internal view override returns (address) {
    return proposal.NEW_FLASH_BORROWER();
  }

  function _executePayload() internal override {
    GovV3Helpers.executePayload(vm, address(proposal));
  }

  function _collateralSwapConfig() internal pure override returns (CollateralSwapConfig memory) {
    return
      CollateralSwapConfig({
        collateralAsset: AaveV3EthereumAssets.wstETH_UNDERLYING,
        debtAsset: AaveV3EthereumAssets.USDC_UNDERLYING,
        collateralSeed: 10 ether,
        debtSeed: 10_000 * 1e6,
        sellAmount: 10 ether,
        expectedBuyAmount: 42_000 * 1e6
      });
  }
}
