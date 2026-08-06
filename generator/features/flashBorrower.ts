import {CodeArtifact, FEATURE, FeatureModule} from '../types';
import {Hex} from 'viem';
import {testExecuteProposal} from '../utils/constants';
import {addressPrompt, translateJsAddressToSol} from '../prompts/addressPrompt';
import {CHAIN_TO_CHAIN_ID, getExplorerLink, getMarketChain} from '../common';

export type FlashBorrower = {
  address: Hex;
};

export const flashBorrower: FeatureModule<FlashBorrower> = {
  value: FEATURE.FLASH_BORROWER,
  description: 'FlashBorrower (whitelist address as 0% fee flashborrower)',
  async cli({market}) {
    console.log(`Fetching information for FlashBorrower on ${market}`);
    const response: FlashBorrower = {
      address: await addressPrompt({
        message: 'Who do you want to grant the flashBorrower role',
        required: true,
      }),
    };
    return response;
  },
  build({market, cfg}) {
    const response: CodeArtifact = {
      code: {
        constants: [
          `// ${getExplorerLink(CHAIN_TO_CHAIN_ID[getMarketChain(market)], cfg.address)}\naddress public constant NEW_FLASH_BORROWER = ${translateJsAddressToSol(cfg.address)};`,
        ],
        execute: [`${market}.ACL_MANAGER.addFlashBorrower(NEW_FLASH_BORROWER);`],
      },
      test: {
        fn: [
          `function test_isFlashBorrower() external {
          ${testExecuteProposal(market)}
          bool isFlashBorrower = ${market}.ACL_MANAGER.isFlashBorrower(proposal.NEW_FLASH_BORROWER());
          assertEq(isFlashBorrower, true);
        }`,
        ],
      },
    };
    return response;
  },
};
