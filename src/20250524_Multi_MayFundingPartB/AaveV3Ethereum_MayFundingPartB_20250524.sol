// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {AaveV2Ethereum, AaveV2EthereumAssets} from 'aave-address-book/AaveV2Ethereum.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {AaveV3EthereumLidoAssets} from 'aave-address-book/AaveV3EthereumLido.sol';
import {CollectorUtils, ICollector} from 'aave-helpers/src/CollectorUtils.sol';
import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';

// https://etherscan.io/address/0xf86141a5657Cf52AEB3E30eBccA5Ad3a8f714B89#code#F1#L63
interface IMigrationActions {
  /**
   * @notice Migrate `assetsIn` of `DAI` to `USDS`.
   * @param  receiver The receiver of `USDS`.
   * @param  assetsIn The amount of `DAI` to migrate.
   */
  function migrateDAIToUSDS(address receiver, uint256 assetsIn) external;
}

/**
 * @title May Funding Part B
 * @author @TokenLogic
 * - Snapshot: https://snapshot.box/#/s:aavedao.eth/proposal/0x4dfc398fabb63305900572dff38b2ff8e104b0710077f6b7e48049de173d186b
 * - Discussion: https://governance.aave.com/t/arfc-may-2025-funding-update/21906/5
 */
contract AaveV3Ethereum_MayFundingPartB_20250524 is IProposalGenericExecutor {
  using CollectorUtils for ICollector;

  /// https://etherscan.io/address/0xf86141a5657Cf52AEB3E30eBccA5Ad3a8f714B89
  address public constant MIGRATION_ACTIONS = 0xf86141a5657Cf52AEB3E30eBccA5Ad3a8f714B89;

  /// https://etherscan.io/address/0xdeadD8aB03075b7FBA81864202a2f59EE25B312b
  address public constant MERIT_AHAB_SAFE = 0xdeadD8aB03075b7FBA81864202a2f59EE25B312b;

  /// https://etherscan.io/address/0xA1c93D2687f7014Aaf588c764E3Ce80aF016229b
  address public constant ALC_SAFE = 0xA1c93D2687f7014Aaf588c764E3Ce80aF016229b;

  /// https://etherscan.io/address/0x22740deBa78d5a0c24C58C740e3715ec29de1bFa
  address public constant AFC_SAFE = 0x22740deBa78d5a0c24C58C740e3715ec29de1bFa;

  /// https://etherscan.io/address/0xAA088dfF3dcF619664094945028d44E779F19894
  address public constant NEW_TOKENLOGIC_SAFE = 0xAA088dfF3dcF619664094945028d44E779F19894;

  uint256 public constant MERIT_LIDO_GHO_ALLOWANCE = 3_000_000 ether;
  uint256 public constant AHAB_WETH_ALLOWANCE = 800 ether;
  uint256 public constant AFC_A_ETH_USDC_ALLOWANCE = 2_400_000e6;
  uint256 public constant TOKENLOGIC_STREAM_ID = 100055;

  function execute() external {
    _updateTokenLogicStream();
    _migrateDaiToUsds();
    _approvals();
  }

  function _approvals() internal {
    // Merit aEthLidoGHO Approval
    AaveV3Ethereum.COLLECTOR.approve(
      IERC20(AaveV3EthereumLidoAssets.GHO_A_TOKEN),
      MERIT_AHAB_SAFE,
      MERIT_LIDO_GHO_ALLOWANCE
    );

    // Ahab aEthWETH Approval
    AaveV3Ethereum.COLLECTOR.approve(
      IERC20(AaveV3EthereumAssets.WETH_A_TOKEN),
      MERIT_AHAB_SAFE,
      AHAB_WETH_ALLOWANCE
    );

    // RAI Approval
    AaveV3Ethereum.COLLECTOR.approve(
      IERC20(AaveV2EthereumAssets.RAI_UNDERLYING),
      AFC_SAFE,
      IERC20(AaveV2EthereumAssets.RAI_UNDERLYING).balanceOf(address(AaveV2Ethereum.COLLECTOR))
    );

    // CRV Approval
    AaveV3Ethereum.COLLECTOR.approve(
      IERC20(AaveV3EthereumAssets.CRV_UNDERLYING),
      ALC_SAFE,
      IERC20(AaveV3EthereumAssets.CRV_UNDERLYING).balanceOf(address(AaveV3Ethereum.COLLECTOR))
    );

    // BAL Approval
    AaveV3Ethereum.COLLECTOR.approve(
      IERC20(AaveV3EthereumAssets.BAL_UNDERLYING),
      ALC_SAFE,
      IERC20(AaveV3EthereumAssets.BAL_UNDERLYING).balanceOf(address(AaveV3Ethereum.COLLECTOR))
    );

    // aEthUSDC Approval
    AaveV3Ethereum.COLLECTOR.approve(
      IERC20(AaveV3EthereumAssets.USDC_A_TOKEN),
      AFC_SAFE,
      AFC_A_ETH_USDC_ALLOWANCE
    );
  }

  function _migrateDaiToUsds() internal {
    AaveV3Ethereum.COLLECTOR.withdrawFromV2(
      CollectorUtils.IOInput({
        pool: address(AaveV2Ethereum.POOL),
        underlying: AaveV2EthereumAssets.DAI_UNDERLYING,
        amount: IERC20(AaveV2EthereumAssets.DAI_A_TOKEN).balanceOf(
          address(AaveV2Ethereum.COLLECTOR)
        )
      }),
      address(this)
    );
    AaveV3Ethereum.COLLECTOR.withdrawFromV3(
      CollectorUtils.IOInput({
        pool: address(AaveV3Ethereum.POOL),
        underlying: AaveV3EthereumAssets.DAI_UNDERLYING,
        amount: IERC20(AaveV3EthereumAssets.DAI_A_TOKEN).balanceOf(
          address(AaveV3Ethereum.COLLECTOR)
        )
      }),
      address(this)
    );

    AaveV3Ethereum.COLLECTOR.transfer(
      IERC20(AaveV3EthereumAssets.DAI_UNDERLYING),
      address(this),
      IERC20(AaveV3EthereumAssets.DAI_UNDERLYING).balanceOf(address(AaveV3Ethereum.COLLECTOR))
    );

    uint256 daiAmount = IERC20(AaveV3EthereumAssets.DAI_UNDERLYING).balanceOf(address(this));

    IERC20(AaveV3EthereumAssets.DAI_UNDERLYING).approve(MIGRATION_ACTIONS, daiAmount);
    IMigrationActions(MIGRATION_ACTIONS).migrateDAIToUSDS(
      address(AaveV3Ethereum.COLLECTOR),
      daiAmount
    );

    AaveV3Ethereum.COLLECTOR.depositToV3(
      CollectorUtils.IOInput({
        pool: address(AaveV3Ethereum.POOL),
        underlying: AaveV3EthereumAssets.USDS_UNDERLYING,
        amount: type(uint256).max
      })
    );
  }

  function _updateTokenLogicStream() internal {
    (, , , address tokenAddress, , uint256 stopTime, uint256 remainingBalance, ) = AaveV3Ethereum
      .COLLECTOR
      .getStream(TOKENLOGIC_STREAM_ID);

    uint256 timeLeft = stopTime - block.timestamp;
    AaveV3Ethereum.COLLECTOR.cancelStream(TOKENLOGIC_STREAM_ID);

    CollectorUtils.stream(
      AaveV3Ethereum.COLLECTOR,
      CollectorUtils.CreateStreamInput({
        underlying: tokenAddress,
        receiver: NEW_TOKENLOGIC_SAFE,
        amount: remainingBalance,
        start: block.timestamp,
        duration: timeLeft
      })
    );
  }
}
