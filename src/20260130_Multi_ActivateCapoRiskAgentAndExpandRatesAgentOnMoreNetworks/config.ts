import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: ['AaveV3Ethereum', 'AaveV3Avalanche', 'AaveV3Arbitrum', 'AaveV3Base'],
    title: 'Activate Capo Risk Agent and expand Rates Agent on more networks',
    shortName: 'ActivateCapoRiskAgentAndExpandRatesAgentOnMoreNetworks',
    date: '20260130',
    author: 'BGD Labs (@bgdlabs)',
    discussion:
      'https://governance.aave.com/t/arfc-dynamic-calibration-of-capo-parameters-via-risk-oracles/22601',
    snapshot:
      'https://snapshot.box/#/s:aavedao.eth/proposal/0x66aa6904f140d56ada880f45c911994c5c6cc20109b55081f508ccdd6417066d',
    votingNetwork: 'AVALANCHE',
  },
  poolOptions: {
    AaveV3Ethereum: {configs: {OTHERS: {}}, cache: {blockNumber: 24348060}},
    AaveV3Avalanche: {configs: {OTHERS: {}}, cache: {blockNumber: 76877281}},
    AaveV3Arbitrum: {configs: {OTHERS: {}}, cache: {blockNumber: 426819389}},
    AaveV3Base: {configs: {}, cache: {blockNumber: 41495649}},
  },
};
