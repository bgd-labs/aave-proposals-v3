import {CodeArtifact, FEATURE, FeatureModule} from '../types';
import {Hex} from 'viem';
import {TEST_EXECUTE_PROPOSAL} from '../utils/constants';
import {addressPrompt, translateJsAddressToSol} from '../prompts/addressPrompt';

type FlashBorrower = {
  address: Hex;
};

export const flashBorrower: FeatureModule<FlashBorrower> = {
  value: FEATURE.FLASH_BORROWER,
  description: 'FlashBorrower (whitelist address as 0% fee flashborrower)',
  async cli({pool}) {
    console.log(`Fetching information for FlashBorrower on ${pool}`);
    const response: FlashBorrower = {
      address: await addressPrompt({
        message: 'Who do you want to grant the flashBorrower role',
        required: true,
      }),
    };
    return response;
  },
  build({pool, cfg}) {
    const response: CodeArtifact = {
      code: {
        constants: [
          `address public constant NEW_FLASH_BORROWER = ${translateJsAddressToSol(cfg.address)};`,
        ],
        execute: [`${pool}.ACL_MANAGER.addFlashBorrower(NEW_FLASH_BORROWER);`],
      },
      test: {
        fn: [
          `function test_isFlashBorrower() external {
          ${TEST_EXECUTE_PROPOSAL}
          bool isFlashBorrower = ${pool}.ACL_MANAGER.isFlashBorrower(proposal.NEW_FLASH_BORROWER());
          assertEq(isFlashBorrower, true);
        }`,
        ],
      },
    };
    return response;
  },
};
