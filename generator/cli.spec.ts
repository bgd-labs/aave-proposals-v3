import {Command, Option} from 'commander';
import {describe, expect, it} from 'vitest';
import {VOTING_NETWORK} from './types';

describe('voting network option', () => {
  it('parses the voting network as a scalar', () => {
    const program = new Command().addOption(
      new Option(
        '-v, --votingNetwork <votingNetwork>',
        'network where voting should take place for the proposal',
      ).choices(Object.values(VOTING_NETWORK)),
    );

    program.parse(['node', 'test', '--votingNetwork', 'AVALANCHE']);

    expect(program.opts().votingNetwork).toBe('AVALANCHE');
  });
});
