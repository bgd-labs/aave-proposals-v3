// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Base} from 'aave-address-book/AaveV3Base.sol';
import {GovV3Helpers} from 'aave-helpers/src/GovV3Helpers.sol';
import {IEmissionManager} from 'aave-v3-periphery/contracts/rewards/interfaces/IEmissionManager.sol';
import {ICollector} from 'aave-v3-periphery/contracts/treasury/ICollector.sol';
import {IPool} from 'aave-v3-core/contracts/interfaces/IPool.sol';
import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Base_MeritBaseIncentivesAndSuperfestMatching_20240812} from './AaveV3Base_MeritBaseIncentivesAndSuperfestMatching_20240812.sol';
import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {SafeERC20} from 'solidity-utils/contracts/oz-common/SafeERC20.sol';

/**
 * @dev Test for AaveV3Base_MeritBaseIncentivesAndSuperfestMatching_20240812
 * command: FOUNDRY_PROFILE=base forge test --match-path=src/20240812_Multi_MeritBaseIncentivesAndSuperfestMatching/AaveV3Base_MeritBaseIncentivesAndSuperfestMatching_20240812.t.sol -vv
 */
contract AaveV3Base_MeritBaseIncentivesAndSuperfestMatching_20240812_Test is ProtocolV3TestBase {
  using SafeERC20 for IERC20;
  AaveV3Base_MeritBaseIncentivesAndSuperfestMatching_20240812 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('base'), 18354993);
    proposal = new AaveV3Base_MeritBaseIncentivesAndSuperfestMatching_20240812();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Base_MeritBaseIncentivesAndSuperfestMatching_20240812',
      AaveV3Base.POOL,
      address(proposal)
    );
  }

  function test_emissionAdmin() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    AaveV3Base_MeritBaseIncentivesAndSuperfestMatching_20240812.EmissionAdmin[4]
      memory admins = proposal.getEmissionAdmins();
    for (uint56 i = 0; i < admins.length; i++) {
      assertEq(
        IEmissionManager(AaveV3Base.EMISSION_MANAGER).getEmissionAdmin(admins[i].asset),
        admins[i].admin
      );
    }
  }

  function test_transfer() public {
    AaveV3Base_MeritBaseIncentivesAndSuperfestMatching_20240812.Transfer[2]
      memory transfers = proposal.getTransfers();
    uint256[2] memory aTokenBalBefore;
    uint256[2] memory aTokenBalAfter;
    uint256[2] memory uTokenBalBefore;
    uint256[2] memory uTokenBalAfter;

    for (uint56 i = 0; i < transfers.length; i++) {
      uTokenBalBefore[i] = IERC20(transfers[i].asset).balanceOf(transfers[i].recipient);
      aTokenBalBefore[i] = IERC20(AaveV3Base.POOL.getReserveData(transfers[i].asset).aTokenAddress)
        .balanceOf(address(AaveV3Base.COLLECTOR));
    }

    GovV3Helpers.executePayload(vm, address(proposal));

    for (uint56 i = 0; i < transfers.length; i++) {
      uTokenBalAfter[i] = IERC20(transfers[i].asset).balanceOf(transfers[i].recipient);
      aTokenBalAfter[i] = IERC20(AaveV3Base.POOL.getReserveData(transfers[i].asset).aTokenAddress)
        .balanceOf(address(AaveV3Base.COLLECTOR));
    }

    for (uint56 i = 0; i < transfers.length; i++) {
      // Check that the recipient received approximately the expected amount
      assertApproxEqAbs(
        uTokenBalAfter[i] - uTokenBalBefore[i],
        transfers[i].amount,
        1 wei,
        'Recipient balance change should be close to expected amount'
      );

      // Check that the aToken balance decreased by approximately the expected amount
      assertApproxEqAbs(
        aTokenBalBefore[i] - aTokenBalAfter[i],
        transfers[i].amount,
        1 wei,
        'aToken balance change should be close to expected amount'
      );
    }
  }
}
