// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {AaveGovernanceV2} from 'aave-address-book/AaveGovernanceV2.sol';
import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {MiscEthereum} from 'aave-address-book/MiscEthereum.sol';
import {AaveV2EthereumArc} from 'aave-address-book/AaveV2EthereumArc.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';

import {AaveV2Ethereum_AaveFundingUpdates_20231102} from './AaveV2Ethereum_AaveFundingUpdates_20231102.sol';

/**
 * @dev Test for AaveV3Ethereum_AaveFundingUpdates_20231102
 * command: make test-contract filter=AaveV2Ethereum_AaveFundingUpdates_20231102
 */
contract AaveV2Ethereum_AaveFundingUpdates_20231102_Test is ProtocolV3TestBase {
  event SwapRequested(
    address milkman,
    address indexed fromToken,
    address indexed toToken,
    address fromOracle,
    address toOracle,
    uint256 amount,
    address indexed recipient,
    uint256 slippage
  );

  AaveV2Ethereum_AaveFundingUpdates_20231102 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 18486934);
    proposal = new AaveV2Ethereum_AaveFundingUpdates_20231102();
  }

  function test_execute() public {
    uint256 balanceArcUSDCBefore = IERC20(proposal.ARC_USDC()).balanceOf(
      address(AaveV3Ethereum.COLLECTOR)
    );

    assertGt(balanceArcUSDCBefore, 0);

    vm.expectEmit(true, true, false, false, MiscEthereum.AAVE_SWAPPER);
    emit SwapRequested(
      proposal.MILKMAN(),
      AaveV3EthereumAssets.USDC_UNDERLYING,
      AaveV3EthereumAssets.GHO_UNDERLYING,
      AaveV3EthereumAssets.USDC_ORACLE,
      AaveV3EthereumAssets.GHO_ORACLE,
      IERC20(proposal.ARC_USDC()).balanceOf(address(AaveV3Ethereum.COLLECTOR)),
      address(AaveV3Ethereum.COLLECTOR),
      100
    );

    GovHelpers.executePayload(vm, address(proposal), AaveGovernanceV2.ARC_TIMELOCK);

    assertLt(
      IERC20(proposal.ARC_USDC()).balanceOf(address(AaveV3Ethereum.COLLECTOR)),
      balanceArcUSDCBefore
    );

    assertEq(IERC20(proposal.ARC_USDC()).balanceOf(address(proposal.SWAPPER())), 0);
  }
}
