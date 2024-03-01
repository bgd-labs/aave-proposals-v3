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

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 19300831);
    proposal = new AaveV3Ethereum_FundingUpdate_20240224();
  }

  function test_execution() public {
    _assertPreTransfer();
    _assertPreMigration();
    _assertPreSwaps();

    executePayload(vm, address(proposal));
  }

  function _assertPreTransfer() internal {
    assertGt(
      IERC20(AaveV3EthereumAssets.CRV_UNDERLYING).balanceOf(address(AaveV3Ethereum.COLLECTOR)),
      0
    );
    assertGt(
      IERC20(AaveV3EthereumAssets.BAL_UNDERLYING).balanceOf(address(AaveV3Ethereum.COLLECTOR)),
      0
    );
    assertGt(
      IERC20(AaveV3EthereumAssets.CRV_A_TOKEN).balanceOf(address(AaveV3Ethereum.COLLECTOR)),
      1 ether
    );
    assertGt(
      IERC20(AaveV3EthereumAssets.BAL_A_TOKEN).balanceOf(address(AaveV3Ethereum.COLLECTOR)),
      1 ether
    );
    assertGt(
      IERC20(AaveV2EthereumAssets.CRV_A_TOKEN).balanceOf(address(AaveV3Ethereum.COLLECTOR)),
      1 ether
    );
    assertGt(
      IERC20(AaveV2EthereumAssets.BAL_A_TOKEN).balanceOf(address(AaveV3Ethereum.COLLECTOR)),
      1 ether
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
  }

  function _assertPreSwaps() internal {
    AaveV3Ethereum_FundingUpdate_20240224.TokenToSwap[] memory tokens = proposal
      .aTokensToWithdraw();
    for (uint256 i = 0; i < tokens.length; i++) {
      assertGt(IERC20(tokens[i].aToken).balanceOf(address(AaveV3Ethereum.COLLECTOR)), 0);
    }
  }
}
