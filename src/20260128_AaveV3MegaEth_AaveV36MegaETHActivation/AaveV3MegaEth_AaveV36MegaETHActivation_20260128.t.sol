// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers} from 'aave-helpers/src/GovV3Helpers.sol';
import {AaveV3MegaEth} from 'aave-address-book/AaveV3MegaEth.sol';
import {MiscMegaEth} from 'aave-address-book/MiscMegaEth.sol';
import {GovernanceV3MegaEth} from 'aave-address-book/GovernanceV3MegaEth.sol';
import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {IEmissionManager} from 'aave-v3-origin/contracts/rewards/interfaces/IEmissionManager.sol';
import {ProtocolV3TestBase} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {IPriceOracleSentinel} from 'aave-v3-origin/contracts/interfaces/IPriceOracleSentinel.sol';
import {AaveV3MegaEth_AaveV36MegaETHActivation_20260128} from './AaveV3MegaEth_AaveV36MegaETHActivation_20260128.sol';

/**
 * @dev Test for AaveV3MegaEth_AaveV36MegaETHActivation_20260128
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20260128_AaveV3MegaEth_AaveV36MegaETHActivation/AaveV3MegaEth_AaveV36MegaETHActivation_20260128.t.sol -vv
 */
contract AaveV3MegaEth_AaveV36MegaETHActivation_20260128_Test is ProtocolV3TestBase {
  AaveV3MegaEth_AaveV36MegaETHActivation_20260128 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('megaeth'), 7321769);
    proposal = new AaveV3MegaEth_AaveV36MegaETHActivation_20260128();

    _postSetup(); // TODO: remove after seeding tokens
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3MegaEth_AaveV36MegaETHActivation_20260128',
      AaveV3MegaEth.POOL,
      address(proposal),
      false,
      false
    );
  }

  function test_dustBinHasFunds() public {
    GovV3Helpers.executePayload(vm, address(proposal));

    _validateDustbinFundsAndLMAdmin(proposal.WETH(), 0.0025e18);
    _validateDustbinFundsAndLMAdmin(proposal.BTCb(), 0.0005e8);
    _validateDustbinFundsAndLMAdmin(proposal.USDT0(), 10e6);
    _validateDustbinFundsAndLMAdmin(proposal.USDm(), 10e18);
    _validateDustbinFundsAndLMAdmin(proposal.wrsETH(), 0.0025e18);
    _validateDustbinFundsAndLMAdmin(proposal.wstETH(), 0.0025e18);
    _validateDustbinFundsAndLMAdmin(proposal.ezETH(), 0.0025e18);
  }

  function test_guardianPoolAdmin() public {
    assertFalse(AaveV3MegaEth.ACL_MANAGER.isPoolAdmin(MiscMegaEth.PROTOCOL_GUARDIAN));
    executePayload(vm, address(proposal));
    assertTrue(AaveV3MegaEth.ACL_MANAGER.isPoolAdmin(MiscMegaEth.PROTOCOL_GUARDIAN));
  }

  function test_riskStewardRiskAdmin() public {
    assertFalse(AaveV3MegaEth.ACL_MANAGER.isRiskAdmin(AaveV3MegaEth.RISK_STEWARD));
    executePayload(vm, address(proposal));
    assertTrue(AaveV3MegaEth.ACL_MANAGER.isRiskAdmin(AaveV3MegaEth.RISK_STEWARD));
  }

  function test_price_oracle_sentinel() public {
    assertEq(AaveV3MegaEth.POOL_ADDRESSES_PROVIDER.getPriceOracleSentinel(), address(0));
    executePayload(vm, address(proposal));
    assertEq(
      AaveV3MegaEth.POOL_ADDRESSES_PROVIDER.getPriceOracleSentinel(),
      proposal.PRICE_ORACLE_SENTINEL()
    );

    // sentinel config validate
    assertEq(
      address(IPriceOracleSentinel(proposal.PRICE_ORACLE_SENTINEL()).ADDRESSES_PROVIDER()),
      address(AaveV3MegaEth.POOL_ADDRESSES_PROVIDER)
    );
    assertEq(IPriceOracleSentinel(proposal.PRICE_ORACLE_SENTINEL()).getGracePeriod(), 3600);
    assertEq(
      IPriceOracleSentinel(proposal.PRICE_ORACLE_SENTINEL()).getSequencerOracle(),
      0x78B2195A21B8BBe82acaB43F90F9180E9513FD0C
    );
  }

  function _validateDustbinFundsAndLMAdmin(address asset, uint256 seedAmount) internal view {
    (address aToken, , ) = AaveV3MegaEth.AAVE_PROTOCOL_DATA_PROVIDER.getReserveTokensAddresses(
      asset
    );
    assertGe(IERC20(aToken).balanceOf(address(AaveV3MegaEth.DUST_BIN)), seedAmount);

    assertEq(
      IEmissionManager(AaveV3MegaEth.EMISSION_MANAGER).getEmissionAdmin(asset),
      proposal.LM_ADMIN()
    );
    assertEq(
      IEmissionManager(AaveV3MegaEth.EMISSION_MANAGER).getEmissionAdmin(aToken),
      proposal.LM_ADMIN()
    );
  }

  function _postSetup() internal {
    // mock funding seed amount
    deal(proposal.BTCb(), GovernanceV3MegaEth.EXECUTOR_LVL_1, proposal.BTCb_SEED_AMOUNT());
    deal(proposal.wrsETH(), GovernanceV3MegaEth.EXECUTOR_LVL_1, proposal.wrsETH_SEED_AMOUNT());
    deal(proposal.wstETH(), GovernanceV3MegaEth.EXECUTOR_LVL_1, proposal.wstETH_SEED_AMOUNT());
    deal(proposal.ezETH(), GovernanceV3MegaEth.EXECUTOR_LVL_1, proposal.ezETH_SEED_AMOUNT());
  }
}
