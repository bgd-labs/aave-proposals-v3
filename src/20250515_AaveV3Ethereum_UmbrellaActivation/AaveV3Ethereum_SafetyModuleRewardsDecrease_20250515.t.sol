// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';

import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {AaveSafetyModule} from 'aave-address-book/AaveSafetyModule.sol';
import {IStakeToken} from 'aave-address-book/common/IStakeToken.sol';
import {MiscEthereum} from 'aave-address-book/MiscEthereum.sol';

import {ProtocolV3TestBase} from 'aave-helpers/src/ProtocolV3TestBase.sol';

import {AaveV3Ethereum_SafetyModuleRewardsDecrease_20250515} from './AaveV3Ethereum_SafetyModuleRewardsDecrease_20250515.sol';

interface IStkAave {
  function DISTRIBUTION_END() external view returns (uint256);
}

/**
 * @dev Test for AaveV3Ethereum_SafetyModuleRewardsDecrease_20250515
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20250515_AaveV3Ethereum_UmbrellaActivation/AaveV3Ethereum_SafetyModuleRewardsDecrease_20250515.t.sol -vv
 */
contract AaveV3Ethereum_SafetyModuleRewardsDecrease_20250515_Test is ProtocolV3TestBase {
  AaveV3Ethereum_SafetyModuleRewardsDecrease_20250515 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 22581600);
    proposal = new AaveV3Ethereum_SafetyModuleRewardsDecrease_20250515();
  }

  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Ethereum_SafetyModuleRewardsDecrease_20250515',
      AaveV3Ethereum.POOL,
      address(proposal)
    );
  }

  // Emission tests
  /////////////////////////////////////////////////////////////////////////////////////////

  function test_checkEmissionsStkAAVE() public {
    (uint128 emissionPerSecondBeforeStkAave, , ) = IStakeToken(AaveSafetyModule.STK_AAVE).assets(
      AaveSafetyModule.STK_AAVE
    );

    assertEq(emissionPerSecondBeforeStkAave, proposal.CURRENT_AAVE_EMISSION_PER_SECOND_AAVE());

    executePayload(vm, address(proposal));

    (uint128 emissionPerSecondAfterStkAave, , ) = IStakeToken(AaveSafetyModule.STK_AAVE).assets(
      AaveSafetyModule.STK_AAVE
    );

    assertEq(emissionPerSecondAfterStkAave, proposal.AAVE_EMISSION_PER_SECOND_AAVE());
  }

  function test_checkEmissionsStkBPT() public {
    (uint128 emissionPerSecondBeforeStkBPT, , ) = IStakeToken(
      AaveSafetyModule.STK_AAVE_WSTETH_BPTV2
    ).assets(AaveSafetyModule.STK_AAVE_WSTETH_BPTV2);

    assertEq(emissionPerSecondBeforeStkBPT, proposal.CURRENT_AAVE_EMISSION_PER_SECOND_STK_BPT());

    executePayload(vm, address(proposal));

    (uint128 emissionPerSecondAfterStkBPT, , ) = IStakeToken(AaveSafetyModule.STK_AAVE_WSTETH_BPTV2)
      .assets(AaveSafetyModule.STK_AAVE_WSTETH_BPTV2);

    assertEq(emissionPerSecondAfterStkBPT, proposal.AAVE_EMISSION_PER_SECOND_STK_BPT());
  }

  function test_checkEmissionsStkGHO() public {
    (uint128 emissionPerSecondBeforeStkGho, , ) = IStakeToken(AaveSafetyModule.STK_GHO).assets(
      AaveSafetyModule.STK_GHO
    );

    assertEq(emissionPerSecondBeforeStkGho, proposal.CURRENT_AAVE_EMISSION_PER_SECOND_GHO());

    executePayload(vm, address(proposal));

    (uint128 emissionPerSecondAfterStkGho, , ) = IStakeToken(AaveSafetyModule.STK_GHO).assets(
      AaveSafetyModule.STK_GHO
    );

    assertEq(emissionPerSecondAfterStkGho, proposal.AAVE_EMISSION_PER_SECOND_GHO());
  }

  // Distribution end tests
  /////////////////////////////////////////////////////////////////////////////////////////

  function test_checkDistributionEndStkAave() public {
    uint256 distributionEndBefore = IStkAave(AaveSafetyModule.STK_AAVE).DISTRIBUTION_END();

    executePayload(vm, address(proposal));

    uint256 distributionEndAfter = IStkAave(AaveSafetyModule.STK_AAVE).DISTRIBUTION_END();

    assertEq(distributionEndBefore, distributionEndAfter);
  }

  function test_checkDistributionEndStkBPT() public {
    uint256 endTimestampBefore = IStakeToken(AaveSafetyModule.STK_AAVE_WSTETH_BPTV2)
      .distributionEnd();

    assertGt(endTimestampBefore, block.timestamp);

    executePayload(vm, address(proposal));

    uint256 endTimestampAfter = IStakeToken(AaveSafetyModule.STK_AAVE_WSTETH_BPTV2)
      .distributionEnd();

    assertEq(endTimestampBefore, endTimestampAfter);
  }

  function test_checkDistributionEndStkGHO() public {
    uint256 endTimestampBefore = IStakeToken(AaveSafetyModule.STK_GHO).distributionEnd();

    assertGt(endTimestampBefore, block.timestamp);

    executePayload(vm, address(proposal));

    uint256 endTimestampAfter = IStakeToken(AaveSafetyModule.STK_GHO).distributionEnd();

    assertEq(endTimestampAfter, block.timestamp);
  }

  // Allowance check
  /////////////////////////////////////////////////////////////////////////////////////////

  function test_checkAllowanceStkAave() public {
    uint256 allowanceBefore = IERC20(AaveV3EthereumAssets.AAVE_UNDERLYING).allowance(
      MiscEthereum.ECOSYSTEM_RESERVE,
      AaveSafetyModule.STK_AAVE
    );

    executePayload(vm, address(proposal));

    uint256 allowanceAfter = IERC20(AaveV3EthereumAssets.AAVE_UNDERLYING).allowance(
      MiscEthereum.ECOSYSTEM_RESERVE,
      AaveSafetyModule.STK_AAVE
    );

    // allowance wasn't changed
    assertEq(allowanceAfter, allowanceBefore);
  }

  function test_checkAllowanceStkBPT() public {
    uint256 allowanceBefore = IERC20(AaveV3EthereumAssets.AAVE_UNDERLYING).allowance(
      MiscEthereum.ECOSYSTEM_RESERVE,
      AaveSafetyModule.STK_AAVE_WSTETH_BPTV2
    );

    executePayload(vm, address(proposal));

    uint256 allowanceAfter = IERC20(AaveV3EthereumAssets.AAVE_UNDERLYING).allowance(
      MiscEthereum.ECOSYSTEM_RESERVE,
      AaveSafetyModule.STK_AAVE_WSTETH_BPTV2
    );

    assertLt(allowanceAfter, allowanceBefore);
  }

  function test_checkAllowanceStkGHO() public {
    uint256 allowanceBefore = IERC20(AaveV3EthereumAssets.AAVE_UNDERLYING).allowance(
      MiscEthereum.ECOSYSTEM_RESERVE,
      AaveSafetyModule.STK_GHO
    );

    executePayload(vm, address(proposal));

    uint256 allowanceAfter = IERC20(AaveV3EthereumAssets.AAVE_UNDERLYING).allowance(
      MiscEthereum.ECOSYSTEM_RESERVE,
      AaveSafetyModule.STK_GHO
    );

    assertLt(allowanceAfter, allowanceBefore);
  }

  // `MaxSlashablePercentage` check
  /////////////////////////////////////////////////////////////////////////////////////////

  function test_checkMaxSlashablePercentage() public {
    uint256 maxSlashableBPT = IStakeToken(AaveSafetyModule.STK_AAVE_WSTETH_BPTV2)
      .getMaxSlashablePercentage();
    uint256 maxSlashableAave = IStakeToken(AaveSafetyModule.STK_AAVE).getMaxSlashablePercentage();
    uint256 maxSlashableGho = IStakeToken(AaveSafetyModule.STK_GHO).getMaxSlashablePercentage();

    assertEq(maxSlashableBPT, 30_00);
    assertEq(maxSlashableAave, 30_00);
    assertEq(maxSlashableGho, 99_00);

    executePayload(vm, address(proposal));

    uint256 maxSlashableBPTAfter = IStakeToken(AaveSafetyModule.STK_AAVE_WSTETH_BPTV2)
      .getMaxSlashablePercentage();
    uint256 maxSlashableAaveAfter = IStakeToken(AaveSafetyModule.STK_AAVE)
      .getMaxSlashablePercentage();
    uint256 maxSlashableGhoAfter = IStakeToken(AaveSafetyModule.STK_GHO)
      .getMaxSlashablePercentage();

    assertEq(maxSlashableBPTAfter, proposal.STK_BPT_MAX_SLASHABLE_PERCENTAGE());
    assertEq(maxSlashableAaveAfter, proposal.STK_AAVE_MAX_SLASHABLE_PERCENTAGE());
    assertEq(maxSlashableGhoAfter, 0);
  }

  // `Cooldown` check
  /////////////////////////////////////////////////////////////////////////////////////////

  function test_checkCooldownGho() public {
    uint256 cooldownGho = IStakeToken(AaveSafetyModule.STK_GHO).getCooldownSeconds();

    assertEq(cooldownGho, 20 days);

    executePayload(vm, address(proposal));

    uint256 cooldownGhoAfter = IStakeToken(AaveSafetyModule.STK_GHO).getCooldownSeconds();

    assertEq(cooldownGhoAfter, 0);
  }
}
