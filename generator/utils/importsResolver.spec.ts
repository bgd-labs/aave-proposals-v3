// sum.test.js
import {expect, describe, it} from 'vitest';
import {prefixWithImports} from './importsResolver';

describe('prefixWithImports', () => {
  it('should resolve IProposalGenericExecutor', () => {
    expect(prefixWithImports(`is IProposalGenericExecutor {`)).toContain(
      `import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';`,
    );
  });

  it('should resolve Engine imports', () => {
    expect(prefixWithImports(`GovV3Helpers.createPayload`)).toContain(
      `import {GovV3Helpers} from 'aave-helpers/GovV3Helpers.sol';`,
    );
  });

  it('should detect v3 Engine imports', () => {
    expect(prefixWithImports(`EngineFlags.KEEP_CURRENT`)).toContain(
      `import {EngineFlags} from 'aave-v3-periphery/contracts/v3-config-engine/EngineFlags.sol';`,
    );

    expect(prefixWithImports('IAaveV3ConfigEngine.CapsUpdate')).toContain(
      `import {IAaveV3ConfigEngine} from 'aave-v3-periphery/contracts/v3-config-engine/IAaveV3ConfigEngine.sol';`,
    );
  });

  it('should detect v2 Engine imports', () => {
    const result = prefixWithImports('IAaveV2ConfigEngine.RateStrategyUpdate');
    expect(result).toContain(
      `import {IAaveV2ConfigEngine} from 'aave-helpers/v2-config-engine/IAaveV2ConfigEngine.sol';`,
    );
  });

  it('should detect addressbook imports', () => {
    expect(prefixWithImports('AaveV2Ethereum.POOL AaveV2EthereumAssets.DAI')).toContain(
      `import {AaveV2Ethereum,AaveV2EthereumAssets} from 'aave-address-book/AaveV2Ethereum.sol';`,
    );

    expect(prefixWithImports('AaveV3Avalanche.POOL')).toContain(
      `import {AaveV3Avalanche} from 'aave-address-book/AaveV3Avalanche.sol';`,
    );
  });
});
