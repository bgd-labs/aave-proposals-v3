// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Ethereum} from 'aave-address-book/AaveV3Ethereum.sol';
import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Ethereum_ARFCSafetyModuleUmbrellaEmissionUpdate_20250918} from './AaveV3Ethereum_ARFCSafetyModuleUmbrellaEmissionUpdate_20250918.sol';
import {IStakeToken} from 'aave-address-book/common/IStakeToken.sol';
import {AaveSafetyModule} from 'aave-address-book/AaveSafetyModule.sol';

/**
 * @dev Test for AaveV3Ethereum_ARFCSafetyModuleUmbrellaEmissionUpdate_20250918
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20250918_AaveV3Ethereum_ARFCSafetyModuleUmbrellaEmissionUpdate/AaveV3Ethereum_ARFCSafetyModuleUmbrellaEmissionUpdate_20250918.t.sol -vv
 */
contract AaveV3Ethereum_ARFCSafetyModuleUmbrellaEmissionUpdate_20250918_Test is ProtocolV3TestBase {
  AaveV3Ethereum_ARFCSafetyModuleUmbrellaEmissionUpdate_20250918 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 23431964);
    proposal = new AaveV3Ethereum_ARFCSafetyModuleUmbrellaEmissionUpdate_20250918();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Ethereum_ARFCSafetyModuleUmbrellaEmissionUpdate_20250918',
      AaveV3Ethereum.POOL,
      address(proposal)
    );
  }

  function test_checkSlashingConfig() public {
    uint256 stkAAVE_before = IStakeToken(AaveSafetyModule.STK_AAVE).getMaxSlashablePercentage();
    uint256 stkABPT_before = IStakeToken(AaveSafetyModule.STK_ABPT).getMaxSlashablePercentage();

    assertGt(stkAAVE_before, 0, 'stkAAVE slashing already 0 before proposal');
    assertGt(stkABPT_before, 0, 'stkABPT slashing already 0 before proposal');

    executePayload(vm, address(proposal));

    uint256 stkAAVE_after = IStakeToken(AaveSafetyModule.STK_AAVE).getMaxSlashablePercentage();
    uint256 stkABPT_after = IStakeToken(AaveSafetyModule.STK_ABPT).getMaxSlashablePercentage();

    assertEq(stkAAVE_after, proposal.NEW_MAX_SLASHING_PCT(), 'stkAAVE slashing not updated');
    assertEq(stkABPT_after, proposal.NEW_MAX_SLASHING_PCT(), 'stkABPT slashing not updated');
  }
}
