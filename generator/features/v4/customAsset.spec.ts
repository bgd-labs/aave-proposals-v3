import {expect, describe, it} from 'vitest';
import {hubAssetListing} from './hub/hubAssetListing';
import {spokeReserveListing} from './spoke/spokeReserveListing';
import {assetIdentifier, checksumAddress} from './testHelpers';
import {literal} from './sentinels';
import {V4HubAssetListing, V4SpokeReserveListing} from '../types';
import {Options} from '../../types';

const HUB = 'AaveV4EthereumHubs.CORE_HUB';
const SPOKE = 'AaveV4EthereumSpokes.MAIN_SPOKE';
const ADDR = '0x2222222222222222222222222222222222222222';
// lower-cased input to assert checksumming + identifier derivation
const CUSTOM = '0xa0b86991c6218b36c1d19d4a2e9eb0ce3606eb48';
const CUSTOM_CHECKSUMMED = '0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48';

const OPTS: Options = {
  markets: ['AaveV4Ethereum'],
  title: 'V4 custom asset',
  shortName: 'V4CustomAsset',
  date: '20260521',
  author: 'test',
  discussion: 'test',
  snapshot: 'test',
};

const ctx = {
  options: OPTS,
  market: 'AaveV4Ethereum' as const,
  cache: {blockNumber: 42},
  configs: {},
};

describe('assetIdentifier', () => {
  it('strips a library accessor down to its asset key', () => {
    expect(assetIdentifier('AaveV4EthereumAssets.WETH_UNDERLYING')).toBe('WETH');
  });

  it('derives a Solidity-safe key from a raw address', () => {
    expect(assetIdentifier(CUSTOM)).toBe('CUSTOM_3606EB48');
  });
});

describe('checksumAddress', () => {
  it('checksums a raw hex address', () => {
    expect(checksumAddress(CUSTOM)).toBe(CUSTOM_CHECKSUMMED);
  });

  it('returns a library accessor verbatim', () => {
    expect(checksumAddress('AaveV4EthereumAssets.WETH_UNDERLYING')).toBe(
      'AaveV4EthereumAssets.WETH_UNDERLYING',
    );
  });
});

describe('listing a custom ERC20 address', () => {
  it('hubAssetListing builds valid identifiers and a checksummed underlying', () => {
    const cfg: V4HubAssetListing[] = [
      {
        hubLib: HUB,
        hub: HUB,
        underlying: checksumAddress(CUSTOM),
        feeReceiver: ADDR,
        liquidityFee: '100',
        irStrategy: ADDR,
        irData: {
          optimalUsageRatio: literal('8000'),
          baseDrawnRate: literal('0'),
          rateGrowthBeforeOptimal: literal('400'),
          rateGrowthAfterOptimal: literal('6000'),
        },
        tokenization: undefined,
      },
    ];
    const out = hubAssetListing.build({...ctx, cfg});
    expect(out.code!.constants!.join('\n')).toContain('CORE_HUB_CUSTOM_3606EB48_FEE_RECEIVER');
    expect(out.code!.v4Getters!.hubAssetListings.entries[0]).toContain(
      `underlying: ${CUSTOM_CHECKSUMMED}`,
    );
    expect(out.test!.fn![0]).toContain('test_hubAssetListing_CORE_HUB_CUSTOM_3606EB48');
  });

  it('spokeReserveListing builds a valid price-feed constant and checksummed underlying', () => {
    const cfg: V4SpokeReserveListing[] = [
      {
        spokeLib: SPOKE,
        spoke: SPOKE,
        hub: HUB,
        underlying: checksumAddress(CUSTOM),
        priceSource: ADDR,
        config: {
          collateralRisk: '0',
          paused: false,
          frozen: false,
          borrowable: true,
          receiveSharesEnabled: true,
        },
        dynamicConfig: {
          collateralFactor: '8000',
          maxLiquidationBonus: '500',
          liquidationFee: '100',
        },
      },
    ];
    const out = spokeReserveListing.build({...ctx, cfg});
    expect(out.code!.constants!.join('\n')).toContain('MAIN_SPOKE_CUSTOM_3606EB48_PRICE_FEED');
    expect(out.code!.v4Getters!.spokeReserveListings.entries[0]).toContain(
      `underlying: ${CUSTOM_CHECKSUMMED}`,
    );
    expect(out.test!.fn![0]).toContain('test_spokeReserveListing_MAIN_SPOKE_CUSTOM_3606EB48');
  });
});
