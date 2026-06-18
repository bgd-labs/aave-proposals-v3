import {input, confirm} from '@inquirer/prompts';
import {CodeArtifact, FEATURE, FeatureModule} from '../../../types';
import {addressPrompt} from '../../../prompts/addressPrompt';
import {accessManagerRoleMembership} from '../access/accessManagerRoleMembership';
import {accessManagerRoleUpdate} from '../access/accessManagerRoleUpdate';
import {V4RoleMembership, V4RoleUpdate} from '../../types';
import {keepCurrentUint64, keepCurrentUint32, literal, renderSentinel} from '../sentinels';
import {Sentinel} from '../../types';
import {mergeArtifact} from '../bundleHelpers';

type BundleCfg = {
  memberships: V4RoleMembership[];
  updates: V4RoleUpdate[];
};

async function sentinelUint64(message: string): Promise<Sentinel> {
  const v = await input({message: `${message} (empty = keep current)`});
  if (!v) return keepCurrentUint64();
  return literal(v);
}

async function sentinelUint32(message: string): Promise<Sentinel> {
  const v = await input({message: `${message} (empty = keep current)`});
  if (!v) return keepCurrentUint32();
  return literal(v);
}

export const manageRole: FeatureModule<BundleCfg> = {
  value: FEATURE.V4_USECASE_MANAGE_ROLE,
  description: 'Bundle: grant/revoke a role and optionally update its metadata',
  async cli() {
    const result: BundleCfg = {memberships: [], updates: []};
    let more = true;
    while (more) {
      const roleId = await input({message: 'Role ID (uint64)'});
      const grant = await confirm({message: 'Grant the role? (no = revoke)', default: true});
      const account = await addressPrompt({message: 'Account', required: true});
      const executionDelay = grant
        ? await input({message: 'Execution delay (seconds, uint32)', default: '0'})
        : '0';
      result.memberships.push({
        roleId,
        account: account as `0x${string}`,
        granted: grant,
        executionDelay,
      });

      const wantMeta = await confirm({
        message: 'Also update this role metadata (admin/guardian/grantDelay/label)?',
        default: false,
      });
      if (wantMeta) {
        result.updates.push({
          roleId,
          admin: await sentinelUint64('New admin role (uint64)'),
          guardian: await sentinelUint64('New guardian role (uint64)'),
          grantDelay: await sentinelUint32('New grant delay (uint32, seconds)'),
          label: await input({message: 'New label (empty = keep current)'}),
        });
      }
      more = await confirm({message: 'Manage another role?', default: false});
    }
    return result;
  },
  build({options, market, cache, cfg, configs}) {
    const artifact: CodeArtifact = {code: {}};
    if (cfg.memberships.length > 0) {
      mergeArtifact(
        artifact,
        accessManagerRoleMembership.build({
          options,
          market,
          cache,
          cfg: cfg.memberships,
          configs,
        }),
      );
    }
    if (cfg.updates.length > 0) {
      mergeArtifact(
        artifact,
        accessManagerRoleUpdate.build({
          options,
          market,
          cache,
          cfg: cfg.updates,
          configs,
        }),
      );
    }
    return artifact;
  },
};
