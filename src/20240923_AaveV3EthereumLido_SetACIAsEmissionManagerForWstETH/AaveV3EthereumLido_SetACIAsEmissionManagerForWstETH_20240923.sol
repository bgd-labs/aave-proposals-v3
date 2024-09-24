// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {AaveV3EthereumLido, AaveV3EthereumLidoAssets} from 'aave-address-book/AaveV3EthereumLido.sol';
import {IEmissionManager} from 'aave-v3-periphery/contracts/rewards/interfaces/IEmissionManager.sol';
/**
 * @title Set ACI as Emission Manager for wstETH & tBTC
 * @author Aave Chan Initiative
 * - Snapshot: Direct-to-AIP
 * - Discussion: https://governance.aave.com/t/arfc-set-aci-as-emission-manager-for-liquidity-mining-programs/17898/16
 */
contract AaveV3EthereumLido_SetACIAsEmissionManagerForWstETH_20240923 is IProposalGenericExecutor {
  address public constant ACI_MULTISIG = 0xac140648435d03f784879cd789130F22Ef588Fcd;
  address public constant tBTC = 0x18084fbA666a33d37592fA2633fD49a74DD93a88; // Hardcoded as lib is not updated yet.

  function execute() external {
    IEmissionManager(AaveV3EthereumLido.EMISSION_MANAGER).setEmissionAdmin(
      AaveV3EthereumLidoAssets.wstETH_UNDERLYING,
      ACI_MULTISIG
    );
    IEmissionManager(AaveV3EthereumLido.EMISSION_MANAGER).setEmissionAdmin(tBTC, ACI_MULTISIG); // reused lido import as it's the same Emission Manager as mainnet
  }
}
