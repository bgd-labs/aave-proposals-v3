// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {AaveV3Base, AaveV3BaseAssets} from 'aave-address-book/AaveV3Base.sol';
import {IEmissionManager} from 'aave-v3-periphery/contracts/rewards/interfaces/IEmissionManager.sol';
import {ICollector} from 'aave-v3-periphery/contracts/treasury/ICollector.sol';
import {IPool} from 'aave-v3-core/contracts/interfaces/IPool.sol';
import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {SafeERC20} from 'solidity-utils/contracts/oz-common/SafeERC20.sol';

/**
 * @title Merit Base Incentives and Superfest Matching
 * @author Aave Chan Initiative
 * - Snapshot: https://snapshot.org/#/aave.eth/proposal/0x15cbc6b6c5b4ef76a1fb8cf8747460bf327c459fa01b69907fab0119457939a8
 * - Discussion: https://governance.aave.com/t/arfc-merit-base-incentives-and-superfest-matching/18450
 */
contract AaveV3Base_MeritBaseIncentivesAndSuperfestMatching_20240812 is IProposalGenericExecutor {
  using SafeERC20 for IERC20;

  // Used for emission admin
  struct EmissionAdmin {
    address asset;
    address admin;
  }

  // Used to withdraw and transfer funds
  struct Transfer {
    address asset; //underlying
    address recipient;
    uint256 amount;
  }

  IEmissionManager public constant EMISSION_MANAGER = IEmissionManager(AaveV3Base.EMISSION_MANAGER);

  address public constant ACI_MULTISIG = 0xac140648435d03f784879cd789130F22Ef588Fcd;

  function execute() external {
    // Emission admin setting
    EmissionAdmin[4] memory admins = getEmissionAdmins();
    for (uint256 i = 0; i < admins.length; i++) {
      EMISSION_MANAGER.setEmissionAdmin(admins[i].asset, admins[i].admin);
    }

    // Funds 100k$ to ACI
    // 80k from USDC & 20k from USDbC
    // those are aToken so we need to withdraw them
    Transfer[2] memory transfers = getTransfers();
    for (uint256 i = 0; i < transfers.length; i++) {
      AaveV3Base.COLLECTOR.transfer(
        AaveV3Base.POOL.getReserveData(transfers[i].asset).aTokenAddress,
        address(this),
        transfers[i].amount
      );
      AaveV3Base.POOL.withdraw(transfers[i].asset, type(uint256).max, transfers[i].recipient);
    }
  }

  function getEmissionAdmins() public pure returns (EmissionAdmin[4] memory) {
    return [
      EmissionAdmin({asset: AaveV3BaseAssets.USDC_UNDERLYING, admin: ACI_MULTISIG}),
      EmissionAdmin({asset: AaveV3BaseAssets.WETH_UNDERLYING, admin: ACI_MULTISIG}),
      EmissionAdmin({asset: AaveV3BaseAssets.USDC_A_TOKEN, admin: ACI_MULTISIG}),
      EmissionAdmin({asset: AaveV3BaseAssets.WETH_A_TOKEN, admin: ACI_MULTISIG})
    ];
  }

  function getTransfers() public pure returns (Transfer[2] memory) {
    return [
      Transfer({
        asset: AaveV3BaseAssets.USDC_UNDERLYING,
        recipient: ACI_MULTISIG,
        amount: 80_000e6
      }),
      Transfer({
        asset: AaveV3BaseAssets.USDbC_UNDERLYING,
        recipient: ACI_MULTISIG,
        amount: 20_000e6
      })
    ];
  }
}
