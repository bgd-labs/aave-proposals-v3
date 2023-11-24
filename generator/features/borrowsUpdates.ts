import {CodeArtifact, ENGINE_FLAGS, FEATURE, FeatureModule} from '../types';
import {BorrowUpdate} from './types';
import {
  assetsSelectPrompt,
  translateAssetToAssetLibUnderlying,
} from '../prompts/assetsSelectPrompt';
import {boolPrompt, translateJsBoolToSol} from '../prompts/boolPrompt';
import {percentPrompt, translateJsPercentToSol} from '../prompts/percentPrompt';

export async function fetchBorrowUpdate<T extends boolean>(required?: T) {
  return {
    enabledToBorrow: await boolPrompt({
      message: 'enabled to borrow',
      required,
    }),
    flashloanable: await boolPrompt({
      message: 'flashloanable',
      required,
    }),
    stableRateModeEnabled: await boolPrompt({
      message: 'stable rate mode enabled',
      required,
      defaultValue: ENGINE_FLAGS.DISABLED,
    }),
    borrowableInIsolation: await boolPrompt({
      message: 'borrowable in isolation',
      required,
      defaultValue: ENGINE_FLAGS.DISABLED,
    }),
    withSiloedBorrowing: await boolPrompt({
      message: 'siloed borrowing',
      required,
      defaultValue: ENGINE_FLAGS.DISABLED,
    }),
    reserveFactor: await percentPrompt({
      message: 'reserve factor',
      required,
    }),
  };
}

type BorrowUpdates = BorrowUpdate[];

export const borrowsUpdates: FeatureModule<BorrowUpdates> = {
  value: FEATURE.BORROWS_UPDATE,
  description:
    'BorrowsUpdates (enabledToBorrow, flashloanable, stableRateModeEnabled, borrowableInIsolation, withSiloedBorrowing, reserveFactor)',
  async cli({pool}) {
    const assets = await assetsSelectPrompt({
      message: 'Select the assets you want to amend',
      pool,
    });
    const response: BorrowUpdates = [];
    for (const asset of assets) {
      console.log(`Fetching information for BorrowUpdates on ${pool} ${asset}`);
      response.push({...(await fetchBorrowUpdate(false)), asset});
    }
    return response;
  },
  build({pool, cfg}) {
    const response: CodeArtifact = {
      code: {
        fn: [
          `function borrowsUpdates() public pure override returns (IAaveV3ConfigEngine.BorrowUpdate[] memory) {
          IAaveV3ConfigEngine.BorrowUpdate[] memory borrowUpdates = new IAaveV3ConfigEngine.BorrowUpdate[](${
            cfg.length
          });

          ${cfg
            .map(
              (cfg, ix) => `borrowUpdates[${ix}] = IAaveV3ConfigEngine.BorrowUpdate({
               asset: ${translateAssetToAssetLibUnderlying(cfg.asset, pool)},
               enabledToBorrow: ${translateJsBoolToSol(cfg.enabledToBorrow)},
               flashloanable: ${translateJsBoolToSol(cfg.flashloanable)},
               stableRateModeEnabled: ${translateJsBoolToSol(cfg.stableRateModeEnabled)},
               borrowableInIsolation: ${translateJsBoolToSol(cfg.borrowableInIsolation)},
               withSiloedBorrowing: ${translateJsBoolToSol(cfg.withSiloedBorrowing)},
               reserveFactor: ${translateJsPercentToSol(cfg.reserveFactor)}
             });`
            )
            .join('\n')}

          return borrowUpdates;
        }`,
        ],
      },
    };
    return response;
  },
};
