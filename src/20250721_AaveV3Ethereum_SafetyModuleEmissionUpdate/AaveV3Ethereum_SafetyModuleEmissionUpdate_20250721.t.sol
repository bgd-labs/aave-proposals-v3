// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {MiscEthereum} from 'aave-address-book/MiscEthereum.sol';
import {AaveSafetyModule} from 'aave-address-book/AaveSafetyModule.sol';
import {ProtocolV3TestBase} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {IStakeToken} from 'aave-address-book/common/IStakeToken.sol';

import {AaveV3Ethereum_SafetyModuleEmissionUpdate_20250721} from './AaveV3Ethereum_SafetyModuleEmissionUpdate_20250721.sol';

/**
 * @dev Test for AaveV3Ethereum_SafetyModuleEmissionUpdate_20250721
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20250721_AaveV3Ethereum_SafetyModuleEmissionUpdate/AaveV3Ethereum_SafetyModuleEmissionUpdate_20250721.t.sol -vv
 */
contract AaveV3Ethereum_SafetyModuleEmissionUpdate_20250721_Test is ProtocolV3TestBase {
  AaveV3Ethereum_SafetyModuleEmissionUpdate_20250721 internal proposal;

  uint128 public constant CURRENT_AAVE_EMISSION_PER_SECOND_STK_AAVE = uint128(315 ether) / 1 days;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 22967726);
    proposal = new AaveV3Ethereum_SafetyModuleEmissionUpdate_20250721();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Ethereum_SafetyModuleEmissionUpdate_20250721',
      AaveV3Ethereum.POOL,
      address(proposal)
    );
  }

  function test_checkConfig() public {
    (uint128 emissionPerSecondBeforeStkAAVE, , ) = IStakeToken(AaveSafetyModule.STK_AAVE).assets(
      AaveSafetyModule.STK_AAVE
    );

    (uint128 emissionPerSecondBeforeStkBPT, , ) = IStakeToken(
      AaveSafetyModule.STK_AAVE_WSTETH_BPTV2
    ).assets(AaveSafetyModule.STK_AAVE_WSTETH_BPTV2);

    assertEq(
      emissionPerSecondBeforeStkAAVE,
      CURRENT_AAVE_EMISSION_PER_SECOND_STK_AAVE,
      'emissions before not equal stkAAVE'
    );

    assertEq(
      emissionPerSecondBeforeStkBPT,
      proposal.CURRENT_AAVE_EMISSION_PER_SECOND_STK_BPT(),
      'emissions before not equal stkBPT'
    );

    assertEq(IStakeToken(AaveSafetyModule.STK_AAVE).getMaxSlashablePercentage(), 2000);

    assertEq(IStakeToken(AaveSafetyModule.STK_AAVE_WSTETH_BPTV2).getMaxSlashablePercentage(), 2000);

    executePayload(vm, address(proposal));

    (uint128 emissionPerSecondAfterStkAAVE, , ) = IStakeToken(AaveSafetyModule.STK_AAVE).assets(
      AaveSafetyModule.STK_AAVE
    );

    (uint128 emissionPerSecondAfterStkBPT, , ) = IStakeToken(AaveSafetyModule.STK_AAVE_WSTETH_BPTV2)
      .assets(AaveSafetyModule.STK_AAVE_WSTETH_BPTV2);

    assertEq(
      emissionPerSecondAfterStkAAVE,
      proposal.AAVE_EMISSION_PER_SECOND_STK_AAVE(),
      'emissions after not equal stkAAVE'
    );

    assertEq(
      emissionPerSecondAfterStkBPT,
      proposal.AAVE_EMISSION_PER_SECOND_STK_BPT(),
      'emissions after not equal stkBPT'
    );

    assertEq(
      IStakeToken(AaveSafetyModule.STK_AAVE).getMaxSlashablePercentage(),
      proposal.NEW_MAX_SLASHING_PCT()
    );

    assertEq(
      IStakeToken(AaveSafetyModule.STK_AAVE_WSTETH_BPTV2).getMaxSlashablePercentage(),
      proposal.NEW_MAX_SLASHING_PCT()
    );
  }

  function test_checkDistributionEnd() public {
    // stkAAVE has no distribution end date

    uint256 endTimestampBeforeStkABPT = IStakeToken(AaveSafetyModule.STK_AAVE_WSTETH_BPTV2)
      .distributionEnd();

    assertGt(
      endTimestampBeforeStkABPT,
      block.timestamp,
      'New distribution duration is lower than current timestamp stkABPT'
    );

    executePayload(vm, address(proposal));

    uint256 endTimestampAfterStkABPT = IStakeToken(AaveSafetyModule.STK_AAVE_WSTETH_BPTV2)
      .distributionEnd();

    assertGt(
      endTimestampAfterStkABPT,
      endTimestampBeforeStkABPT,
      'New distribution duration not greater stkABPT'
    );
  }

  function test_checkAllowance() public {
    uint256 allowanceBeforeStkAAVE = IERC20(AaveV3EthereumAssets.AAVE_UNDERLYING).allowance(
      MiscEthereum.ECOSYSTEM_RESERVE,
      AaveSafetyModule.STK_AAVE
    );

    uint256 allowanceBeforeStkABPT = IERC20(AaveV3EthereumAssets.AAVE_UNDERLYING).allowance(
      MiscEthereum.ECOSYSTEM_RESERVE,
      AaveSafetyModule.STK_AAVE_WSTETH_BPTV2
    );

    executePayload(vm, address(proposal));

    uint256 allowanceAfterStkAAVE = IERC20(AaveV3EthereumAssets.AAVE_UNDERLYING).allowance(
      MiscEthereum.ECOSYSTEM_RESERVE,
      AaveSafetyModule.STK_AAVE
    );

    uint256 allowanceAfterStkABPT = IERC20(AaveV3EthereumAssets.AAVE_UNDERLYING).allowance(
      MiscEthereum.ECOSYSTEM_RESERVE,
      AaveSafetyModule.STK_AAVE_WSTETH_BPTV2
    );

    // New allowance is less than before
    assertLt(allowanceBeforeStkAAVE, allowanceAfterStkAAVE);
    assertLt(allowanceBeforeStkABPT, allowanceAfterStkABPT);
  }

  function test_checkRewards_stkAAVE() public {
    address stakedToken = AaveV3EthereumAssets.AAVE_UNDERLYING;
    address staker = 0x5a801a9418D036fD453078c3ADCB761fdc5Ae695;
    uint256 rewardsPerDay = 260e18;

    executePayload(vm, address(proposal));

    vm.startPrank(staker);
    IERC20(stakedToken).approve(AaveSafetyModule.STK_AAVE, 1 ether);
    IERC20(stakedToken).balanceOf(staker);
    IStakeToken(AaveSafetyModule.STK_AAVE).stake(staker, 1 ether);
    vm.stopPrank();

    vm.warp(block.timestamp + 1 days);

    uint256 rewardsBalance = IStakeToken(AaveSafetyModule.STK_AAVE).getTotalRewardsBalance(staker);

    assertTrue(rewardsBalance > 0 && rewardsBalance <= rewardsPerDay);

    vm.stopPrank();
  }

  function test_checkRewards_stkBPT() public {
    address stakedToken = 0x3de27EFa2F1AA663Ae5D458857e731c129069F29;
    address staker = 0xce88686553686DA562CE7Cea497CE749DA109f9F;
    uint256 rewardsPerDay = 130e18;

    executePayload(vm, address(proposal));

    vm.startPrank(staker);
    IERC20(stakedToken).approve(AaveSafetyModule.STK_AAVE_WSTETH_BPTV2, 1 ether);
    IERC20(stakedToken).balanceOf(staker);
    IStakeToken(AaveSafetyModule.STK_AAVE_WSTETH_BPTV2).stake(staker, 1 ether);
    vm.stopPrank();

    vm.warp(block.timestamp + 1 days);

    uint256 rewardsBalance = IStakeToken(AaveSafetyModule.STK_AAVE_WSTETH_BPTV2)
      .getTotalRewardsBalance(staker);

    assertTrue(rewardsBalance > 0 && rewardsBalance <= rewardsPerDay);

    vm.stopPrank();
  }
}
