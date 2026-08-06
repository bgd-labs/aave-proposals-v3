import {expect, describe, it} from 'vitest';
import {generateScript} from './script.template';
import {MarketIdentifier, Options, VOTING_NETWORK} from '../types';

function makeOptions(markets: string[]): Options {
  return {
    markets: markets as MarketIdentifier[],
    title: 'Test',
    shortName: 'Test',
    author: 'Author',
    discussion: '',
    snapshot: '',
    votingNetwork: VOTING_NETWORK.ETHEREUM,
    date: '20260101',
  };
}

describe('generateScript - mixed whitelabel and regular markets on the same chain', () => {
  const output = generateScript(makeOptions(['AaveV3Ethereum', 'AaveV3EthereumWhitelabel']));

  it('emits a single deploy contract for the shared chain', () => {
    expect(output.match(/contract DeployEthereum\b/g)?.length).toBe(1);
  });

  it('registers the regular market through governance and the whitelabel market through its permissioned controller', () => {
    expect(output).toContain('GovV3Helpers.createPayload(actions);');
    expect(output).toContain(
      'GovV3Helpers.createPermissionedPayloadCalldata(GovernanceV3EthereumWhitelabel.PERMISSIONED_PAYLOADS_CONTROLLER',
    );
  });

  it('includes only the regular market in the governance proposal', () => {
    expect(output).toContain('new PayloadsControllerUtils.Payload[](1)');
    const createProposal = output.slice(output.indexOf('contract CreateProposal'));
    expect(createProposal).toContain('buildMainnetPayload');
    expect(createProposal).toContain('type(AaveV3Ethereum_Test_20260101).creationCode');
    expect(createProposal).not.toContain('AaveV3EthereumWhitelabel');
  });
});

describe('generateScript - regular markets only on the same chain', () => {
  const output = generateScript(makeOptions(['AaveV3Ethereum', 'AaveV3EthereumLido']));

  it('batches the regular markets into a single governance payload without permissioned calldata', () => {
    expect(output).toContain('new IPayloadsControllerCore.ExecutionAction[](2)');
    expect(output).toContain('GovV3Helpers.createPayload(actions);');
    expect(output).not.toContain('createPermissionedPayloadCalldata');
  });
});

describe('generateScript - whitelabel market only', () => {
  const output = generateScript(makeOptions(['AaveV3InkWhitelabel']));

  it('registers through the permissioned controller and skips the governance proposal entirely', () => {
    expect(output).toContain(
      'GovV3Helpers.createPermissionedPayloadCalldata(GovernanceV3InkWhitelabel.PERMISSIONED_PAYLOADS_CONTROLLER',
    );
    expect(output).not.toContain('GovV3Helpers.createPayload(');
    expect(output).not.toContain('contract CreateProposal');
  });
});
