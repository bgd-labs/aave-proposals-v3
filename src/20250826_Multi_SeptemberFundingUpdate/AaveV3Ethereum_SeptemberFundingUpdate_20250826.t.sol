// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {AaveV2EthereumAssets} from 'aave-address-book/AaveV2Ethereum.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {AaveV3EthereumLido, AaveV3EthereumLidoAssets} from 'aave-address-book/AaveV3EthereumLido.sol';
import {MiscEthereum} from 'aave-address-book/MiscEthereum.sol';
import {ProtocolV3TestBase} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Ethereum_SeptemberFundingUpdate_20250826} from './AaveV3Ethereum_SeptemberFundingUpdate_20250826.sol';

/**
 * @dev Test for AaveV3Ethereum_SeptemberFundingUpdate_20250826
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20250826_Multi_SeptemberFundingUpdate/AaveV3Ethereum_SeptemberFundingUpdate_20250826.t.sol -vv
 */
contract AaveV3Ethereum_SeptemberFundingUpdate_20250826_Test is ProtocolV3TestBase {
  AaveV3Ethereum_SeptemberFundingUpdate_20250826 internal proposal;

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
    vm.createSelectFork(vm.rpcUrl('mainnet'), 23228445);
    proposal = new AaveV3Ethereum_SeptemberFundingUpdate_20250826();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Ethereum_SeptemberFundingUpdate_20250826',
      AaveV3Ethereum.POOL,
      address(proposal)
    );
  }

  function test_approvals() public {
    uint256 allowanceAEthUSDTBefore = IERC20(AaveV3EthereumAssets.USDT_A_TOKEN).allowance(
      address(AaveV3Ethereum.COLLECTOR),
      MiscEthereum.AFC_SAFE
    );
    uint256 allowanceAEthUSDCBefore = IERC20(AaveV3EthereumAssets.USDC_A_TOKEN).allowance(
      address(AaveV3Ethereum.COLLECTOR),
      MiscEthereum.AFC_SAFE
    );
    uint256 allowanceAEthGHOBefore = IERC20(AaveV3EthereumLidoAssets.GHO_A_TOKEN).allowance(
      address(AaveV3Ethereum.COLLECTOR),
      MiscEthereum.MERIT_AHAB_SAFE
    );
    uint256 allowanceAEthCRVBefore = IERC20(AaveV3EthereumAssets.CRV_A_TOKEN).allowance(
      address(AaveV3Ethereum.COLLECTOR),
      MiscEthereum.ALC_SAFE
    );
    assertEq(
      IERC20(AaveV3EthereumAssets.USDT_A_TOKEN).allowance(
        address(AaveV3Ethereum.COLLECTOR),
        MiscEthereum.AFC_SAFE
      ),
      0
    );
    assertEq(
      IERC20(AaveV3EthereumAssets.USDC_A_TOKEN).allowance(
        address(AaveV3Ethereum.COLLECTOR),
        MiscEthereum.AFC_SAFE
      ),
      0
    );
    assertEq(
      IERC20(AaveV3EthereumLidoAssets.GHO_A_TOKEN).allowance(
        address(AaveV3Ethereum.COLLECTOR),
        MiscEthereum.MERIT_AHAB_SAFE
      ),
      0
    );
    assertEq(
      IERC20(AaveV3EthereumAssets.CRV_A_TOKEN).allowance(
        address(AaveV3Ethereum.COLLECTOR),
        MiscEthereum.ALC_SAFE
      ),
      0
    );

    executePayload(vm, address(proposal));

    uint256 allowanceAEthUSDTAfter = IERC20(AaveV3EthereumAssets.USDT_A_TOKEN).allowance(
      address(AaveV3Ethereum.COLLECTOR),
      MiscEthereum.AFC_SAFE
    );
    uint256 allowanceAEthUSDCAfter = IERC20(AaveV3EthereumAssets.USDC_A_TOKEN).allowance(
      address(AaveV3Ethereum.COLLECTOR),
      MiscEthereum.AFC_SAFE
    );
    uint256 allowanceAEthGHOAfter = IERC20(AaveV3EthereumLidoAssets.GHO_A_TOKEN).allowance(
      address(AaveV3Ethereum.COLLECTOR),
      MiscEthereum.MERIT_AHAB_SAFE
    );
    uint256 allowanceAEthCRVAfter = IERC20(AaveV3EthereumAssets.CRV_A_TOKEN).allowance(
      address(AaveV3Ethereum.COLLECTOR),
      MiscEthereum.ALC_SAFE
    );

    assertEq(allowanceAEthUSDTAfter, allowanceAEthUSDTBefore + proposal.AFC_USDT_ALLOWANCE());
    assertEq(allowanceAEthUSDCAfter, allowanceAEthUSDCBefore + proposal.AFC_USDC_ALLOWANCE());
    assertEq(allowanceAEthCRVAfter, allowanceAEthCRVBefore + proposal.ALC_CRV_ALLOWANCE());
    assertEq(allowanceAEthGHOAfter, allowanceAEthGHOBefore + proposal.MERIT_GHO_ALLOWANCE());

    vm.startPrank(MiscEthereum.AFC_SAFE);
    IERC20(AaveV3EthereumAssets.USDC_A_TOKEN).transferFrom(
      address(AaveV3Ethereum.COLLECTOR),
      MiscEthereum.AFC_SAFE,
      proposal.AFC_USDC_ALLOWANCE()
    );

    IERC20(AaveV3EthereumAssets.USDT_A_TOKEN).transferFrom(
      address(AaveV3Ethereum.COLLECTOR),
      MiscEthereum.AFC_SAFE,
      proposal.AFC_USDT_ALLOWANCE()
    );
    vm.stopPrank();

    vm.startPrank(MiscEthereum.MERIT_AHAB_SAFE);
    IERC20(AaveV3EthereumLidoAssets.GHO_A_TOKEN).transferFrom(
      address(AaveV3EthereumLido.COLLECTOR),
      MiscEthereum.MERIT_AHAB_SAFE,
      proposal.MERIT_GHO_ALLOWANCE()
    );
    vm.stopPrank();

    vm.startPrank(MiscEthereum.ALC_SAFE);
    IERC20(AaveV3EthereumAssets.CRV_A_TOKEN).transferFrom(
      address(AaveV3Ethereum.COLLECTOR),
      MiscEthereum.ALC_SAFE,
      proposal.ALC_CRV_ALLOWANCE()
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
      100
    );

    vm.expectEmit(true, true, true, true, MiscEthereum.AAVE_SWAPPER);
    emit SwapRequested(
      proposal.MILKMAN(),
      AaveV2EthereumAssets.GUSD_UNDERLYING,
      AaveV2EthereumAssets.USDC_UNDERLYING,
      AaveV2EthereumAssets.GUSD_ORACLE,
      AaveV2EthereumAssets.USDC_ORACLE,
      1,
      address(AaveV3Ethereum.COLLECTOR),
      200
    );

    vm.expectEmit(true, true, true, true, MiscEthereum.AAVE_SWAPPER);
    emit SwapRequested(
      proposal.MILKMAN(),
      AaveV2EthereumAssets.sUSD_UNDERLYING,
      AaveV2EthereumAssets.USDC_UNDERLYING,
      AaveV2EthereumAssets.sUSD_ORACLE,
      AaveV2EthereumAssets.USDC_ORACLE,
      1, // Hardcoded as swap is dynamic
      address(AaveV3Ethereum.COLLECTOR),
      300
    );

    vm.expectEmit(true, true, true, true, MiscEthereum.AAVE_SWAPPER);
    emit SwapRequested(
      proposal.MILKMAN(),
      AaveV2EthereumAssets.TUSD_UNDERLYING,
      AaveV2EthereumAssets.USDC_UNDERLYING,
      AaveV2EthereumAssets.TUSD_ORACLE,
      AaveV2EthereumAssets.USDC_ORACLE,
      1, // Hardcoded as swap is dynamic
      address(AaveV3Ethereum.COLLECTOR),
      300
    );

    vm.expectEmit(true, true, true, true, MiscEthereum.AAVE_SWAPPER);
    emit SwapRequested(
      proposal.MILKMAN(),
      AaveV2EthereumAssets.USDP_UNDERLYING,
      AaveV2EthereumAssets.USDC_UNDERLYING,
      AaveV2EthereumAssets.USDP_ORACLE,
      AaveV2EthereumAssets.USDC_ORACLE,
      1, // Hardcoded as swap is dynamic
      address(AaveV3Ethereum.COLLECTOR),
      300
    );

    executePayload(vm, address(proposal));

    vm.expectEmit(true, true, true, true, MiscEthereum.AAVE_SWAPPER);
    emit SwapRequested(
      proposal.MILKMAN(),
      AaveV3EthereumAssets.crvUSD_UNDERLYING,
      AaveV3EthereumAssets.USDC_UNDERLYING,
      AaveV3EthereumAssets.crvUSD_ORACLE,
      AaveV3EthereumAssets.USDC_ORACLE,
      1, // Hardcoded as swap is dynamic
      address(AaveV3Ethereum.COLLECTOR),
      500
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
      300
    );

    assertEq(
      IERC20(AaveV3EthereumAssets.DAI_UNDERLYING).balanceOf(address(AaveV3Ethereum.COLLECTOR)),
      0
    );

    assertEq(
      IERC20(AaveV3EthereumAssets.LUSD_UNDERLYING).balanceOf(address(AaveV3Ethereum.COLLECTOR)),
      0
    );

    assertEq(
      IERC20(AaveV3EthereumAssets.crvUSD_UNDERLYING).balanceOf(address(AaveV3Ethereum.COLLECTOR)),
      0
    );

    assertEq(
      IERC20(AaveV2EthereumAssets.GUSD_UNDERLYING).balanceOf(address(AaveV3Ethereum.COLLECTOR)),
      0
    );

    assertEq(
      IERC20(AaveV2EthereumAssets.sUSD_UNDERLYING).balanceOf(address(AaveV3Ethereum.COLLECTOR)),
      0
    );

    assertEq(
      IERC20(AaveV2EthereumAssets.TUSD_UNDERLYING).balanceOf(address(AaveV3Ethereum.COLLECTOR)),
      0
    );

    assertEq(
      IERC20(AaveV2EthereumAssets.USDP_UNDERLYING).balanceOf(address(AaveV3Ethereum.COLLECTOR)),
      0
    );
  }
}
