// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Ethereum} from 'aave-address-book/AaveV3Ethereum.sol';
import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';

/**
 * @title addFlashborrowers
 * @author Aave Chan Initiative
 * - Snapshot: https://snapshot.org/#/aave.eth/proposal/0x09bb9e7cffc974d330d82ce7a0b0502b573d6f3b4f839ea15d6629613901e96d
 * - Discussion: https://governance.aave.com/t/arfc-add-contango-protocol-cian-protocol-and-index-coop-to-flashborrowers-on-aave-v3/16478
 */
contract AaveV3Ethereum_AddFlashborrowers_20240306 is IProposalGenericExecutor {
  address public constant CONTANGO_PROTOCOL = 0xab515542d621574f9b5212d50593cD0C07e641bD;
  address public constant CIAN_PROTOCOL = 0x85105b7E11c442Ca6fF6b4d90d7a439f68376Ac4;
  address public constant INDEXCOOP_FLASHBORROWER = 0x45c00508C14601fd1C1e296eB3C0e3eEEdCa45D0;
  address public constant INDEXCOOP_ETHX2 = 0x6e8ac99B2ec2e08600c7d0Aab970f31e9b11957a;
  address public constant INDEXCOOP_BTCX2 = 0x3a657Ec8a755d2E43DDbfDeaDc15899EDaf8dcf8;
  address public constant ALIGNED_PROTOCOL_1 = 0xb5b29320d2Dde5BA5BAFA1EbcD270052070483ec;
  address public constant ALIGNED_PROTOCOL_2 = 0x0274a704a6D9129F90A62dDC6f6024b33EcDad36;

  function execute() external {
    AaveV3Ethereum.ACL_MANAGER.addFlashBorrower(CONTANGO_PROTOCOL);
    AaveV3Ethereum.ACL_MANAGER.addFlashBorrower(CIAN_PROTOCOL);
    AaveV3Ethereum.ACL_MANAGER.addFlashBorrower(INDEXCOOP_FLASHBORROWER);
    AaveV3Ethereum.ACL_MANAGER.addFlashBorrower(INDEXCOOP_ETHX2);
    AaveV3Ethereum.ACL_MANAGER.addFlashBorrower(INDEXCOOP_BTCX2);
    AaveV3Ethereum.ACL_MANAGER.addFlashBorrower(ALIGNED_PROTOCOL_1);
    AaveV3Ethereum.ACL_MANAGER.addFlashBorrower(ALIGNED_PROTOCOL_2);
  }
}
