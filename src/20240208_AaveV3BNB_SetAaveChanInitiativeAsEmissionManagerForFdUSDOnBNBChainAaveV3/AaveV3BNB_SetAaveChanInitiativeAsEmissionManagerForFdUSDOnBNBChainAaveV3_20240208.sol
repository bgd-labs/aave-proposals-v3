// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';
import {AaveV3BNB, AaveV3BNBAssets} from 'aave-address-book/AaveV3BNB.sol';
import {IEmissionManager} from 'aave-v3-periphery/contracts/rewards/interfaces/IEmissionManager.sol';

/**
 * @title Set Aave Chan Initiative as Emission Manager for fdUSD on BNB Chain Aave V3
 * @author  Aave Chan Initiative (ACI)
 * - Snapshot: https://snapshot.org/#/aave.eth/proposal/0x4db0fe8cb6c21abd34e4d38836db72ed7f1b06c91386ec9e637df8786a289d0d
 * - Discussion: https://governance.aave.com/t/arfc-set-aave-chan-initiative-as-emission-manager-for-fdusd-on-bnb-chain-aave-v3/16558
 */
contract AaveV3BNB_SetAaveChanInitiativeAsEmissionManagerForFdUSDOnBNBChainAaveV3_20240208 is
  IProposalGenericExecutor
{
  address constant EMISSION_ADMIN = 0xac140648435d03f784879cd789130F22Ef588Fcd;

  function execute() external {
    IEmissionManager(AaveV3BNB.EMISSION_MANAGER).setEmissionAdmin(
      AaveV3BNBAssets.FDUSD_UNDERLYING,
      EMISSION_ADMIN
    );
  }
}
