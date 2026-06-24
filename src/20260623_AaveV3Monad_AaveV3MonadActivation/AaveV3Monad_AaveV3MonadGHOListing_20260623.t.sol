// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers} from 'aave-helpers/src/GovV3Helpers.sol';
import {AaveV3Monad} from 'aave-address-book/AaveV3Monad.sol';
import {GovernanceV3Monad} from 'aave-address-book/GovernanceV3Monad.sol';
import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Monad_AaveV3MonadActivation_20260623} from './AaveV3Monad_AaveV3MonadActivation_20260623.sol';
import {AaveV3Monad_AaveV3MonadGHOListing_20260623} from './AaveV3Monad_AaveV3MonadGHOListing_20260623.sol';

/**
 * @dev Test for AaveV3Monad_AaveV3MonadGHOListing_20260623
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20260623_AaveV3Monad_AaveV3MonadActivation/AaveV3Monad_AaveV3MonadGHOListing_20260623.t.sol -vv
 */
contract AaveV3Monad_AaveV3MonadGHOListing_20260623_Test is ProtocolV3TestBase {
  AaveV3Monad_AaveV3MonadGHOListing_20260623 internal proposal;
  AaveV3Monad_AaveV3MonadActivation_20260623 internal activation;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('monad'), 83370000);

    // the GHO listing depends on the eModes created by the activation payload, so execute it first
    activation = new AaveV3Monad_AaveV3MonadActivation_20260623();
    deal(activation.USDT0(), GovernanceV3Monad.EXECUTOR_LVL_1, activation.USDT0_SEED_AMOUNT());
    deal(activation.USDC(), GovernanceV3Monad.EXECUTOR_LVL_1, activation.USDC_SEED_AMOUNT());
    deal(activation.USDe(), GovernanceV3Monad.EXECUTOR_LVL_1, activation.USDe_SEED_AMOUNT());
    deal(activation.mUSD(), GovernanceV3Monad.EXECUTOR_LVL_1, activation.mUSD_SEED_AMOUNT());
    deal(activation.AUSD(), GovernanceV3Monad.EXECUTOR_LVL_1, activation.AUSD_SEED_AMOUNT());
    deal(activation.WETH(), GovernanceV3Monad.EXECUTOR_LVL_1, activation.WETH_SEED_AMOUNT());
    deal(activation.cbBTC(), GovernanceV3Monad.EXECUTOR_LVL_1, activation.cbBTC_SEED_AMOUNT());
    deal(activation.wstETH(), GovernanceV3Monad.EXECUTOR_LVL_1, activation.wstETH_SEED_AMOUNT());
    deal(activation.weETH(), GovernanceV3Monad.EXECUTOR_LVL_1, activation.weETH_SEED_AMOUNT());
    deal(
      activation.syrupUSDC(),
      GovernanceV3Monad.EXECUTOR_LVL_1,
      activation.syrupUSDC_SEED_AMOUNT()
    );
    deal(activation.sUSDe(), GovernanceV3Monad.EXECUTOR_LVL_1, activation.sUSDe_SEED_AMOUNT());
    GovV3Helpers.executePayload(vm, address(activation));

    proposal = new AaveV3Monad_AaveV3MonadGHOListing_20260623();
    deal(proposal.GHO(), GovernanceV3Monad.EXECUTOR_LVL_1, proposal.GHO_SEED_AMOUNT());
  }

  /**
   * @dev AUSD uses namespaced storage that forge-std `deal` cannot write; the generic e2e funds
   * test users via `deal`, so route AUSD through an on-chain holder instead.
   */
  function deal(address token, address to, uint256 give) internal override {
    if (token == activation.AUSD()) {
      vm.prank(0xD5D960E8C380B724a48AC59E2DfF1b2CB4a1eAee);
      IERC20(token).transfer(to, give);
      return;
    }
    super.deal(token, to, give);
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    // GHO has no supply on Monad yet; give it a non-zero total supply so the newly-listed-asset
    // supply-cap plausibility check (supplyCap vs token totalSupply) passes
    deal(proposal.GHO(), makeAddr('ghoSupply'), 1_000_000 * 10 ** 18, true);

    defaultTest('AaveV3Monad_AaveV3MonadGHOListing_20260623', AaveV3Monad.POOL, address(proposal));
  }

  function test_dustBinHasGHOFunds() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    address aTokenAddress = AaveV3Monad.POOL.getReserveAToken(proposal.GHO());
    assertGe(
      IERC20(aTokenAddress).balanceOf(address(AaveV3Monad.DUST_BIN)),
      proposal.GHO_SEED_AMOUNT()
    );
  }

  function test_GHOAddedToEModes() public {
    GovV3Helpers.executePayload(vm, address(proposal));

    address[] memory gho = new address[](1);
    gho[0] = proposal.GHO();
    uint128 ghoBitmap = _toBitmap(gho);

    uint8 eMode_Maple_syrupUSDC = _findEModeCategoryId('Maple_syrupUSDC');
    assertEq(
      AaveV3Monad.POOL.getEModeCategoryBorrowableBitmap(eMode_Maple_syrupUSDC) & ghoBitmap,
      ghoBitmap
    );
    assertEq(
      AaveV3Monad.POOL.getEModeCategoryCollateralBitmap(eMode_Maple_syrupUSDC) & ghoBitmap,
      0
    );

    uint8 eMode_Liquid_Leverage = _findEModeCategoryId('Liquid_Leverage');
    assertEq(
      AaveV3Monad.POOL.getEModeCategoryBorrowableBitmap(eMode_Liquid_Leverage) & ghoBitmap,
      ghoBitmap
    );
    assertEq(
      AaveV3Monad.POOL.getEModeCategoryCollateralBitmap(eMode_Liquid_Leverage) & ghoBitmap,
      0
    );
  }

  function _findEModeCategoryId(string memory label) internal view returns (uint8) {
    for (uint8 i = 1; i < 255; i++) {
      if (keccak256(bytes(AaveV3Monad.POOL.getEModeCategoryLabel(i))) == keccak256(bytes(label))) {
        return i;
      }
    }
    revert('eMode category not found');
  }

  function _toBitmap(address[] memory assets) internal view returns (uint128 bitmap) {
    for (uint256 i = 0; i < assets.length; i++) {
      bitmap |= uint128(1) << AaveV3Monad.POOL.getReserveData(assets[i]).id;
    }
  }
}
