// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {AaveV2Ethereum, AaveV2EthereumAssets} from 'aave-address-book/AaveV2Ethereum.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {ProtocolV3TestBase} from 'aave-helpers/src/ProtocolV3TestBase.sol';

import {AaveV2Ethereum_SeptemberFundingUpdatePartA_20241020} from './AaveV2Ethereum_SeptemberFundingUpdatePartA_20241020.sol';

/**
 * @dev Test for AaveV2Ethereum_SeptemberFundingUpdatePartA_20241020
 * command: FOUNDRY_PROFILE=mainnet forge test --match-path=src/20241020_Multi_SeptemberFundingUpdatePartA/AaveV2Ethereum_SeptemberFundingUpdatePartA_20241020.t.sol -vv
 */
contract AaveV2Ethereum_SeptemberFundingUpdatePartA_20241020_Test is ProtocolV3TestBase {
  AaveV2Ethereum_SeptemberFundingUpdatePartA_20241020 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 21010553);
    proposal = new AaveV2Ethereum_SeptemberFundingUpdatePartA_20241020();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV2Ethereum_SeptemberFundingUpdatePartA_20241020',
      AaveV3Ethereum.POOL,
      address(proposal)
    );
  }

  function test_isTokensRescuedV2() external {
    uint256 sUSDCollectorInitialBalance = IERC20(AaveV2EthereumAssets.sUSD_UNDERLYING).balanceOf(
      address(AaveV3Ethereum.COLLECTOR)
    );
    uint256 USDCCollectorInitialBalance = IERC20(AaveV2EthereumAssets.USDC_UNDERLYING).balanceOf(
      address(AaveV3Ethereum.COLLECTOR)
    );

    uint256 sUSDTransferred = IERC20(AaveV2EthereumAssets.sUSD_UNDERLYING).balanceOf(
      AaveV2Ethereum.DEBT_SWAP_ADAPTER
    );
    uint256 USDCTransferred = IERC20(AaveV2EthereumAssets.USDC_UNDERLYING).balanceOf(
      AaveV2Ethereum.DEBT_SWAP_ADAPTER
    );

    executePayload(vm, address(proposal));

    // AaveV2Ethereum current
    assertEq(
      IERC20(AaveV2EthereumAssets.sUSD_UNDERLYING).balanceOf(proposal.DEBT_SWAP_ADAPTER()),
      0,
      'Unexpected sUSD_UNDERLYING remaining'
    );
    assertEq(
      sUSDCollectorInitialBalance + sUSDTransferred,
      IERC20(AaveV2EthereumAssets.sUSD_UNDERLYING).balanceOf(address(AaveV3Ethereum.COLLECTOR)),
      'Unexpected sUSD_UNDERLYING final treasury balance'
    );
    assertEq(
      IERC20(AaveV2EthereumAssets.USDC_UNDERLYING).balanceOf(proposal.DEBT_SWAP_ADAPTER()),
      0,
      'Unexpected USDC_UNDERLYING remaining'
    );
    assertEq(
      USDCCollectorInitialBalance + USDCTransferred,
      IERC20(AaveV2EthereumAssets.USDC_UNDERLYING).balanceOf(address(AaveV3Ethereum.COLLECTOR)),
      'Unexpected USDC_UNDERLYING final treasury balance'
    );
  }

  function test_isTokensRescuedV3() external {
    uint256 USDTCollectorInitialBalance = IERC20(AaveV3EthereumAssets.USDT_UNDERLYING).balanceOf(
      address(AaveV3Ethereum.COLLECTOR)
    );
    uint256 crvUSDCollectorInitialBalance = IERC20(AaveV3EthereumAssets.crvUSD_UNDERLYING)
      .balanceOf(address(AaveV3Ethereum.COLLECTOR));
    uint256 GHOCollectorInitialBalance = IERC20(AaveV3EthereumAssets.GHO_UNDERLYING).balanceOf(
      address(AaveV3Ethereum.COLLECTOR)
    );
    uint256 rETHCollectorInitialBalance = IERC20(AaveV3EthereumAssets.rETH_UNDERLYING).balanceOf(
      address(AaveV3Ethereum.COLLECTOR)
    );
    uint256 WBTCCollectorInitialBalance = IERC20(AaveV3EthereumAssets.WBTC_UNDERLYING).balanceOf(
      address(AaveV3Ethereum.COLLECTOR)
    );

    uint256 USDTTransferred = IERC20(AaveV3EthereumAssets.USDT_UNDERLYING).balanceOf(
      proposal.DEBT_SWAP_ADAPTER_V3()
    );
    uint256 crvUSDTransferred = IERC20(AaveV3EthereumAssets.crvUSD_UNDERLYING).balanceOf(
      proposal.DEBT_SWAP_ADAPTER_V3()
    );
    uint256 GHOTransferred = IERC20(AaveV3EthereumAssets.GHO_UNDERLYING).balanceOf(
      proposal.REPAY_WITH_COLLATERAL_ADAPTER()
    );
    uint256 rETHTransferred = IERC20(AaveV3EthereumAssets.rETH_UNDERLYING).balanceOf(
      proposal.REPAY_WITH_COLLATERAL_ADAPTER()
    );
    uint256 WBTCTransferred = IERC20(AaveV3EthereumAssets.WBTC_UNDERLYING).balanceOf(
      proposal.REPAY_WITH_COLLATERAL_ADAPTER()
    );

    executePayload(vm, address(proposal));

    // AaveV3Ethereum current
    assertEq(
      IERC20(AaveV3EthereumAssets.USDT_UNDERLYING).balanceOf(proposal.DEBT_SWAP_ADAPTER_V3()),
      0,
      'Unexpected USDT_UNDERLYING remaining'
    );
    assertEq(
      USDTCollectorInitialBalance + USDTTransferred,
      IERC20(AaveV3EthereumAssets.USDT_UNDERLYING).balanceOf(address(AaveV3Ethereum.COLLECTOR)),
      'Unexpected USDT_UNDERLYING final treasury balance'
    );
    assertEq(
      IERC20(AaveV3EthereumAssets.crvUSD_UNDERLYING).balanceOf(proposal.DEBT_SWAP_ADAPTER_V3()),
      0,
      'Unexpected crvUSD_UNDERLYING remaining'
    );
    assertEq(
      crvUSDCollectorInitialBalance + crvUSDTransferred,
      IERC20(AaveV3EthereumAssets.crvUSD_UNDERLYING).balanceOf(address(AaveV3Ethereum.COLLECTOR)),
      'Unexpected crvUSD_UNDERLYING final treasury balance'
    );
    assertEq(
      IERC20(AaveV3EthereumAssets.GHO_UNDERLYING).balanceOf(
        proposal.REPAY_WITH_COLLATERAL_ADAPTER()
      ),
      0,
      'Unexpected GHO_UNDERLYING remaining'
    );
    assertEq(
      GHOCollectorInitialBalance + GHOTransferred,
      IERC20(AaveV3EthereumAssets.GHO_UNDERLYING).balanceOf(address(AaveV3Ethereum.COLLECTOR)),
      'Unexpected GHO_UNDERLYING final treasury balance'
    );
    assertEq(
      IERC20(AaveV3EthereumAssets.rETH_UNDERLYING).balanceOf(
        proposal.REPAY_WITH_COLLATERAL_ADAPTER()
      ),
      0,
      'Unexpected rETH_UNDERLYING remaining'
    );
    assertEq(
      rETHCollectorInitialBalance + rETHTransferred,
      IERC20(AaveV3EthereumAssets.rETH_UNDERLYING).balanceOf(address(AaveV3Ethereum.COLLECTOR)),
      'Unexpected rETH_UNDERLYING final treasury balance'
    );
    assertEq(
      IERC20(AaveV3EthereumAssets.WBTC_UNDERLYING).balanceOf(
        proposal.REPAY_WITH_COLLATERAL_ADAPTER()
      ),
      0,
      'Unexpected WBTC_UNDERLYING remaining'
    );
    assertEq(
      WBTCCollectorInitialBalance + WBTCTransferred,
      IERC20(AaveV3EthereumAssets.WBTC_UNDERLYING).balanceOf(address(AaveV3Ethereum.COLLECTOR)),
      'Unexpected WBTC_UNDERLYING final treasury balance'
    );
  }
}