// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import 'forge-std/Test.sol';
import {ProtocolV3TestBase} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {AaveV3EthereumLido, AaveV3EthereumLidoAssets} from 'aave-address-book/AaveV3EthereumLido.sol';
import {AaveV3EthereumEtherFi} from 'aave-address-book/AaveV3EthereumEtherFi.sol';
import {AaveV3Ethereum_RiskStewardsUpdate_20260331} from './AaveV3Ethereum_RiskStewardsUpdate_20260331.sol';
import {IRiskSteward} from 'src/interfaces/IRiskSteward.sol';
import {IRiskStewardEtherFiOld} from './interfaces/IRiskStewardEtherFiOld.sol';
import {RiskStewardUpdateBaseTest} from './RiskStewardUpdateBaseTest.sol';

/**
 * @dev Test for AaveV3Ethereum_RiskStewardsUpdate_20260331
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20260331_Multi_UpgradeAaveInstancesToV37Part2/AaveV3Ethereum_RiskStewardsUpdate_20260331.t.sol -vv
 */
contract AaveV3Ethereum_RiskStewardsUpdate_20260331_Test is
  ProtocolV3TestBase,
  RiskStewardUpdateBaseTest
{
  AaveV3Ethereum_RiskStewardsUpdate_20260331 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 25129927);
    proposal = new AaveV3Ethereum_RiskStewardsUpdate_20260331();
  }

  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Ethereum_RiskStewardsUpdate_20260331',
      AaveV3Ethereum.POOL,
      address(proposal)
    );
  }

  function test_configParity_Core() public view {
    _verifyConfigParity(AaveV3Ethereum.RISK_STEWARD, proposal.NEW_RISK_STEWARD_CORE());
  }

  function test_configParity_Lido() public view {
    _verifyConfigParity(AaveV3EthereumLido.RISK_STEWARD, proposal.NEW_RISK_STEWARD_LIDO());
  }

  /**
   * @dev EtherFi uses an older flat `Config` layout on the on-chain steward, so we decode it
   *      through the EtherFi-specific helper. Fields not present on the old steward
   *      (eMode block, discountRatePendle) are skipped, as is `debtCeiling` (removed in v3.7).
   */
  function test_configParity_EtherFi() public view {
    _verifyConfigParityEtherFi(
      AaveV3EthereumEtherFi.RISK_STEWARD,
      proposal.NEW_RISK_STEWARD_ETHERFI()
    );
  }

  function test_immutablesParity_Core() public view {
    _verifyImmutablesParity(AaveV3Ethereum.RISK_STEWARD, proposal.NEW_RISK_STEWARD_CORE());
  }

  function test_immutablesParity_Lido() public view {
    _verifyImmutablesParity(AaveV3EthereumLido.RISK_STEWARD, proposal.NEW_RISK_STEWARD_LIDO());
  }

  /**
   * @dev EtherFi's old steward predates the `POOL()` getter (it exposes
   *      `POOL_DATA_PROVIDER()` instead), so the POOL comparison is skipped here.
   *      RISK_COUNCIL and owner are still asserted.
   */
  function test_immutablesParity_EtherFi() public view {
    _verifyImmutablesParityEtherFi(
      AaveV3EthereumEtherFi.RISK_STEWARD,
      proposal.NEW_RISK_STEWARD_ETHERFI()
    );
  }

  function test_riskAdminRotated_Core() public {
    executePayload(vm, address(proposal));
    assertTrue(
      AaveV3Ethereum.ACL_MANAGER.isRiskAdmin(proposal.NEW_RISK_STEWARD_CORE()),
      'new core steward not risk admin'
    );
    assertFalse(
      AaveV3Ethereum.ACL_MANAGER.isRiskAdmin(AaveV3Ethereum.RISK_STEWARD),
      'old core steward still risk admin'
    );
  }

  function test_riskAdminRotated_Lido() public {
    executePayload(vm, address(proposal));
    assertTrue(
      AaveV3EthereumLido.ACL_MANAGER.isRiskAdmin(proposal.NEW_RISK_STEWARD_LIDO()),
      'new prime steward not risk admin'
    );
    assertFalse(
      AaveV3EthereumLido.ACL_MANAGER.isRiskAdmin(AaveV3EthereumLido.RISK_STEWARD),
      'old prime steward still risk admin'
    );
  }

  function test_riskAdminRotated_EtherFi() public {
    executePayload(vm, address(proposal));
    assertTrue(
      AaveV3EthereumEtherFi.ACL_MANAGER.isRiskAdmin(proposal.NEW_RISK_STEWARD_ETHERFI()),
      'new etherfi steward not risk admin'
    );
    assertFalse(
      AaveV3EthereumEtherFi.ACL_MANAGER.isRiskAdmin(AaveV3EthereumEtherFi.RISK_STEWARD),
      'old etherfi steward still risk admin'
    );
  }

  function test_ghoBlacklisted_Core() public {
    executePayload(vm, address(proposal));
    assertTrue(
      IRiskSteward(proposal.NEW_RISK_STEWARD_CORE()).isAddressRestricted(
        AaveV3EthereumAssets.GHO_UNDERLYING
      ),
      'GHO not restricted on Core steward'
    );
  }

  function test_ghoBlacklisted_Lido() public {
    executePayload(vm, address(proposal));
    assertTrue(
      IRiskSteward(proposal.NEW_RISK_STEWARD_LIDO()).isAddressRestricted(
        AaveV3EthereumLidoAssets.GHO_UNDERLYING
      ),
      'GHO not restricted on Prime steward'
    );
  }

  /**
   * @dev EtherFi-specific config parity. The old EtherFi steward uses an older flat `Config`
   *      layout (no `CollateralConfig` / `EmodeConfig` sub-structs, no eMode block, no
   *      `discountRatePendle`), so we decode it through a dedicated interface and only compare
   *      the fields that exist on both sides. `debtCeiling` is also skipped (removed in v3.7).
   */
  function _verifyConfigParityEtherFi(address oldSteward, address newSteward) internal view {
    IRiskStewardEtherFiOld.Config memory oldConfig = IRiskStewardEtherFiOld(oldSteward)
      .getRiskConfig();
    IRiskSteward.Config memory newConfig = IRiskSteward(newSteward).getRiskConfig();

    // collateral (debtCeiling intentionally skipped — removed in v3.7)
    _assertParamEqEtherFi(oldConfig.ltv, newConfig.collateralConfig.ltv, 'collateral.ltv');
    _assertParamEqEtherFi(
      oldConfig.liquidationThreshold,
      newConfig.collateralConfig.liquidationThreshold,
      'collateral.liquidationThreshold'
    );
    _assertParamEqEtherFi(
      oldConfig.liquidationBonus,
      newConfig.collateralConfig.liquidationBonus,
      'collateral.liquidationBonus'
    );

    // rates
    _assertParamEqEtherFi(
      oldConfig.baseVariableBorrowRate,
      newConfig.rateConfig.baseVariableBorrowRate,
      'rate.baseVariableBorrowRate'
    );
    _assertParamEqEtherFi(
      oldConfig.variableRateSlope1,
      newConfig.rateConfig.variableRateSlope1,
      'rate.variableRateSlope1'
    );
    _assertParamEqEtherFi(
      oldConfig.variableRateSlope2,
      newConfig.rateConfig.variableRateSlope2,
      'rate.variableRateSlope2'
    );
    _assertParamEqEtherFi(
      oldConfig.optimalUsageRatio,
      newConfig.rateConfig.optimalUsageRatio,
      'rate.optimalUsageRatio'
    );

    // caps
    _assertParamEqEtherFi(oldConfig.supplyCap, newConfig.capConfig.supplyCap, 'cap.supplyCap');
    _assertParamEqEtherFi(oldConfig.borrowCap, newConfig.capConfig.borrowCap, 'cap.borrowCap');

    // price caps (no discountRatePendle on the old EtherFi steward — skipped)
    _assertParamEqEtherFi(
      oldConfig.priceCapLst,
      newConfig.priceCapConfig.priceCapLst,
      'priceCap.priceCapLst'
    );
    _assertParamEqEtherFi(
      oldConfig.priceCapStable,
      newConfig.priceCapConfig.priceCapStable,
      'priceCap.priceCapStable'
    );
  }

  /**
   * @dev EtherFi-specific immutables parity. The old EtherFi steward predates the `POOL()`
   *      getter (it exposes `POOL_DATA_PROVIDER()` instead), so the POOL comparison is
   *      intentionally skipped. RISK_COUNCIL and owner still match.
   */
  function _verifyImmutablesParityEtherFi(address oldSteward, address newSteward) internal view {
    assertEq(
      IRiskStewardEtherFiOld(oldSteward).RISK_COUNCIL(),
      IRiskSteward(newSteward).RISK_COUNCIL(),
      'RISK_COUNCIL mismatch'
    );
    assertEq(
      IRiskStewardEtherFiOld(oldSteward).owner(),
      IRiskSteward(newSteward).owner(),
      'owner mismatch'
    );
  }

  function _assertParamEqEtherFi(
    IRiskStewardEtherFiOld.RiskParamConfig memory a,
    IRiskSteward.RiskParamConfig memory b,
    string memory label
  ) internal pure {
    assertEq(a.minDelay, b.minDelay, string.concat(label, '.minDelay mismatch'));
    assertEq(
      a.maxPercentChange,
      b.maxPercentChange,
      string.concat(label, '.maxPercentChange mismatch')
    );
  }
}
