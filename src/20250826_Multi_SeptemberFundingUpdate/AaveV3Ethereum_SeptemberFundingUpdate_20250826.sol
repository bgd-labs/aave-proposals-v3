// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {AaveV2EthereumAssets} from 'aave-address-book/AaveV2Ethereum.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {AaveV3EthereumLido, AaveV3EthereumLidoAssets} from 'aave-address-book/AaveV3EthereumLido.sol';
import {AaveV3EthereumLidoAssets} from 'aave-address-book/AaveV3EthereumLido.sol';
import {MiscEthereum} from 'aave-address-book/MiscEthereum.sol';
import {Rescuable} from 'solidity-utils/contracts/utils/Rescuable.sol';
import {CollectorUtils, ICollector} from 'aave-helpers/src/CollectorUtils.sol';
import {IWETH} from 'aave-v3-origin/contracts/helpers/interfaces/IWETH.sol';
import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';

/**
 * @title September Funding Update
 * @author @TokenLogic
 * - Snapshot: Direct-to-AIP
 * - Discussion: https://governance.aave.com/t/direct-to-aip-september-2025-funding-update/22915
 */
contract AaveV3Ethereum_SeptemberFundingUpdate_20250826 is IProposalGenericExecutor {
  using CollectorUtils for ICollector;

  /// AAVE Buybacks allowance
  uint256 public constant AFC_USDC_ALLOWANCE = 2_000_000e6;
  uint256 public constant AFC_USDT_ALLOWANCE = 2_000_000e6;

  /// ALC CRV allowance
  uint256 public constant ALC_CRV_ALLOWANCE = 30_000 ether;

  /// MERIT GHO allowance
  uint256 public constant MERIT_GHO_ALLOWANCE = 3_000_000 ether;

  /// https://etherscan.io/address/0x060373D064d0168931dE2AB8DDA7410923d06E88
  address public constant MILKMAN = 0x060373D064d0168931dE2AB8DDA7410923d06E88;

  /// https://etherscan.io/address/0xe80a1C615F75AFF7Ed8F08c9F21f9d00982D666c
  address public constant PRICE_CHECKER = 0xe80a1C615F75AFF7Ed8F08c9F21f9d00982D666c;

  /// https://etherscan.io/address/0x455e53CBB86018Ac2B8092FdCd39d8444aFFC3F6
  address public constant POL = 0x455e53CBB86018Ac2B8092FdCd39d8444aFFC3F6;

  /// https://etherscan.io/address/0xc980508cC8866f726040Da1C0C61f682e74aBc39
  address public constant PLASMA_BRIDGE = 0xc980508cC8866f726040Da1C0C61f682e74aBc39;

  /// Reimbursements
  address public constant ACI = 0xac140648435d03f784879cd789130F22Ef588Fcd;
  uint256 public constant ACI_REIMBURSEMENT = 0.2415 ether;

  address public constant TOKEN_LOGIC = 0xAA088dfF3dcF619664094945028d44E779F19894;
  uint256 public constant TL_REIMBURSEMENT = 9_000 ether;

  uint256 public constant ETH_TO_DEPOSIT = 223 ether;

  function execute() external {
    _approvals();
    _swaps();
    _reimbursements();
  }

  function _approvals() internal {
    // AFC aEthUSDC Approval
    AaveV3Ethereum.COLLECTOR.approve(
      IERC20(AaveV3EthereumAssets.USDC_A_TOKEN),
      MiscEthereum.AFC_SAFE,
      AFC_USDC_ALLOWANCE
    );

    // AFC aEthUSDT Approval
    AaveV3Ethereum.COLLECTOR.approve(
      IERC20(AaveV3EthereumAssets.USDT_A_TOKEN),
      MiscEthereum.AFC_SAFE,
      AFC_USDT_ALLOWANCE
    );

    // ALC aEthCRV Approval
    AaveV3Ethereum.COLLECTOR.approve(
      IERC20(AaveV3EthereumAssets.CRV_A_TOKEN),
      MiscEthereum.ALC_SAFE,
      ALC_CRV_ALLOWANCE
    );

    // MERIT aEthLidoGHO Approval
    AaveV3EthereumLido.COLLECTOR.approve(
      IERC20(AaveV3EthereumLidoAssets.GHO_A_TOKEN),
      MiscEthereum.MERIT_AHAB_SAFE,
      MERIT_GHO_ALLOWANCE
    );
  }

  function _swaps() internal {
    // ETH
    AaveV3Ethereum.COLLECTOR.transfer(
      IERC20(AaveV3Ethereum.COLLECTOR.ETH_MOCK_ADDRESS()),
      address(this),
      ETH_TO_DEPOSIT
    );
    IWETH(AaveV3EthereumAssets.WETH_UNDERLYING).deposit{value: ETH_TO_DEPOSIT}();
    IERC20(AaveV3EthereumAssets.WETH_UNDERLYING).transfer(
      address(AaveV3Ethereum.COLLECTOR),
      ETH_TO_DEPOSIT
    );

    // crvUSD
    AaveV3Ethereum.COLLECTOR.swap(
      MiscEthereum.AAVE_SWAPPER,
      CollectorUtils.SwapInput({
        milkman: MILKMAN,
        priceChecker: PRICE_CHECKER,
        fromUnderlying: AaveV3EthereumAssets.crvUSD_UNDERLYING,
        toUnderlying: AaveV3EthereumAssets.USDC_UNDERLYING,
        fromUnderlyingPriceFeed: AaveV3EthereumAssets.crvUSD_ORACLE,
        toUnderlyingPriceFeed: AaveV3EthereumAssets.USDC_ORACLE,
        amount: IERC20(AaveV3EthereumAssets.crvUSD_UNDERLYING).balanceOf(
          address(AaveV3Ethereum.COLLECTOR)
        ),
        slippage: 500
      })
    );

    /// Get POL
    Rescuable(PLASMA_BRIDGE).emergencyTokenTransfer(
      POL,
      address(AaveV3Ethereum.COLLECTOR),
      IERC20(POL).balanceOf(PLASMA_BRIDGE)
    );
  }

  function _reimbursements() internal {
    AaveV3Ethereum.COLLECTOR.transfer(
      IERC20(AaveV3EthereumAssets.WETH_A_TOKEN),
      ACI,
      ACI_REIMBURSEMENT
    );

    AaveV3EthereumLido.COLLECTOR.transfer(
      IERC20(AaveV3EthereumLidoAssets.GHO_A_TOKEN),
      TOKEN_LOGIC,
      TL_REIMBURSEMENT
    );
  }
}
