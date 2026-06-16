import {input, confirm} from '@inquirer/prompts';
import {CodeArtifact, FEATURE, FeatureModule} from '../../../types';
import {V4TargetAdminDelayUpdate} from '../../types';
import {addressPrompt} from '../../../prompts/addressPrompt';
import {buildAddressConstant} from '../constants';

export const accessManagerTargetAdminDelayUpdate: FeatureModule<V4TargetAdminDelayUpdate[]> = {
  value: FEATURE.V4_AM_TARGET_ADMIN_DELAY_UPDATE,
  description: 'AccessManager: update target admin delay',
  async cli() {
    const response: V4TargetAdminDelayUpdate[] = [];
    let more = true;
    while (more) {
      const target = await addressPrompt({message: 'Target contract address', required: true});
      const newDelay = await input({message: 'New admin delay (seconds, uint32)'});
      response.push({
        target: target as `0x${string}`,
        newDelay,
      });
      more = await confirm({message: 'Add another?', default: false});
    }
    return response;
  },
  build({market, cfg}) {
    const constants: string[] = [];
    const targetExprs: string[] = [];
    cfg.forEach((c, ix) => {
      if (c.target.startsWith('0x')) {
        const targetName = `TARGET_ADMIN_DELAY_TARGET_${ix}`;
        constants.push(buildAddressConstant(market, targetName, c.target));
        targetExprs.push(`proposal.${targetName}()`);
      } else {
        targetExprs.push(`address(${c.target})`);
      }
    });
    const entries = cfg.map((c, ix) => {
      const targetExpr = c.target.startsWith('0x')
        ? `TARGET_ADMIN_DELAY_TARGET_${ix}`
        : `address(${c.target})`;
      return `items[__INDEX__] = IConfigEngine.TargetAdminDelayUpdate({
        authority: address(${market}.ACCESS_MANAGER),
        target: ${targetExpr},
        newDelay: ${c.newDelay}
      });`;
    });
    const testFns = cfg.map(
      (c, ix) =>
        `function test_accessManagerTargetAdminDelayUpdate_${ix}() public {
        GovV3Helpers.executePayload(vm, address(proposal));
        assertEq(
          uint256(IAccessManager(address(${market}.ACCESS_MANAGER)).getTargetAdminDelay(${targetExprs[ix]})),
          uint256(${c.newDelay}),
          'targetAdminDelay mismatch'
        );
      }`,
    );
    const response: CodeArtifact = {
      code: {
        constants,
        v4Getters: {
          accessManagerTargetAdminDelayUpdates: {
            returnType: 'IConfigEngine.TargetAdminDelayUpdate',
            entries,
          },
        },
      },
      test: {fn: testFns},
    };
    return response;
  },
};
