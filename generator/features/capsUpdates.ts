import {CodeArtifact, FEATURE, FeatureModule, PoolIdentifier} from '../types';
import {assetsSelect, numberInput} from '../prompts';
import {CapsUpdate, CapsUpdatePartial} from './types';

export async function fetchCapsUpdate(disableKeepCurrent?: boolean): Promise<CapsUpdatePartial> {
  return {
    supplyCap: await numberInput({
      message: 'New supply cap',
      disableKeepCurrent,
    }),
    borrowCap: await numberInput({
      message: 'New borrow cap',
      disableKeepCurrent,
    }),
  };
}

type CapsUpdates = CapsUpdate[];

export const capsUpdates: FeatureModule<CapsUpdates> = {
  value: FEATURE.CAPS_UPDATE,
  description: 'CapsUpdates (supplyCap, borrowCap)',
  async cli(opt, pool) {
    console.log(`Fetching information for CapsUpdates on ${pool}`);
    const assets = await assetsSelect({
      message: 'Select the assets you want to amend',
      pool,
    });

    const response: CapsUpdates = [];
    for (const asset of assets) {
      console.log(`collecting info for ${asset}`);
      response.push({asset, ...(await fetchCapsUpdate())});
    }
    return response;
  },
  build(opt, pool, cfg) {
    const response: CodeArtifact = {
      code: {
        fn: [
          `function capsUpdates() public pure override returns (IAaveV3ConfigEngine.CapsUpdate[] memory) {
          IAaveV3ConfigEngine.CapsUpdate[] memory capsUpdate = new IAaveV3ConfigEngine.CapsUpdate[](${
            cfg.length
          });

          ${cfg
            .map(
              (cfg, ix) => `capsUpdate[${ix}] = IAaveV3ConfigEngine.CapsUpdate({
               asset: ${cfg.asset},
               supplyCap: ${cfg.supplyCap},
               borrowCap: ${cfg.borrowCap}
             });`
            )
            .join('\n')}

          return capsUpdate;
        }`,
        ],
      },
    };
    return response;
  },
};
