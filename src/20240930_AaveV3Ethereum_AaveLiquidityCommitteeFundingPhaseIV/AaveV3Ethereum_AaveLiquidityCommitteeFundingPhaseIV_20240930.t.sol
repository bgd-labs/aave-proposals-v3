// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';

import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Ethereum_AaveLiquidityCommitteeFundingPhaseIV_20240930} from './AaveV3Ethereum_AaveLiquidityCommitteeFundingPhaseIV_20240930.sol';

/**
 * @dev Test for AaveV3Ethereum_AaveLiquidityCommitteeFundingPhaseIV_20240930
 * command: FOUNDRY_PROFILE=mainnet forge test --match-path=src/20240930_AaveV3Ethereum_AaveLiquidityCommitteeFundingPhaseIV/AaveV3Ethereum_AaveLiquidityCommitteeFundingPhaseIV_20240930.t.sol -vv
 */
contract AaveV3Ethereum_AaveLiquidityCommitteeFundingPhaseIV_20240930_Test is ProtocolV3TestBase {
  AaveV3Ethereum_AaveLiquidityCommitteeFundingPhaseIV_20240930 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 20863717);
    proposal = new AaveV3Ethereum_AaveLiquidityCommitteeFundingPhaseIV_20240930();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Ethereum_AaveLiquidityCommitteeFundingPhaseIV_20240930',
      AaveV3Ethereum.POOL,
      address(proposal)
    );
  }

  function test_allowance() public {
    assertEq(
      IERC20(AaveV3EthereumAssets.GHO_UNDERLYING).allowance(
        address(AaveV3Ethereum.COLLECTOR),
        proposal.ALC_SAFE()
      ),
      0
    );

    executePayload(vm, address(proposal));

    assertEq(
      IERC20(AaveV3EthereumAssets.GHO_UNDERLYING).allowance(
        address(AaveV3Ethereum.COLLECTOR),
        proposal.ALC_SAFE()
      ),
      proposal.AMOUNT()
    );

    vm.startPrank(proposal.ALC_SAFE());
    IERC20(AaveV3EthereumAssets.GHO_UNDERLYING).transferFrom(
      address(AaveV3Ethereum.COLLECTOR),
      proposal.ALC_SAFE(),
      proposal.AMOUNT()
    );
    vm.stopPrank();
  }
}
