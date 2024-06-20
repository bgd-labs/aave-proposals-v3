// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';
import {AaveV3Ethereum} from 'aave-address-book/AaveV3Ethereum.sol';
import {IEmissionManager} from 'aave-v3-periphery/contracts/rewards/interfaces/IEmissionManager.sol';

/**
 * @title Set ACI as Emission Manager
 * @author ACI
 * - Snapshot: https://snapshot.org/#/aave.eth/proposal/0x364de11d3a298f2c76721a8926cb32823cc29d0a95eadecbc0a98c628a38194b
 * - Discussion: https://governance.aave.com/t/arfc-set-aci-as-emission-manager-for-liquidity-mining-programs/17898#arfc-set-aci-as-emission-manager-for-liquidity-mining-programs-1
 */

contract AaveV3Ethereum_SetACIAsEmissionManager_20240620 is IProposalGenericExecutor {
  address public constant SD = 0x30D20208d987713f46DFD34EF128Bb16C404D10f;
  address public constant SD_EMISSION_ADMIN = 0xac140648435d03f784879cd789130F22Ef588Fcd;

  function execute() external {
    IEmissionManager(AaveV3Ethereum.EMISSION_MANAGER).setEmissionAdmin(SD, SD_EMISSION_ADMIN);
  }
}
