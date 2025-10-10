// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {CollectorUtils} from 'aave-helpers/src/CollectorUtils.sol';
import {MiscEthereum} from 'aave-address-book/MiscEthereum.sol';
import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {SafeERC20} from 'openzeppelin-contracts/contracts/token/ERC20/utils/SafeERC20.sol';
import {SafeCast} from 'openzeppelin-contracts/contracts/utils/math/SafeCast.sol';

import {IAaveCLRobotOperator} from '../interfaces/IAaveCLRobotOperator.sol';

/**
 * @title Slope2 Risk Oracle Activation On Core Ethereum, Linea
 * @author BGD Labs (@bgdlabs)
 * - Discussion: https://governance.aave.com/t/chaos-labs-risk-stewards-slope2-parameter-adjustments-for-risk-oracle-deployment/23192
 */
contract AaveV3Ethereum_Slope2RiskOracleActivationOnCoreEthereumLinea_20251009 is
  IProposalGenericExecutor
{
  using SafeERC20 for IERC20;
  using SafeCast for uint256;

  address public constant EDGE_RISK_STEWARD_RATES = AaveV3Ethereum.EDGE_RISK_STEWARD_RATES;
  address public constant EDGE_INJECTOR_RATES = AaveV3Ethereum.EDGE_INJECTOR_RATES;
  uint256 public constant LINK_AMOUNT = 250 ether;

  function execute() external {
    AaveV3Ethereum.ACL_MANAGER.addRiskAdmin(EDGE_RISK_STEWARD_RATES);

    uint256 linkAmount = CollectorUtils.withdrawFromV3(
      AaveV3Ethereum.COLLECTOR,
      CollectorUtils.IOInput({
        pool: address(AaveV3Ethereum.POOL),
        underlying: AaveV3EthereumAssets.LINK_UNDERLYING,
        amount: LINK_AMOUNT
      }),
      address(this)
    );

    IERC20(AaveV3EthereumAssets.LINK_UNDERLYING).forceApprove(
      MiscEthereum.AAVE_CL_ROBOT_OPERATOR,
      linkAmount
    );
    IAaveCLRobotOperator(MiscEthereum.AAVE_CL_ROBOT_OPERATOR).register(
      'CORE AGRS Injector',
      EDGE_INJECTOR_RATES,
      '',
      5_000_000,
      linkAmount.toUint96(),
      0,
      ''
    );
  }
}
