import {describe, expect, it} from 'vitest';
import {FEATURE, MarketConfig} from '../types';
import {MOCK_OPTIONS} from '../features/mocks/configs';
import {testTemplate} from './test.template';

function marketConfig(
  configs: MarketConfig['configs'],
  artifacts: MarketConfig['artifacts'] = [
    {
      test: {
        fn: [
          `function _expectedCapsChanges() internal pure override returns (IAaveV3ConfigEngine.CapsUpdate[] memory) {
              return new IAaveV3ConfigEngine.CapsUpdate[](0);
            }`,
        ],
        updatedAssets: ['AaveV3EthereumAssets.DAI_UNDERLYING'],
      },
    },
  ],
): MarketConfig {
  return {
    configs,
    cache: {blockNumber: 42},
    artifacts,
  };
}

describe('testTemplate', () => {
  it('uses ProtocolV3TestBase for reserve config changes', () => {
    const output = testTemplate(
      MOCK_OPTIONS,
      marketConfig({
        [FEATURE.CAPS_UPDATE]: [],
        [FEATURE.COLLATERALS_UPDATE]: [],
        [FEATURE.EMODES_CREATION]: [],
      }),
      'AaveV3Ethereum',
    );

    expect(output).toContain(
      "import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';",
    );
    expect(output).toContain('contract AaveV3Ethereum_Test_20231023_Test is ProtocolV3TestBase');
    expect(output).toContain('function test_defaultProposalExecution() public');
    expect(output).toContain('defaultTest(');
    expect(output).toContain(
      "defaultTest('AaveV3Ethereum_Test_20231023', AaveV3Ethereum.POOL, address(proposal));",
    );
    expect(output).not.toContain(
      '_validateReserveConfigChanges(allConfigsBefore, allConfigsAfter);',
    );
    expect(output).toContain('function test_reserveConfigChanges() public');
    expect(output).toContain('address[] memory updatedAssets = new address[](1);');
    expect(output).toContain('updatedAssets[0] = AaveV3EthereumAssets.DAI_UNDERLYING;');
    expect(output).toContain(
      'reserveConfigChangesTest(AaveV3Ethereum.POOL, address(proposal), updatedAssets);',
    );
    expect(output).toContain('executes the generic test suite including e2e and config snapshots');
    expect(output).toContain(
      'checks whether reserve configurations changed or stayed unchanged as expected',
    );
    expect(output).toContain("'AaveV3Ethereum_Test_20231023'");
    expect(output).toContain('AaveV3Ethereum.POOL');
    expect(output).toContain('address(proposal)');
    expect(output).not.toContain('defaultTestWithReserveConfigChanges');
    expect(output).not.toContain('function _payload()');
    expect(output).not.toContain('function _pool()');
    expect(output).not.toContain('_allReserveChangesDeclared');
  });

  it('emits an unchanged-reserve-config test for v3 payloads without expected changes', () => {
    const output = testTemplate(
      MOCK_OPTIONS,
      marketConfig({[FEATURE.PRICE_FEEDS_UPDATE]: []}, [{}]),
      'AaveV3Ethereum',
    );

    expect(output).toContain('contract AaveV3Ethereum_Test_20231023_Test is ProtocolV3TestBase');
    expect(output).toContain(
      "defaultTest('AaveV3Ethereum_Test_20231023', AaveV3Ethereum.POOL, address(proposal));",
    );
    expect(output).not.toContain(
      '_validateReserveConfigChanges(allConfigsBefore, allConfigsAfter);',
    );
    expect(output).toContain('function test_reserveConfigChanges() public');
    expect(output).toContain('address[] memory updatedAssets = new address[](0);');
    expect(output).not.toContain('updatedAssets[0]');
    expect(output).toContain(
      'reserveConfigChangesTest(AaveV3Ethereum.POOL, address(proposal), updatedAssets);',
    );
    expect(output).toContain(
      'checks whether reserve configurations changed or stayed unchanged as expected',
    );
    expect(output).not.toContain('_expectedCollateralChanges()/_expectedCapsChanges()');
  });
});
