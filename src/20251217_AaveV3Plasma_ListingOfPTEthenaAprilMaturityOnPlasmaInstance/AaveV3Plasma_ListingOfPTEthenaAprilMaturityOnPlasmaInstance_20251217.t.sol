// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers} from 'aave-helpers/src/GovV3Helpers.sol';
import {AaveV3Plasma} from 'aave-address-book/AaveV3Plasma.sol';
import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {IEmissionManager} from 'aave-v3-origin/contracts/rewards/interfaces/IEmissionManager.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Plasma_ListingOfPTEthenaAprilMaturityOnPlasmaInstance_20251217} from './AaveV3Plasma_ListingOfPTEthenaAprilMaturityOnPlasmaInstance_20251217.sol';

/**
 * @dev Test for AaveV3Plasma_ListingOfPTEthenaAprilMaturityOnPlasmaInstance_20251217
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20251217_AaveV3Plasma_ListingOfPTEthenaAprilMaturityOnPlasmaInstance/AaveV3Plasma_ListingOfPTEthenaAprilMaturityOnPlasmaInstance_20251217.t.sol -vv
 */
contract AaveV3Plasma_ListingOfPTEthenaAprilMaturityOnPlasmaInstance_20251217_Test is
  ProtocolV3TestBase
{
  AaveV3Plasma_ListingOfPTEthenaAprilMaturityOnPlasmaInstance_20251217 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('plasma'), 9134331);
    proposal = new AaveV3Plasma_ListingOfPTEthenaAprilMaturityOnPlasmaInstance_20251217();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Plasma_ListingOfPTEthenaAprilMaturityOnPlasmaInstance_20251217',
      AaveV3Plasma.POOL,
      address(proposal)
    );
  }

  function test_dustBinHasPT_sUSDE_9APR2026Funds() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    address aTokenAddress = AaveV3Plasma.POOL.getReserveAToken(proposal.PT_sUSDE_9APR2026());
    assertGe(IERC20(aTokenAddress).balanceOf(address(AaveV3Plasma.DUST_BIN)), 10 ** 18);
  }

  function test_PT_sUSDE_9APR2026Admin() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    address aPT_sUSDE_9APR2026 = AaveV3Plasma.POOL.getReserveAToken(proposal.PT_sUSDE_9APR2026());
    assertEq(
      IEmissionManager(AaveV3Plasma.EMISSION_MANAGER).getEmissionAdmin(
        proposal.PT_sUSDE_9APR2026()
      ),
      proposal.PT_sUSDE_9APR2026_LM_ADMIN()
    );
    assertEq(
      IEmissionManager(AaveV3Plasma.EMISSION_MANAGER).getEmissionAdmin(aPT_sUSDE_9APR2026),
      proposal.PT_sUSDE_9APR2026_LM_ADMIN()
    );
  }

  function test_dustBinHasPT_USDe_9APR2026Funds() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    address aTokenAddress = AaveV3Plasma.POOL.getReserveAToken(proposal.PT_USDe_9APR2026());
    assertGe(IERC20(aTokenAddress).balanceOf(address(AaveV3Plasma.DUST_BIN)), 10 ** 18);
  }

  function test_PT_USDe_9APR2026Admin() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    address aPT_USDe_9APR2026 = AaveV3Plasma.POOL.getReserveAToken(proposal.PT_USDe_9APR2026());
    assertEq(
      IEmissionManager(AaveV3Plasma.EMISSION_MANAGER).getEmissionAdmin(proposal.PT_USDe_9APR2026()),
      proposal.PT_USDe_9APR2026_LM_ADMIN()
    );
    assertEq(
      IEmissionManager(AaveV3Plasma.EMISSION_MANAGER).getEmissionAdmin(aPT_USDe_9APR2026),
      proposal.PT_USDe_9APR2026_LM_ADMIN()
    );
  }
}
