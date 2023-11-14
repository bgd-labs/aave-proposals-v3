// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {AaveGovernanceV2} from 'aave-address-book/AaveGovernanceV2.sol';
import {GovernanceV3Ethereum} from 'aave-address-book/GovernanceV3Ethereum.sol';
import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {MiscEthereum} from 'aave-address-book/MiscEthereum.sol';
import {AaveV2EthereumArc} from 'aave-address-book/AaveV2EthereumArc.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';

import {AaveV2Ethereum_AaveFundingUpdates_20231102} from './AaveV2Ethereum_AaveFundingUpdates_20231102.sol';
import {WithdrawAndSwapPayload} from './WithdrawAndSwapPayload.sol';

interface IPermissionsManager {
  function addPermissions(uint256[] calldata roles, address[] calldata users)
    external;
  function addPermissionAdmins(address[] calldata admins) external;
}

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
    address[] memory admins = new address[](1);
    admins[0] = GovernanceV3Ethereum.EXECUTOR_LVL_1;

    address[] memory users = new address[](2);
    users[0] = address(AaveV3Ethereum.COLLECTOR);
    users[1] = GovernanceV3Ethereum.EXECUTOR_LVL_1;

    uint256[] memory roles = new uint256[](2);

    vm.startPrank(AaveGovernanceV2.ARC_TIMELOCK);
    IPermissionsManager(0xF4a1F5fEA79C3609514A417425971FadC10eCfBE).addPermissionAdmins(admins);
    vm.stopPrank();

    vm.startPrank(GovernanceV3Ethereum.EXECUTOR_LVL_1);
    IPermissionsManager(0xF4a1F5fEA79C3609514A417425971FadC10eCfBE).addPermissions(roles, users);
    vm.stopPrank();

    uint256 balanceArcUSDCBefore = IERC20(proposal.ARC_USDC()).balanceOf(
      address(AaveV3Ethereum.COLLECTOR)
    );

    assertGt(balanceArcUSDCBefore, 0);

    GovHelpers.executePayload(vm, address(proposal), GovernanceV3Ethereum.EXECUTOR_LVL_1);

    WithdrawAndSwapPayload proposalTwo = WithdrawAndSwapPayload(proposal.withdrawAndSwapPayload());

    vm.expectEmit(true, true, true, true, MiscEthereum.AAVE_SWAPPER);
    emit SwapRequested(
      proposalTwo.MILKMAN(),
      AaveV3EthereumAssets.USDC_UNDERLYING,
      AaveV3EthereumAssets.GHO_UNDERLYING,
      AaveV3EthereumAssets.USDC_ORACLE,
      AaveV3EthereumAssets.GHO_ORACLE,
      IERC20(proposal.ARC_USDC()).balanceOf(address(proposalTwo)),
      address(AaveV3Ethereum.COLLECTOR),
      300
    );

    GovHelpers.executePayload(vm, address(proposal), AaveGovernanceV2.ARC_TIMELOCK);

    assertApproxEqAbs(
      IERC20(proposal.ARC_USDC()).balanceOf(address(AaveV3Ethereum.COLLECTOR)),
      balanceArcUSDCBefore,
      1
    );

    assertEq(IERC20(proposal.ARC_USDC()).balanceOf(address(proposalTwo.SWAPPER())), 0);
  }
}
