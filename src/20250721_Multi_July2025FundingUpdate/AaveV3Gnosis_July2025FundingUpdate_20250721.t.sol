// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {AaveV3Gnosis, AaveV3GnosisAssets} from 'aave-address-book/AaveV3Gnosis.sol';
import {MiscGnosis} from 'aave-address-book/MiscGnosis.sol';
import {ProtocolV3TestBase} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Gnosis_July2025FundingUpdate_20250721} from './AaveV3Gnosis_July2025FundingUpdate_20250721.sol';

/**
 * @dev Test for AaveV3Gnosis_July2025FundingUpdate_20250721
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20250721_Multi_July2025FundingUpdate/AaveV3Gnosis_July2025FundingUpdate_20250721.t.sol -vv
 */
contract AaveV3Gnosis_July2025FundingUpdate_20250721_Test is ProtocolV3TestBase {
  AaveV3Gnosis_July2025FundingUpdate_20250721 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('gnosis'), 41201011);
    proposal = new AaveV3Gnosis_July2025FundingUpdate_20250721();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Gnosis_July2025FundingUpdate_20250721',
      AaveV3Gnosis.POOL,
      address(proposal)
    );
  }

  function test_approvals() public {
    assertEq(
      IERC20(AaveV3GnosisAssets.EURe_A_TOKEN).allowance(
        address(AaveV3Gnosis.COLLECTOR),
        MiscGnosis.MASIV_SAFE
      ),
      0
    );

    executePayload(vm, address(proposal));

    assertEq(
      IERC20(AaveV3GnosisAssets.EURe_A_TOKEN).allowance(
        address(AaveV3Gnosis.COLLECTOR),
        MiscGnosis.MASIV_SAFE
      ),
      proposal.EURE_AMOUNT()
    );

    vm.startPrank(MiscGnosis.MASIV_SAFE);
    IERC20(AaveV3GnosisAssets.EURe_A_TOKEN).transferFrom(
      address(AaveV3Gnosis.COLLECTOR),
      MiscGnosis.MASIV_SAFE,
      proposal.EURE_AMOUNT()
    );
  }
}
