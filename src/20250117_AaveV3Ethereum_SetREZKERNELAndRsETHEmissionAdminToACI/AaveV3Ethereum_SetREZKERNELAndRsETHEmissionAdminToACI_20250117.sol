// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Ethereum} from 'aave-address-book/AaveV3Ethereum.sol';
import {AaveV3PayloadEthereum} from 'aave-helpers/src/v3-config-engine/AaveV3PayloadEthereum.sol';
import {IEmissionManager} from 'aave-v3-origin/contracts/rewards/interfaces/IEmissionManager.sol';
/**
 * @title Set REZ, KERNEL and rsETH Emission Admin to ACI
 * @author Aave-chan Initiative
 * - Snapshot: Direct-to-AIP
 * - Discussion: https://governance.aave.com/t/arfc-set-rez-kernel-and-rseth-emission-admin-to-aci/20599
 */
contract AaveV3Ethereum_SetREZKERNELAndRsETHEmissionAdminToACI_20250117 is AaveV3PayloadEthereum {
  address public constant REZ = 0x3B50805453023a91a8bf641e279401a0b23FA6F9;
  address public constant REZ_ADMIN = 0xdef1FA4CEfe67365ba046a7C630D6B885298E210;
  address public constant KERNEL = 0x3f80B1c54Ae920Be41a77f8B902259D48cf24cCf;
  address public constant KERNEL_ADMIN = 0xdef1FA4CEfe67365ba046a7C630D6B885298E210;
  address public constant rsETH = 0xA1290d69c65A6Fe4DF752f95823fae25cB99e5A7;
  address public constant rsETH_ADMIN = 0xdef1FA4CEfe67365ba046a7C630D6B885298E210;

  function _postExecute() internal override {
    IEmissionManager(AaveV3Ethereum.EMISSION_MANAGER).setEmissionAdmin(REZ, REZ_ADMIN);
    IEmissionManager(AaveV3Ethereum.EMISSION_MANAGER).setEmissionAdmin(KERNEL, KERNEL_ADMIN);
    IEmissionManager(AaveV3Ethereum.EMISSION_MANAGER).setEmissionAdmin(rsETH, rsETH_ADMIN);
  }
}
