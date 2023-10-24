import {CodeArtifact, ENGINE_FLAGS, FEATURE, FeatureModule} from '../types';
import {assetsSelect, booleanSelect, percentInput} from '../prompts';
import {BorrowUpdate} from './types';

export async function fetchBorrowUpdate<T extends boolean>(disableKeepCurrent?: T) {
  return {
    enabledToBorrow: await booleanSelect({
      message: 'enabled to borrow',
      disableKeepCurrent,
    }),
    flashloanable: await booleanSelect({
      message: 'flashloanable',
      disableKeepCurrent,
    }),
    stableRateModeEnabled: await booleanSelect({
      message: 'stable rate mode enabled',
      disableKeepCurrent,
      defaultValue: ENGINE_FLAGS.DISABLED,
    }),
    borrowableInIsolation: await booleanSelect({
      message: 'borrowable in isolation',
      disableKeepCurrent,
      defaultValue: ENGINE_FLAGS.DISABLED,
    }),
    withSiloedBorrowing: await booleanSelect({
      message: 'siloed borrowing',
      disableKeepCurrent,
      defaultValue: ENGINE_FLAGS.DISABLED,
    }),
    reserveFactor: await percentInput({
      message: 'reserve factor',
      disableKeepCurrent,
    }),
  };
}

type BorrowUpdates = BorrowUpdate[];

export const borrowsUpdates: FeatureModule<BorrowUpdates> = {
  value: FEATURE.BORROWS_UPDATE,
  description:
    'BorrowsUpdates (enabledToBorrow, flashloanable, stableRateModeEnabled, borrowableInIsolation, withSiloedBorrowing, reserveFactor)',
  async cli(opt, pool) {
    const assets = await assetsSelect({
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
  build(opt, pool, cfg) {
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
               asset: ${cfg.asset},
               enabledToBorrow: ${cfg.enabledToBorrow},
               flashloanable: ${cfg.flashloanable},
               stableRateModeEnabled: ${cfg.stableRateModeEnabled},
               borrowableInIsolation: ${cfg.borrowableInIsolation},
               withSiloedBorrowing: ${cfg.withSiloedBorrowing},
               reserveFactor: ${cfg.reserveFactor}
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
