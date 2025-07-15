// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3EthereumAssets, AaveV3EthereumEModes} from 'aave-address-book/AaveV3Ethereum.sol';
import {AaveV3PayloadEthereum} from 'aave-helpers/src/v3-config-engine/AaveV3PayloadEthereum.sol';
import {EngineFlags} from 'aave-v3-origin/contracts/extensions/v3-config-engine/EngineFlags.sol';
import {IAaveV3ConfigEngine} from 'aave-v3-origin/contracts/extensions/v3-config-engine/IAaveV3ConfigEngine.sol';
/**
 * @title Addition of USDe to Ethena Principal Token Stablecoin E-Modes
 * @author Aave-Chan Initiative
 * - Snapshot: https://snapshot.box/#/s:aavedao.eth/proposal/0x92235fc2feaa585d700789395bb69374d4de1a7a2735a7565815f8423009f160
 * - Discussion: https://governance.aave.com/t/arfc-addition-of-usde-to-ethena-principal-token-stablecoin-e-modes/22355
 */
contract AaveV3Ethereum_AdditionOfUSDeToEthenaPrincipalTokenStablecoinEModes_20250623 is
  AaveV3PayloadEthereum
{
  function assetsEModeUpdates()
    public
    pure
    override
    returns (IAaveV3ConfigEngine.AssetEModeUpdate[] memory)
  {
    IAaveV3ConfigEngine.AssetEModeUpdate[]
      memory assetEModeUpdates = new IAaveV3ConfigEngine.AssetEModeUpdate[](2);

    assetEModeUpdates[0] = IAaveV3ConfigEngine.AssetEModeUpdate({
      asset: AaveV3EthereumAssets.USDe_UNDERLYING,
      eModeCategory: AaveV3EthereumEModes.PT_EUSDE_STABLECOINS_AUGUST_2025,
      borrowable: EngineFlags.ENABLED,
      collateral: EngineFlags.KEEP_CURRENT
    });
    assetEModeUpdates[1] = IAaveV3ConfigEngine.AssetEModeUpdate({
      asset: AaveV3EthereumAssets.USDe_UNDERLYING,
      eModeCategory: AaveV3EthereumEModes.PT_USDE_STABLECOINS_JULY_2025,
      borrowable: EngineFlags.ENABLED,
      collateral: EngineFlags.KEEP_CURRENT
    });

    return assetEModeUpdates;
  }
}
