// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';
import {IAaveCLRobotOperator} from './interfaces/IAaveCLRobotOperator.sol';
import {IRootsConsumer} from './interfaces/IRootsConsumer.sol';
import {IWETH} from './interfaces/IWETH.sol';
import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {SafeERC20} from 'solidity-utils/contracts/oz-common/SafeERC20.sol';
import {SafeCast} from 'solidity-utils/contracts/oz-common/SafeCast.sol';
import {GovernanceV3Ethereum} from 'aave-address-book/GovernanceV3Ethereum.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';

/**
 * @title Migrate Robots to Chainlink Automation v2
 * @author BGD Labs (@bgdlabs)
 * - Discussion: https://governance.aave.com/t/bgd-technical-maintenance-proposals/15274/36
 */
contract AaveV3Ethereum_MigrateRobotsToChainlinkAutomationV2_20240422 is IProposalGenericExecutor {
  using SafeERC20 for IERC20;
  using SafeCast for uint256;

  error FailedToSendETH();

  address public constant OLD_ROBOT_OPERATOR = 0x020E452b463568f55BAc6Dc5aFC8F0B62Ea5f0f3;
  uint256 public constant OLD_EXECUTION_CHAIN_ROBOT_ID =
    103962992988872542945147446194468190544109628047207929929141163121857186570465;
  uint256 public constant OLD_GOVERNANCE_CHAIN_ROBOT_ID =
    2651260633509968244842245718659958660539758109819220392919944208741153930322;
  uint256 public constant OLD_VOTING_CHAIN_ROBOT_ID =
    37197956100690146667709888676659477205673841758151251597253206670225866349198;
  uint256 public constant OLD_GSM_SWAP_FREEZE_USDC_ROBOT_ID =
    27746244780147594627138196730124243558900438379060566825820479909082807342202;
  uint256 public constant OLD_GSM_SWAP_FREEZE_USDT_ROBOT_ID =
    29419557335377754353590946220126755014551271053492007946914462953700619858182;

  address public constant ROBOT_OPERATOR = 0x1cDF8879eC8bE012bA959EB515b11008E0cb6323;
  address public constant ROOTS_CONSUMER = 0x2fA6F0A65886123AFD24A575aE4554d0FCe8B577;

  address public constant GSM_SWAP_FREEZE_USDC_ROBOT_ADDRESS =
    0xef6beCa8D9543eC007bceA835aF768B58F730C1f;
  address public constant GSM_SWAP_FREEZE_USDT_ROBOT_ADDRESS =
    0x71381e6718b37C12155CB961Ca3D374A8BfFa0e5;
  address public constant GAS_CAPPED_EXECUTION_CHAIN_ROBOT_ADDRESS =
    0xBa37F9eDC52f57caFA3a13ddfD655797Cc4FE257;
  address public constant GAS_CAPPED_VOTING_CHAIN_ROBOT_ADDRESS =
    0x7Ed0A6A294Cf085c90917c0ee1aa34e795932558;
  address public constant GAS_CAPPED_GOVERNANCE_CHAIN_ROBOT_ADDRESS =
    0x1996c281235D99bB3c6B8d2afbEb8ac6c7A39C11;
  address public constant GAS_CAPPED_STATIC_A_TOKEN_ROBOT_ADDRESS =
    0xda82148a3944BBe442116f41cDb329b0edF11d41;

  uint256 public constant GSM_SWAP_FREEZE_USDC_ROBOT_LINK_AMOUNT = 80 ether;
  uint256 public constant GSM_SWAP_FREEZE_USDT_ROBOT_LINK_AMOUNT = 80 ether;
  uint256 public constant EXECUTION_CHAIN_ROBOT_LINK_AMOUNT = 1500 ether;
  uint256 public constant GOVERNANCE_CHAIN_ROBOT_LINK_AMOUNT = 2500 ether;
  uint256 public constant VOTING_CHAIN_ROBOT_LINK_AMOUNT = 400 ether;
  uint256 public constant STATIC_A_TOKEN_ROBOT_LINK_AMOUNT = 200 ether;
  uint256 public constant CROSS_CHAIN_CONTROLLER_ETH_AMOUNT = 1 ether;

  function execute() external {
    // refill cross-chain-controller with ETH
    AaveV3Ethereum.COLLECTOR.transfer(
      AaveV3EthereumAssets.WETH_UNDERLYING,
      address(this),
      CROSS_CHAIN_CONTROLLER_ETH_AMOUNT
    );
    IWETH(AaveV3EthereumAssets.WETH_UNDERLYING).withdraw(CROSS_CHAIN_CONTROLLER_ETH_AMOUNT);
    (bool status, ) = GovernanceV3Ethereum.CROSS_CHAIN_CONTROLLER.call{
      value: CROSS_CHAIN_CONTROLLER_ETH_AMOUNT
    }('');
    if (!status) revert FailedToSendETH();

    // cancel previous robots
    IAaveCLRobotOperator(OLD_ROBOT_OPERATOR).cancel(OLD_GSM_SWAP_FREEZE_USDC_ROBOT_ID);
    IAaveCLRobotOperator(OLD_ROBOT_OPERATOR).cancel(OLD_GSM_SWAP_FREEZE_USDT_ROBOT_ID);
    IAaveCLRobotOperator(OLD_ROBOT_OPERATOR).cancel(OLD_EXECUTION_CHAIN_ROBOT_ID);
    IAaveCLRobotOperator(OLD_ROBOT_OPERATOR).cancel(OLD_GOVERNANCE_CHAIN_ROBOT_ID);
    IAaveCLRobotOperator(OLD_ROBOT_OPERATOR).cancel(OLD_VOTING_CHAIN_ROBOT_ID);

    uint256 totalLinkAmount = EXECUTION_CHAIN_ROBOT_LINK_AMOUNT +
      GOVERNANCE_CHAIN_ROBOT_LINK_AMOUNT +
      VOTING_CHAIN_ROBOT_LINK_AMOUNT +
      GSM_SWAP_FREEZE_USDC_ROBOT_LINK_AMOUNT +
      GSM_SWAP_FREEZE_USDT_ROBOT_LINK_AMOUNT +
      STATIC_A_TOKEN_ROBOT_LINK_AMOUNT;

    AaveV3Ethereum.COLLECTOR.transfer(
      AaveV3EthereumAssets.LINK_A_TOKEN,
      address(this),
      totalLinkAmount
    );
    AaveV3Ethereum.POOL.withdraw(
      AaveV3EthereumAssets.LINK_UNDERLYING,
      type(uint256).max,
      address(this)
    );

    uint256 linkBalance = IERC20(AaveV3EthereumAssets.LINK_UNDERLYING).balanceOf(address(this));
    IERC20(AaveV3EthereumAssets.LINK_UNDERLYING).forceApprove(ROBOT_OPERATOR, linkBalance);

    // register new robots
    IAaveCLRobotOperator(ROBOT_OPERATOR).register(
      'Gas Capped Execution Chain Robot',
      GAS_CAPPED_EXECUTION_CHAIN_ROBOT_ADDRESS,
      '',
      5_000_000,
      EXECUTION_CHAIN_ROBOT_LINK_AMOUNT.toUint96(),
      0,
      ''
    );
    IAaveCLRobotOperator(ROBOT_OPERATOR).register(
      'Gas Capped Governance Chain Robot',
      GAS_CAPPED_GOVERNANCE_CHAIN_ROBOT_ADDRESS,
      '',
      5_000_000,
      GOVERNANCE_CHAIN_ROBOT_LINK_AMOUNT.toUint96(),
      0,
      ''
    );
    IAaveCLRobotOperator(ROBOT_OPERATOR).register(
      'Gas Capped Voting Chain Robot',
      GAS_CAPPED_VOTING_CHAIN_ROBOT_ADDRESS,
      '',
      5_000_000,
      VOTING_CHAIN_ROBOT_LINK_AMOUNT.toUint96(),
      0,
      ''
    );
    IAaveCLRobotOperator(ROBOT_OPERATOR).register(
      'GHO GSM USDC OracleSwapFreezer',
      GSM_SWAP_FREEZE_USDC_ROBOT_ADDRESS,
      '',
      150_000,
      GSM_SWAP_FREEZE_USDC_ROBOT_LINK_AMOUNT.toUint96(),
      0,
      ''
    );
    IAaveCLRobotOperator(ROBOT_OPERATOR).register(
      'GHO GSM USDT OracleSwapFreezer',
      GSM_SWAP_FREEZE_USDT_ROBOT_ADDRESS,
      '',
      150_000,
      GSM_SWAP_FREEZE_USDT_ROBOT_LINK_AMOUNT.toUint96(),
      0,
      ''
    );
    IAaveCLRobotOperator(ROBOT_OPERATOR).register(
      'Gas Capped StaticAToken Rewards Robot',
      GAS_CAPPED_STATIC_A_TOKEN_ROBOT_ADDRESS,
      '',
      1_000_000,
      IERC20(AaveV3EthereumAssets.LINK_UNDERLYING).balanceOf(address(this)).toUint96(),
      0,
      ''
    );

    // whitelist new robot on the roots consumer contract
    IRootsConsumer(ROOTS_CONSUMER).setRobotKeeper(GAS_CAPPED_VOTING_CHAIN_ROBOT_ADDRESS);
  }
}
