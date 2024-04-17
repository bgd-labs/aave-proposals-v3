// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';
import {IEmissionManager} from 'aave-v3-periphery/contracts/rewards/interfaces/IEmissionManager.sol';

/**
 * @title Mainnet PYUSD Emissions Admin
 * @author Aave Chan Initiative
 * - Snapshot: https://snapshot.org/#/aave.eth/proposal/0xac80b6d5488c4949e30013d8ed88189ed48b64cb47580bee46921b28e3899bb7
 * - Discussion: https://governance.aave.com/t/arfc-set-aave-chan-initiative-as-emission-manager-for-pyusd-on-aave-v3-ethereum-market/16837
 */
contract AaveV3Ethereum_MainnetPYUSDEmissionsAdmin_20240312 is IProposalGenericExecutor {
  address public constant PYUSD_EMISSION_ADMIN = 0xac140648435d03f784879cd789130F22Ef588Fcd;

  function execute() external {
    IEmissionManager(AaveV3Ethereum.EMISSION_MANAGER).setEmissionAdmin(
      AaveV3EthereumAssets.PYUSD_UNDERLYING,
      PYUSD_EMISSION_ADMIN
    );
  }
}
