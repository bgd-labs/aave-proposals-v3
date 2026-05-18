// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Roles} from 'aave-v4/deployments/utils/libraries/Roles.sol';
import {AaveV4Ethereum_SVRfeeds_20260507} from './AaveV4Ethereum_SVRfeeds_20260507.sol';
import {AaveV4Ethereum_SVRfeeds_20260507_Test} from './AaveV4Ethereum_SVRfeeds_20260507.t.sol';

/**
 * @dev Fork test against the deployed (but not yet executed) payload on mainnet.
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20260507_AaveV4Ethereum_SVRfeeds/AaveV4Ethereum_SVRfeeds_20260507_DeployedFork.t.sol -vv
 */
contract AaveV4Ethereum_SVRfeeds_20260507_DeployedForkTest is
  AaveV4Ethereum_SVRfeeds_20260507_Test
{
  // https://etherscan.io/address/0x614edc5e7dce84968fb8011787fc1b4ea762dbc5
  address internal constant DEPLOYED_PAYLOAD = 0x614EDC5E7dce84968FB8011787fc1b4eA762dBC5;

  function setUp() public override {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 25088522);

    payload = AaveV4Ethereum_SVRfeeds_20260507(DEPLOYED_PAYLOAD);

    // Spoke-side updateReservePriceSource requires SPOKE_CONFIGURATOR_DOMAIN_ADMIN_ROLE.
    vm.prank(SECURITY_COUNCIL);
    ACCESS_MANAGER.grantRole(Roles.SPOKE_CONFIGURATOR_DOMAIN_ADMIN_ROLE, EXECUTOR, 0);
  }
}
