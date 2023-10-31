import {CodeArtifact, FEATURE, FeatureModule, PoolIdentifier} from '../types';
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
  value: FEATURE.PRICE_FEEDS_UPDATE,
  description: 'PriceFeedsUpdates (replacing priceFeeds)',
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
          `function priceFeedsUpdates() public pure override returns (IAaveV3ConfigEngine.PriceFeedUpdate[] memory) {
          IAaveV3ConfigEngine.PriceFeedUpdate[] memory priceFeedUpdates = new IAaveV3ConfigEngine.PriceFeedUpdate[](${
            cfg.length
          });

          ${cfg
            .map(
              (cfg, ix) => `priceFeedUpdates[${ix}] = IAaveV3ConfigEngine.PriceFeedUpdate({
               asset: ${cfg.asset},
               priceFeed: ${cfg.priceFeed}
             });`
            )
            .join('\n')}

          return priceFeedUpdates;
        }`,
        ],
      },
    };
    return response;
  },
};
