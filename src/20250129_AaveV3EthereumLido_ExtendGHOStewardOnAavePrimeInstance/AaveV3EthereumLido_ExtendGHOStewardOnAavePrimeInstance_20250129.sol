// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {AaveV3EthereumLido, AaveV3EthereumLidoAssets} from 'aave-address-book/AaveV3EthereumLido.sol';
import {IRiskSteward} from './IRiskSteward.sol';

/**
 * @title Extend GHO Steward on Aave Prime Instance
 * @author TokenLogic
 * - Snapshot: https://snapshot.org/#/s:aave.eth/proposal/0xf28190a683eff1dc246924f150a724dcf29b23dd40971df38d20fc6cf301fbe1
 * - Discussion: https://governance.aave.com/t/arfc-extend-gho-steward-on-aave-prime-instance/20598
 */
contract AaveV3EthereumLido_ExtendGHOStewardOnAavePrimeInstance_20250129 is
  IProposalGenericExecutor
{
  // https://etherscan.io/address/0x5C905d62B22e4DAa4967E517C4a047Ff6026C731
  address public constant NEW_GHO_AAVE_STEWARD = 0x5C905d62B22e4DAa4967E517C4a047Ff6026C731;
  function execute() external {
    // Gho Aave Steward
    AaveV3EthereumLido.ACL_MANAGER.grantRole(
      AaveV3EthereumLido.ACL_MANAGER.RISK_ADMIN_ROLE(),
      NEW_GHO_AAVE_STEWARD
    );

    IRiskSteward(AaveV3EthereumLido.RISK_STEWARD).setAddressRestricted(
      AaveV3EthereumLidoAssets.GHO_UNDERLYING,
      true
    );
  }
}
