// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';
import {AaveV3Ethereum} from 'aave-address-book/AaveV3Ethereum.sol';
import {IEmissionManager} from '@aave/periphery-v3/contracts/rewards/interfaces/IEmissionManager.sol';

/**
 * @title Assign Emission Admin - Ethereum, Arbitrum and Optimism
 * @author karpatkey-TokenLogic & ACI
 * - Snapshot: https://snapshot.org/#/aave.eth/proposal/0x0d83730d546d74d463f045697e9ea6b1708b5c833a40e09e4f87f1804177f5a6 & https://snapshot.org/#/aave.eth/proposal/0xe0579b1efa1f26237104632f4ccddac0158866a18061b27a634634fa9d31e250
 * - Discussion: https://governance.aave.com/t/arfc-set-ethx-and-sd-emission-admin-to-stader-labs/16599 & https://governance.aave.com/t/arfc-set-oseth-swise-emission-admin-to-stakewise/16590
 */
contract AaveV3Ethereum_AssignEmissionAdminEthereumArbitrumAndOptimism_20240229 is
  IProposalGenericExecutor
{
  IEmissionManager public constant EMISSION_MANAGER =
    IEmissionManager(AaveV3Ethereum.EMISSION_MANAGER);

  address public constant SD = 0x30D20208d987713f46DFD34EF128Bb16C404D10f;
  address public constant ETHX = 0xA35b1B31Ce002FBF2058D22F30f95D405200A15b;
  address public constant EMISSION_ADMIN_SD_ETHX = 0xbDa6C9cd7eD043CB739ca2C748dAbd1fCA397132;

  address public constant SWISE = 0x48C3399719B582dD63eB5AADf12A40B4C3f52FA2;
  address public constant OSETH = 0xf1C9acDc66974dFB6dEcB12aA385b9cD01190E38;
  address public constant EMISSION_ADMIN_SWISE_OSETH = 0x189Cb93839AD52b5e955ddA254Ed7212ae1B1f61;

  function execute() external {
    EMISSION_MANAGER.setEmissionAdmin(SD, EMISSION_ADMIN_SD_ETHX);
    EMISSION_MANAGER.setEmissionAdmin(ETHX, EMISSION_ADMIN_SD_ETHX);

    EMISSION_MANAGER.setEmissionAdmin(SWISE, EMISSION_ADMIN_SWISE_OSETH);
    EMISSION_MANAGER.setEmissionAdmin(OSETH, EMISSION_ADMIN_SWISE_OSETH);
  }
}
