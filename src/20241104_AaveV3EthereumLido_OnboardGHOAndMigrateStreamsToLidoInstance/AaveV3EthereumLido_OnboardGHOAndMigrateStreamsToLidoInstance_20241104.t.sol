// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers} from 'aave-helpers/src/GovV3Helpers.sol';
import {AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {AaveV3EthereumLido} from 'aave-address-book/AaveV3EthereumLido.sol';
import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3EthereumLido_OnboardGHOAndMigrateStreamsToLidoInstance_20241104} from './AaveV3EthereumLido_OnboardGHOAndMigrateStreamsToLidoInstance_20241104.sol';

/**
 * @dev Test for AaveV3EthereumLido_OnboardGHOAndMigrateStreamsToLidoInstance_20241104
 * command: FOUNDRY_PROFILE=mainnet forge test --match-path=src/20241104_AaveV3EthereumLido_OnboardGHOAndMigrateStreamsToLidoInstance/AaveV3EthereumLido_OnboardGHOAndMigrateStreamsToLidoInstance_20241104.t.sol -vv
 */
contract AaveV3EthereumLido_OnboardGHOAndMigrateStreamsToLidoInstance_20241104_Test is
  ProtocolV3TestBase
{
  AaveV3EthereumLido_OnboardGHOAndMigrateStreamsToLidoInstance_20241104 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 21118528);
    proposal = new AaveV3EthereumLido_OnboardGHOAndMigrateStreamsToLidoInstance_20241104();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3EthereumLido_OnboardGHOAndMigrateStreamsToLidoInstance_20241104',
      AaveV3EthereumLido.POOL,
      address(proposal)
    );
  }

  function test_migrateStream() public {
    uint256[] memory streamIds = new uint256[](4);
    address[] memory recipients = new address[](4);
    uint256[] memory remainingBalances = new uint256[](4);
    uint256[] memory beforeBalances = new uint256[](4);
    uint256[] memory withdrawalBalances = new uint256[](5);
    uint256[] memory startTimes = new uint256[](4);
    uint256[] memory endTimes = new uint256[](4);

    streamIds[0] = proposal.STREAM_0();
    streamIds[1] = proposal.STREAM_1();
    streamIds[2] = proposal.STREAM_2();
    streamIds[3] = proposal.STREAM_3();

    for (uint256 i = 0; i < 4; ++i) {
      (, recipients[i], , , startTimes[i], endTimes[i], remainingBalances[i], ) = AaveV3EthereumLido
        .COLLECTOR
        .getStream(streamIds[i]);
      withdrawalBalances[i] = AaveV3EthereumLido.COLLECTOR.balanceOf(streamIds[i], recipients[i]);
      beforeBalances[i] = IERC20(AaveV3EthereumAssets.GHO_UNDERLYING).balanceOf(recipients[i]);
    }

    GovV3Helpers.executePayload(vm, address(proposal));

    uint256 nextStreamId = AaveV3EthereumLido.COLLECTOR.getNextStreamId();

    for (uint256 i = 0; i < 4; ++i) {
      vm.expectRevert('stream does not exist');
      AaveV3EthereumLido.COLLECTOR.getStream(streamIds[i]);

      assertEq(
        IERC20(AaveV3EthereumAssets.GHO_UNDERLYING).balanceOf(recipients[i]),
        beforeBalances[i] + withdrawalBalances[i]
      );

      (
        ,
        address newRecipient,
        ,
        ,
        uint256 newStartTime,
        uint256 newEndTime,
        uint256 newRemainingBalance,

      ) = AaveV3EthereumLido.COLLECTOR.getStream(nextStreamId - 4 + i);
      assertEq(newRecipient, recipients[i]);
      assertEq(newRemainingBalance, remainingBalances[i] - withdrawalBalances[i]);
      if (block.timestamp < startTimes[i]) {
        assertEq(startTimes[i], newStartTime);
      } else {
        assertEq(block.timestamp, newStartTime);
      }
      assertEq(endTimes[i], newEndTime);
    }
  }

  function test_collectorHasGHOFunds() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    (address aTokenAddress, , ) = AaveV3EthereumLido
      .AAVE_PROTOCOL_DATA_PROVIDER
      .getReserveTokensAddresses(AaveV3EthereumAssets.GHO_UNDERLYING);
    assertGe(
      IERC20(aTokenAddress).balanceOf(address(AaveV3EthereumLido.COLLECTOR)),
      proposal.GHO_SEED_AMOUNT()
    );
  }

  function test_agdAllowance() public {
    uint256 allowance = IERC20(AaveV3EthereumAssets.GHO_UNDERLYING).allowance(
      address(AaveV3EthereumLido.COLLECTOR),
      proposal.AGD_MULTISIG()
    );
    assertGt(allowance, 0);

    GovV3Helpers.executePayload(vm, address(proposal));

    allowance = IERC20(AaveV3EthereumAssets.GHO_UNDERLYING).allowance(
      address(AaveV3EthereumLido.COLLECTOR),
      proposal.AGD_MULTISIG()
    );
    assertEq(allowance, 0);
  }
}
