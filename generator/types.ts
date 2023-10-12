import * as addressBook from '@bgd-labs/aave-address-book';

export interface Options {
  force: boolean;
  pools: PoolIdentifier[];
  title: string;
  // automatically generated shortName from title
  shortName: string;
  author: string;
  discussion: string;
  snapshot: string;
  configFile: string;
}

export interface PoolConfig {
  features: string[];
  artifacts: CodeArtifact[];
  configs: {[feature: string]: {}};
}

export type PoolConfigs = Partial<Record<PoolIdentifier, PoolConfig>>;

export type CodeArtifact = {
  code?: {
    constants?: string[];
    fn?: string[];
    execute?: string[];
  };
  test?: {
    fn?: string[];
  };
};

export type Feature = {
  name: string;
  value: string;
  module?: FeatureModule<any>;
};

export interface FeatureModule<T extends {} = {}> {
  value: string;
  cli: (opt: Options, pool: PoolIdentifier) => Promise<T>;
  build: (opt: Options, pool: PoolIdentifier, cfg: T) => CodeArtifact;
}

export const ENGINE_FLAGS = {
  KEEP_CURRENT: 'KEEP_CURRENT',
  KEEP_CURRENT_STRING: 'KEEP_CURRENT_STRING',
  KEEP_CURRENT_ADDRESS: 'KEEP_CURRENT_ADDRESS',
  ENABLED: 'ENABLED',
  DISABLED: 'DISABLED',
} as const;

export const AVAILABLE_VERSIONS = {V2: 'V2', V3: 'V3'} as const;

export const V2_POOLS = [
  'AaveV2Ethereum',
  'AaveV2EthereumAMM',
  'AaveV2Polygon',
  'AaveV2Avalanche',
] as const satisfies readonly (keyof typeof addressBook)[];

export const V3_POOLS = [
  'AaveV3Ethereum',
  'AaveV3Polygon',
  'AaveV3Avalanche',
  'AaveV3Optimism',
  'AaveV3Arbitrum',
  'AaveV3Metis',
  'AaveV3Base',
] as const satisfies readonly (keyof typeof addressBook)[];

export const POOLS = [
  ...V2_POOLS,
  ...V3_POOLS,
] as const satisfies readonly (keyof typeof addressBook)[];

export type PoolIdentifier = (typeof POOLS)[number];
export type PoolIdentifierV3 = (typeof V3_POOLS)[number];

export type ConfigFile = {
  rootOptions: Options;
  poolOptions: Record<PoolIdentifier, Omit<PoolConfig, 'artifacts'>>;
};
