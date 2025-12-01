// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {UmbrellaEthereum} from 'aave-address-book/UmbrellaEthereum.sol';
import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Ethereum_RenewalOfUmbrellaRewardAllowances_20251201} from './AaveV3Ethereum_RenewalOfUmbrellaRewardAllowances_20251201.sol';

/**
 * @dev Test for AaveV3Ethereum_RenewalOfUmbrellaRewardAllowances_20251201
 * command:
 *  FOUNDRY_PROFILE=test forge test \
 *    --match-path=src/20251201_AaveV3Ethereum_RenewalOfUmbrellaRewardAllowances/AaveV3Ethereum_RenewalOfUmbrellaRewardAllowances_20251201.t.sol \
 *    -vv
 */
contract AaveV3Ethereum_RenewalOfUmbrellaRewardAllowances_20251201_Test is ProtocolV3TestBase {
  AaveV3Ethereum_RenewalOfUmbrellaRewardAllowances_20251201 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 23916170);
    proposal = new AaveV3Ethereum_RenewalOfUmbrellaRewardAllowances_20251201();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Ethereum_RenewalOfUmbrellaRewardAllowances_20251201',
      AaveV3Ethereum.POOL,
      address(proposal)
    );
  }

  function test_allowancesBeforeAfter() public {
    address collector = address(AaveV3Ethereum.COLLECTOR);
    address rewardsController = UmbrellaEthereum.UMBRELLA_REWARDS_CONTROLLER;

    uint256 usdcBefore = IERC20(AaveV3EthereumAssets.USDC_A_TOKEN).allowance(
      collector,
      rewardsController
    );
    uint256 usdtBefore = IERC20(AaveV3EthereumAssets.USDT_A_TOKEN).allowance(
      collector,
      rewardsController
    );
    uint256 wethBefore = IERC20(AaveV3EthereumAssets.WETH_A_TOKEN).allowance(
      collector,
      rewardsController
    );
    uint256 ghoBefore = IERC20(AaveV3EthereumAssets.GHO_UNDERLYING).allowance(
      collector,
      rewardsController
    );

    executePayload(vm, address(proposal));

    uint256 usdcAfter = IERC20(AaveV3EthereumAssets.USDC_A_TOKEN).allowance(
      collector,
      rewardsController
    );
    uint256 usdtAfter = IERC20(AaveV3EthereumAssets.USDT_A_TOKEN).allowance(
      collector,
      rewardsController
    );
    uint256 wethAfter = IERC20(AaveV3EthereumAssets.WETH_A_TOKEN).allowance(
      collector,
      rewardsController
    );
    uint256 ghoAfter = IERC20(AaveV3EthereumAssets.GHO_UNDERLYING).allowance(
      collector,
      rewardsController
    );

    assertEq(
      usdcAfter - usdcBefore,
      proposal.USDC_RENEWAL_ALLOWANCE(),
      'USDC renewal allowance mismatch'
    );
    assertEq(
      usdtAfter - usdtBefore,
      proposal.USDT_RENEWAL_ALLOWANCE(),
      'USDT renewal allowance mismatch'
    );
    assertEq(
      wethAfter - wethBefore,
      proposal.WETH_RENEWAL_ALLOWANCE(),
      'WETH renewal allowance mismatch'
    );
    assertEq(
      ghoAfter - ghoBefore,
      proposal.GHO_RENEWAL_ALLOWANCE(),
      'GHO renewal allowance mismatch'
    );
  }
}
