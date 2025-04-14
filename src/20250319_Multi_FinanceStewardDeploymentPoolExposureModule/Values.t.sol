// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Test} from 'forge-std/Test.sol';
import {AaveV2Ethereum, AaveV2EthereumAssets} from 'aave-address-book/AaveV2Ethereum.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {IPriceOracleGetter} from 'aave-address-book/AaveV3.sol';

import {Values} from './Values.sol';

contract ValuesTest is Test {
  uint256 public constant MIN_DOLLAR_VALUE = 100;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 22139430);
  }

  function test_getTokenAmountByDollarValue_18decimals() public view {
    uint256 tokenAmount = Values.getTokenAmountByDollarValue(
      AaveV3EthereumAssets.BAL_UNDERLYING,
      address(AaveV3Ethereum.ORACLE),
      AaveV3EthereumAssets.BAL_DECIMALS,
      MIN_DOLLAR_VALUE
    );

    // BAL/USD is ~1.48 on March 27, 2025
    // $100 worth of BAL is ~67.5 tokens
    assertApproxEqAbs(tokenAmount, 67.5 ether, 1 ether);
  }

  function test_getTokenAmountByDollarValue_6decimals() public view {
    uint256 tokenAmount = Values.getTokenAmountByDollarValue(
      AaveV3EthereumAssets.USDC_UNDERLYING,
      address(AaveV3Ethereum.ORACLE),
      AaveV3EthereumAssets.USDC_DECIMALS,
      MIN_DOLLAR_VALUE
    );

    // USDC is ~$1, so $100 worth of USDC is around 100 tokens
    assertApproxEqAbs(tokenAmount, 100e6, 1e6);
  }

  function test_getTokenAmountByDollarValueEthOracle_18decimals() public view {
    uint256 ethPrice = IPriceOracleGetter(address(AaveV3Ethereum.ORACLE)).getAssetPrice(
      AaveV3EthereumAssets.WETH_UNDERLYING
    );

    // BAL/USD is ~1.48 on March 27, 2025
    // $100 worth of BAL is ~67.5 tokens
    uint256 tokenAmount = Values.getTokenAmountByDollarValueEthOracle(
      AaveV2EthereumAssets.BAL_UNDERLYING,
      address(AaveV2Ethereum.ORACLE),
      AaveV2EthereumAssets.BAL_DECIMALS,
      MIN_DOLLAR_VALUE,
      ethPrice
    );

    assertApproxEqAbs(tokenAmount, 67.5 ether, 1 ether);
  }

  function test_getTokenAmountByDollarValueEthOracle_6decimals() public view {
    uint256 ethPrice = IPriceOracleGetter(address(AaveV3Ethereum.ORACLE)).getAssetPrice(
      AaveV3EthereumAssets.WETH_UNDERLYING
    );

    // USDC is ~$1, so $100 worth of USDC is around 100 tokens
    uint256 tokenAmount = Values.getTokenAmountByDollarValueEthOracle(
      AaveV2EthereumAssets.USDC_UNDERLYING,
      address(AaveV2Ethereum.ORACLE),
      AaveV2EthereumAssets.USDC_DECIMALS,
      MIN_DOLLAR_VALUE,
      ethPrice
    );

    assertApproxEqAbs(tokenAmount, 100e6, 1e6);
  }
}
