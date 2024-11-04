// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {MiscEthereum} from 'aave-address-book/MiscEthereum.sol';
import {IACLManager} from 'aave-address-book/AaveV3.sol';
import {IAccessControl} from '@openzeppelin/contracts/access/IAccessControl.sol';
import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';

import {IGhoBucketSteward} from 'src/interfaces/IGhoBucketSteward.sol';
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
  // https://etherscan.io/address/0x46Aa1063e5265b43663E81329333B47c517A5409
  address public constant GHO_BUCKET_STEWARD = 0x46Aa1063e5265b43663E81329333B47c517A5409;

  // https://etherscan.io/address/0xfeb4e54591660f42288312ae8eb59e9f2b746b66
  address public constant GHO_AAVE_STEWARD = 0xFEb4e54591660F42288312AE8eB59e9f2B746b66;

  // https://etherscan.io/address/0x101efb7b9beb073b1219cd5473a7c8a2f2eb84f4
  address public constant GHO_CCIP_STEWARD = 0x101Efb7b9Beb073B1219Cd5473a7C8A2f2EB84f4;

  // https://etherscan.io/address/0xd1e856a947cdf56b4f000ee29d34f5808e0a6848
  address public constant GHO_GSM_STEWARD = 0xD1E856a947CdF56b4f000ee29d34F5808E0A6848;

  // https://etherscan.io/address/0xb9481a29f0f996BCAc759aB201FB3844c81866c4
  address public constant OLD_STEWARD = 0xb9481a29f0f996BCAc759aB201FB3844c81866c4;

  function execute() external {
    // Old Gho Steward
    AaveV3Ethereum.ACL_MANAGER.removeRiskAdmin(OLD_STEWARD);

    IGhoToken(AaveV3EthereumAssets.GHO_UNDERLYING).revokeRole(
      IGhoToken(AaveV3EthereumAssets.GHO_UNDERLYING).BUCKET_MANAGER_ROLE(),
      OLD_STEWARD
    );

    IGsm(MiscEthereum.GSM_USDC).revokeRole(
      IGsm(MiscEthereum.GSM_USDC).CONFIGURATOR_ROLE(),
      OLD_STEWARD
    );

    IGsm(MiscEthereum.GSM_USDT).revokeRole(
      IGsm(MiscEthereum.GSM_USDT).CONFIGURATOR_ROLE(),
      OLD_STEWARD
    );

    // Gho Bucket Steward
    IGhoToken(AaveV3EthereumAssets.GHO_UNDERLYING).grantRole(
      IGhoToken(AaveV3EthereumAssets.GHO_UNDERLYING).BUCKET_MANAGER_ROLE(),
      GHO_BUCKET_STEWARD
    );

    address[] memory controlledFacilitators = new address[](3);
    controlledFacilitators[0] = AaveV3EthereumAssets.GHO_A_TOKEN;
    controlledFacilitators[1] = MiscEthereum.GSM_USDC;
    controlledFacilitators[2] = MiscEthereum.GSM_USDT;
    IGhoBucketSteward(GHO_BUCKET_STEWARD).setControlledFacilitator(controlledFacilitators, true);

    // Gho Aave Steward
    IAccessControl(address(AaveV3Ethereum.ACL_MANAGER)).grantRole(
      IACLManager(address(AaveV3Ethereum.ACL_MANAGER)).RISK_ADMIN_ROLE(),
      GHO_AAVE_STEWARD
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
