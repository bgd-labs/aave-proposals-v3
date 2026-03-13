// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers} from 'aave-helpers/src/GovV3Helpers.sol';
import {AaveV3XLayer} from 'aave-address-book/AaveV3XLayer.sol';
import {MiscXLayer} from 'aave-address-book/MiscXLayer.sol';
import {GovernanceV3XLayer} from 'aave-address-book/GovernanceV3XLayer.sol';
import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {IEmissionManager} from 'aave-v3-origin/contracts/rewards/interfaces/IEmissionManager.sol';
import {ProtocolV3TestBase} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3XLayer_AaveV36XLayerActivation_20260306} from './AaveV3XLayer_AaveV36XLayerActivation_20260306.sol';

/**
 * @dev Test for AaveV3XLayer_AaveV36XLayerActivation_20260306
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20260306_AaveV3XLayer_AaveV36XLayerActivation/AaveV3XLayer_AaveV36XLayerActivation_20260306.t.sol -vv
 */
contract AaveV3XLayer_AaveV36XLayerActivation_20260306_Test is ProtocolV3TestBase {
  AaveV3XLayer_AaveV36XLayerActivation_20260306 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('xlayer'), 54632532);
    proposal = new AaveV3XLayer_AaveV36XLayerActivation_20260306();

    _postSetup(); // TODO: remove after seeding tokens
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3XLayer_AaveV36XLayerActivation_20260306',
      AaveV3XLayer.POOL,
      address(proposal),
      false,
      false
    );
  }

  function test_capsIncreaseByGuardian() public {
    GovV3Helpers.executePayload(vm, address(proposal));

    _setAndValidateCapsByGuardian(proposal.USDT0(), 50_000_000, 48_000_000);
    _setAndValidateCapsByGuardian(proposal.USDG(), 5_000_000, 4_250_000);
    _setAndValidateCapsByGuardian(proposal.xBTC(), 150, 20);
    _setAndValidateCapsByGuardian(proposal.WOKB(), 125_000, 1);
    _setAndValidateCapsByGuardian(proposal.xETH(), 5_000, 1_300);
    _setAndValidateCapsByGuardian(proposal.xSOL(), 110_000, 14_000);
  }

  function test_dustBinHasFunds() public {
    GovV3Helpers.executePayload(vm, address(proposal));

    _validateDustbinFundsAndLMAdmin(proposal.USDT0(), proposal.USDT0_SEED_AMOUNT());
    _validateDustbinFundsAndLMAdmin(proposal.USDG(), proposal.USDG_SEED_AMOUNT());
    _validateDustbinFundsAndLMAdmin(proposal.xBTC(), proposal.xBTC_SEED_AMOUNT());
    _validateDustbinFundsAndLMAdmin(proposal.WOKB(), proposal.WOKB_SEED_AMOUNT());
    _validateDustbinFundsAndLMAdmin(proposal.xETH(), proposal.xETH_SEED_AMOUNT());
    _validateDustbinFundsAndLMAdmin(proposal.xSOL(), proposal.xSOL_SEED_AMOUNT());
  }

  function test_guardianPoolAdmin() public {
    assertFalse(AaveV3XLayer.ACL_MANAGER.isPoolAdmin(MiscXLayer.PROTOCOL_GUARDIAN));
    executePayload(vm, address(proposal));
    assertTrue(AaveV3XLayer.ACL_MANAGER.isPoolAdmin(MiscXLayer.PROTOCOL_GUARDIAN));
  }

  function test_riskStewardRiskAdmin() public {
    assertFalse(AaveV3XLayer.ACL_MANAGER.isRiskAdmin(AaveV3XLayer.RISK_STEWARD));
    executePayload(vm, address(proposal));
    assertTrue(AaveV3XLayer.ACL_MANAGER.isRiskAdmin(AaveV3XLayer.RISK_STEWARD));
  }

  function test_price_oracle_sentinel() public view {
    assertEq(
      AaveV3XLayer.POOL_ADDRESSES_PROVIDER.getPriceOracleSentinel(),
      AaveV3XLayer.PRICE_ORACLE_SENTINEL
    );
  }

  function _validateDustbinFundsAndLMAdmin(address asset, uint256 seedAmount) internal view {
    (address aToken, , ) = AaveV3XLayer.AAVE_PROTOCOL_DATA_PROVIDER.getReserveTokensAddresses(
      asset
    );
    assertGe(IERC20(aToken).balanceOf(address(AaveV3XLayer.DUST_BIN)), seedAmount);

    assertEq(
      IEmissionManager(AaveV3XLayer.EMISSION_MANAGER).getEmissionAdmin(asset),
      proposal.LM_ADMIN()
    );
    assertEq(
      IEmissionManager(AaveV3XLayer.EMISSION_MANAGER).getEmissionAdmin(aToken),
      proposal.LM_ADMIN()
    );
  }

  function _setAndValidateCapsByGuardian(
    address asset,
    uint256 supplyCap,
    uint256 borrowCap
  ) internal {
    vm.startPrank(MiscXLayer.PROTOCOL_GUARDIAN);
    AaveV3XLayer.POOL_CONFIGURATOR.setSupplyCap(asset, supplyCap);
    AaveV3XLayer.POOL_CONFIGURATOR.setBorrowCap(asset, borrowCap);
    vm.stopPrank();

    (uint256 currentBorrowCap, uint256 currentSupplyCap) = AaveV3XLayer
      .AAVE_PROTOCOL_DATA_PROVIDER
      .getReserveCaps(asset);
    assertEq(currentBorrowCap, borrowCap);
    assertEq(currentSupplyCap, supplyCap);
  }

  function _postSetup() internal {
    // mock funding seed amounts
    deal(proposal.USDT0(), GovernanceV3XLayer.EXECUTOR_LVL_1, proposal.USDT0_SEED_AMOUNT());
    deal(proposal.USDG(), GovernanceV3XLayer.EXECUTOR_LVL_1, proposal.USDG_SEED_AMOUNT());
    deal(proposal.xBTC(), GovernanceV3XLayer.EXECUTOR_LVL_1, proposal.xBTC_SEED_AMOUNT());
    deal(proposal.WOKB(), GovernanceV3XLayer.EXECUTOR_LVL_1, proposal.WOKB_SEED_AMOUNT());
    deal(proposal.xETH(), GovernanceV3XLayer.EXECUTOR_LVL_1, proposal.xETH_SEED_AMOUNT());
    deal(proposal.xSOL(), GovernanceV3XLayer.EXECUTOR_LVL_1, proposal.xSOL_SEED_AMOUNT());
  }
}
