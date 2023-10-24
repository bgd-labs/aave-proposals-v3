// sum.test.js
import {expect, describe, it} from 'vitest';
import {prefixWithImports} from './importsResolver';

describe('prefixWithImports', () => {
  it('should resolve Engine imports', () => {
    expect(prefixWithImports(`GovV3Helpers.createPayload`)).toContain(
      `import {GovV3Helpers} from 'aave-helpers/GovV3Helpers.sol';`
    );
  });

  it('should detect v3 Engine imports', () => {
    expect(prefixWithImports(`EngineFlags.KEEP_CURRENT`)).toContain(
      `import {EngineFlags} from 'aave-helpers/v3-config-engine/EngineFlags.sol';`
    );

    expect(prefixWithImports('IAaveV3ConfigEngine.CapsUpdate')).toContain(
      `import {IAaveV3ConfigEngine} from 'aave-helpers/v3-config-engine/IAaveV3ConfigEngine.sol';`
    );
  });

  it('should detect v2 Engine imports', () => {
    expect(prefixWithImports('IAaveV2ConfigEngine.RateStrategyUpdate')).toContain(
      `import {IAaveV2ConfigEngine} from 'aave-helpers/v2-config-engine/IAaveV2ConfigEngine.sol';`
    );
  });

  it('should detect addressbook imports', () => {
    console.log(prefixWithImports('AaveV2Ethereum.POOL AaveV2EthereumAssets.DAI'));
    expect(prefixWithImports('AaveV2Ethereum.POOL AaveV2EthereumAssets.DAI')).toContain(
      `import {AaveV2Ethereum,AaveV2EthereumAssets} from 'aave-address-book/AaveV2Ethereum.sol';`
    );
  });
});
