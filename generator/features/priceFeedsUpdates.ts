import {CodeArtifact, FeatureModule, PoolIdentifier} from '../types';
import {addressInput, assetsSelect} from '../prompts';
import {PriceFeedUpdate, PriceFeedUpdatePartial} from './types';

async function fetchPriceFeedUpdate(): Promise<PriceFeedUpdatePartial> {
  return {
    priceFeed: await addressInput({
      message: 'New price feed address',
      disableKeepCurrent: true,
    }),
  };
}

export const priceFeedsUpdates: FeatureModule<PriceFeedUpdate[]> = {
  value: 'PriceFeedsUpdates (replacing priceFeeds)',
  async cli(opt, pool) {
    const response: PriceFeedUpdate[] = [];
    const assets = await assetsSelect({
      message: 'Select the assets you want to amend',
      pool,
    });
    for (const asset of assets) {
      console.log(`collecting info for ${asset}`);
      response.push({asset, ...(await fetchPriceFeedUpdate())});
    }
    return response;
  },
  build(opt, pool, cfg) {
    const response: CodeArtifact = {
      code: {
        fn: [
          `function priceFeedsUpdates() public pure override returns (IEngine.PriceFeedUpdate[] memory) {
          IEngine.PriceFeedUpdate[] memory priceFeedsUpdates = new IEngine.PriceFeedUpdate[](${
            cfg.length
          });

          ${cfg
            .map(
              (cfg, ix) => `priceFeedsUpdates[${ix}] = IEngine.PriceFeedUpdate({
               asset: ${cfg.asset},
               priceFeed: ${cfg.priceFeed}
             });`
            )
            .join('\n')}

          return priceFeedsUpdates;
        }`,
        ],
      },
    };
    return response;
  },
};
