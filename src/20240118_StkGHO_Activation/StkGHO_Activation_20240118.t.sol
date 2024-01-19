// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {ProtocolV2TestBase, ReserveConfig} from 'aave-helpers/ProtocolV2TestBase.sol';
import {GovV3Helpers} from 'aave-helpers/GovV3Helpers.sol';
import {AaveV3Ethereum} from 'aave-address-book/AaveV3Ethereum.sol';
import 'forge-std/console.sol';
import {StkGHO_Activation_20240118} from './StkGHO_Activation_20240118.sol';
import {IAggregatedStakeToken} from 'stake-token/src/contracts/IAggregatedStakeToken.sol';
import {IStakeToken} from 'stake-token/src/contracts/IStakeToken.sol';
import {MiscEthereum} from 'aave-address-book/MiscEthereum.sol';
import {AaveV3Ethereum} from 'aave-address-book/AaveV3Ethereum.sol';
import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {AaveSafetyModule} from 'aave-address-book/AaveSafetyModule.sol';

/**
 * @dev Test for StkGHO_Activation_20240118
 * command: make test-contract filter=StkGHO_Activation_20240118
 */
contract StkGHO_Activation_20240118_Test is ProtocolV2TestBase {
  uint256 public constant STKGHO_EMISSION_PER_SECOND = 578703703703704; // 50 AAVE/day
  uint256 public constant DISTRIBUTION_DURATION = 3 * 30 * 86400; // three months
  address public constant STKGHO_PROXY = 0x1a88Df1cFe15Af22B3c4c783D4e6F7F9e0C1885d; // AaveSafetyModule.STK_GHO;

  struct Changes {
    address asset;
    uint256 reserveFactor;
  }

  StkGHO_Activation_20240118 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 19040576);

    proposal = new StkGHO_Activation_20240118();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    (uint128 emissionPerSecondBefore, , ) = IAggregatedStakeToken(STKGHO_PROXY).assets(
      AaveV3Ethereum.GHO_TOKEN
    );

    GovV3Helpers.executePayload(vm, address(proposal));
    (
      uint128 emissionPerSecondAfter,
      uint128 lastUpdateTimestampAfter, // uint256 indexAfter

    ) = IAggregatedStakeToken(STKGHO_PROXY).assets(AaveV3Ethereum.GHO_TOKEN);

    // NOTE index is still 0
    assertEq((emissionPerSecondBefore + emissionPerSecondAfter), STKGHO_EMISSION_PER_SECOND);
    assertEq(lastUpdateTimestampAfter, block.timestamp);
  }

  function test_EcosystemCorrectAllowance() public {
    uint256 allowanceBefore = IERC20(AaveV3EthereumAssets.AAVE_UNDERLYING).allowance(
      MiscEthereum.ECOSYSTEM_RESERVE,
      STKGHO_PROXY
    );

    GovV3Helpers.executePayload(vm, address(proposal));

    uint256 allowanceAfter = IERC20(AaveV3EthereumAssets.AAVE_UNDERLYING).allowance(
      MiscEthereum.ECOSYSTEM_RESERVE,
      STKGHO_PROXY
    );

    assertEq(
      (allowanceAfter + allowanceBefore),
      STKGHO_EMISSION_PER_SECOND * DISTRIBUTION_DURATION
    );
  }
}
