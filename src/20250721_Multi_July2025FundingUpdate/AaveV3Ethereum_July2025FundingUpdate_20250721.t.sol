// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Ethereum} from 'aave-address-book/AaveV3Ethereum.sol';

import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {AaveV3EthereumLidoAssets} from 'aave-address-book/AaveV3EthereumLido.sol';
import {MiscEthereum} from 'aave-address-book/MiscEthereum.sol';
import {ProtocolV3TestBase} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Ethereum_July2025FundingUpdate_20250721} from './AaveV3Ethereum_July2025FundingUpdate_20250721.sol';

/**
 * @dev Test for AaveV3Ethereum_July2025FundingUpdate_20250721
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20250721_Multi_July2025FundingUpdate/AaveV3Ethereum_July2025FundingUpdate_20250721.t.sol -vv
 */
contract AaveV3Ethereum_July2025FundingUpdate_20250721_Test is ProtocolV3TestBase {
  AaveV3Ethereum_July2025FundingUpdate_20250721 internal proposal;

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

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 22962153);
    proposal = new AaveV3Ethereum_July2025FundingUpdate_20250721();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Ethereum_July2025FundingUpdate_20250720',
      AaveV3Ethereum.POOL,
      address(proposal)
    );
  }

  function test_approvals() public {
    uint256 allowanceAEthUSDTBefore = IERC20(AaveV3EthereumAssets.USDT_A_TOKEN).allowance(
      address(AaveV3Ethereum.COLLECTOR),
      proposal.AHAB_SAFE()
    );
    uint256 allowanceAEthUSDCBefore = IERC20(AaveV3EthereumAssets.USDC_A_TOKEN).allowance(
      address(AaveV3Ethereum.COLLECTOR),
      proposal.AHAB_SAFE()
    );
    uint256 allowanceAEthUSDSBefore = IERC20(AaveV3EthereumLidoAssets.USDS_A_TOKEN).allowance(
      address(AaveV3Ethereum.COLLECTOR),
      proposal.AHAB_SAFE()
    );
    uint256 allowanceAEthGHOBefore = IERC20(AaveV3EthereumLidoAssets.GHO_A_TOKEN).allowance(
      address(AaveV3Ethereum.COLLECTOR),
      proposal.AHAB_SAFE()
    );
    assertEq(
      IERC20(AaveV3EthereumAssets.USDT_A_TOKEN).allowance(
        address(AaveV3Ethereum.COLLECTOR),
        proposal.AHAB_SAFE()
      ),
      0
    );
    assertEq(
      IERC20(AaveV3EthereumAssets.USDC_A_TOKEN).allowance(
        address(AaveV3Ethereum.COLLECTOR),
        proposal.AHAB_SAFE()
      ),
      0
    );
    assertEq(
      IERC20(AaveV3EthereumLidoAssets.USDS_A_TOKEN).allowance(
        address(AaveV3Ethereum.COLLECTOR),
        proposal.AHAB_SAFE()
      ),
      0
    );
    assertEq(
      IERC20(AaveV3EthereumLidoAssets.GHO_A_TOKEN).allowance(
        address(AaveV3Ethereum.COLLECTOR),
        proposal.AHAB_SAFE()
      ),
      0
    );

    executePayload(vm, address(proposal));

    uint256 allowanceAEthUSDTAfter = IERC20(AaveV3EthereumAssets.USDT_A_TOKEN).allowance(
      address(AaveV3Ethereum.COLLECTOR),
      proposal.AHAB_SAFE()
    );
    uint256 allowanceAEthUSDCAfter = IERC20(AaveV3EthereumAssets.USDC_A_TOKEN).allowance(
      address(AaveV3Ethereum.COLLECTOR),
      proposal.AHAB_SAFE()
    );
    uint256 allowanceAEthUSDSAfter = IERC20(AaveV3EthereumLidoAssets.USDS_A_TOKEN).allowance(
      address(AaveV3Ethereum.COLLECTOR),
      proposal.AHAB_SAFE()
    );
    uint256 allowanceAEthGHOAfter = IERC20(AaveV3EthereumLidoAssets.GHO_A_TOKEN).allowance(
      address(AaveV3Ethereum.COLLECTOR),
      proposal.AHAB_SAFE()
    );

    assertEq(allowanceAEthUSDTAfter, allowanceAEthUSDTBefore + proposal.AHAB_ALLOWANCE_USDC_USDT());
    assertEq(allowanceAEthUSDCAfter, allowanceAEthUSDCBefore + proposal.AHAB_ALLOWANCE_USDC_USDT());
    assertEq(allowanceAEthUSDSAfter, allowanceAEthUSDSBefore + proposal.AHAB_ALLOWANCE_USDS_GHO());
    assertEq(allowanceAEthGHOAfter, allowanceAEthGHOBefore + proposal.AHAB_ALLOWANCE_USDS_GHO());

    vm.startPrank(proposal.AHAB_SAFE());
    IERC20(AaveV3EthereumAssets.USDT_A_TOKEN).transferFrom(
      address(AaveV3Ethereum.COLLECTOR),
      proposal.AHAB_SAFE(),
      proposal.AHAB_ALLOWANCE_USDC_USDT()
    );
    IERC20(AaveV3EthereumAssets.USDC_A_TOKEN).transferFrom(
      address(AaveV3Ethereum.COLLECTOR),
      proposal.AHAB_SAFE(),
      proposal.AHAB_ALLOWANCE_USDC_USDT()
    );
    IERC20(AaveV3EthereumLidoAssets.USDS_A_TOKEN).transferFrom(
      address(AaveV3Ethereum.COLLECTOR),
      proposal.AHAB_SAFE(),
      proposal.AHAB_ALLOWANCE_USDS_GHO()
    );
    IERC20(AaveV3EthereumLidoAssets.GHO_A_TOKEN).transferFrom(
      address(AaveV3Ethereum.COLLECTOR),
      proposal.AHAB_SAFE(),
      proposal.AHAB_ALLOWANCE_USDS_GHO()
    );
    vm.stopPrank();
  }

  function test_swaps() public {
    vm.expectEmit(true, true, true, true, MiscEthereum.AAVE_SWAPPER);
    emit SwapRequested(
      proposal.MILKMAN(),
      AaveV3EthereumAssets.DAI_UNDERLYING,
      AaveV3EthereumAssets.USDC_UNDERLYING,
      AaveV3EthereumAssets.DAI_ORACLE,
      AaveV3EthereumAssets.USDC_ORACLE,
      1, // Hardcoded as swap is dynamic
      address(AaveV3Ethereum.COLLECTOR),
      150
    );

    vm.expectEmit(true, true, true, true, MiscEthereum.AAVE_SWAPPER);
    emit SwapRequested(
      proposal.MILKMAN(),
      AaveV3EthereumAssets.LUSD_UNDERLYING,
      AaveV3EthereumAssets.USDC_UNDERLYING,
      AaveV3EthereumAssets.LUSD_ORACLE,
      AaveV3EthereumAssets.USDC_ORACLE,
      1, // Hardcoded as swap is dynamic
      address(AaveV3Ethereum.COLLECTOR),
      500
    );

    vm.expectEmit(true, true, true, true, MiscEthereum.AAVE_SWAPPER);
    emit SwapRequested(
      proposal.MILKMAN(),
      AaveV3EthereumAssets.PYUSD_UNDERLYING,
      AaveV3EthereumAssets.USDC_UNDERLYING,
      AaveV3EthereumAssets.PYUSD_ORACLE,
      AaveV3EthereumAssets.USDC_ORACLE,
      1, // Hardcoded as swap is dynamic
      address(AaveV3Ethereum.COLLECTOR),
      200
    );

    executePayload(vm, address(proposal));

    assertEq(
      IERC20(AaveV3EthereumAssets.DAI_UNDERLYING).balanceOf(address(AaveV3Ethereum.COLLECTOR)),
      0
    );

    assertEq(
      IERC20(AaveV3EthereumAssets.LUSD_UNDERLYING).balanceOf(address(AaveV3Ethereum.COLLECTOR)),
      0
    );

    assertEq(
      IERC20(AaveV3EthereumAssets.PYUSD_UNDERLYING).balanceOf(address(AaveV3Ethereum.COLLECTOR)),
      0
    );
  }

  function test_aciRefund() public {
    uint256 balanceBefore = IERC20(AaveV3EthereumAssets.WETH_UNDERLYING).balanceOf(
      MiscEthereum.MASIV_SAFE
    );
  }
}
