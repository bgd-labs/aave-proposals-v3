// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {MiscEthereum} from 'aave-address-book/MiscEthereum.sol';
import {AaveSafetyModule} from 'aave-address-book/AaveSafetyModule.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';

import {IStakeToken} from './IStakeToken.sol';
import {AaveV3Ethereum_StkABPTEmissionsUpdate_20250417} from './AaveV3Ethereum_StkABPTEmissionsUpdate_20250417.sol';

/**
 * @dev Test for AaveV3Ethereum_StkABPTEmissionsUpdate_20250417
 * command: FOUNDRY_PROFILE=mainnet forge test --match-path=src/20250417_AaveV3Ethereum_StkABPTEmissionsUpdate/AaveV3Ethereum_StkABPTEmissionsUpdate_20250417.t.sol -vv
 */
contract AaveV3Ethereum_StkABPTEmissionsUpdate_20250417_Test is ProtocolV3TestBase {
  AaveV3Ethereum_StkABPTEmissionsUpdate_20250417 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 22288815);
    proposal = new AaveV3Ethereum_StkABPTEmissionsUpdate_20250417();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Ethereum_StkABPTEmissionsUpdate_20250417',
      AaveV3Ethereum.POOL,
      address(proposal)
    );
  }

  function test_checkConfig() public {
    (uint128 emissionPerSecondBeforeStkABPT, , ) = IStakeToken(
      AaveSafetyModule.STK_AAVE_WSTETH_BPTV2
    ).assets(AaveSafetyModule.STK_AAVE_WSTETH_BPTV2);
    uint256 distributionEndBefore = IStakeToken(AaveSafetyModule.STK_AAVE_WSTETH_BPTV2)
      .distributionEnd();

    assertEq(
      emissionPerSecondBeforeStkABPT,
      uint128(360e18) / 1 days,
      'emissions before not equal stkABPT'
    );

    executePayload(vm, address(proposal));

    (
      uint128 emissionPerSecondAfterStkABPT,
      uint128 lastUpdateTimestampAfterStkABPT,

    ) = IStakeToken(AaveSafetyModule.STK_AAVE_WSTETH_BPTV2).assets(
        AaveSafetyModule.STK_AAVE_WSTETH_BPTV2
      );
    uint256 distributionEndAfter = IStakeToken(AaveSafetyModule.STK_AAVE_WSTETH_BPTV2)
      .distributionEnd();

    assertEq(
      emissionPerSecondAfterStkABPT,
      proposal.AAVE_EMISSION_PER_SECOND_STK_ABPT(),
      'emissions after not equal stkABPT'
    );
    assertEq(lastUpdateTimestampAfterStkABPT, block.timestamp);
    assertLt(emissionPerSecondAfterStkABPT, emissionPerSecondBeforeStkABPT);
    assertEq(distributionEndAfter, distributionEndBefore);
  }

  function test_checkRewards_stkABPT() public {
    address abpt = 0x3de27EFa2F1AA663Ae5D458857e731c129069F29;
    address staker = 0xce88686553686DA562CE7Cea497CE749DA109f9F;

    uint256 rewardsPerDay = 350e18;

    executePayload(vm, address(proposal));

    vm.startPrank(staker);
    IERC20(abpt).approve(AaveSafetyModule.STK_AAVE_WSTETH_BPTV2, 1e18);

    IStakeToken(AaveSafetyModule.STK_AAVE_WSTETH_BPTV2).stake(staker, 1e18);

    vm.warp(block.timestamp + 1 days);

    uint256 rewardsBalance = IStakeToken(AaveSafetyModule.STK_AAVE_WSTETH_BPTV2)
      .getTotalRewardsBalance(staker);

    assertTrue(rewardsBalance > 0 && rewardsBalance <= rewardsPerDay);

    vm.stopPrank();
  }

  function test_checkAllowance() public {
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
}
