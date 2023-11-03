// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {GovernanceV3Ethereum} from 'aave-address-book/GovernanceV3Ethereum.sol';
import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {AaveV2Ethereum, AaveV2EthereumAssets} from 'aave-address-book/AaveV2Ethereum.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';

import {AaveV3Ethereum_AaveFundingUpdates_20231102} from './AaveV3Ethereum_AaveFundingUpdates_20231102.sol';

/**
 * @dev Test for AaveV3Ethereum_AaveFundingUpdates_20231102
 * command: make test-contract filter=AaveV3Ethereum_AaveFundingUpdates_20231102
 */
contract AaveV3Ethereum_AaveFundingUpdates_20231102_Test is ProtocolV3TestBase {
  AaveV3Ethereum_AaveFundingUpdates_20231102 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 18486934);
    proposal = new AaveV3Ethereum_AaveFundingUpdates_20231102();
  }

  function test_execute() public {
    uint256 balanceDaiBefore = IERC20(AaveV3EthereumAssets.DAI_UNDERLYING).balanceOf(
      address(AaveV3Ethereum.COLLECTOR)
    );
    uint256 balanceADaiBeforeV2 = IERC20(AaveV2EthereumAssets.DAI_A_TOKEN).balanceOf(
      address(AaveV3Ethereum.COLLECTOR)
    );
    uint256 balanceADaiBeforeV3 = IERC20(AaveV3EthereumAssets.DAI_A_TOKEN).balanceOf(
      address(AaveV3Ethereum.COLLECTOR)
    );
    uint256 balanceAUSDTBeforeV2 = IERC20(AaveV2EthereumAssets.USDT_A_TOKEN).balanceOf(
      address(AaveV3Ethereum.COLLECTOR)
    ) - proposal.USDT_TO_KEEP_V2();
    uint256 balanceAUSDTBeforeV3 = IERC20(AaveV3EthereumAssets.USDT_A_TOKEN).balanceOf(
      address(AaveV3Ethereum.COLLECTOR)
    );

    GovHelpers.executePayload(vm, address(proposal), GovernanceV3Ethereum.EXECUTOR_LVL_1);

    assertEq(
      balanceDaiBefore - proposal.DAI_TO_DEPOSIT(),
      IERC20(AaveV3EthereumAssets.DAI_UNDERLYING).balanceOf(address(AaveV3Ethereum.COLLECTOR))
    );
    assertApproxEqAbs(
      proposal.USDT_TO_KEEP_V2(),
      IERC20(AaveV2EthereumAssets.USDT_A_TOKEN).balanceOf(address(AaveV3Ethereum.COLLECTOR)),
      0.001e18
    );

    // Less than 1,000 aDAI remain after migrating ~37,000
    assertLt(
      IERC20(AaveV2EthereumAssets.DAI_A_TOKEN).balanceOf(address(AaveV3Ethereum.COLLECTOR)),
      1_000e18
    );

    assertEq(
      balanceAUSDTBeforeV2 + balanceAUSDTBeforeV3,
      IERC20(AaveV3EthereumAssets.USDT_A_TOKEN).balanceOf(address(AaveV3Ethereum.COLLECTOR))
    );
    assertEq(
      balanceADaiBeforeV2 + balanceADaiBeforeV3 + proposal.DAI_TO_DEPOSIT(),
      IERC20(AaveV3EthereumAssets.DAI_A_TOKEN).balanceOf(address(AaveV3Ethereum.COLLECTOR))
    );
  }
}
