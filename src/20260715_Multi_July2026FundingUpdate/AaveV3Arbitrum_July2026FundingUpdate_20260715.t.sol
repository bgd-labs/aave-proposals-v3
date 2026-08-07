// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {AaveV3Arbitrum, AaveV3ArbitrumAssets} from 'aave-address-book/AaveV3Arbitrum.sol';
import {MiscArbitrum} from 'aave-address-book/MiscArbitrum.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Arbitrum_July2026FundingUpdate_20260715} from './AaveV3Arbitrum_July2026FundingUpdate_20260715.sol';

/**
 * @dev Test for AaveV3Arbitrum_July2026FundingUpdate_20260715
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20260715_Multi_July2026FundingUpdate/AaveV3Arbitrum_July2026FundingUpdate_20260715.t.sol -vv
 */
contract AaveV3Arbitrum_July2026FundingUpdate_20260715_Test is ProtocolV3TestBase {
  AaveV3Arbitrum_July2026FundingUpdate_20260715 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('arbitrum'), 484112325);
    proposal = new AaveV3Arbitrum_July2026FundingUpdate_20260715();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   * forge-config: default.isolate = true
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Arbitrum_July2026FundingUpdate_20260715',
      AaveV3Arbitrum.POOL,
      address(proposal)
    );
  }

  /**
   * @dev checks whether reserve configurations changed or stayed unchanged as expected
   */
  function test_reserveConfigChanges() public {
    address[] memory updatedAssets = new address[](0);

    reserveConfigChangesTest(AaveV3Arbitrum.POOL, address(proposal), updatedAssets);
  }

  function test_depositETH() public {
    uint256 collectorEthBalanceBefore = address(AaveV3Arbitrum.COLLECTOR).balance;
    assertGt(collectorEthBalanceBefore, 0, 'collector should hold ETH to deposit');

    uint256 aWethBalanceBefore = IERC20(AaveV3ArbitrumAssets.WETH_A_TOKEN).balanceOf(
      address(AaveV3Arbitrum.COLLECTOR)
    );

    executePayload(vm, address(proposal));

    // All of the collector's ETH has been wrapped and deposited.
    assertEq(address(AaveV3Arbitrum.COLLECTOR).balance, 0);
    uint256 aWethBalanceAfter = IERC20(AaveV3ArbitrumAssets.WETH_A_TOKEN).balanceOf(
      address(AaveV3Arbitrum.COLLECTOR)
    );

    // aTokens are minted ~1:1 with the deposited underlying.
    assertApproxEqAbs(
      aWethBalanceAfter,
      aWethBalanceBefore + collectorEthBalanceBefore,
      1,
      'aWETH not minted for the deposited ETH'
    );
  }

  function test_approvals_weth() public {
    assertEq(
      IERC20(AaveV3ArbitrumAssets.WETH_A_TOKEN).allowance(
        address(AaveV3Arbitrum.COLLECTOR),
        MiscArbitrum.AFC_SAFE
      ),
      14000000000000000000
    );
    _assertAllowanceIncrease(AaveV3ArbitrumAssets.WETH_A_TOKEN, proposal.WETH_ALLOWANCE());
  }

  function test_approvals_usdc() public {
    assertEq(
      IERC20(AaveV3ArbitrumAssets.USDCn_A_TOKEN).allowance(
        address(AaveV3Arbitrum.COLLECTOR),
        MiscArbitrum.AFC_SAFE
      ),
      0
    );
    _assertAllowanceIncrease(AaveV3ArbitrumAssets.USDCn_A_TOKEN, proposal.USDCn_ALLOWANCE());
  }

  function test_approvals_usdt() public {
    assertEq(
      IERC20(AaveV3ArbitrumAssets.USDT_A_TOKEN).allowance(
        address(AaveV3Arbitrum.COLLECTOR),
        MiscArbitrum.AFC_SAFE
      ),
      19999999998
    );
    _assertAllowanceIncrease(AaveV3ArbitrumAssets.USDT_A_TOKEN, proposal.USDT_ALLOWANCE());
  }

  function test_approvals_gho() public {
    assertEq(
      IERC20(AaveV3ArbitrumAssets.GHO_A_TOKEN).allowance(
        address(AaveV3Arbitrum.COLLECTOR),
        MiscArbitrum.AFC_SAFE
      ),
      0
    );
    _assertAllowanceIncrease(AaveV3ArbitrumAssets.GHO_A_TOKEN, proposal.GHO_ALLOWANCE());
  }

  function test_approvals_weEth() public {
    uint256 allowanceBefore = IERC20(AaveV3ArbitrumAssets.weETH_A_TOKEN).allowance(
      address(AaveV3Arbitrum.COLLECTOR),
      MiscArbitrum.AFC_SAFE
    );
    assertGt(allowanceBefore, 0);

    executePayload(vm, address(proposal));

    uint256 allowanceAfter = IERC20(AaveV3ArbitrumAssets.weETH_A_TOKEN).allowance(
      address(AaveV3Arbitrum.COLLECTOR),
      MiscArbitrum.AFC_SAFE
    );

    assertEq(allowanceAfter, 0);
  }

  /**
   * @dev the collector's AFC safe allowance is increased by `amount`, so the resulting
   *      allowance must equal the prior allowance plus `amount`.
   */
  function _assertAllowanceIncrease(address aToken, uint256 amount) internal {
    uint256 allowanceBefore = IERC20(aToken).allowance(
      address(AaveV3Arbitrum.COLLECTOR),
      MiscArbitrum.AFC_SAFE
    );

    executePayload(vm, address(proposal));

    uint256 allowanceAfter = IERC20(aToken).allowance(
      address(AaveV3Arbitrum.COLLECTOR),
      MiscArbitrum.AFC_SAFE
    );
    assertEq(allowanceAfter, allowanceBefore + amount);
  }
}
