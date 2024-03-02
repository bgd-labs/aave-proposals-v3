// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {AaveV2Ethereum, AaveV2EthereumAssets} from 'aave-address-book/AaveV2Ethereum.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {MiscEthereum} from 'aave-address-book/MiscEthereum.sol';
import {ProtocolV3TestBase} from 'aave-helpers/ProtocolV3TestBase.sol';

import {AaveV3Ethereum_FundingUpdate_20240224} from './AaveV3Ethereum_FundingUpdate_20240224.sol';

/**
 * @dev Test for AaveV3Ethereum_FundingUpdate_20240224
 * command: make test-contract filter=AaveV3Ethereum_FundingUpdate_20240224
 */
contract AaveV3Ethereum_FundingUpdate_20240224_Test is ProtocolV3TestBase {
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

  AaveV3Ethereum_FundingUpdate_20240224 internal proposal;

  uint256 balanceABUSDBefore;
  uint256 balanceAUSDCBefore;
  uint256 balanceEthAWBTCBefore;
  uint256 balanceEthAWETHBefore;
  uint256 balanceEthAUSDCBefore;
  uint256 balanceAEthUSDTBefore;
  uint256 balanceAEthUSDCBefore;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 19300831);
    proposal = new AaveV3Ethereum_FundingUpdate_20240224();
  }

  function test_execution() public {
    _assertPreTransferCRVBAL();
    _assertPreMigration();
    _assertPreSwaps();
    _expectEmits();

    executePayload(vm, address(proposal));

    _assertPostTransferCRVBAL();
    _assertPostMigration();
  }

  function _assertPreTransferCRVBAL() internal {
    assertGt(
      IERC20(AaveV3EthereumAssets.CRV_UNDERLYING).balanceOf(address(AaveV3Ethereum.COLLECTOR)),
      0,
      'pre CRV not greater than zero'
    );
    assertGt(
      IERC20(AaveV3EthereumAssets.BAL_UNDERLYING).balanceOf(address(AaveV3Ethereum.COLLECTOR)),
      0,
      'pre BAL not greater than zero'
    );
    assertGt(
      IERC20(AaveV3EthereumAssets.CRV_A_TOKEN).balanceOf(address(AaveV3Ethereum.COLLECTOR)),
      1 ether,
      'pre aEthCRV not greater than 1'
    );
    assertGt(
      IERC20(AaveV3EthereumAssets.BAL_A_TOKEN).balanceOf(address(AaveV3Ethereum.COLLECTOR)),
      1 ether,
      'pre aEthBal not greater than 1'
    );
    assertGt(
      IERC20(AaveV2EthereumAssets.CRV_A_TOKEN).balanceOf(address(AaveV3Ethereum.COLLECTOR)),
      1 ether,
      'pre aCRV not greater than 1'
    );
    assertGt(
      IERC20(AaveV2EthereumAssets.BAL_A_TOKEN).balanceOf(address(AaveV3Ethereum.COLLECTOR)),
      1 ether,
      'pre aBAL not greater than 1'
    );
  }

  function _assertPostTransferCRVBAL() internal {
    assertEq(
      IERC20(AaveV3EthereumAssets.CRV_UNDERLYING).balanceOf(address(AaveV3Ethereum.COLLECTOR)),
      0,
      'post CRV not equal zero'
    );
    assertEq(
      IERC20(AaveV3EthereumAssets.BAL_UNDERLYING).balanceOf(address(AaveV3Ethereum.COLLECTOR)),
      0,
      'post BAL not equal zero'
    );
    assertApproxEqAbs(
      IERC20(AaveV3EthereumAssets.CRV_A_TOKEN).balanceOf(address(AaveV3Ethereum.COLLECTOR)),
      0,
      1 ether,
      'post aEthCRV not equal to 1'
    );
    assertApproxEqAbs(
      IERC20(AaveV3EthereumAssets.BAL_A_TOKEN).balanceOf(address(AaveV3Ethereum.COLLECTOR)),
      0,
      1 ether,
      'post aEthBAL not equal to 1'
    );
    assertApproxEqAbs(
      IERC20(AaveV2EthereumAssets.CRV_A_TOKEN).balanceOf(address(AaveV3Ethereum.COLLECTOR)),
      155 ether,
      1 ether,
      'post aCRV not equal to 155 ether'
    );
    assertApproxEqAbs(
      IERC20(AaveV2EthereumAssets.BAL_A_TOKEN).balanceOf(address(AaveV3Ethereum.COLLECTOR)),
      4 ether,
      1 ether,
      'post aBAL not equal to 4 ether'
    );
  }

  function _assertPreMigration() internal {
    AaveV3Ethereum_FundingUpdate_20240224.TokenToMigrate[] memory tokens = proposal
      .tokensToMigrate();
    for (uint256 i = 0; i < tokens.length; i++) {
      assertGt(
        IERC20(tokens[i].aToken).balanceOf(address(AaveV3Ethereum.COLLECTOR)),
        tokens[i].qty
      );
    }

    balanceAUSDCBefore = IERC20(AaveV2EthereumAssets.USDC_A_TOKEN).balanceOf(
      address(AaveV3Ethereum.COLLECTOR)
    );
    balanceEthAWBTCBefore = IERC20(AaveV3EthereumAssets.WBTC_A_TOKEN).balanceOf(
      address(AaveV3Ethereum.COLLECTOR)
    );
    balanceEthAWETHBefore = IERC20(AaveV3EthereumAssets.WETH_A_TOKEN).balanceOf(
      address(AaveV3Ethereum.COLLECTOR)
    );
    balanceEthAUSDCBefore = IERC20(AaveV3EthereumAssets.USDC_A_TOKEN).balanceOf(
      address(AaveV3Ethereum.COLLECTOR)
    );
  }

  function _assertPostMigration() internal {
    AaveV3Ethereum_FundingUpdate_20240224.TokenToMigrate[] memory tokens = proposal
      .tokensToMigrate();
    for (uint256 i = 0; i < 2; i++) {
      assertApproxEqAbs(
        IERC20(tokens[i].aToken).balanceOf(address(AaveV3Ethereum.COLLECTOR)),
        1 ether,
        1 ether
      );
    }

    assertLt(
      IERC20(AaveV2EthereumAssets.USDC_A_TOKEN).balanceOf(address(AaveV3Ethereum.COLLECTOR)),
      balanceAUSDCBefore
    );

    assertGt(
      IERC20(AaveV3EthereumAssets.WBTC_A_TOKEN).balanceOf(address(AaveV3Ethereum.COLLECTOR)),
      balanceEthAWBTCBefore
    );
    assertGt(
      IERC20(AaveV3EthereumAssets.WETH_A_TOKEN).balanceOf(address(AaveV3Ethereum.COLLECTOR)),
      balanceEthAWETHBefore
    );
    assertGt(
      IERC20(AaveV3EthereumAssets.USDC_A_TOKEN).balanceOf(address(AaveV3Ethereum.COLLECTOR)),
      balanceEthAUSDCBefore - proposal.USDC_V3_TO_SWAP()
    );
  }

  function _assertPreSwaps() internal {
    AaveV3Ethereum_FundingUpdate_20240224.TokenToSwap[] memory tokens = proposal
      .aTokensToWithdraw();
    for (uint256 i = 0; i < tokens.length; i++) {
      assertGt(IERC20(tokens[i].aToken).balanceOf(address(AaveV3Ethereum.COLLECTOR)), 0);
    }

    balanceAEthUSDCBefore = IERC20(AaveV3EthereumAssets.USDC_A_TOKEN).balanceOf(
      address(AaveV3Ethereum.COLLECTOR)
    );
    balanceAEthUSDTBefore = IERC20(AaveV3EthereumAssets.USDT_A_TOKEN).balanceOf(
      address(AaveV3Ethereum.COLLECTOR)
    );
    balanceABUSDBefore = IERC20(AaveV2EthereumAssets.BUSD_A_TOKEN).balanceOf(
      address(AaveV3Ethereum.COLLECTOR)
    );
  }

  function _assertPostSwaps() internal {
    AaveV3Ethereum_FundingUpdate_20240224.TokenToSwap[] memory tokens = proposal
      .aTokensToWithdraw();
    for (uint256 i = 0; i < tokens.length; i++) {
      assertApproxEqAbs(
        IERC20(tokens[i].aToken).balanceOf(address(AaveV3Ethereum.COLLECTOR)),
        1 ether,
        1
      );
    }

    assertApproxEqAbs(
      IERC20(AaveV3EthereumAssets.USDC_A_TOKEN).balanceOf(address(AaveV3Ethereum.COLLECTOR)),
      balanceAEthUSDCBefore - proposal.USDC_V3_TO_SWAP() + proposal.USDC_V2_TO_MIGRATE(),
      1
    );
    assertApproxEqAbs(
      IERC20(AaveV3EthereumAssets.USDT_A_TOKEN).balanceOf(address(AaveV3Ethereum.COLLECTOR)),
      balanceAEthUSDTBefore - proposal.USDT_V3_TO_SWAP(),
      1
    );
    assertApproxEqAbs(
      IERC20(AaveV2EthereumAssets.BUSD_A_TOKEN).balanceOf(address(AaveV3Ethereum.COLLECTOR)),
      balanceABUSDBefore - proposal.BUSD_V2_TO_SWAP(),
      1
    );
  }

  function _expectEmits() internal {
    AaveV3Ethereum_FundingUpdate_20240224.TokenToSwap[] memory tokens = proposal
      .aTokensToWithdraw();
    for (uint256 i = 0; i < tokens.length; i++) {
      vm.expectEmit(true, true, false, false, MiscEthereum.AAVE_SWAPPER);
      emit SwapRequested(
        proposal.MILKMAN(),
        tokens[i].underlying,
        AaveV3EthereumAssets.GHO_UNDERLYING,
        tokens[i].underlying,
        proposal.GHO_ETH_FEED(),
        IERC20(tokens[i].underlying).balanceOf(address(proposal.SWAPPER())),
        address(AaveV3Ethereum.COLLECTOR),
        tokens[i].slippage
      );
    }

    vm.expectEmit(true, true, true, true, MiscEthereum.AAVE_SWAPPER);
    emit SwapRequested(
      proposal.MILKMAN(),
      AaveV3EthereumAssets.USDC_UNDERLYING,
      AaveV3EthereumAssets.GHO_UNDERLYING,
      AaveV3EthereumAssets.USDC_ORACLE,
      proposal.GHO_USD_FEED(),
      proposal.USDC_V3_TO_SWAP(),
      address(AaveV3Ethereum.COLLECTOR),
      50
    );

    vm.expectEmit(true, true, true, true, MiscEthereum.AAVE_SWAPPER);
    emit SwapRequested(
      proposal.MILKMAN(),
      AaveV3EthereumAssets.USDT_UNDERLYING,
      AaveV3EthereumAssets.GHO_UNDERLYING,
      AaveV3EthereumAssets.USDT_ORACLE,
      proposal.GHO_USD_FEED(),
      proposal.USDT_V3_TO_SWAP() + proposal.USDT_V2_TO_SWAP() - 1, // Rounding error on withdrawal
      address(AaveV3Ethereum.COLLECTOR),
      50
    );

    vm.expectEmit(true, true, true, true, MiscEthereum.AAVE_SWAPPER);
    emit SwapRequested(
      proposal.MILKMAN(),
      AaveV2EthereumAssets.BUSD_UNDERLYING,
      AaveV3EthereumAssets.GHO_UNDERLYING,
      proposal.BUSD_USD_FEED(),
      proposal.GHO_USD_FEED(),
      proposal.BUSD_V2_TO_SWAP() - 1, // Rounding error on withdrawal
      address(AaveV3Ethereum.COLLECTOR),
      300
    );
  }
}
