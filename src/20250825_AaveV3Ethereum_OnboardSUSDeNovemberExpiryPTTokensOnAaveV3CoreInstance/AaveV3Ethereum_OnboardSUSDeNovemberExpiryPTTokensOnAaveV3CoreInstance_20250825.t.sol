// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers} from 'aave-helpers/src/GovV3Helpers.sol';
import {AaveV3Ethereum} from 'aave-address-book/AaveV3Ethereum.sol';
import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {IEmissionManager} from 'aave-v3-origin/contracts/rewards/interfaces/IEmissionManager.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Ethereum_OnboardSUSDeNovemberExpiryPTTokensOnAaveV3CoreInstance_20250825} from './AaveV3Ethereum_OnboardSUSDeNovemberExpiryPTTokensOnAaveV3CoreInstance_20250825.sol';

/**
 * @dev Test for AaveV3Ethereum_OnboardSUSDeNovemberExpiryPTTokensOnAaveV3CoreInstance_20250825
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20250825_AaveV3Ethereum_OnboardSUSDeNovemberExpiryPTTokensOnAaveV3CoreInstance/AaveV3Ethereum_OnboardSUSDeNovemberExpiryPTTokensOnAaveV3CoreInstance_20250825.t.sol -vv
 */
contract AaveV3Ethereum_OnboardSUSDeNovemberExpiryPTTokensOnAaveV3CoreInstance_20250825_Test is
  ProtocolV3TestBase
{
  AaveV3Ethereum_OnboardSUSDeNovemberExpiryPTTokensOnAaveV3CoreInstance_20250825 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 23217884);
    proposal = new AaveV3Ethereum_OnboardSUSDeNovemberExpiryPTTokensOnAaveV3CoreInstance_20250825();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Ethereum_OnboardSUSDeNovemberExpiryPTTokensOnAaveV3CoreInstance_20250825',
      AaveV3Ethereum.POOL,
      address(proposal)
    );
  }

  function test_dustBinHasPT_sUSDe_27NOV2025Funds() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    address aTokenAddress = AaveV3Ethereum.POOL.getReserveAToken(proposal.PT_sUSDe_27NOV2025());
    assertGe(IERC20(aTokenAddress).balanceOf(address(AaveV3Ethereum.DUST_BIN)), proposal.PT_sUSDe_27NOV2025_SEED_AMOUNT());
  }

  function test_PT_sUSDe_27NOV2025Admin() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    address aPT_sUSDe_27NOV2025 = AaveV3Ethereum.POOL.getReserveAToken(
      proposal.PT_sUSDe_27NOV2025()
    );
    assertEq(
      IEmissionManager(AaveV3Ethereum.EMISSION_MANAGER).getEmissionAdmin(
        proposal.PT_sUSDe_27NOV2025()
      ),
      proposal.PT_sUSDe_27NOV2025_LM_ADMIN()
    );
    assertEq(
      IEmissionManager(AaveV3Ethereum.EMISSION_MANAGER).getEmissionAdmin(aPT_sUSDe_27NOV2025),
      proposal.PT_sUSDe_27NOV2025_LM_ADMIN()
    );
  }
}
