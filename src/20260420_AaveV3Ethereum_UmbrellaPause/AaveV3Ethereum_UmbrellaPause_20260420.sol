// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {MiscEthereum} from 'aave-address-book/MiscEthereum.sol';
import {UmbrellaEthereum, UmbrellaEthereumAssets} from 'aave-address-book/UmbrellaEthereum.sol';
import {UmbrellaConfiguration} from 'aave-umbrella/umbrella/UmbrellaConfiguration.sol';
import {IAccessControl} from 'openzeppelin-contracts/contracts/access/IAccessControl.sol';
import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';

/**
 * @title rsETH Incident: Umbrella WETH Pause
 * @author Aave Labs
 * - Snapshot: Direct-to-AIP
 * - Discussion: https://governance.aave.com/t/direct-to-aip-pause-stkwaweth-umbrella-staked-token-on-ethereum-v3/24595
 */
contract AaveV3Ethereum_UmbrellaPause_20260420 is IProposalGenericExecutor {
  function execute() external override {
    address umbrellaAddress = address(UmbrellaEthereum.UMBRELLA);

    UmbrellaEthereum.UMBRELLA.pauseStk(UmbrellaEthereumAssets.STK_WA_WETH_V1);
    IAccessControl(umbrellaAddress).grantRole(
      UmbrellaConfiguration(umbrellaAddress).PAUSE_GUARDIAN_ROLE(),
      MiscEthereum.PROTOCOL_GUARDIAN
    );
  }
}
