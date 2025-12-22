// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Ethereum} from 'aave-address-book/AaveV3Ethereum.sol';
import {ProtocolV3TestBase} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Ethereum_EmissionUpdate_20251219} from './AaveV3Ethereum_EmissionUpdate_20251219.sol';
import {IStakeToken} from 'aave-address-book/common/IStakeToken.sol';
import {AaveSafetyModule} from 'aave-address-book/AaveSafetyModule.sol';
import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {MiscEthereum} from 'aave-address-book/MiscEthereum.sol';
import {AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';

/**
 * @dev Test for AaveV3Ethereum_EmissionUpdate_20251219
 * command:
 * FOUNDRY_PROFILE=mainnet forge test --match-path=src/20251219_AaveV3Ethereum_EmissionUpdate/AaveV3Ethereum_EmissionUpdate_20251219.t.sol -vv
 */
contract AaveV3Ethereum_EmissionUpdate_20251219_Test is ProtocolV3TestBase {
  AaveV3Ethereum_EmissionUpdate_20251219 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 24044627);
    proposal = new AaveV3Ethereum_EmissionUpdate_20251219();
  }

  function test_defaultProposalExecution() public {
    defaultTest('AaveV3Ethereum_EmissionUpdate_20251219', AaveV3Ethereum.POOL, address(proposal));
  }

  function test_checkConfig() public {
    (uint128 emissionPerSecondBefore, , ) = IStakeToken(AaveSafetyModule.STK_AAVE_WSTETH_BPTV2)
      .assets(AaveSafetyModule.STK_AAVE_WSTETH_BPTV2);

    assertEq(
      emissionPerSecondBefore,
      uint128(130 ether) / 1 days,
      'unexpected stkABPT emission rate before'
    );

    executePayload(vm, address(proposal));

    (uint128 emissionPerSecondAfter, , ) = IStakeToken(AaveSafetyModule.STK_AAVE_WSTETH_BPTV2)
      .assets(AaveSafetyModule.STK_AAVE_WSTETH_BPTV2);

    assertEq(
      emissionPerSecondAfter,
      proposal.AAVE_EMISSION_PER_SECOND_STK_BPT(),
      'unexpected stkABPT emission rate after'
    );
  }

  function test_checkAllowance() public {
    uint256 allowanceBefore = IERC20(AaveV3EthereumAssets.AAVE_UNDERLYING).allowance(
      MiscEthereum.ECOSYSTEM_RESERVE,
      AaveSafetyModule.STK_AAVE_WSTETH_BPTV2
    );

    uint256 distributionEnd = IStakeToken(AaveSafetyModule.STK_AAVE_WSTETH_BPTV2).distributionEnd();
    uint256 secondsRemaining = distributionEnd > block.timestamp
      ? distributionEnd - block.timestamp
      : 0;

    uint256 expectedAllowance = uint256(proposal.AAVE_EMISSION_PER_SECOND_STK_BPT()) *
      secondsRemaining;

    executePayload(vm, address(proposal));

    uint256 allowanceAfter = IERC20(AaveV3EthereumAssets.AAVE_UNDERLYING).allowance(
      MiscEthereum.ECOSYSTEM_RESERVE,
      AaveSafetyModule.STK_AAVE_WSTETH_BPTV2
    );

    assertEq(allowanceAfter, expectedAllowance, 'unexpected allowance after');
    assertLt(allowanceAfter, allowanceBefore, 'allowance after should be lower than before');
  }
}
