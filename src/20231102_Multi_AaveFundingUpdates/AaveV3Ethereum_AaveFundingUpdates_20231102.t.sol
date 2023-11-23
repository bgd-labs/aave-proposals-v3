// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers} from 'aave-helpers/GovV3Helpers.sol';
import {GovernanceV3Ethereum} from 'aave-address-book/GovernanceV3Ethereum.sol';
import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {MiscEthereum} from 'aave-address-book/MiscEthereum.sol';
import {AaveV2Ethereum, AaveV2EthereumAssets} from 'aave-address-book/AaveV2Ethereum.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';

import {AaveV3Ethereum_AaveFundingUpdates_20231102} from './AaveV3Ethereum_AaveFundingUpdates_20231102.sol';

/**
 * @dev Test for AaveV3Ethereum_AaveFundingUpdates_20231102
 * command: make test-contract filter=AaveV3Ethereum_AaveFundingUpdates_20231102
 */
contract AaveV3Ethereum_AaveFundingUpdates_20231102_Test is ProtocolV3TestBase {
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

  AaveV3Ethereum_AaveFundingUpdates_20231102 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 18620845);
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

    assertGt(
      IERC20(AaveV2EthereumAssets.UST_UNDERLYING).balanceOf(address(AaveV3Ethereum.COLLECTOR)),
      0
    );

    uint256 balanceATusdBefore = IERC20(AaveV2EthereumAssets.TUSD_A_TOKEN).balanceOf(
      address(AaveV3Ethereum.COLLECTOR)
    );
    assertGt(balanceATusdBefore, 0);

    uint256 balanceABusdBefore = IERC20(AaveV2EthereumAssets.BUSD_A_TOKEN).balanceOf(
      address(AaveV3Ethereum.COLLECTOR)
    );
    assertGt(balanceABusdBefore, 0);

    assertGt(
      IERC20(AaveV2EthereumAssets.GUSD_UNDERLYING).balanceOf(address(AaveV3Ethereum.COLLECTOR)),
      0
    );

    vm.expectEmit(true, true, true, true, MiscEthereum.AAVE_SWAPPER);
    emit SwapRequested(
      proposal.MILKMAN(),
      AaveV3EthereumAssets.DAI_UNDERLYING,
      AaveV3EthereumAssets.GHO_UNDERLYING,
      AaveV3EthereumAssets.DAI_ORACLE,
      proposal.GHO_ORACLE(),
      proposal.DAI_TO_SWAP(),
      address(AaveV3Ethereum.COLLECTOR),
      100
    );

    vm.expectEmit(true, true, true, true, MiscEthereum.AAVE_SWAPPER);
    emit SwapRequested(
      proposal.MILKMAN(),
      AaveV2EthereumAssets.UST_UNDERLYING,
      AaveV2EthereumAssets.USDC_UNDERLYING,
      AaveV2EthereumAssets.UST_ORACLE,
      AaveV2EthereumAssets.USDC_ORACLE,
      IERC20(AaveV2EthereumAssets.UST_UNDERLYING).balanceOf(address(AaveV2Ethereum.COLLECTOR)),
      address(AaveV3Ethereum.COLLECTOR),
      600
    );

    vm.expectEmit(true, true, true, false, MiscEthereum.AAVE_SWAPPER);
    emit SwapRequested(
      proposal.MILKMAN(),
      AaveV2EthereumAssets.TUSD_UNDERLYING,
      AaveV3EthereumAssets.GHO_UNDERLYING,
      proposal.TUSD_USD_FEED(),
      proposal.GHO_ORACLE(),
      IERC20(AaveV2EthereumAssets.TUSD_UNDERLYING).balanceOf(address(AaveV2Ethereum.COLLECTOR)),
      address(AaveV3Ethereum.COLLECTOR),
      300
    );

    vm.expectEmit(true, true, true, false, MiscEthereum.AAVE_SWAPPER);
    emit SwapRequested(
      proposal.MILKMAN(),
      AaveV2EthereumAssets.BUSD_UNDERLYING,
      AaveV3EthereumAssets.GHO_UNDERLYING,
      proposal.BUSD_USD_FEED(),
      proposal.GHO_ORACLE(),
      IERC20(AaveV2EthereumAssets.BUSD_UNDERLYING).balanceOf(address(AaveV2Ethereum.COLLECTOR)),
      address(AaveV3Ethereum.COLLECTOR),
      300
    );

    vm.expectEmit(true, true, true, true, MiscEthereum.AAVE_SWAPPER);
    emit SwapRequested(
      proposal.MILKMAN(),
      AaveV2EthereumAssets.GUSD_UNDERLYING,
      AaveV2EthereumAssets.USDC_UNDERLYING,
      AaveV2EthereumAssets.GUSD_ORACLE,
      AaveV2EthereumAssets.USDC_ORACLE,
      IERC20(AaveV2EthereumAssets.GUSD_UNDERLYING).balanceOf(address(AaveV2Ethereum.COLLECTOR)),
      address(AaveV3Ethereum.COLLECTOR),
      500
    );

    GovV3Helpers.executePayload(vm, address(proposal));

    assertEq(
      balanceDaiBefore - proposal.DAI_TO_DEPOSIT() - proposal.DAI_TO_SWAP(),
      IERC20(AaveV3EthereumAssets.DAI_UNDERLYING).balanceOf(address(AaveV3Ethereum.COLLECTOR))
    );

    // Less than 1,000 aDAI remain after migrating ~37,000
    assertLt(
      IERC20(AaveV2EthereumAssets.DAI_A_TOKEN).balanceOf(address(AaveV3Ethereum.COLLECTOR)),
      1_000e18
    );

    assertEq(
      balanceADaiBeforeV2 + balanceADaiBeforeV3 + proposal.DAI_TO_DEPOSIT(),
      IERC20(AaveV3EthereumAssets.DAI_A_TOKEN).balanceOf(address(AaveV3Ethereum.COLLECTOR))
    );

    assertEq(
      IERC20(AaveV2EthereumAssets.UST_UNDERLYING).balanceOf(address(AaveV3Ethereum.COLLECTOR)),
      0
    );

    assertLt(
      IERC20(AaveV2EthereumAssets.TUSD_A_TOKEN).balanceOf(address(AaveV3Ethereum.COLLECTOR)),
      balanceATusdBefore
    );

    assertLt(
      IERC20(AaveV2EthereumAssets.BUSD_A_TOKEN).balanceOf(address(AaveV3Ethereum.COLLECTOR)),
      balanceABusdBefore
    );

    assertEq(
      IERC20(AaveV2EthereumAssets.GUSD_UNDERLYING).balanceOf(address(AaveV3Ethereum.COLLECTOR)),
      0
    );

    assertEq(IERC20(AaveV3EthereumAssets.DAI_UNDERLYING).balanceOf(address(proposal.SWAPPER())), 0);

    assertEq(
      IERC20(AaveV2EthereumAssets.TUSD_UNDERLYING).balanceOf(address(proposal.SWAPPER())),
      0
    );

    assertEq(
      IERC20(AaveV2EthereumAssets.BUSD_UNDERLYING).balanceOf(address(proposal.SWAPPER())),
      0
    );

    assertEq(IERC20(AaveV2EthereumAssets.UST_UNDERLYING).balanceOf(address(proposal.SWAPPER())), 0);

    assertEq(
      IERC20(AaveV2EthereumAssets.GUSD_UNDERLYING).balanceOf(address(proposal.SWAPPER())),
      0
    );
  }
}
