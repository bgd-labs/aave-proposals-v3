// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';

import {AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {MiscEthereum} from 'aave-address-book/MiscEthereum.sol';
import {AaveSafetyModule} from 'aave-address-book/AaveSafetyModule.sol';
import {ProtocolV3TestBase} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {IStakeToken} from 'aave-address-book/common/IStakeToken.sol';

import {AaveV3Ethereum_SafetyModuleRewardsDecrease_20250515} from './AaveV3Ethereum_SafetyModuleRewardsDecrease_20250515.sol';

/**
 * @dev Test for AaveV3Ethereum_SafetyModuleRewardsDecrease_20250515
 * command: FOUNDRY_PROFILE=mainnet forge test --match-path=src/20250515_AaveV3Ethereum_UmbrellaActivation/AaveV3Ethereum_SafetyModuleRewardsDecrease_20250515.t.sol -vv
 */
contract AaveV3Ethereum_SafetyModuleRewardsDecrease_20250515_Test is ProtocolV3TestBase {
  AaveV3Ethereum_SafetyModuleRewardsDecrease_20250515 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 22517759);
    proposal = new AaveV3Ethereum_SafetyModuleRewardsDecrease_20250515();
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

  // StkAave has almost infinite `distributionEnd`, so test is skipped

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

    // we increase allowance for skipped period + grant for the next 180 days with new rate
    assertGt(allowanceAfter, allowanceBefore);
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
}
