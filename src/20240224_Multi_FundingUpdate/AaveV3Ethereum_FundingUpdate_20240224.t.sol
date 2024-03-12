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

  struct TokenToMigrate {
    address underlying;
    address aToken;
    uint256 qty;
  }

  struct TokenToSwap {
    address underlying;
    address aToken;
    uint256 balance;
  }

  AaveV3Ethereum_FundingUpdate_20240224 internal proposal;

  uint256 balanceUsdtBefore;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 19363481);
    proposal = new AaveV3Ethereum_FundingUpdate_20240224();
  }

  function test_alcTransfers() public {
    uint256 balanceCRVBeforeALC = IERC20(AaveV3EthereumAssets.CRV_UNDERLYING).balanceOf(
      proposal.ALC_SAFE()
    );
    uint256 balanceBALBeforeALC = IERC20(AaveV3EthereumAssets.CRV_UNDERLYING).balanceOf(
      proposal.ALC_SAFE()
    );
    uint256 balanceCRVBeforeCollector = IERC20(AaveV3EthereumAssets.CRV_UNDERLYING).balanceOf(
      address(AaveV3Ethereum.COLLECTOR)
    );
    uint256 balanceBALBeforeCollector = IERC20(AaveV3EthereumAssets.BAL_UNDERLYING).balanceOf(
      address(AaveV3Ethereum.COLLECTOR)
    );
    uint256 balanceAEthCRVBeforeCollector = IERC20(AaveV2EthereumAssets.CRV_A_TOKEN).balanceOf(
      address(AaveV3Ethereum.COLLECTOR)
    );
    uint256 balanceAEthBALBeforeCollector = IERC20(AaveV2EthereumAssets.BAL_A_TOKEN).balanceOf(
      address(AaveV3Ethereum.COLLECTOR)
    );

    assertGt(balanceCRVBeforeCollector, 0);
    assertGt(balanceBALBeforeCollector, 0);

    executePayload(vm, address(proposal));

    uint256 balanceCRVAfterALC = IERC20(AaveV3EthereumAssets.CRV_UNDERLYING).balanceOf(
      proposal.ALC_SAFE()
    );
    uint256 balanceBALAfterALC = IERC20(AaveV3EthereumAssets.CRV_UNDERLYING).balanceOf(
      proposal.ALC_SAFE()
    );
    uint256 balanceCRVAfterCollector = IERC20(AaveV3EthereumAssets.CRV_UNDERLYING).balanceOf(
      address(AaveV3Ethereum.COLLECTOR)
    );
    uint256 balanceBALAfterCollector = IERC20(AaveV3EthereumAssets.BAL_UNDERLYING).balanceOf(
      address(AaveV3Ethereum.COLLECTOR)
    );

    assertEq(balanceCRVAfterCollector, 0, 'collector CRV balance after not 0');
    assertEq(balanceBALAfterCollector, 0, 'collector BAL balance after not 0');
    assertGt(
      balanceCRVAfterALC,
      balanceCRVBeforeALC + balanceCRVBeforeCollector + balanceAEthCRVBeforeCollector
    );
    assertGt(
      balanceBALAfterALC,
      balanceBALBeforeALC + balanceBALBeforeCollector + balanceAEthBALBeforeCollector
    );
  }

  function test_migrateV2toV3() internal {
    uint256 balanceAUSDCBefore = IERC20(AaveV2EthereumAssets.USDC_A_TOKEN).balanceOf(
      address(AaveV3Ethereum.COLLECTOR)
    );
    uint256 balanceEthAWBTCBefore = IERC20(AaveV3EthereumAssets.WBTC_A_TOKEN).balanceOf(
      address(AaveV3Ethereum.COLLECTOR)
    );
    uint256 balanceEthAWETHBefore = IERC20(AaveV3EthereumAssets.WETH_A_TOKEN).balanceOf(
      address(AaveV3Ethereum.COLLECTOR)
    );
    uint256 balanceEthAUSDCBefore = IERC20(AaveV3EthereumAssets.USDC_A_TOKEN).balanceOf(
      address(AaveV3Ethereum.COLLECTOR)
    );

    executePayload(vm, address(proposal));

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

  function test_withdrawV2() public {
    TokenToSwap[] memory tokens = new TokenToSwap[](5);
    tokens[0] = TokenToSwap(
      AaveV2EthereumAssets.LUSD_UNDERLYING,
      AaveV2EthereumAssets.LUSD_A_TOKEN,
      IERC20(AaveV2EthereumAssets.LUSD_A_TOKEN).balanceOf(address(AaveV3Ethereum.COLLECTOR)) -
        1 ether
    );
    tokens[1] = TokenToSwap(
      AaveV2EthereumAssets.DAI_UNDERLYING,
      AaveV2EthereumAssets.DAI_A_TOKEN,
      IERC20(AaveV2EthereumAssets.DAI_A_TOKEN).balanceOf(address(AaveV3Ethereum.COLLECTOR)) -
        1 ether
    );
    tokens[2] = TokenToSwap(
      AaveV2EthereumAssets.DPI_UNDERLYING,
      AaveV2EthereumAssets.DPI_A_TOKEN,
      IERC20(AaveV2EthereumAssets.DPI_A_TOKEN).balanceOf(address(AaveV3Ethereum.COLLECTOR)) -
        1 ether
    );
    tokens[3] = TokenToSwap(
      AaveV2EthereumAssets.FRAX_UNDERLYING,
      AaveV2EthereumAssets.FRAX_A_TOKEN,
      IERC20(AaveV2EthereumAssets.FRAX_A_TOKEN).balanceOf(address(AaveV3Ethereum.COLLECTOR)) -
        1 ether
    );
    tokens[4] = TokenToSwap(
      AaveV2EthereumAssets.USDT_UNDERLYING,
      AaveV2EthereumAssets.USDT_A_TOKEN,
      proposal.USDT_V2_TO_SWAP()
    );

    for (uint256 i = 0; i < tokens.length; i++) {
      assertGt(IERC20(tokens[i].aToken).balanceOf(address(AaveV3Ethereum.COLLECTOR)), 0);
    }

    _expectEmits();

    executePayload(vm, address(proposal));

    for (uint256 i = 0; i < tokens.length; i++) {
      assertApproxEqAbs(
        IERC20(tokens[i].aToken).balanceOf(address(AaveV3Ethereum.COLLECTOR)),
        1 ether,
        1000 ether
      );
    } // V2 Withdrawals leave a lot behind
  }

  function test_withdrawV3() public {
    TokenToSwap[] memory tokens = new TokenToSwap[](3);
    tokens[0] = TokenToSwap(
      AaveV3EthereumAssets.USDC_UNDERLYING,
      AaveV3EthereumAssets.USDC_A_TOKEN,
      proposal.USDC_V3_TO_SWAP()
    );
    tokens[1] = TokenToSwap(
      AaveV3EthereumAssets.USDT_UNDERLYING,
      AaveV3EthereumAssets.USDT_A_TOKEN,
      proposal.USDT_V3_TO_SWAP() -
        IERC20(AaveV3EthereumAssets.USDT_UNDERLYING).balanceOf(address(AaveV3Ethereum.COLLECTOR))
    );
    tokens[2] = TokenToSwap(
      AaveV3EthereumAssets.LUSD_UNDERLYING,
      AaveV3EthereumAssets.LUSD_A_TOKEN,
      IERC20(AaveV3EthereumAssets.LUSD_A_TOKEN).balanceOf(address(AaveV3Ethereum.COLLECTOR)) -
        1 ether
    );

    for (uint256 i = 0; i < tokens.length; i++) {
      assertGt(IERC20(tokens[i].aToken).balanceOf(address(AaveV3Ethereum.COLLECTOR)), 0);
    }

    uint256 balanceAEthUSDCBefore = IERC20(AaveV3EthereumAssets.USDC_A_TOKEN).balanceOf(
      address(AaveV3Ethereum.COLLECTOR)
    );
    uint256 balanceAEthUSDTBefore = IERC20(AaveV3EthereumAssets.USDT_A_TOKEN).balanceOf(
      address(AaveV3Ethereum.COLLECTOR)
    );
    uint256 balanceUSDTBefore = IERC20(AaveV3EthereumAssets.USDT_UNDERLYING).balanceOf(
      address(AaveV3Ethereum.COLLECTOR)
    );

    _expectEmits();

    executePayload(vm, address(proposal));

    assertApproxEqAbs(
      IERC20(AaveV3EthereumAssets.LUSD_A_TOKEN).balanceOf(address(AaveV3Ethereum.COLLECTOR)),
      1 ether,
      1,
      'aEthLUSD not within 1 ether'
    );
    assertApproxEqAbs(
      IERC20(AaveV3EthereumAssets.USDC_A_TOKEN).balanceOf(address(AaveV3Ethereum.COLLECTOR)),
      balanceAEthUSDCBefore - proposal.USDC_V3_TO_SWAP() + proposal.USDC_V2_TO_MIGRATE(),
      1,
      'aEthUSDC not within 1 ether'
    );
    assertApproxEqAbs(
      IERC20(AaveV3EthereumAssets.USDT_A_TOKEN).balanceOf(address(AaveV3Ethereum.COLLECTOR)),
      balanceAEthUSDTBefore - proposal.USDT_V3_TO_SWAP() + balanceUSDTBefore,
      1,
      'aEthUSDT not within 1 ether'
    );
  }

  function _expectEmits() internal {
    vm.expectEmit(true, true, true, true, MiscEthereum.AAVE_SWAPPER);
    emit SwapRequested(
      proposal.MILKMAN(),
      AaveV3EthereumAssets.LUSD_UNDERLYING,
      AaveV3EthereumAssets.GHO_UNDERLYING,
      AaveV3EthereumAssets.LUSD_ORACLE,
      proposal.GHO_USD_FEED(),
      32761384430524382295524, // Hardcoded because of V2 withdrawal
      address(AaveV3Ethereum.COLLECTOR),
      500
    );

    vm.expectEmit(true, true, true, true, MiscEthereum.AAVE_SWAPPER);
    emit SwapRequested(
      proposal.MILKMAN(),
      AaveV3EthereumAssets.DAI_UNDERLYING,
      AaveV3EthereumAssets.GHO_UNDERLYING,
      AaveV3EthereumAssets.DAI_ORACLE,
      proposal.GHO_USD_FEED(),
      400349503743721455670834, // Hardcoded because of V2 withdrawal
      address(AaveV3Ethereum.COLLECTOR),
      100
    );

    vm.expectEmit(true, true, true, true, MiscEthereum.AAVE_SWAPPER);
    emit SwapRequested(
      proposal.MILKMAN(),
      AaveV2EthereumAssets.DPI_UNDERLYING,
      AaveV3EthereumAssets.GHO_UNDERLYING,
      proposal.DPI_USD_FEED(),
      proposal.GHO_USD_FEED(),
      486852204700306697462, // Hardcoded because of V2 withdrawal
      address(AaveV3Ethereum.COLLECTOR),
      300
    );

    vm.expectEmit(true, true, true, true, MiscEthereum.AAVE_SWAPPER);
    emit SwapRequested(
      proposal.MILKMAN(),
      AaveV3EthereumAssets.FRAX_UNDERLYING,
      AaveV3EthereumAssets.GHO_UNDERLYING,
      AaveV3EthereumAssets.FRAX_ORACLE,
      proposal.GHO_USD_FEED(),
      29115641783196347431241, // Hardcoded because of V2 withdrawal
      address(AaveV3Ethereum.COLLECTOR),
      300
    );

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
      proposal.USDT_V3_TO_SWAP() + proposal.USDT_V2_TO_SWAP(),
      address(AaveV3Ethereum.COLLECTOR),
      50
    );
  }
}
