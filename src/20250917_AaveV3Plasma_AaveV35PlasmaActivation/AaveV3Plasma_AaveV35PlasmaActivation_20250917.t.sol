// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers} from 'aave-helpers/src/GovV3Helpers.sol';
import {MiscPlasma} from 'aave-address-book/MiscPlasma.sol';
import {GovernanceV3Plasma} from 'aave-address-book/GovernanceV3Plasma.sol';
import {AaveV3Plasma} from 'aave-address-book/AaveV3Plasma.sol';
import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {ProtocolV3TestBase} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Plasma_AaveV35PlasmaActivation_20250917} from './AaveV3Plasma_AaveV35PlasmaActivation_20250917.sol';
import {IEmissionManager} from 'aave-v3-origin/contracts/rewards/interfaces/IEmissionManager.sol';
import {AggregatorInterface} from 'aave-v3-origin/contracts/dependencies/chainlink/AggregatorInterface.sol';

/**
 * @dev Test for AaveV3Plasma_AaveV35PlasmaActivation_20250917
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20250917_AaveV3Plasma_AaveV35PlasmaActivation/AaveV3Plasma_AaveV35PlasmaActivation_20250917.t.sol -vv
 */
contract AaveV3Plasma_AaveV35PlasmaActivation_20250917_Test is ProtocolV3TestBase {
  AaveV3Plasma_AaveV35PlasmaActivation_20250917 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('plasma'), 1261137);
    proposal = new AaveV3Plasma_AaveV35PlasmaActivation_20250917();

    _postSetup();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Plasma_AaveV35PlasmaActivation_20250917',
      AaveV3Plasma.POOL,
      address(proposal)
    );
  }

  function test_collectorHasFunds() public {
    GovV3Helpers.executePayload(vm, address(proposal));

    _validateCollectorFundsAndLMAdmin(proposal.USDT0(), proposal.USDT0_SEED_AMOUNT());
    _validateCollectorFundsAndLMAdmin(proposal.USDe(), proposal.USDe_SEED_AMOUNT());
    _validateCollectorFundsAndLMAdmin(proposal.sUSDe(), proposal.sUSDe_SEED_AMOUNT());
    _validateCollectorFundsAndLMAdmin(proposal.XAUt0(), proposal.XAUt0_SEED_AMOUNT());
    _validateCollectorFundsAndLMAdmin(proposal.weETH(), proposal.weETH_SEED_AMOUNT());
    _validateCollectorFundsAndLMAdmin(proposal.WETH(), proposal.WETH_SEED_AMOUNT());
  }

  function test_guardianPoolAdmin() public {
    assertFalse(AaveV3Plasma.ACL_MANAGER.isPoolAdmin(MiscPlasma.PROTOCOL_GUARDIAN));
    executePayload(vm, address(proposal));
    assertTrue(AaveV3Plasma.ACL_MANAGER.isPoolAdmin(MiscPlasma.PROTOCOL_GUARDIAN));
  }

  function test_riskStewardRiskAdmin() public {
    assertFalse(AaveV3Plasma.ACL_MANAGER.isRiskAdmin(AaveV3Plasma.RISK_STEWARD));
    executePayload(vm, address(proposal));
    assertTrue(AaveV3Plasma.ACL_MANAGER.isRiskAdmin(AaveV3Plasma.RISK_STEWARD));
  }

  function test_capsIncreaseByGuardian() public {
    GovV3Helpers.executePayload(vm, address(proposal));

    _setAndValidateCapsByGuardian(proposal.USDT0(), 2_200_000_000, 2_00_000_000);
    _setAndValidateCapsByGuardian(proposal.USDe(), 500_000_000, 50_000_000);
    _setAndValidateCapsByGuardian(proposal.sUSDe(), 450_000_000, 1);
    _setAndValidateCapsByGuardian(proposal.XAUt0(), 7_000, 1);
    _setAndValidateCapsByGuardian(proposal.weETH(), 10_000, 1);
    _setAndValidateCapsByGuardian(proposal.WETH(), 80_000, 10_000);
  }

  function _validateCollectorFundsAndLMAdmin(address asset, uint256 seedAmount) internal view {
    (address aToken, , ) = AaveV3Plasma.AAVE_PROTOCOL_DATA_PROVIDER.getReserveTokensAddresses(
      asset
    );
    assertGe(IERC20(aToken).balanceOf(address(AaveV3Plasma.DUST_BIN)), seedAmount);

    assertEq(
      IEmissionManager(AaveV3Plasma.EMISSION_MANAGER).getEmissionAdmin(asset),
      proposal.LM_ADMIN()
    );
    assertEq(
      IEmissionManager(AaveV3Plasma.EMISSION_MANAGER).getEmissionAdmin(aToken),
      proposal.LM_ADMIN()
    );
  }

  function _setAndValidateCapsByGuardian(
    address asset,
    uint256 supplyCap,
    uint256 borrowCap
  ) internal {
    vm.startPrank(MiscPlasma.PROTOCOL_GUARDIAN);
    AaveV3Plasma.POOL_CONFIGURATOR.setSupplyCap(asset, supplyCap);
    AaveV3Plasma.POOL_CONFIGURATOR.setBorrowCap(asset, borrowCap);
    vm.stopPrank();

    (uint256 currentBorrowCap, uint256 currentSupplyCap) = AaveV3Plasma
      .AAVE_PROTOCOL_DATA_PROVIDER
      .getReserveCaps(asset);
    assertEq(currentBorrowCap, borrowCap);
    assertEq(currentSupplyCap, supplyCap);
  }

  function _postSetup() internal {
    // mock increase totalSupply so the defaultTest does not cry because of `PL_SUPPLY_CAP_GT_TOTAL_SUPPLY` require
    vm.mockCall(
      0xdBbB0b5DD13E7AC9C56624834ef193df87b022c3,
      abi.encodeWithSelector(IERC20.totalSupply.selector),
      abi.encode(2_200_000_001)
    );
    vm.mockCall(
      0x5d3a1Ff2b6BAb83b63cd9AD0787074081a52ef34,
      abi.encodeWithSelector(IERC20.totalSupply.selector),
      abi.encode(500_000_001)
    );
    vm.mockCall(
      0x211Cc4DD073734dA055fbF44a2b4667d5E5fE5d2,
      abi.encodeWithSelector(IERC20.totalSupply.selector),
      abi.encode(450_000_001)
    );
    vm.mockCall(
      0x1B64B9025EEbb9A6239575dF9Ea4b9Ac46D4d193,
      abi.encodeWithSelector(IERC20.totalSupply.selector),
      abi.encode(7_001)
    );
    vm.mockCall(
      0xA3D68b74bF0528fdD07263c60d6488749044914b,
      abi.encodeWithSelector(IERC20.totalSupply.selector),
      abi.encode(10_001)
    );
    vm.mockCall(
      0x9895D81bB462A195b4922ED7De0e3ACD007c32CB,
      abi.encodeWithSelector(IERC20.totalSupply.selector),
      abi.encode(80_001)
    );
  }
}
