// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3InkWhitelabel} from 'aave-address-book/AaveV3InkWhitelabel.sol';
import {GovernanceV3InkWhitelabel} from 'aave-address-book/GovernanceV3InkWhitelabel.sol';
import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {IEmissionManager} from 'aave-v3-origin/contracts/rewards/interfaces/IEmissionManager.sol';
import {ProtocolV3TestBase} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Ink_AaveV3InkActivation_20250728} from './AaveV3Ink_AaveV3InkActivation_20250728.sol';
import {IOwnable} from 'aave-address-book/common/IOwnable.sol';
import {AggregatorInterface} from 'aave-v3-origin/contracts/dependencies/chainlink/AggregatorInterface.sol';

/**
 * @dev Test for AaveV3Ink_AaveV3InkActivation_20250728
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20250728_AaveV3Ink_AaveV3InkActivation/AaveV3Ink_AaveV3InkActivation_20250728.t.sol -vv
 */
contract AaveV3Ink_AaveV3InkActivation_20250728_Test is ProtocolV3TestBase {
  AaveV3Ink_AaveV3InkActivation_20250728 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('ink'), 22116303);
    proposal = new AaveV3Ink_AaveV3InkActivation_20250728();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Ink_AaveV3InkActivation_20250728',
      AaveV3InkWhitelabel.POOL,
      address(proposal),
      true,
      true
    );
  }

  function test_dustbinFundsAndLMAdmin() public {
    executePayload(vm, address(proposal), AaveV3InkWhitelabel.POOL);

    _validateDustbinFundsAndLMAdmin(proposal.WETH(), proposal.WETH_SEED_AMOUNT());
    _validateDustbinFundsAndLMAdmin(proposal.KBTC(), proposal.KBTC_SEED_AMOUNT());
    _validateDustbinFundsAndLMAdmin(proposal.USDT(), proposal.USDT_SEED_AMOUNT());
    _validateDustbinFundsAndLMAdmin(proposal.USDG(), proposal.USDG_SEED_AMOUNT());
  }

  function _validateDustbinFundsAndLMAdmin(address asset, uint256 seedAmount) internal view {
    (address aToken, , ) = AaveV3InkWhitelabel
      .AAVE_PROTOCOL_DATA_PROVIDER
      .getReserveTokensAddresses(asset);
    assertGe(IERC20(aToken).balanceOf(address(AaveV3InkWhitelabel.DUST_BIN)), seedAmount);

    assertEq(
      IEmissionManager(AaveV3InkWhitelabel.EMISSION_MANAGER).getEmissionAdmin(asset),
      proposal.LM_ADMIN()
    );
    assertEq(
      IEmissionManager(AaveV3InkWhitelabel.EMISSION_MANAGER).getEmissionAdmin(aToken),
      proposal.LM_ADMIN()
    );
  }
}
