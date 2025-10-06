// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';

/**
 * @title Adopt The SEAL Safe Harbor Agreement
 * @author BGD Labs (@bgdlabs)
 * - Discussion: https://governance.aave.com/t/arfc-adopt-the-seal-safe-harbor-agreement/23059
 */
contract AaveV3Ethereum_AdoptTheSEALSafeHarborAgreement_20251006 is IProposalGenericExecutor {
  ISafeHarborRegistry public constant REGISTRY =
    ISafeHarborRegistry(0x1eaCD100B0546E433fbf4d773109cAD482c34686);
  address public constant AGREEMENT = 0x585aFfCCFF9398AfdB12bDfF2E74182437f45aF0;

  function execute() external {
    REGISTRY.adoptSafeHarbor(AGREEMENT);
  }
}

interface ISafeHarborRegistry {
  function adoptSafeHarbor(address agreementAddress) external;
  function getAgreement(address adopter) external view returns (address);
}
