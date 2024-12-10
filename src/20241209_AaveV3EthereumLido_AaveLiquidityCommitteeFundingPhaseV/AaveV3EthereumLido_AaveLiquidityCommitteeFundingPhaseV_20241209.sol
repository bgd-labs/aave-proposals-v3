// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';

import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {SafeERC20} from 'solidity-utils/contracts/oz-common/SafeERC20.sol';
import {Rescuable} from 'solidity-utils/contracts/utils/Rescuable.sol';
import {RescuableBase, IRescuableBase} from 'solidity-utils/contracts/utils/RescuableBase.sol';
import {CollectorUtils, ICollector} from 'aave-helpers/src/CollectorUtils.sol';
import {AaveSwapper} from 'aave-helpers/src/swaps/AaveSwapper.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {MiscEthereum} from 'aave-address-book/MiscEthereum.sol';
import {AaveV3EthereumLido} from 'aave-address-book/AaveV3EthereumLido.sol';

/**
 * @title Aave Liquidity Committee Funding Phase V
 * @author karpatkey_TokenLogic
 * - Snapshot: https://snapshot.box/#/s:aave.eth/proposal/0xe6740e5aec256ccf1dfbf538591f6b1631927f8d950b17067fe6912b74158332
 * - Discussion: https://governance.aave.com/t/arfc-aave-liquidity-committee-funding-phase-v/20043
 */
contract AaveV3EthereumLido_AaveLiquidityCommitteeFundingPhaseV_20241209 is
  IProposalGenericExecutor,
  Rescuable
{
  using SafeERC20 for IERC20;
  using CollectorUtils for ICollector;

  event DepositedIntoLido(address indexed token, uint256 amount);

  address public immutable SELF;

  uint256 public constant A_ETH_USDT_WITHDRAW_AMOUNT = 1_250_000e6;
  uint256 public constant A_ETH_USDC_WITHDRAW_AMOUNT = 1_250_000e6;

  // https://etherscan.io/address/0x060373D064d0168931dE2AB8DDA7410923d06E88
  address public constant MILKMAN = 0x060373D064d0168931dE2AB8DDA7410923d06E88;
  // https://etherscan.io/address/0xe80a1C615F75AFF7Ed8F08c9F21f9d00982D666c
  address public constant PRICE_CHECKER = 0xe80a1C615F75AFF7Ed8F08c9F21f9d00982D666c;
  // https://etherscan.io/address/0x3f12643D3f6f874d39C2a4c9f2Cd6f2DbAC877FC
  address public constant GHO_USD_FEED = 0x3f12643D3f6f874d39C2a4c9f2Cd6f2DbAC877FC;

  address public constant ALC_SAFE = 0xA1c93D2687f7014Aaf588c764E3Ce80aF016229b;
  uint256 public constant ALC_ALLOWANCE = 2_000_000e18;

  constructor() {
    SELF = address(this);
  }

  function execute() external override {
    // alc allowance
    uint256 initialAlcAllowance = IERC20(AaveV3EthereumAssets.GHO_UNDERLYING).allowance(
      address(AaveV3EthereumLido.COLLECTOR),
      ALC_SAFE
    );
    if (initialAlcAllowance > 0) {
      // clear initial allowance
      AaveV3EthereumLido.COLLECTOR.approve(AaveV3EthereumAssets.GHO_UNDERLYING, ALC_SAFE, 0);
    }
    AaveV3EthereumLido.COLLECTOR.approve(
      AaveV3EthereumAssets.GHO_UNDERLYING,
      ALC_SAFE,
      initialAlcAllowance + ALC_ALLOWANCE
    );

    // swap
    // usdt
    AaveV3Ethereum.COLLECTOR.withdrawFromV3(
      CollectorUtils.IOInput({
        pool: address(AaveV3Ethereum.POOL),
        underlying: AaveV3EthereumAssets.USDT_UNDERLYING,
        amount: A_ETH_USDT_WITHDRAW_AMOUNT
      }),
      MiscEthereum.AAVE_SWAPPER
    );

    AaveSwapper(MiscEthereum.AAVE_SWAPPER).swap(
      MILKMAN,
      PRICE_CHECKER,
      AaveV3EthereumAssets.USDT_UNDERLYING,
      AaveV3EthereumAssets.GHO_UNDERLYING,
      AaveV3EthereumAssets.USDT_ORACLE,
      GHO_USD_FEED,
      SELF,
      IERC20(AaveV3EthereumAssets.USDT_UNDERLYING).balanceOf(MiscEthereum.AAVE_SWAPPER),
      100
    );

    // usdc
    AaveV3Ethereum.COLLECTOR.withdrawFromV3(
      CollectorUtils.IOInput({
        pool: address(AaveV3Ethereum.POOL),
        underlying: AaveV3EthereumAssets.USDC_UNDERLYING,
        amount: A_ETH_USDC_WITHDRAW_AMOUNT
      }),
      MiscEthereum.AAVE_SWAPPER
    );

    AaveSwapper(MiscEthereum.AAVE_SWAPPER).swap(
      MILKMAN,
      PRICE_CHECKER,
      AaveV3EthereumAssets.USDC_UNDERLYING,
      AaveV3EthereumAssets.GHO_UNDERLYING,
      AaveV3EthereumAssets.USDC_ORACLE,
      GHO_USD_FEED,
      SELF,
      IERC20(AaveV3EthereumAssets.USDC_UNDERLYING).balanceOf(MiscEthereum.AAVE_SWAPPER),
      100
    );
  }

  /**
   * @notice deposit token to AaveV3EthereumLido pool
   * @param token The address of token to deposit
   */
  function deposit(address token) external {
    uint256 amount = IERC20(token).balanceOf(SELF);
    IERC20(token).forceApprove(address(AaveV3EthereumLido.POOL), amount);
    AaveV3EthereumLido.POOL.deposit(token, amount, address(AaveV3EthereumLido.COLLECTOR), 0);
    emit DepositedIntoLido(token, amount);
  }

  /// @inheritdoc Rescuable
  function whoCanRescue() public view override returns (address) {
    return MiscEthereum.PROTOCOL_GUARDIAN;
  }

  /// @inheritdoc IRescuableBase
  function maxRescue(
    address
  ) public pure override(RescuableBase, IRescuableBase) returns (uint256) {
    return type(uint256).max;
  }
}
