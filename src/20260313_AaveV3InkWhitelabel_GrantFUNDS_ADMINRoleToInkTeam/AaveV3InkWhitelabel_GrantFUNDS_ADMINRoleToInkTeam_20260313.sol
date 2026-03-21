// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3InkWhitelabel} from 'aave-address-book/AaveV3InkWhitelabel.sol';
import {ICollector} from 'aave-helpers/src/CollectorUtils.sol';
import {IAccessControl} from 'openzeppelin-contracts/contracts/access/IAccessControl.sol';
import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';

/**
 * @title Grant FUNDS_ADMIN role to Ink team
 * @author ACI
 */
contract AaveV3InkWhitelabel_GrantFUNDS_ADMINRoleToInkTeam_20260313 is IProposalGenericExecutor {
  address public constant INK_TEAM_SAFE = 0x82d7d57C22F56d5f7dE062CbcA9783001f885302;

  function execute() external {
    IAccessControl(address(AaveV3InkWhitelabel.COLLECTOR)).grantRole(
      ICollector(address(AaveV3InkWhitelabel.COLLECTOR)).FUNDS_ADMIN_ROLE(),
      INK_TEAM_SAFE
    );
  }
}
