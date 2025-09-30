// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Ethereum_ARFCSafetyModuleUmbrellaEmissionUpdate_20250918} from './AaveV3Ethereum_ARFCSafetyModuleUmbrellaEmissionUpdate_20250918.sol';
import {IStakeToken} from 'aave-address-book/common/IStakeToken.sol';
import {AaveSafetyModule} from 'aave-address-book/AaveSafetyModule.sol';
import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {MiscEthereum} from 'aave-address-book/MiscEthereum.sol';

/**
 * @dev Test for AaveV3Ethereum_ARFCSafetyModuleUmbrellaEmissionUpdate_20250918
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20250918_AaveV3Ethereum_ARFCSafetyModuleUmbrellaEmissionUpdate/AaveV3Ethereum_ARFCSafetyModuleUmbrellaEmissionUpdate_20250918.t.sol -vv
 */
contract AaveV3Ethereum_ARFCSafetyModuleUmbrellaEmissionUpdate_20250918_Test is ProtocolV3TestBase {
  AaveV3Ethereum_ARFCSafetyModuleUmbrellaEmissionUpdate_20250918 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 23449402);
    proposal = new AaveV3Ethereum_ARFCSafetyModuleUmbrellaEmissionUpdate_20250918();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Ethereum_ARFCSafetyModuleUmbrellaEmissionUpdate_20250918',
      AaveV3Ethereum.POOL,
      address(proposal)
    );
  }

  function test_checkSlashingConfig() public {
    uint256 stkAAVE_before = IStakeToken(AaveSafetyModule.STK_AAVE).getMaxSlashablePercentage();
    uint256 stkABPT_before = IStakeToken(AaveSafetyModule.STK_ABPT).getMaxSlashablePercentage();

    assertGt(stkAAVE_before, 0, 'stkAAVE slashing already 0 before proposal');
    assertGt(stkABPT_before, 0, 'stkABPT slashing already 0 before proposal');

    executePayload(vm, address(proposal));

    uint256 stkAAVE_after = IStakeToken(AaveSafetyModule.STK_AAVE).getMaxSlashablePercentage();
    uint256 stkABPT_after = IStakeToken(AaveSafetyModule.STK_ABPT).getMaxSlashablePercentage();

    assertEq(stkAAVE_after, proposal.NEW_MAX_SLASHING_PCT(), 'stkAAVE slashing not updated');
    assertEq(stkABPT_after, proposal.NEW_MAX_SLASHING_PCT(), 'stkABPT slashing not updated');
  }

  function test_checkCooldownUpdated() public {
    uint256 cooldownBefore = IStakeToken(AaveSafetyModule.STK_AAVE).getCooldownSeconds();
    assertTrue(
      cooldownBefore != proposal.NEW_COOLDOWN_PERIOD_AAVE(),
      'precondition failed: cooldown already equals target'
    );

    executePayload(vm, address(proposal));

    uint256 cooldownAfter = IStakeToken(AaveSafetyModule.STK_AAVE).getCooldownSeconds();
    assertEq(
      cooldownAfter,
      proposal.NEW_COOLDOWN_PERIOD_AAVE(),
      'stkAAVE cooldown not updated to expected value'
    );
  }

  function test_liquiditySafeAllowances() public {
    uint256 awethAllowanceBefore = IERC20(AaveV3EthereumAssets.WETH_A_TOKEN).allowance(
      address(AaveV3Ethereum.COLLECTOR),
      proposal.AAVE_LIQUIDITY_SAFE()
    );
    assertTrue(
      awethAllowanceBefore != proposal.WETH_ALLOWANCE(),
      'aWETH allowance already at target value'
    );
    uint256 aaveAllowanceBefore = IERC20(AaveV3EthereumAssets.AAVE_UNDERLYING).allowance(
      address(MiscEthereum.ECOSYSTEM_RESERVE),
      proposal.AAVE_LIQUIDITY_SAFE()
    );
    assertTrue(
      aaveAllowanceBefore != proposal.AAVE_ALLOWANCE(),
      'AAVE allowance already at target value'
    );

    executePayload(vm, address(proposal));

    uint256 awethAllowanceAfter = IERC20(AaveV3EthereumAssets.WETH_A_TOKEN).allowance(
      address(AaveV3Ethereum.COLLECTOR),
      proposal.AAVE_LIQUIDITY_SAFE()
    );
    assertEq(
      awethAllowanceAfter,
      proposal.WETH_ALLOWANCE(),
      'Collector AAVE_LIQUIDITY_SAFE aWETH allowance not updated'
    );
    uint256 aaveAllowanceAfter = IERC20(AaveV3EthereumAssets.AAVE_UNDERLYING).allowance(
      address(MiscEthereum.ECOSYSTEM_RESERVE),
      proposal.AAVE_LIQUIDITY_SAFE()
    );
    assertEq(
      aaveAllowanceAfter,
      proposal.AAVE_ALLOWANCE(),
      'EcosystemReserve AAVE_LIQUIDITY_SAFE AAVE allowance not updated'
    );
  }
}
