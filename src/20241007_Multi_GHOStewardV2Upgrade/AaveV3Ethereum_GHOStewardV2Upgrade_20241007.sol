// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {MiscEthereum} from 'aave-address-book/MiscEthereum.sol';
import {IACLManager} from 'aave-address-book/AaveV3.sol';
import {IAccessControl} from '@openzeppelin/contracts/access/IAccessControl.sol';
import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';

import {IGhoToken} from 'src/interfaces/IGhoToken.sol';
import {IGsm} from 'src/interfaces/IGsm.sol';
import {IUpgradeableLockReleaseTokenPool} from 'src/interfaces/ccip/IUpgradeableLockReleaseTokenPool.sol';

/**
 * @title GHO Steward v2 Upgrade
 * @author @karpatkey_TokenLogic
 * - Snapshot: https://snapshot.org/#/aave.eth/proposal/0xc5e7df1536ef9fc71a7d2e2f6fee6e4e20e37a50b4e0f1646616d066b8697da5
 * - Discussion: https://governance.aave.com/t/arfc-gho-steward-v2-upgrade/19116
 */
contract AaveV3Ethereum_GHOStewardV2Upgrade_20241007 is IProposalGenericExecutor {
  // https://etherscan.io/address/0x5b31304e24287e31873ffda82e6f1956ec61c74c
  address public constant GHO_BUCKET_STEWARD = 0x5b31304e24287E31873FFdA82e6f1956EC61c74c;

  // https://etherscan.io/address/0xfeb4e54591660f42288312ae8eb59e9f2b746b66
  address public constant GHO_AAVE_STEWARD = 0xFEb4e54591660F42288312AE8eB59e9f2B746b66;

  // https://etherscan.io/address/0x101efb7b9beb073b1219cd5473a7c8a2f2eb84f4
  address public constant GHO_CCIP_STEWARD = 0x101Efb7b9Beb073B1219Cd5473a7C8A2f2EB84f4;

  address public constant GHO_GSM_STEWARD = address(0); // TODO

  function execute() external {
    address ACL_MANAGER = AaveV3Ethereum.POOL_ADDRESSES_PROVIDER.getACLManager();

    // Gho Bucket Steward
    IGhoToken(AaveV3EthereumAssets.GHO_UNDERLYING).grantRole(
      IGhoToken(AaveV3EthereumAssets.GHO_UNDERLYING).BUCKET_MANAGER_ROLE(),
      address(GHO_BUCKET_STEWARD)
    );

    // Gho Aave Steward
    IAccessControl(ACL_MANAGER).grantRole(
      IACLManager(ACL_MANAGER).RISK_ADMIN_ROLE(),
      address(GHO_AAVE_STEWARD)
    );

    // Gho CCIP Steward
    IUpgradeableLockReleaseTokenPool(MiscEthereum.GHO_CCIP_TOKEN_POOL).setRateLimitAdmin(
      GHO_CCIP_STEWARD
    );
    IUpgradeableLockReleaseTokenPool(MiscEthereum.GHO_CCIP_TOKEN_POOL).setBridgeLimitAdmin(
      GHO_CCIP_STEWARD
    );

    // GHO GSM Steward
    IGsm(MiscEthereum.GSM_USDC).grantRole(
      IGsm(MiscEthereum.GSM_USDC).CONFIGURATOR_ROLE(),
      GHO_GSM_STEWARD
    );
    IGsm(MiscEthereum.GSM_USDT).grantRole(
      IGsm(MiscEthereum.GSM_USDT).CONFIGURATOR_ROLE(),
      GHO_GSM_STEWARD
    );
  }
}
