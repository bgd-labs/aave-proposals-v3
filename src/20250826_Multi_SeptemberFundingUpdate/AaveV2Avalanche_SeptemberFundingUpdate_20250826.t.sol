// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {AaveV2Avalanche, AaveV2AvalancheAssets} from 'aave-address-book/AaveV2Avalanche.sol';
import {MiscAvalanche} from 'aave-address-book/MiscAvalanche.sol';
import {ProtocolV2TestBase} from 'aave-helpers/src/ProtocolV2TestBase.sol';
import {AaveV2Avalanche_SeptemberFundingUpdate_20250826} from './AaveV2Avalanche_SeptemberFundingUpdate_20250826.sol';

/**
 * @dev Test for AaveV2Avalanche_SeptemberFundingUpdate_20250826
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20250826_Multi_SeptemberFundingUpdate/AaveV2Avalanche_SeptemberFundingUpdate_20250826.t.sol -vv
 */
contract AaveV2Avalanche_SeptemberFundingUpdate_20250826_Test is ProtocolV2TestBase {
  AaveV2Avalanche_SeptemberFundingUpdate_20250826 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('avalanche'), 67696205);
    proposal = new AaveV2Avalanche_SeptemberFundingUpdate_20250826();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV2Avalanche_SeptemberFundingUpdate_20250826',
      AaveV2Avalanche.POOL,
      address(proposal)
    );
  }

  function test_approvals() public {
    assertEq(
      IERC20(AaveV2AvalancheAssets.USDCe_A_TOKEN).allowance(
        address(AaveV2Avalanche.COLLECTOR),
        MiscAvalanche.AFC_SAFE
      ),
      0
    );

    assertEq(
      IERC20(AaveV2AvalancheAssets.USDTe_A_TOKEN).allowance(
        address(AaveV2Avalanche.COLLECTOR),
        MiscAvalanche.AFC_SAFE
      ),
      0
    );

    assertEq(
      IERC20(AaveV2AvalancheAssets.DAIe_A_TOKEN).allowance(
        address(AaveV2Avalanche.COLLECTOR),
        MiscAvalanche.AFC_SAFE
      ),
      0
    );

    uint256 balanceBeforeUsdc = IERC20(AaveV2AvalancheAssets.USDCe_A_TOKEN).balanceOf(
      address(AaveV2Avalanche.COLLECTOR)
    );
    uint256 balanceBeforeUsdt = IERC20(AaveV2AvalancheAssets.USDTe_A_TOKEN).balanceOf(
      address(AaveV2Avalanche.COLLECTOR)
    );
    uint256 balanceBeforeDai = IERC20(AaveV2AvalancheAssets.DAIe_A_TOKEN).balanceOf(
      address(AaveV2Avalanche.COLLECTOR)
    );

    executePayload(vm, address(proposal));

    assertEq(
      IERC20(AaveV2AvalancheAssets.USDCe_A_TOKEN).allowance(
        address(AaveV2Avalanche.COLLECTOR),
        MiscAvalanche.AFC_SAFE
      ),
      balanceBeforeUsdc
    );

    assertEq(
      IERC20(AaveV2AvalancheAssets.USDTe_A_TOKEN).allowance(
        address(AaveV2Avalanche.COLLECTOR),
        MiscAvalanche.AFC_SAFE
      ),
      balanceBeforeUsdt
    );

    assertEq(
      IERC20(AaveV2AvalancheAssets.DAIe_A_TOKEN).allowance(
        address(AaveV2Avalanche.COLLECTOR),
        MiscAvalanche.AFC_SAFE
      ),
      balanceBeforeDai
    );

    vm.startPrank(MiscAvalanche.AFC_SAFE);
    IERC20(AaveV2AvalancheAssets.USDCe_A_TOKEN).transferFrom(
      address(AaveV2Avalanche.COLLECTOR),
      MiscAvalanche.AFC_SAFE,
      balanceBeforeUsdc
    );

    IERC20(AaveV2AvalancheAssets.USDTe_A_TOKEN).transferFrom(
      address(AaveV2Avalanche.COLLECTOR),
      MiscAvalanche.AFC_SAFE,
      balanceBeforeUsdt
    );

    IERC20(AaveV2AvalancheAssets.DAIe_A_TOKEN).transferFrom(
      address(AaveV2Avalanche.COLLECTOR),
      MiscAvalanche.AFC_SAFE,
      balanceBeforeDai
    );
  }
}
