// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {AaveV3EthereumLido, AaveV3EthereumLidoAssets} from 'aave-address-book/AaveV3EthereumLido.sol';
import {AaveV3EthereumEtherFi} from 'aave-address-book/AaveV3EthereumEtherFi.sol';
import {IRiskSteward} from 'src/interfaces/IRiskSteward.sol';

/**
 * @title Aave V3.7 RiskSteward Update on Ethereum (Core, Prime, EtherFi)
 * @author BGD Labs @bgdlabs
 * - Discussion: https://governance.aave.com/t/arfc-bgd-aave-v3-7/24075
 */
contract AaveV3Ethereum_RiskStewardsUpdate_20260331 is IProposalGenericExecutor {
  address public constant NEW_RISK_STEWARD_CORE = 0x13a9CC64344b02bACC5AD9Cf38B5711F1B9ec3d4;
  address public constant NEW_RISK_STEWARD_LIDO = 0x5BA8d98feE911C2422EbEBFB6b774128924CcD68;
  address public constant NEW_RISK_STEWARD_ETHERFI = 0x9Db34dC89D9BC56A5E2899c328D959eF9E072645;

  function execute() external {
    // Core
    AaveV3Ethereum.ACL_MANAGER.addRiskAdmin(NEW_RISK_STEWARD_CORE);
    AaveV3Ethereum.ACL_MANAGER.removeRiskAdmin(AaveV3Ethereum.RISK_STEWARD);
    IRiskSteward(NEW_RISK_STEWARD_CORE).setAddressRestricted(
      AaveV3EthereumAssets.GHO_UNDERLYING,
      true
    );

    // Prime (Lido)
    AaveV3EthereumLido.ACL_MANAGER.addRiskAdmin(NEW_RISK_STEWARD_LIDO);
    AaveV3EthereumLido.ACL_MANAGER.removeRiskAdmin(AaveV3EthereumLido.RISK_STEWARD);
    IRiskSteward(NEW_RISK_STEWARD_LIDO).setAddressRestricted(
      AaveV3EthereumLidoAssets.GHO_UNDERLYING,
      true
    );

    // EtherFi
    AaveV3EthereumEtherFi.ACL_MANAGER.addRiskAdmin(NEW_RISK_STEWARD_ETHERFI);
    AaveV3EthereumEtherFi.ACL_MANAGER.removeRiskAdmin(AaveV3EthereumEtherFi.RISK_STEWARD);
  }
}
