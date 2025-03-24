// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {ISvrOracleSteward} from './ISvrOracleSteward.sol';

/**
 * @title Enable SVR
 * @author BGD Labs @bgdlabs
 * - Snapshot: https://snapshot.box/#/s:aave.eth/proposal/0xe260268c607f20c85d1f93323f2f58b05f202916e0d3dbf55a8c335ed9be92da
 * - Discussion: https://governance.aave.com/t/arfc-aave-chainlink-svr-v1-phase-1-activation/21247
 */
contract AaveV3Ethereum_EnableSVR_20250312 is IProposalGenericExecutor {
  address public constant STEWARD = 0x8b493f416F5F7933cC146b1899c069F2361cad60;

  address public constant SVR_BTC_USD = 0xb41E773f507F7a7EA890b1afB7d2b660c30C8B0A;
  address public constant SVR_AAVE_USD = 0xF02C1e2A3B77c1cacC72f72B44f7d0a4c62e4a85;
  address public constant SVR_LINK_USD = 0xC7e9b623ed51F033b32AE7f1282b1AD62C28C183;

  function execute() external {
    AaveV3Ethereum.ACL_MANAGER.addAssetListingAdmin(STEWARD);
    ISvrOracleSteward.AssetOracle[] memory configInput = new ISvrOracleSteward.AssetOracle[](4);
    configInput[0] = ISvrOracleSteward.AssetOracle({
      asset: AaveV3EthereumAssets.LBTC_UNDERLYING,
      svrOracle: SVR_BTC_USD
    });
    configInput[1] = ISvrOracleSteward.AssetOracle({
      asset: AaveV3EthereumAssets.tBTC_UNDERLYING,
      svrOracle: SVR_BTC_USD
    });
    configInput[2] = ISvrOracleSteward.AssetOracle({
      asset: AaveV3EthereumAssets.AAVE_UNDERLYING,
      svrOracle: SVR_AAVE_USD
    });
    configInput[3] = ISvrOracleSteward.AssetOracle({
      asset: AaveV3EthereumAssets.LINK_UNDERLYING,
      svrOracle: SVR_LINK_USD
    });
    ISvrOracleSteward(STEWARD).enableSvrOracles(configInput);
  }
}
