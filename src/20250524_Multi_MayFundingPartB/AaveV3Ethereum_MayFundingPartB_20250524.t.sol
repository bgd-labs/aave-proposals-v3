// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {AaveV2Ethereum, AaveV2EthereumAssets} from 'aave-address-book/AaveV2Ethereum.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {AaveV3EthereumLidoAssets} from 'aave-address-book/AaveV3EthereumLido.sol';
import {GhoEthereum} from 'aave-address-book/GhoEthereum.sol';
import {GovernanceV3Ethereum} from 'aave-address-book/GovernanceV3Ethereum.sol';
import {MiscEthereum} from 'aave-address-book/MiscEthereum.sol';
import {ProtocolV3TestBase} from 'aave-helpers/src/ProtocolV3TestBase.sol';

import {AaveV3Ethereum_MayFundingPartB_20250524} from './AaveV3Ethereum_MayFundingPartB_20250524.sol';

/**
 * @dev Test for AaveV3Ethereum_MayFundingPartB_20250524
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20250524_Multi_MayFundingPartB/AaveV3Ethereum_MayFundingPartB_20250524.t.sol -vv
 */
contract AaveV3Ethereum_MayFundingPartB_20250524_Test is ProtocolV3TestBase {
  AaveV3Ethereum_MayFundingPartB_20250524 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 22596260);
    proposal = new AaveV3Ethereum_MayFundingPartB_20250524();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest('AaveV3Ethereum_MayFundingPartB_20250524', AaveV3Ethereum.POOL, address(proposal));
  }

  function test_approvals() public {
    assertLt(
      IERC20(AaveV3EthereumLidoAssets.GHO_A_TOKEN).allowance(
        address(AaveV3Ethereum.COLLECTOR),
        proposal.MERIT_AHAB_SAFE()
      ),
      1 ether
    );

    assertEq(
      IERC20(AaveV3EthereumAssets.WETH_A_TOKEN).allowance(
        address(AaveV3Ethereum.COLLECTOR),
        proposal.MERIT_AHAB_SAFE()
      ),
      0
    );

    uint256 balanceRaiBefore = IERC20(AaveV2EthereumAssets.RAI_UNDERLYING).balanceOf(
      address(AaveV3Ethereum.COLLECTOR)
    );
    assertEq(
      IERC20(AaveV2EthereumAssets.RAI_UNDERLYING).allowance(
        address(AaveV3Ethereum.COLLECTOR),
        proposal.AFC_SAFE()
      ),
      0
    );

    uint256 balanceCrvBefore = IERC20(AaveV3EthereumAssets.CRV_UNDERLYING).balanceOf(
      address(AaveV3Ethereum.COLLECTOR)
    );
    assertEq(
      IERC20(AaveV3EthereumAssets.CRV_UNDERLYING).allowance(
        address(AaveV3Ethereum.COLLECTOR),
        proposal.ALC_SAFE()
      ),
      0
    );

    uint256 balanceBalBefore = IERC20(AaveV3EthereumAssets.BAL_UNDERLYING).balanceOf(
      address(AaveV3Ethereum.COLLECTOR)
    );
    assertEq(
      IERC20(AaveV3EthereumAssets.BAL_UNDERLYING).allowance(
        address(AaveV3Ethereum.COLLECTOR),
        proposal.ALC_SAFE()
      ),
      0
    );

    uint256 allowanceAEthUSDCBefore = IERC20(AaveV3EthereumAssets.USDC_A_TOKEN).allowance(
      address(AaveV3Ethereum.COLLECTOR),
      proposal.AFC_SAFE()
    );
    assertEq(
      IERC20(AaveV3EthereumAssets.USDC_A_TOKEN).allowance(
        address(AaveV3Ethereum.COLLECTOR),
        proposal.AFC_SAFE()
      ),
      0
    );

    executePayload(vm, address(proposal));

    uint256 allowanceGhoAfter = IERC20(AaveV3EthereumLidoAssets.GHO_A_TOKEN).allowance(
      address(AaveV3Ethereum.COLLECTOR),
      proposal.MERIT_AHAB_SAFE()
    );

    uint256 allowanceWethAfter = IERC20(AaveV3EthereumAssets.WETH_A_TOKEN).allowance(
      address(AaveV3Ethereum.COLLECTOR),
      proposal.MERIT_AHAB_SAFE()
    );

    uint256 allowanceRaiAfter = IERC20(AaveV2EthereumAssets.RAI_UNDERLYING).allowance(
      address(AaveV3Ethereum.COLLECTOR),
      proposal.AFC_SAFE()
    );

    uint256 allowanceAEthUSDCfter = IERC20(AaveV3EthereumAssets.USDC_A_TOKEN).allowance(
      address(AaveV3Ethereum.COLLECTOR),
      proposal.AFC_SAFE()
    );

    uint256 allowanceCrvAfter = IERC20(AaveV3EthereumAssets.CRV_UNDERLYING).allowance(
      address(AaveV3Ethereum.COLLECTOR),
      proposal.ALC_SAFE()
    );

    uint256 allowanceBalAfter = IERC20(AaveV3EthereumAssets.BAL_UNDERLYING).allowance(
      address(AaveV3Ethereum.COLLECTOR),
      proposal.ALC_SAFE()
    );

    assertEq(allowanceGhoAfter, proposal.MERIT_LIDO_GHO_ALLOWANCE());
    assertEq(allowanceWethAfter, proposal.AHAB_WETH_ALLOWANCE());
    assertEq(allowanceRaiAfter, balanceRaiBefore);
    assertEq(allowanceCrvAfter, balanceCrvBefore);
    assertEq(allowanceBalAfter, balanceBalBefore);
    assertEq(allowanceAEthUSDCfter, allowanceAEthUSDCBefore + proposal.AFC_A_ETH_USDC_ALLOWANCE());

    vm.startPrank(proposal.MERIT_AHAB_SAFE());
    IERC20(AaveV3EthereumLidoAssets.GHO_A_TOKEN).transferFrom(
      address(AaveV3Ethereum.COLLECTOR),
      proposal.MERIT_AHAB_SAFE(),
      proposal.MERIT_LIDO_GHO_ALLOWANCE()
    );
    IERC20(AaveV3EthereumAssets.WETH_A_TOKEN).transferFrom(
      address(AaveV3Ethereum.COLLECTOR),
      proposal.MERIT_AHAB_SAFE(),
      proposal.AHAB_WETH_ALLOWANCE()
    );
    vm.stopPrank();

    vm.startPrank(proposal.AFC_SAFE());
    IERC20(AaveV2EthereumAssets.RAI_UNDERLYING).transferFrom(
      address(AaveV3Ethereum.COLLECTOR),
      proposal.AFC_SAFE(),
      balanceRaiBefore
    );

    IERC20(AaveV3EthereumAssets.USDC_A_TOKEN).transferFrom(
      address(AaveV3Ethereum.COLLECTOR),
      proposal.AFC_SAFE(),
      proposal.AFC_A_ETH_USDC_ALLOWANCE()
    );
    vm.stopPrank();

    vm.startPrank(proposal.ALC_SAFE());
    IERC20(AaveV3EthereumAssets.CRV_UNDERLYING).transferFrom(
      address(AaveV3Ethereum.COLLECTOR),
      proposal.ALC_SAFE(),
      balanceCrvBefore
    );

    IERC20(AaveV3EthereumAssets.BAL_UNDERLYING).transferFrom(
      address(AaveV3Ethereum.COLLECTOR),
      proposal.ALC_SAFE(),
      balanceBalBefore
    );
    vm.stopPrank();
  }

  function test_daiUsdsMigration() public {
    assertGt(
      IERC20(AaveV3EthereumAssets.DAI_UNDERLYING).balanceOf(address(AaveV3Ethereum.COLLECTOR)),
      0
    );
    assertGt(
      IERC20(AaveV3EthereumAssets.DAI_A_TOKEN).balanceOf(address(AaveV3Ethereum.COLLECTOR)),
      0
    );
    assertGt(
      IERC20(AaveV2EthereumAssets.DAI_A_TOKEN).balanceOf(address(AaveV3Ethereum.COLLECTOR)),
      0
    );

    uint256 balanceAUsdsBefore = IERC20(AaveV3EthereumAssets.USDS_A_TOKEN).balanceOf(
      address(AaveV3Ethereum.COLLECTOR)
    );

    executePayload(vm, address(proposal));

    assertEq(
      IERC20(AaveV3EthereumAssets.DAI_UNDERLYING).balanceOf(address(AaveV3Ethereum.COLLECTOR)),
      0
    );

    assertEq(
      IERC20(AaveV3EthereumAssets.DAI_A_TOKEN).balanceOf(address(AaveV3Ethereum.COLLECTOR)),
      0
    );

    // Withdrawing from V2 isn't exact
    assertLt(
      IERC20(AaveV2EthereumAssets.DAI_A_TOKEN).balanceOf(address(AaveV3Ethereum.COLLECTOR)),
      300 ether
    );

    uint256 balanceAUsdsAfter = IERC20(AaveV3EthereumAssets.USDS_A_TOKEN).balanceOf(
      address(AaveV3Ethereum.COLLECTOR)
    );

    assertGt(balanceAUsdsAfter, balanceAUsdsBefore);
  }

  function test_streamMigration() public {
    (
      ,
      ,
      uint256 deposit,
      address tokenAddress,
      ,
      uint256 stopTime,
      uint256 remainingBalance,

    ) = AaveV3Ethereum.COLLECTOR.getStream(proposal.TOKENLOGIC_STREAM_ID());

    uint256 nextCollectorStreamID = AaveV3Ethereum.COLLECTOR.getNextStreamId();

    vm.expectRevert();
    AaveV3Ethereum.COLLECTOR.getStream(nextCollectorStreamID);

    executePayload(vm, address(proposal));

    (
      address newSender,
      address newRecipient,
      uint256 newDeposit,
      address newTokenAddress,
      uint256 newStartTime,
      uint256 newStopTime,
      uint256 newRemainingBalance,

    ) = AaveV3Ethereum.COLLECTOR.getStream(nextCollectorStreamID);

    assertEq(newSender, address(AaveV3Ethereum.COLLECTOR));
    assertEq(newRecipient, proposal.NEW_TOKENLOGIC_SAFE());
    assertNotEq(deposit, newDeposit);
    assertEq(newTokenAddress, AaveV3EthereumLidoAssets.GHO_A_TOKEN);
    assertEq(tokenAddress, newTokenAddress);
    assertEq(newStartTime, block.timestamp);
    assertEq(stopTime, newStopTime);
    assertApproxEqAbs(remainingBalance, newRemainingBalance, 0.0000000001 ether);

    uint256 collectorGhoBalanceBefore = IERC20(AaveV3EthereumLidoAssets.GHO_A_TOKEN).balanceOf(
      address(AaveV3Ethereum.COLLECTOR)
    );
    uint256 receiverGhoBalanceBefore = IERC20(AaveV3EthereumLidoAssets.GHO_A_TOKEN).balanceOf(
      proposal.NEW_TOKENLOGIC_SAFE()
    );

    // Can withdraw post stream all remaining funds
    vm.warp(newStopTime);

    (, , , , , , uint256 remaining, ) = AaveV3Ethereum.COLLECTOR.getStream(nextCollectorStreamID);

    vm.startPrank(proposal.NEW_TOKENLOGIC_SAFE());
    AaveV3Ethereum.COLLECTOR.withdrawFromStream(nextCollectorStreamID, remaining);
    vm.stopPrank();

    assertGt(
      IERC20(AaveV3EthereumLidoAssets.GHO_A_TOKEN).balanceOf(proposal.NEW_TOKENLOGIC_SAFE()),
      receiverGhoBalanceBefore
    );

    assertLt(
      IERC20(AaveV3EthereumLidoAssets.GHO_A_TOKEN).balanceOf(address(AaveV3Ethereum.COLLECTOR)),
      collectorGhoBalanceBefore
    );

    assertEq(
      IERC20(AaveV3EthereumLidoAssets.GHO_A_TOKEN).balanceOf(proposal.NEW_TOKENLOGIC_SAFE()),
      receiverGhoBalanceBefore + newRemainingBalance,
      'Unexpected ending balance'
    );
  }
}
