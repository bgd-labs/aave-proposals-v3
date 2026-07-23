import {Hex, PublicClient} from 'viem';
import {IHubV4_ABI, ISpokeV4_ABI} from '@aave-dao/aave-address-book/abis';
import {CHAIN_TO_CHAIN_ID, getMarketChain} from '../../common';
import {MarketIdentifierV4} from '../../types';
import {getClient} from '@aave-dao/toolbox';

export const PAUSED_MASK = 0x01;
export const FROZEN_MASK = 0x02;
export const BORROWABLE_MASK = 0x04;
export const RECEIVE_SHARES_ENABLED_MASK = 0x08;

export type HubAssetSnapshot = {
  assetId: number;
  underlying: Hex;
  decimals: number;
  liquidityFee: number;
  irStrategy: Hex;
  reinvestmentController: Hex;
  feeReceiver: Hex;
};

export type SpokeReserveSnapshot = {
  reserveId: number;
  underlying: Hex;
  hub: Hex;
  assetId: number;
  decimals: number;
  collateralRisk: number;
  paused: boolean;
  frozen: boolean;
  borrowable: boolean;
  receiveSharesEnabled: boolean;
  dynamicConfigKey: number;
};

export function getViemClientForMarket(
  market: MarketIdentifierV4,
  _blockNumber?: number,
): PublicClient {
  const chain = getMarketChain(market);
  return getClient(CHAIN_TO_CHAIN_ID[chain], {
    providerConfig: {alchemyKey: process.env.ALCHEMY_API_KEY},
  }) as unknown as PublicClient;
}

export async function readHubAssets(
  market: MarketIdentifierV4,
  hub: Hex,
  blockNumber?: number,
): Promise<HubAssetSnapshot[]> {
  const client = getViemClientForMarket(market);
  const count = await client.readContract({
    address: hub,
    abi: IHubV4_ABI,
    functionName: 'getAssetCount',
    blockNumber: blockNumber !== undefined ? BigInt(blockNumber) : undefined,
  });
  const out: HubAssetSnapshot[] = [];
  for (let assetId = 0; assetId < Number(count); assetId++) {
    const asset = (await client.readContract({
      address: hub,
      abi: IHubV4_ABI,
      functionName: 'getAsset',
      args: [BigInt(assetId)],
      blockNumber: blockNumber !== undefined ? BigInt(blockNumber) : undefined,
    })) as any;
    out.push({
      assetId,
      underlying: asset.underlying,
      decimals: Number(asset.decimals),
      liquidityFee: Number(asset.liquidityFee),
      irStrategy: asset.irStrategy,
      reinvestmentController: asset.reinvestmentController,
      feeReceiver: asset.feeReceiver,
    });
  }
  return out;
}

export async function readHubSpokeAddresses(
  market: MarketIdentifierV4,
  hub: Hex,
  assetId: number,
  blockNumber?: number,
): Promise<Hex[]> {
  const client = getViemClientForMarket(market);
  const count = await client.readContract({
    address: hub,
    abi: IHubV4_ABI,
    functionName: 'getSpokeCount',
    args: [BigInt(assetId)],
    blockNumber: blockNumber !== undefined ? BigInt(blockNumber) : undefined,
  });
  const out: Hex[] = [];
  for (let i = 0; i < Number(count); i++) {
    const addr = (await client.readContract({
      address: hub,
      abi: IHubV4_ABI,
      functionName: 'getSpokeAddress',
      args: [BigInt(assetId), BigInt(i)],
      blockNumber: blockNumber !== undefined ? BigInt(blockNumber) : undefined,
    })) as Hex;
    out.push(addr);
  }
  return out;
}

export async function readSpokeReserves(
  market: MarketIdentifierV4,
  spoke: Hex,
  blockNumber?: number,
): Promise<SpokeReserveSnapshot[]> {
  const client = getViemClientForMarket(market);
  const count = await client.readContract({
    address: spoke,
    abi: ISpokeV4_ABI,
    functionName: 'getReserveCount',
    blockNumber: blockNumber !== undefined ? BigInt(blockNumber) : undefined,
  });
  const out: SpokeReserveSnapshot[] = [];
  for (let reserveId = 0; reserveId < Number(count); reserveId++) {
    const r = (await client.readContract({
      address: spoke,
      abi: ISpokeV4_ABI,
      functionName: 'getReserve',
      args: [BigInt(reserveId)],
      blockNumber: blockNumber !== undefined ? BigInt(blockNumber) : undefined,
    })) as any;
    const flags = Number(r.flags);
    out.push({
      reserveId,
      underlying: r.underlying,
      hub: r.hub,
      assetId: Number(r.assetId),
      decimals: Number(r.decimals),
      collateralRisk: Number(r.collateralRisk),
      paused: (flags & PAUSED_MASK) !== 0,
      frozen: (flags & FROZEN_MASK) !== 0,
      borrowable: (flags & BORROWABLE_MASK) !== 0,
      receiveSharesEnabled: (flags & RECEIVE_SHARES_ENABLED_MASK) !== 0,
      dynamicConfigKey: Number(r.dynamicConfigKey),
    });
  }
  return out;
}

export function isAssetListedOnHub(
  snapshots: HubAssetSnapshot[],
  underlying: Hex,
): HubAssetSnapshot | undefined {
  const lower = underlying.toLowerCase();
  return snapshots.find((s) => s.underlying.toLowerCase() === lower);
}

export function isReserveListedOnSpoke(
  snapshots: SpokeReserveSnapshot[],
  underlying: Hex,
): SpokeReserveSnapshot | undefined {
  const lower = underlying.toLowerCase();
  return snapshots.find((s) => s.underlying.toLowerCase() === lower);
}
