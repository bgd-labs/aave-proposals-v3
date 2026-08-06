import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    markets: ['AaveV3Ethereum'],
    title: 'Certora Concord Equivalence Checker Funding',
    shortName: 'CertoraConcordEquivalenceCheckerFunding',
    date: '20260623',
    author: 'Certora (implemented by Aave Labs)',
    discussion:
      'https://governance.aave.com/t/arfc-strengthening-upgrade-safety-concord-equivalence-checker-by-certora/24713',
    snapshot:
      'https://snapshot.org/#/s:aavedao.eth/proposal/0xcf9ca2d7a9b1ee819b6b76f8dae1cdc7fb507e027f044e90d7937b4b264a42c1',
    votingNetwork: 'AVALANCHE',
  },
  marketOptions: {AaveV3Ethereum: {configs: {OTHERS: {}}, cache: {blockNumber: 25380684}}},
};
