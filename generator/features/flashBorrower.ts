import {CodeArtifact, FeatureModule} from '../types';
import {addressInput} from '../prompts';

type FlashBorrower = {
  address: string;
};

export const flashBorrower: FeatureModule<FlashBorrower> = {
  value: 'FlashBorrower (whitelist address as 0% fee flashborrower)',
  async cli(opt, pool) {
    console.log(`Fetching information for FlashBorrower on ${pool}`);
    const response: FlashBorrower = {
      address: await addressInput({
        message: 'Who do you want to grant the flashBorrower role',
      }),
    };
    return response;
  },
  build(opt, pool, cfg) {
    const response: CodeArtifact = {
      code: {
        constants: [`address public constant NEW_FLASH_BORROWER = address(${cfg.address});`],
        execute: [`${pool}.ACL_MANAGER.addFlashBorrower(NEW_FLASH_BORROWER);`],
      },
      test: {
        fn: [
          `function test_isFlashBorrower() external {
          GovV3Helpers.executePayload(
            vm,
            address(proposal)
          );
          bool isFlashBorrower = ${pool}.ACL_MANAGER.isFlashBorrower(proposal.NEW_FLASH_BORROWER());
          assertEq(isFlashBorrower, true);
        }`,
        ],
      },
    };
    return response;
  },
};
