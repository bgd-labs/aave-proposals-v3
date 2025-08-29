// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {AaveV3Arbitrum, AaveV3ArbitrumAssets} from 'aave-address-book/AaveV3Arbitrum.sol';
import {MiscArbitrum} from 'aave-address-book/MiscArbitrum.sol';
import {ProtocolV3TestBase} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Arbitrum_SeptemberFundingUpdate_20250826} from './AaveV3Arbitrum_SeptemberFundingUpdate_20250826.sol';

/**
 * @dev Test for AaveV3Arbitrum_SeptemberFundingUpdate_20250826
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20250826_Multi_SeptemberFundingUpdate/AaveV3Arbitrum_SeptemberFundingUpdate_20250826.t.sol -vv
 */
contract AaveV3Arbitrum_SeptemberFundingUpdate_20250826_Test is ProtocolV3TestBase {
  AaveV3Arbitrum_SeptemberFundingUpdate_20250826 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('arbitrum'), 372840280);
    proposal = new AaveV3Arbitrum_SeptemberFundingUpdate_20250826();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Arbitrum_SeptemberFundingUpdate_20250826',
      AaveV3Arbitrum.POOL,
      address(proposal)
    );
  }

  function test_approvals() public {
    assertEq(
      IERC20(AaveV3ArbitrumAssets.ARB_UNDERLYING).allowance(
        address(AaveV3Arbitrum.COLLECTOR),
        MiscArbitrum.APE_SAFE
      ),
      0
    );

    executePayload(vm, address(proposal));

    assertEq(
      IERC20(AaveV3ArbitrumAssets.ARB_UNDERLYING).allowance(
        address(AaveV3Arbitrum.COLLECTOR),
        MiscArbitrum.APE_SAFE
      ),
      proposal.ARB_AMOUNT()
    );

    vm.startPrank(MiscArbitrum.APE_SAFE);
    IERC20(AaveV3ArbitrumAssets.ARB_UNDERLYING).transferFrom(
      address(AaveV3Arbitrum.COLLECTOR),
      MiscArbitrum.APE_SAFE,
      proposal.ARB_AMOUNT()
    );
  }
}
