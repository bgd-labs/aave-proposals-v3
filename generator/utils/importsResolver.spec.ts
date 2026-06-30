// sum.test.js
import {expect, describe, it} from 'vitest';
import {prefixWithImports} from './importsResolver';

describe('prefixWithImports', () => {
  it('should resolve IProposalGenericExecutor', () => {
    expect(prefixWithImports(`is IProposalGenericExecutor {`)).toContain(
      `import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';`,
    );
  });

  it('should resolve Engine imports', () => {
    expect(prefixWithImports(`GovV3Helpers.createPayload`)).toContain(
      `import {GovV3Helpers} from 'aave-helpers/src/GovV3Helpers.sol';`,
    );
  });

  it('should detect v3 Engine imports', () => {
    expect(prefixWithImports(`EngineFlags.KEEP_CURRENT`)).toContain(
      `import {EngineFlags} from 'aave-v3-origin/contracts/extensions/v3-config-engine/EngineFlags.sol';`,
    );

    expect(prefixWithImports('IAaveV3ConfigEngine.CapsUpdate')).toContain(
      `import {IAaveV3ConfigEngine} from 'aave-v3-origin/contracts/extensions/v3-config-engine/IAaveV3ConfigEngine.sol';`,
    );
  });

  it('should detect v2 Engine imports', () => {
    const result = prefixWithImports('IAaveV2ConfigEngine.RateStrategyUpdate');
    expect(result).toContain(
      `import {IAaveV2ConfigEngine} from 'aave-helpers/src/v2-config-engine/IAaveV2ConfigEngine.sol';`,
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

  it('should resolve GovernanceV3 imports generically', () => {
    expect(prefixWithImports('GovernanceV3Ethereum.VOTING_PORTAL_ETH_POL')).toContain(
      `import {GovernanceV3Ethereum} from 'aave-address-book/GovernanceV3Ethereum.sol';`,
    );

    expect(
      prefixWithImports('GovernanceV3InkWhitelabel.PERMISSIONED_PAYLOADS_CONTROLLER'),
    ).toContain(
      `import {GovernanceV3InkWhitelabel} from 'aave-address-book/GovernanceV3InkWhitelabel.sol';`,
    );
  });

  it('should not pull in GovernanceV3Ethereum for an EthereumWhitelabel substring', () => {
    const result = prefixWithImports(
      'GovernanceV3EthereumWhitelabel.PERMISSIONED_PAYLOADS_CONTROLLER',
    );
    expect(result).toContain(
      `import {GovernanceV3EthereumWhitelabel} from 'aave-address-book/GovernanceV3EthereumWhitelabel.sol';`,
    );
    expect(result).not.toContain(
      `import {GovernanceV3Ethereum} from 'aave-address-book/GovernanceV3Ethereum.sol';`,
    );
  });

  it('should resolve every GovernanceV3 market referenced in the same code', () => {
    const result = prefixWithImports(
      `GovernanceV3Ethereum.VOTING_PORTAL_ETH_POL
       GovernanceV3InkWhitelabel.PERMISSIONED_PAYLOADS_CONTROLLER
       GovernanceV3SonicWhitelabel.PERMISSIONED_PAYLOADS_CONTROLLER`,
    );
    expect(result).toContain(
      `import {GovernanceV3Ethereum} from 'aave-address-book/GovernanceV3Ethereum.sol';`,
    );
    expect(result).toContain(
      `import {GovernanceV3InkWhitelabel} from 'aave-address-book/GovernanceV3InkWhitelabel.sol';`,
    );
    expect(result).toContain(
      `import {GovernanceV3SonicWhitelabel} from 'aave-address-book/GovernanceV3SonicWhitelabel.sol';`,
    );
  });
});
