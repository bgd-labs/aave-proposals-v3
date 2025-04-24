// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers} from 'aave-helpers/src/GovV3Helpers.sol';
import {AaveV3Ethereum} from 'aave-address-book/AaveV3Ethereum.sol';
import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {IEmissionManager} from 'aave-v3-origin/contracts/rewards/interfaces/IEmissionManager.sol';
import {ProtocolV3TestBase} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Ethereum_OnboardPTSUSDeJulyOnCoreInstance_20250423} from './AaveV3Ethereum_OnboardPTSUSDeJulyOnCoreInstance_20250423.sol';

/**
 * @dev Test for AaveV3Ethereum_OnboardPTSUSDeJulyOnCoreInstance_20250423
 * command: FOUNDRY_PROFILE=mainnet forge test --match-path=src/20250423_AaveV3Ethereum_OnboardPTSUSDeJulyAndPTEUSDeMayOnCoreInstance/AaveV3Ethereum_OnboardPTSUSDeJulyOnCoreInstance_20250423.t.sol -vv
 */
contract AaveV3Ethereum_OnboardPTSUSDeJulyOnCoreInstance_20250423_Test is ProtocolV3TestBase {
  AaveV3Ethereum_OnboardPTSUSDeJulyOnCoreInstance_20250423 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 22330904);
    proposal = new AaveV3Ethereum_OnboardPTSUSDeJulyOnCoreInstance_20250423();
  }

  /// forge-config: default.evm_version = 'cancun'
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Ethereum_OnboardPTSUSDeJulyOnCoreInstance_20250423',
      AaveV3Ethereum.POOL,
      address(proposal),
      false
    );
  }

  function test_dustBinHasPT_sUSDE_31JUL2025Funds() public {
    executePayload(vm, address(proposal));

    address aTokenAddress = AaveV3Ethereum.POOL.getReserveAToken(proposal.PT_sUSDE_31JUL2025());
    assertGe(
      IERC20(aTokenAddress).balanceOf(address(AaveV3Ethereum.DUST_BIN)),
      proposal.SEED_AMOUNT()
    );
  }

  function test_PT_sUSDE_31JUL2025Admin() public {
    executePayload(vm, address(proposal));

    address aPT_sUSDE_31JUL2025 = AaveV3Ethereum.POOL.getReserveAToken(
      proposal.PT_sUSDE_31JUL2025()
    );
    assertEq(
      IEmissionManager(AaveV3Ethereum.EMISSION_MANAGER).getEmissionAdmin(
        proposal.PT_sUSDE_31JUL2025()
      ),
      proposal.LM_ADMIN()
    );
    assertEq(
      IEmissionManager(AaveV3Ethereum.EMISSION_MANAGER).getEmissionAdmin(aPT_sUSDE_31JUL2025),
      proposal.LM_ADMIN()
    );
  }
}
