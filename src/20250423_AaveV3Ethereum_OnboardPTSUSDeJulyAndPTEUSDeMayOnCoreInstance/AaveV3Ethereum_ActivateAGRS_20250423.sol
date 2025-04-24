// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {MiscEthereum} from 'aave-address-book/MiscEthereum.sol';
import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {SafeERC20} from 'openzeppelin-contracts/contracts/token/ERC20/utils/SafeERC20.sol';
import {SafeCast} from 'openzeppelin-contracts/contracts/utils/math/SafeCast.sol';
import {CollectorUtils, ICollector} from 'aave-helpers/src/CollectorUtils.sol';

import {IAaveCLRobotOperator} from '../interfaces/IAaveCLRobotOperator.sol';
import {IAaveStewardInjector} from './interfaces/IAaveStewardInjector.sol';

/**
 * @title Onboard PT sUSDe July and PT eUSDe May on Core Instance
 * @author BGD Labs (@bgdlabs)
 * - Snapshot: https://snapshot.box/#/s:aavedao.eth/proposal/0xc039953e4f18804bb017876d27621da1ab3e4de53acd3b32d0f1fe94d4bbb6a0
 * - Discussion: https://governance.aave.com/t/arfc-onboard-susde-july-expiry-pt-tokens-on-aave-v3-core-instance/21878
 */
contract AaveV3Ethereum_ActivateAGRS_20250423 is IProposalGenericExecutor {
  using CollectorUtils for ICollector;
  using SafeCast for uint256;
  using SafeERC20 for IERC20;

  address public constant MANUAL_RISK_STEWARD = 0x46Ab47bA01EF627ce47F2ED61C9482794a6109c4;
  address public constant EDGE_RISK_STEWARD = 0xf721bE7AA57a987F3e4D05DAc6fcb5aBF9F7cE9A;
  address public constant AAVE_STEWARD_INJECTOR = 0x83ab600cE8a61b43e1757b89C0589928f765c1C4;

  uint96 public constant LINK_AMOUNT = 200 ether;

  function execute() external {
    // replace manual steward with new one, new one having e-mode and pendle pt changes
    AaveV3Ethereum.ACL_MANAGER.removeRiskAdmin(AaveV3Ethereum.RISK_STEWARD);
    AaveV3Ethereum.ACL_MANAGER.addRiskAdmin(MANUAL_RISK_STEWARD);

    // activate injector
    AaveV3Ethereum.ACL_MANAGER.addRiskAdmin(EDGE_RISK_STEWARD);

    // we whitelist eModeId 9 on the injector
    address[] memory marketsToWhitelist = new address[](1);
    marketsToWhitelist[0] = address(uint160(9)); // on the injector we encode eModeId to address
    IAaveStewardInjector(AAVE_STEWARD_INJECTOR).addMarkets(marketsToWhitelist);

    uint256 linkAmountWithdrawn = AaveV3Ethereum.COLLECTOR.withdrawFromV3(
      CollectorUtils.IOInput({
        pool: address(AaveV3Ethereum.POOL),
        underlying: AaveV3EthereumAssets.LINK_UNDERLYING,
        amount: LINK_AMOUNT
      }),
      address(this)
    );
    IERC20(AaveV3EthereumAssets.LINK_UNDERLYING).forceApprove(
      MiscEthereum.AAVE_CL_ROBOT_OPERATOR,
      linkAmountWithdrawn
    );
    IAaveCLRobotOperator(MiscEthereum.AAVE_CL_ROBOT_OPERATOR).register(
      'Pendle EMode AGRS Injector',
      AAVE_STEWARD_INJECTOR,
      '',
      5_000_000,
      linkAmountWithdrawn.toUint96(),
      0,
      ''
    );
  }
}
