// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {IAaveCLRobotOperator} from './interfaces/IAaveCLRobotOperator.sol';
import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {AaveV3EthereumLido} from 'aave-address-book/AaveV3EthereumLido.sol';
import {CollectorUtils} from 'aave-helpers/src/CollectorUtils.sol';
import {MiscEthereum} from 'aave-address-book/MiscEthereum.sol';
import {SafeERC20} from 'solidity-utils/contracts/oz-common/SafeERC20.sol';
import {SafeCast} from 'solidity-utils/contracts/oz-common/SafeCast.sol';

/**
 * @title Automated AGRS Activation
 * @author BGD Labs (@bgdlabs)
 * - Discussion: https://governance.aave.com/t/arfc-aave-generalized-risk-stewards-agrs-activation/19178/3
 * - Snapshot: https://snapshot.org/#/aave.eth/proposal/0x4809f179e517e5745ec13eba8f40d98dab73ca65f8a141bd2f18cc16dcd0cc16
 */
contract AaveV3EthereumLido_AutomatedAGRSActivation_20241108 is IProposalGenericExecutor {
  using SafeERC20 for IERC20;
  using SafeCast for uint256;

  address public constant EDGE_RISK_STEWARD = 0x81aFd0F99c2Afa2f2DD7E387c2Ef9CD2a29b6E1A;
  address public constant AAVE_STEWARD_INJECTOR = 0x834a5aC6e9D05b92F599A031941262F761c34859;
  uint256 public constant LINK_AMOUNT = 600 ether;

  function execute() external {
    AaveV3EthereumLido.ACL_MANAGER.addRiskAdmin(EDGE_RISK_STEWARD);

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
      'LIDO WETH AGRS Injector',
      AAVE_STEWARD_INJECTOR,
      '',
      5_000_000,
      linkAmount.toUint96(),
      0,
      ''
    );
  }
}
