import {select, checkbox, input, confirm} from '@inquirer/prompts';
import {CodeArtifact, FEATURE, FeatureModule, MarketIdentifierV4} from '../../../types';
import {positionManagerKeys, spokeKeys, spokeLibAccessor} from '../marketBook';
import {accessManagerTargetFunctionRoleUpdate} from '../access/accessManagerTargetFunctionRoleUpdate';
import {spokePositionManagerUpdate} from '../spoke/spokePositionManagerUpdate';
import {positionManagerSpokeRegistration} from '../positionManager/positionManagerSpokeRegistration';
import {
  V4TargetFunctionRoleUpdate,
  V4SpokePositionManagerUpdate,
  V4PMSpokeRegistration,
} from '../../types';
import {positionManagerLibAccessor} from '../marketBook';
import {mergeArtifact} from '../bundleHelpers';

type BundleCfg = {
  targetFunctionRoles: V4TargetFunctionRoleUpdate[];
  spokeActivations: V4SpokePositionManagerUpdate[];
  pmRegistrations: V4PMSpokeRegistration[];
};

export const wirePositionManager: FeatureModule<BundleCfg> = {
  value: FEATURE.V4_USECASE_WIRE_POSITION_MANAGER,
  description: 'Bundle: wire a PositionManager (selectors + spoke activations + PM registrations)',
  async cli({market}) {
    const m = market as MarketIdentifierV4;
    const result: BundleCfg = {targetFunctionRoles: [], spokeActivations: [], pmRegistrations: []};
    const pm = await select({
      message: 'Select PositionManager',
      choices: positionManagerKeys(m).map((k) => ({name: k, value: k})),
    });
    const pmAccessor = positionManagerLibAccessor(m, pm) as `0x${string}`;

    const wantSelectors = await confirm({
      message: 'Grant selectors a role on the PM via AccessManager?',
      default: true,
    });
    if (wantSelectors) {
      const roleId = await input({message: 'Role ID (uint64)'});
      const selectorsCsv = await input({
        message: 'Selectors (comma-separated, e.g. 0x12345678,0xabcdef00)',
      });
      const selectors = selectorsCsv
        .split(',')
        .map((s) => s.trim())
        .filter(Boolean);
      result.targetFunctionRoles.push({
        target: pmAccessor,
        selectors,
        roleId,
      });
    }

    const spokes = await checkbox({
      message: 'Activate/deactivate PM on which spokes?',
      choices: spokeKeys(m).map((k) => ({name: k, value: k})),
    });
    const active = await confirm({message: 'Activate (yes) or deactivate (no)?', default: true});
    for (const spoke of spokes) {
      result.spokeActivations.push({
        spokeLib: spokeLibAccessor(m, spoke),
        spoke: spokeLibAccessor(m, spoke),
        positionManager: pmAccessor,
        active,
      });
    }

    const wantPmReg = await confirm({
      message: 'Also call registerSpoke on the PM side?',
      default: true,
    });
    if (wantPmReg) {
      for (const spoke of spokes) {
        result.pmRegistrations.push({
          positionManager: pmAccessor,
          spoke: spokeLibAccessor(m, spoke),
          registered: active,
        });
      }
    }
    return result;
  },
  build({options, market, cache, cfg, configs}) {
    const artifact: CodeArtifact = {code: {}};
    if (cfg.targetFunctionRoles.length > 0) {
      mergeArtifact(
        artifact,
        accessManagerTargetFunctionRoleUpdate.build({
          options,
          market,
          cache,
          cfg: cfg.targetFunctionRoles,
          configs,
        }),
      );
    }
    if (cfg.spokeActivations.length > 0) {
      mergeArtifact(
        artifact,
        spokePositionManagerUpdate.build({
          options,
          market,
          cache,
          cfg: cfg.spokeActivations,
          configs,
        }),
      );
    }
    if (cfg.pmRegistrations.length > 0) {
      mergeArtifact(
        artifact,
        positionManagerSpokeRegistration.build({
          options,
          market,
          cache,
          cfg: cfg.pmRegistrations,
          configs,
        }),
      );
    }
    return artifact;
  },
};
