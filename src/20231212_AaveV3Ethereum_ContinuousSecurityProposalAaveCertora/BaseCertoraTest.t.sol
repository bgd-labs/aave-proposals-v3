// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {MiscEthereum} from 'aave-address-book/MiscEthereum.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets, ICollector} from 'aave-address-book/AaveV3Ethereum.sol';
import {GovV3Helpers, IPayloadsControllerCore, PayloadsControllerUtils} from 'aave-helpers/GovV3Helpers.sol';
import {GovHelpers, AaveGovernanceV2} from 'aave-helpers/GovHelpers.sol';
import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV3Ethereum_ContinuousSecurityProposalAaveCertoraPart1_20231212} from './AaveV3Ethereum_ContinuousSecurityProposalAaveCertoraPart1_20231212.sol';
import {AaveV3Ethereum_ContinuousSecurityProposalAaveCertoraPart2_20231212} from './AaveV3Ethereum_ContinuousSecurityProposalAaveCertoraPart2_20231212.sol';
import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {CertoraProposalDeployer} from './ContinuousSecurityProposalAaveCertora_20231212.s.sol';

contract BaseCertoraTest is ProtocolV3TestBase {
  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 18771153);
    CertoraProposalDeployer._deployPart1();
    CertoraProposalDeployer._deployPart2();
    vm.startPrank(MiscEthereum.ECOSYSTEM_RESERVE);
    CertoraProposalDeployer._deployProposal(vm);
    vm.stopPrank();
  }

  function execute() internal {
    uint256 proposalsCount = AaveGovernanceV2.GOV.getProposalsCount();
    GovHelpers.passVoteAndExecute(vm, proposalsCount - 1);
    // execute part 1 (gov v3)
    IPayloadsControllerCore payloadsController = GovV3Helpers.getPayloadsController(block.chainid);
    uint40 count = payloadsController.getPayloadsCount();
    GovV3Helpers.executePayload(vm, count - 1);
  }
}
