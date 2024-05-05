// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {BaseAdaptersUpdatePayload, ICrossChainReceiver, ICrossChainForwarder} from './BaseAdaptersUpdatePayload.sol';
import {GovernanceV3Ethereum} from 'aave-address-book/GovernanceV3Ethereum.sol';
import {ChainIds} from 'aave-helpers/ChainIds.sol';

/**
 * @title Native bridge adapters update
 * @author BGD Labs @bgdlabs
 * - Discussion: https://governance.aave.com/t/bgd-technical-maintenance-proposals/15274/26
 */
contract AaveV3Ethereum_NativeBridgeAdaptersUpdate_20240322 is
  BaseAdaptersUpdatePayload(
    BaseAdaptersUpdatePayload.ConstructorInput({
      ccc: GovernanceV3Ethereum.CROSS_CHAIN_CONTROLLER,
      newAdapter: 0x1562F1b2487F892BBA8Ef325aF054Fd157510a71, // POLYGON native bridge adapter
      adapterToRemove: 0xb13712De579E1f9943502FFCf72eab6ec348cF79 // POLYGON native bridge adapter
    })
  )
{
  function getChainsToReceive() public pure override returns (uint256[] memory) {
    uint256[] memory chains = new uint256[](1);
    chains[0] = ChainIds.POLYGON;
    return chains;
  }

  function getForwarderBridgeAdaptersToEnable()
    public
    pure
    override
    returns (ICrossChainForwarder.ForwarderBridgeAdapterConfigInput[] memory)
  {
    ICrossChainForwarder.ForwarderBridgeAdapterConfigInput[]
      memory bridgeAdaptersToEnable = new ICrossChainForwarder.ForwarderBridgeAdapterConfigInput[](
        8
      );

    bridgeAdaptersToEnable[0] = ICrossChainForwarder.ForwarderBridgeAdapterConfigInput({
      currentChainBridgeAdapter: 0x88d6D01e08d3e64513b15fD46528dBbA7d755883,
      destinationBridgeAdapter: 0xc8a2ADC4261c6b669CdFf69E717E77C9cFeB420d,
      destinationChainId: ChainIds.ARBITRUM
    });
    bridgeAdaptersToEnable[1] = ICrossChainForwarder.ForwarderBridgeAdapterConfigInput({
      currentChainBridgeAdapter: 0x1562F1b2487F892BBA8Ef325aF054Fd157510a71,
      destinationBridgeAdapter: 0x853649f897383f89d8441346Cf26a9ed02720B02,
      destinationChainId: ChainIds.POLYGON
    });
    bridgeAdaptersToEnable[2] = ICrossChainForwarder.ForwarderBridgeAdapterConfigInput({
      currentChainBridgeAdapter: 0x0e24524778fdc67f53eEf144b8cbf50261E930B3,
      destinationBridgeAdapter: 0xAE93BEa44dcbE52B625169588574d31e36fb3A67,
      destinationChainId: ChainIds.OPTIMISM
    });
    bridgeAdaptersToEnable[3] = ICrossChainForwarder.ForwarderBridgeAdapterConfigInput({
      currentChainBridgeAdapter: 0x7238d75fD75bb936E83b75854c653F104Ce9c9d8,
      destinationBridgeAdapter: 0x3C06dce358add17aAf230f2234bCCC4afd50d090,
      destinationChainId: ChainIds.GNOSIS
    });
    bridgeAdaptersToEnable[4] = ICrossChainForwarder.ForwarderBridgeAdapterConfigInput({
      currentChainBridgeAdapter: 0xA4dC3F123e1c601A19B3DC8382BB9311F678cafA,
      destinationBridgeAdapter: 0x3C06dce358add17aAf230f2234bCCC4afd50d090,
      destinationChainId: ChainIds.SCROLL
    });
    bridgeAdaptersToEnable[5] = ICrossChainForwarder.ForwarderBridgeAdapterConfigInput({
      currentChainBridgeAdapter: 0xa5948b0ac79f72966dFFC5C13E44f6dfDD3D58A0,
      destinationBridgeAdapter: 0x7120b1f8e5b73c0C0DC99C6e52Fe4937E7EA11e0,
      destinationChainId: ChainIds.BASE
    });
    bridgeAdaptersToEnable[6] = ICrossChainForwarder.ForwarderBridgeAdapterConfigInput({
      currentChainBridgeAdapter: 0x6B3Dc800E7c813Db3fe8D0F30fDCaE636935dC14,
      destinationBridgeAdapter: 0xf41193E25408F652AF878c47E4401A01B5E4B682,
      destinationChainId: ChainIds.METIS
    });
    bridgeAdaptersToEnable[7] = ICrossChainForwarder.ForwarderBridgeAdapterConfigInput({
      currentChainBridgeAdapter: 0x6cfbd2aA4691fc18B9C209bDd43DC3943C228FCf,
      destinationBridgeAdapter: 0x6cfbd2aA4691fc18B9C209bDd43DC3943C228FCf,
      destinationChainId: ChainIds.MAINNET
    });

    return bridgeAdaptersToEnable;
  }

  function getForwarderBridgeAdaptersToRemove()
    public
    pure
    override
    returns (ICrossChainForwarder.BridgeAdapterToDisable[] memory)
  {
    ICrossChainForwarder.BridgeAdapterToDisable[]
      memory forwarderAdaptersToRemove = new ICrossChainForwarder.BridgeAdapterToDisable[](8);

    forwarderAdaptersToRemove[0] = ICrossChainForwarder.BridgeAdapterToDisable({
      bridgeAdapter: 0xE2a33403eaD139873820da597531f07f65ED0E3c,
      chainIds: new uint256[](1)
    });
    forwarderAdaptersToRemove[0].chainIds[0] = ChainIds.ARBITRUM;

    forwarderAdaptersToRemove[1] = ICrossChainForwarder.BridgeAdapterToDisable({
      bridgeAdapter: 0xb13712De579E1f9943502FFCf72eab6ec348cF79,
      chainIds: new uint256[](1)
    });
    forwarderAdaptersToRemove[1].chainIds[0] = ChainIds.POLYGON;

    forwarderAdaptersToRemove[2] = ICrossChainForwarder.BridgeAdapterToDisable({
      bridgeAdapter: 0x2ecC4F6CDbe6ea77107dd131Af81ec82Db330d6b,
      chainIds: new uint256[](1)
    });
    forwarderAdaptersToRemove[2].chainIds[0] = ChainIds.OPTIMISM;

    forwarderAdaptersToRemove[3] = ICrossChainForwarder.BridgeAdapterToDisable({
      bridgeAdapter: 0xe95B40b2CF5fA2F56AAEf9E52f5Bd1e70C059858,
      chainIds: new uint256[](1)
    });
    forwarderAdaptersToRemove[3].chainIds[0] = ChainIds.GNOSIS;

    forwarderAdaptersToRemove[4] = ICrossChainForwarder.BridgeAdapterToDisable({
      bridgeAdapter: 0xb29F03cbCc646201eC83E9F2C164747beA84b162,
      chainIds: new uint256[](1)
    });
    forwarderAdaptersToRemove[4].chainIds[0] = ChainIds.SCROLL;

    forwarderAdaptersToRemove[5] = ICrossChainForwarder.BridgeAdapterToDisable({
      bridgeAdapter: 0xEB442296880a3FC7C00FFe695c40B09d970fb936,
      chainIds: new uint256[](1)
    });
    forwarderAdaptersToRemove[5].chainIds[0] = ChainIds.BASE;

    forwarderAdaptersToRemove[6] = ICrossChainForwarder.BridgeAdapterToDisable({
      bridgeAdapter: 0x619643b346E3389062527cdb60C8720415B39860,
      chainIds: new uint256[](1)
    });
    forwarderAdaptersToRemove[6].chainIds[0] = ChainIds.METIS;

    forwarderAdaptersToRemove[7] = ICrossChainForwarder.BridgeAdapterToDisable({
      bridgeAdapter: 0x118DFD5418890c0332042ab05173Db4A2C1d283c,
      chainIds: new uint256[](1)
    });
    forwarderAdaptersToRemove[7].chainIds[0] = ChainIds.MAINNET;

    return forwarderAdaptersToRemove;
  }
}
