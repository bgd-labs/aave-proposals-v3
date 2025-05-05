// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Gnosis, AaveV3GnosisAssets} from 'aave-address-book/AaveV3Gnosis.sol';
import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Gnosis_MayFundingUpdate_20250426} from './AaveV3Gnosis_MayFundingUpdate_20250426.sol';

/**
 * @dev Test for AaveV3Gnosis_MayFundingUpdate_20250426
 * command: FOUNDRY_PROFILE=gnosis forge test --match-path=src/20250426_Multi_MayFundingUpdate/AaveV3Gnosis_MayFundingUpdate_20250426.t.sol -vv
 */
contract AaveV3Gnosis_MayFundingUpdate_20250426_Test is ProtocolV3TestBase {
  AaveV3Gnosis_MayFundingUpdate_20250426 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('gnosis'), 39797083);
    proposal = new AaveV3Gnosis_MayFundingUpdate_20250426();
  }

  function test_Allowance() public {
    executePayload(vm, address(proposal));
    uint256 eureAllowance = IERC20(AaveV3GnosisAssets.EURe_A_TOKEN).allowance(
      address(AaveV3Gnosis.COLLECTOR),
      proposal.ACI()
    );

    assertEq(eureAllowance, proposal.EURE_AMOUNT());
  }
}
