import {expect, describe, it} from 'vitest';
import {pushSpokeAssets} from './hubSpokeToAssetsAddition';
import {V4HubSpokeToAssetsAddition} from '../../types';

const HUB = 'AaveV4EthereumHubs.CORE_HUB';
const SPOKE = 'AaveV4EthereumSpokes.MAIN_SPOKE';

const asset = (underlying: string): V4HubSpokeToAssetsAddition['assets'] => [
  {
    underlying,
    addCap: '1000',
    drawCap: '500',
    riskPremiumThreshold: '1',
    active: true,
    halted: false,
  },
];

describe('pushSpokeAssets', () => {
  it('collects assets registered on the same (hub, spoke) under one entry', () => {
    const additions: V4HubSpokeToAssetsAddition[] = [];
    const target = {hubLib: HUB, hub: HUB, spoke: SPOKE};
    pushSpokeAssets(additions, target, asset('WETH'));
    pushSpokeAssets(additions, target, asset('USDC'));

    expect(additions).toHaveLength(1);
    expect(additions[0].assets.map((a) => a.underlying)).toEqual(['WETH', 'USDC']);
  });

  it('keeps a separate entry per spoke', () => {
    const additions: V4HubSpokeToAssetsAddition[] = [];
    pushSpokeAssets(additions, {hubLib: HUB, hub: HUB, spoke: SPOKE}, asset('WETH'));
    pushSpokeAssets(additions, {hubLib: HUB, hub: HUB, spoke: 'OTHER_SPOKE'}, asset('WETH'));

    expect(additions.map((a) => a.spoke)).toEqual([SPOKE, 'OTHER_SPOKE']);
  });

  it('does not alias the assets array passed in', () => {
    const additions: V4HubSpokeToAssetsAddition[] = [];
    const assets = asset('WETH');
    pushSpokeAssets(additions, {hubLib: HUB, hub: HUB, spoke: SPOKE}, assets);
    pushSpokeAssets(additions, {hubLib: HUB, hub: HUB, spoke: SPOKE}, asset('USDC'));

    expect(assets).toHaveLength(1);
  });
});
