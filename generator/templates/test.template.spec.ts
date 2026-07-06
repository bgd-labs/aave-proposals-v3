import {describe, expect, it} from 'vitest';
import {FEATURE, MarketConfig} from '../types';
import {MOCK_OPTIONS} from '../features/mocks/configs';
import {testTemplate} from './test.template';

function marketConfig(configs: MarketConfig['configs'], reserveConfigChanges = true): MarketConfig {
  return {
    configs,
    cache: {blockNumber: 42},
    artifacts: [
      {
        test: {
          ...(reserveConfigChanges ? {reserveConfigChanges: true} : {}),
          fn: [
            `function _expectedCapsChanges() internal pure override returns (IAaveV3ConfigEngine.CapsUpdate[] memory) {
              return new IAaveV3ConfigEngine.CapsUpdate[](0);
            }`,
          ],
        },
      },
    ],
  };
}

describe('testTemplate', () => {
  it('switches to ProtocolV3ProposalTestBase for reserve config changes', () => {
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
      "import {ProtocolV3ProposalTestBase} from '../ProtocolV3ProposalTestBase.sol';",
    );
    expect(output).toContain(
      'contract AaveV3Ethereum_Test_20231023_Test is ProtocolV3ProposalTestBase',
    );
    expect(output).toContain('function test_defaultProposalExecution() public');
    expect(output).toContain('defaultTest(');
    expect(output).toContain('function test_reserveConfigChanges() public');
    expect(output).toContain('reserveConfigChangesTest(');
    expect(output).toContain(
      'checks reserve config changes declared in generated _expectedCollateralChanges()/_expectedCapsChanges() overrides and verifies all other reserve configs stay unchanged',
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
      marketConfig({[FEATURE.PRICE_FEEDS_UPDATE]: []}, false),
      'AaveV3Ethereum',
    );

    expect(output).toContain(
      'contract AaveV3Ethereum_Test_20231023_Test is ProtocolV3ProposalTestBase',
    );
    expect(output).toContain('function test_reserveConfigChanges() public');
    expect(output).toContain('reserveConfigChangesTest(AaveV3Ethereum.POOL, address(proposal));');
    expect(output).toContain('checks the payload does not change any reserve config');
    expect(output).not.toContain('checks reserve config changes declared');
  });

  it('keeps the regular test base on zksync', () => {
    const output = testTemplate(
      MOCK_OPTIONS,
      {
        configs: {[FEATURE.CAPS_UPDATE]: []},
        cache: {blockNumber: 42},
        artifacts: [],
      },
      'AaveV3ZkSync',
    );

    expect(output).toContain('contract AaveV3ZkSync_Test_20231023_Test is ProtocolV3TestBase');
    expect(output).toContain('function setUp() public override');
    expect(output).toContain('super.setUp();');
    expect(output).not.toContain('ProtocolV3ProposalTestBase');
    expect(output).not.toContain('function test_reserveConfigChanges() public');
    expect(output).not.toContain('_expectedCapsChanges');
  });

  it('fails clearly if reserve config change tests are requested on zksync', () => {
    expect(() =>
      testTemplate(MOCK_OPTIONS, marketConfig({[FEATURE.CAPS_UPDATE]: []}), 'AaveV3ZkSync'),
    ).toThrow('Reserve config change tests are currently unsupported on ZkSync');
  });
});
