import {expect, describe, it} from 'vitest';
import {getVersion, getTestBase} from './common';
import {MarketIdentifier} from './types';

describe('getVersion', () => {
  it('resolves the version per market family', () => {
    expect(getVersion('AaveV2Ethereum')).toBe('V2');
    expect(getVersion('AaveV3Ethereum')).toBe('V3');
    expect(getVersion('AaveV4Ethereum')).toBe('V4');
  });

  it('throws for an unknown market instead of defaulting to V3', () => {
    expect(() => getVersion('AaveV9Unknown' as MarketIdentifier)).toThrow();
  });
});

describe('getTestBase', () => {
  it('maps each market family to its test base', () => {
    expect(getTestBase('AaveV2Ethereum')).toEqual({
      v4: false,
      testBase: 'ProtocolV2TestBase',
      testBaseImport: `import {ProtocolV2TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV2TestBase.sol';`,
      reserveConfigValidation: false,
    });
    expect(getTestBase('AaveV3Ethereum')).toEqual({
      v4: false,
      testBase: 'ProtocolV3ProposalTestBase',
      testBaseImport: `import {ProtocolV3ProposalTestBase} from '../ProtocolV3ProposalTestBase.sol';
import {ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';`,
      reserveConfigValidation: true,
    });
    expect(getTestBase('AaveV4Ethereum')).toEqual({
      v4: true,
      testBase: 'ProtocolV4TestBase',
      testBaseImport: `import {ProtocolV4TestBase} from 'aave-helpers/src/ProtocolV4TestBase.sol';`,
      reserveConfigValidation: false,
    });
  });

  it('throws for an unknown market', () => {
    expect(() => getTestBase('AaveV9Unknown' as MarketIdentifier)).toThrow();
  });
});
