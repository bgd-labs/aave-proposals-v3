// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV4Payload, IAaveV4ConfigEngine} from 'aave-v4/config-engine/AaveV4Payload.sol';
import {EngineFlags} from 'aave-v4/config-engine/libraries/EngineFlags.sol';
import {IHubConfigurator, ISpoke, IHub} from 'aave-address-book/AaveV4.sol';

library AaveV4AvalancheRound11 {
  // https://snowscan.xyz/address/0x1F0C67Fde7FcaF7eCEA43b76A23461803972c45c
  IAaveV4ConfigEngine internal constant CONFIG_ENGINE =
    IAaveV4ConfigEngine(0x1F0C67Fde7FcaF7eCEA43b76A23461803972c45c);
  // https://snowscan.xyz/address/0xbdf92ed96FF6D678469aFAFFa1e7d37B25beaa33
  IHubConfigurator internal constant HUB_CONFIGURATOR =
    IHubConfigurator(0xbdf92ed96FF6D678469aFAFFa1e7d37B25beaa33);
  // https://snowscan.xyz/address/0xd07369fAE4A5BB13c9Ce446B052c7867B1AbDf6e
  IHub internal constant CORE_HUB = IHub(0xd07369fAE4A5BB13c9Ce446B052c7867B1AbDf6e);
  // https://snowscan.xyz/address/0x6a37776B5E026dBdF043b4F933c323C84DD1B514
  ISpoke internal constant FOREX_SPOKE = ISpoke(0x6a37776B5E026dBdF043b4F933c323C84DD1B514);

  // https://snowscan.xyz/address/0xB97EF9Ef8734C71904D8002F8b6Bc66Dd9c48a6E
  address internal constant USDC = 0xB97EF9Ef8734C71904D8002F8b6Bc66Dd9c48a6E;
  // https://snowscan.xyz/address/0x9702230A8Ea53601f5cD2dc00fDBc13d4dF4A8c7
  address internal constant USDt = 0x9702230A8Ea53601f5cD2dc00fDBc13d4dF4A8c7;
}

/**
 * @title Increase add and draw caps on Avalanche
 * @author Llama Risk (implemented by Aave Labs)
 * - Discussion: https://governance.aave.com/t/arfc-aave-v4-activation-on-ethereum-mainnet/24293/38
 * - To be executed by the Aave Security Council
 */
contract AaveV4Avalanche_IncreaseCaps_20260723 is AaveV4Payload {
  constructor() AaveV4Payload(AaveV4AvalancheRound11.CONFIG_ENGINE) {}

  // prettier-ignore
  function hubSpokeConfigUpdates()
    public
    pure
    override
    returns (IAaveV4ConfigEngine.SpokeConfigUpdate[] memory)
  {
    IAaveV4ConfigEngine.SpokeConfigUpdate[]
      memory updates = new IAaveV4ConfigEngine.SpokeConfigUpdate[](2);

    uint256 i = 0;

    //                             hub                                  spoke                                    asset                        addCap   drawCap
    updates[i++] = _capUpdate(AaveV4AvalancheRound11.CORE_HUB,     AaveV4AvalancheRound11.FOREX_SPOKE,      AaveV4AvalancheRound11.USDC, 400_000, 350_000);
    updates[i++] = _capUpdate(AaveV4AvalancheRound11.CORE_HUB,     AaveV4AvalancheRound11.FOREX_SPOKE,      AaveV4AvalancheRound11.USDt, 400_000, 350_000);

    require(i == updates.length, 'Invalid number of updates');
    return updates;
  }

  function _capUpdate(
    IHub hub,
    ISpoke spoke,
    address underlying,
    uint256 addCap,
    uint256 drawCap
  ) internal pure returns (IAaveV4ConfigEngine.SpokeConfigUpdate memory) {
    return
      IAaveV4ConfigEngine.SpokeConfigUpdate({
        hubConfigurator: AaveV4AvalancheRound11.HUB_CONFIGURATOR,
        hub: address(hub),
        underlying: underlying,
        spoke: address(spoke),
        addCap: addCap,
        drawCap: drawCap,
        riskPremiumThreshold: EngineFlags.KEEP_CURRENT,
        active: EngineFlags.KEEP_CURRENT,
        halted: EngineFlags.KEEP_CURRENT
      });
  }
}
