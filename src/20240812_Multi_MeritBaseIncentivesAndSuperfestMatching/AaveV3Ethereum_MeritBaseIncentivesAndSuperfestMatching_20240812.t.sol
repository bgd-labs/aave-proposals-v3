// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {GovV3Helpers} from 'aave-helpers/src/GovV3Helpers.sol';
import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Ethereum_MeritBaseIncentivesAndSuperfestMatching_20240812} from './AaveV3Ethereum_MeritBaseIncentivesAndSuperfestMatching_20240812.sol';
import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {SafeERC20} from 'solidity-utils/contracts/oz-common/SafeERC20.sol';
/**
 * @dev Test for AaveV3Ethereum_MeritBaseIncentivesAndSuperfestMatching_20240812
 * command: FOUNDRY_PROFILE=mainnet forge test --match-path=src/20240812_Multi_MeritBaseIncentivesAndSuperfestMatching/AaveV3Ethereum_MeritBaseIncentivesAndSuperfestMatching_20240812.t.sol -vv
 */
contract AaveV3Ethereum_MeritBaseIncentivesAndSuperfestMatching_20240812_Test is
  ProtocolV3TestBase
{
  AaveV3Ethereum_MeritBaseIncentivesAndSuperfestMatching_20240812 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 20514462);
    proposal = new AaveV3Ethereum_MeritBaseIncentivesAndSuperfestMatching_20240812();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Ethereum_MeritBaseIncentivesAndSuperfestMatching_20240812',
      AaveV3Ethereum.POOL,
      address(proposal)
    );
  }

  function test_approval() public {
    assertEq(
      IERC20(AaveV3EthereumAssets.USDC_UNDERLYING).allowance(
        address(AaveV3Ethereum.COLLECTOR),
        proposal.ACI_MULTISIG()
      ),
      0
    );

    GovV3Helpers.executePayload(vm, address(proposal));

    assertEq(
      IERC20(AaveV3EthereumAssets.USDC_UNDERLYING).allowance(
        address(AaveV3Ethereum.COLLECTOR),
        proposal.ACI_MULTISIG()
      ),
      proposal.ALLOWANCE()
    );
  }
}
