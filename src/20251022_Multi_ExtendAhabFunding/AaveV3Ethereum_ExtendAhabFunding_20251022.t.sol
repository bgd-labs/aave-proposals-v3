// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {MiscEthereum} from 'aave-address-book/MiscEthereum.sol';
import {ProtocolV3TestBase} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {CollectorUtils} from 'aave-helpers/src/CollectorUtils.sol';

import {AaveV3Ethereum_ExtendAhabFunding_20251022} from './AaveV3Ethereum_ExtendAhabFunding_20251022.sol';

interface IMainnetSwapSteward {
  /// @notice Function to swap one token for another at a time-weighted-average-price
  /// @param fromToken Address of the token to swap
  /// @param toToken Address of the token to receive
  /// @param partSellAmount The amount of tokens to sell per TWAP swap part
  /// @param minPartLimit Minimum amount of toToken to receive per TWAP swap part
  /// @param startTime Timestamp of when TWAP orders start
  /// @param numParts Number of TWAP swap parts to take place (each for partSellAmount)
  /// @param partDuration How long each TWAP takes (ie: hourly, weekly, etc)
  /// @param span The timeframe the orders can take place in
  function twapSwap(
    address fromToken,
    address toToken,
    uint256 partSellAmount,
    uint256 minPartLimit,
    uint256 startTime,
    uint256 numParts,
    uint256 partDuration,
    uint256 span
  ) external;

  function swapApprovedToken(address from, address to) external view returns (bool);

  function priceOracle(address fromToken) external view returns (address);

  function tokenBudget(address token) external view returns (uint256);
}

interface IPoolExposureSteward {
  function withdrawV3(address pool, address reserve, uint256 amount) external;
}

/**
 * @dev Test for AaveV3Ethereum_ExtendAhabFunding_20251022
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20251022_Multi_ExtendAhabFunding/AaveV3Ethereum_ExtendAhabFunding_20251022.t.sol -vv
 */
contract AaveV3Ethereum_ExtendAhabFunding_20251022_Test is ProtocolV3TestBase {
  AaveV3Ethereum_ExtendAhabFunding_20251022 internal proposal;

  /// @notice Emitted when a TWAP Swap order is created
  /// @param fromToken The token that is being swapped from
  /// @param toToken The token that is being swapped for
  /// @param totalAmount The total amount of fromToken that is going to be swapped
  event TWAPSwapRequested(address indexed fromToken, address indexed toToken, uint256 totalAmount);

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 23635048);
    proposal = new AaveV3Ethereum_ExtendAhabFunding_20251022();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Ethereum_ExtendAhabFunding_20251022',
      AaveV3Ethereum.POOL,
      address(proposal)
    );
  }

  function test_allowancesBeforeAfter() public {
    uint256 wethAllowanceBefore = IERC20(AaveV3EthereumAssets.WETH_A_TOKEN).allowance(
      address(AaveV3Ethereum.COLLECTOR),
      MiscEthereum.AHAB_SAFE
    );
    uint256 ghoAllowanceBefore = IERC20(AaveV3EthereumAssets.GHO_A_TOKEN).allowance(
      address(AaveV3Ethereum.COLLECTOR),
      MiscEthereum.AHAB_SAFE
    );
    uint256 usdsAllowanceBefore = IERC20(AaveV3EthereumAssets.USDS_A_TOKEN).allowance(
      address(AaveV3Ethereum.COLLECTOR),
      MiscEthereum.AFC_SAFE
    );

    assertEq(wethAllowanceBefore, 0, 'WETH allowance should be 0 before');
    assertEq(ghoAllowanceBefore, 0, 'GHO allowance should be 0 before');
    assertEq(usdsAllowanceBefore, 0, 'USDS allowance should be 0 before');

    executePayload(vm, address(proposal));

    uint256 wethAllowanceAfter = IERC20(AaveV3EthereumAssets.WETH_A_TOKEN).allowance(
      address(AaveV3Ethereum.COLLECTOR),
      MiscEthereum.AHAB_SAFE
    );
    uint256 ghoAllowanceAfter = IERC20(AaveV3EthereumAssets.GHO_A_TOKEN).allowance(
      address(AaveV3Ethereum.COLLECTOR),
      MiscEthereum.AHAB_SAFE
    );
    uint256 usdsAllowanceAfter = IERC20(AaveV3EthereumAssets.USDS_A_TOKEN).allowance(
      address(AaveV3Ethereum.COLLECTOR),
      MiscEthereum.AFC_SAFE
    );

    assertEq(wethAllowanceAfter, 6_000 ether, 'WETH allowance mismatch');
    assertEq(ghoAllowanceAfter, 10_000_000 ether, 'GHO allowance mismatch');
    assertEq(usdsAllowanceAfter, 5_000_000 ether, 'USDS allowance mismatch');
  }

  function test_setSwappablePairs() public {
    IMainnetSwapSteward steward = IMainnetSwapSteward(AaveV3Ethereum.COLLECTOR_SWAP_STEWARD);
    assertFalse(
      steward.swapApprovedToken(
        AaveV3EthereumAssets.USDC_UNDERLYING,
        AaveV3EthereumAssets.AAVE_UNDERLYING
      )
    );
    assertFalse(
      steward.swapApprovedToken(
        AaveV3EthereumAssets.USDT_UNDERLYING,
        AaveV3EthereumAssets.AAVE_UNDERLYING
      )
    );
    assertFalse(
      steward.swapApprovedToken(
        AaveV3EthereumAssets.USDS_UNDERLYING,
        AaveV3EthereumAssets.AAVE_UNDERLYING
      )
    );

    executePayload(vm, address(proposal));

    assertTrue(
      steward.swapApprovedToken(
        AaveV3EthereumAssets.USDC_UNDERLYING,
        AaveV3EthereumAssets.AAVE_UNDERLYING
      )
    );
    assertTrue(
      steward.swapApprovedToken(
        AaveV3EthereumAssets.USDT_UNDERLYING,
        AaveV3EthereumAssets.AAVE_UNDERLYING
      )
    );
    assertTrue(
      steward.swapApprovedToken(
        AaveV3EthereumAssets.USDS_UNDERLYING,
        AaveV3EthereumAssets.AAVE_UNDERLYING
      )
    );
  }

  function test_twapSwap_USDStoAAVE() public {
    executePayload(vm, address(proposal));

    uint256 budgetBefore = IMainnetSwapSteward(AaveV3Ethereum.COLLECTOR_SWAP_STEWARD).tokenBudget(
      AaveV3EthereumAssets.USDS_UNDERLYING
    );

    // 1,000,000 every 6 hours, for 7 days
    uint256 amount = 35_700 ether;
    uint256 numParts = 28;

    vm.startPrank(MiscEthereum.AFC_SAFE);
    IPoolExposureSteward(AaveV3Ethereum.POOL_EXPOSURE_STEWARD).withdrawV3(
      address(AaveV3Ethereum.POOL),
      AaveV3EthereumAssets.USDS_UNDERLYING,
      amount * numParts
    );

    vm.expectEmit(true, true, true, true, AaveV3Ethereum.COLLECTOR_SWAP_STEWARD);
    emit TWAPSwapRequested(
      AaveV3EthereumAssets.USDS_UNDERLYING,
      AaveV3EthereumAssets.AAVE_UNDERLYING,
      amount * numParts
    );

    IMainnetSwapSteward(AaveV3Ethereum.COLLECTOR_SWAP_STEWARD).twapSwap(
      AaveV3EthereumAssets.USDS_UNDERLYING,
      AaveV3EthereumAssets.AAVE_UNDERLYING,
      amount,
      120 ether, // 35,000 per TWAP, at 220 AAVE is ~159 AAVE, allow min of 120 for increase in price
      block.timestamp,
      numParts,
      6 hours,
      0
    );
    vm.stopPrank();

    assertEq(
      IMainnetSwapSteward(AaveV3Ethereum.COLLECTOR_SWAP_STEWARD).tokenBudget(
        AaveV3EthereumAssets.USDS_UNDERLYING
      ),
      budgetBefore - (amount * numParts)
    );
  }
}
