// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {AaveV3Ethereum} from 'aave-address-book/AaveV3Ethereum.sol';
import {AaveV3EthereumLido, AaveV3EthereumLidoAssets} from 'aave-address-book/AaveV3EthereumLido.sol';
import {IEmissionManager} from 'aave-v3-periphery/contracts/rewards/interfaces/IEmissionManager.sol';
import {DataTypes} from 'aave-v3-origin/core/contracts/protocol/libraries/types/DataTypes.sol';

/**
 * @title Set ACI as Emission Manager for USDS and aUSDS
 * @author ACI
 * - Snapshot: Direct-To-AIP
 * - Discussion: https://governance.aave.com/t/arfc-set-aci-as-emission-manager-for-liquidity-mining-programs/17898/18
 */
contract AaveV3Ethereum_SetACIAsEmissionManagerForUSDSAndAUSDS_20240929 is
  IProposalGenericExecutor
{
  address public constant ACI_MULTISIG = 0xac140648435d03f784879cd789130F22Ef588Fcd;
  address public constant USDS = 0xdC035D45d973E3EC169d2276DDab16f1e407384F; // Hardcoded as lib is not updated yet.
  address public constant awstETH = AaveV3EthereumLidoAssets.wstETH_A_TOKEN;

  function execute() external {
    IEmissionManager(AaveV3Ethereum.EMISSION_MANAGER).setEmissionAdmin(USDS, ACI_MULTISIG);
    DataTypes.ReserveDataLegacy memory protoUSDS = AaveV3Ethereum.POOL.getReserveData(USDS);
    IEmissionManager(AaveV3Ethereum.EMISSION_MANAGER).setEmissionAdmin(
      protoUSDS.aTokenAddress,
      ACI_MULTISIG
    );
    DataTypes.ReserveDataLegacy memory lidoUSDS = AaveV3EthereumLido.POOL.getReserveData(USDS);
    IEmissionManager(AaveV3Ethereum.EMISSION_MANAGER).setEmissionAdmin(
      lidoUSDS.aTokenAddress,
      ACI_MULTISIG
    );
    IEmissionManager(AaveV3Ethereum.EMISSION_MANAGER).setEmissionAdmin(awstETH, ACI_MULTISIG);
  }
}
