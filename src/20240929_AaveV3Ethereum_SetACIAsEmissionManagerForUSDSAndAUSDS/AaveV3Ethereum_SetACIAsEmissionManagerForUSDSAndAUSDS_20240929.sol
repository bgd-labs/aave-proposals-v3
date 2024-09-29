// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {IEmissionManager} from 'aave-v3-periphery/contracts/rewards/interfaces/IEmissionManager.sol';
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
  address public constant aEthUSDS = 0x32a6268f9Ba3642Dda7892aDd74f1D34469A4259; // Hardcoded as it doesn't exist yet.
  address public constant aEthLidoUSDS = 0x09AA30b182488f769a9824F15E6Ce58591Da4781; // Hardcoded as it doesn't exist yet.

  function execute() external {
    IEmissionManager(AaveV3Ethereum.EMISSION_MANAGER).setEmissionAdmin(USDS, ACI_MULTISIG);
    IEmissionManager(AaveV3Ethereum.EMISSION_MANAGER).setEmissionAdmin(aEthUSDS, ACI_MULTISIG);
    IEmissionManager(AaveV3Ethereum.EMISSION_MANAGER).setEmissionAdmin(aEthLidoUSDS, ACI_MULTISIG);
  }
}
