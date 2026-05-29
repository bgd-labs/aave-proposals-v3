import {generateContractName, getVersion, isWhitelabelMarket} from '../common';
import {FEATURE, Options, MarketConfig, MarketIdentifier} from '../types';
import {prefixWithImports} from '../utils/importsResolver';
import {prefixWithPragma} from '../utils/constants';

function dedupeLines(blocks: string[]): string[] {
  const seen = new Set<string>();
  const result: string[] = [];
  for (const block of blocks) {
    const trimmed = block.trim();
    if (!trimmed || seen.has(trimmed)) continue;
    seen.add(trimmed);
    result.push(block);
  }
  return result;
}

export const proposalTemplate = (
  options: Options,
  marketConfig: MarketConfig,
  market: MarketIdentifier,
) => {
  const {title, author, snapshot, discussion} = options;
  const marketName = /AaveV[234](.*)/.test(market) && market.match(/AaveV[234](.*)/)![1];
  const version = getVersion(market);
  const contractName = generateContractName(options, market);
  const isWhitelabel = isWhitelabelMarket(market);

  const constants = dedupeLines(
    marketConfig.artifacts
      .map((artifact) => artifact.code?.constants)
      .flat()
      .filter((f): f is string => f !== undefined),
  ).join('\n');
  const functions = marketConfig.artifacts
    .map((artifact) => artifact.code?.fn)
    .flat()
    .filter((f) => f !== undefined)
    .join('\n');
  const innerExecute = marketConfig.artifacts
    .map((artifact) => artifact.code?.execute)
    .flat()
    .filter((f) => f !== undefined)
    .join('\n');

  let optionalExecute = '';
  const usesConfigEngine = Object.keys(marketConfig.configs).some(
    (f) => ![FEATURE.OTHERS, FEATURE.FLASH_BORROWER, FEATURE.FREEZE].includes(f),
  );
  const isAssetListing = Object.keys(marketConfig.configs).some((f) =>
    [FEATURE.ASSET_LISTING, FEATURE.ASSET_LISTING_CUSTOM].includes(f),
  );
  if (innerExecute) {
    if (usesConfigEngine) {
      optionalExecute = `function _postExecute() internal override {
        ${innerExecute}
       }`;
    } else {
      optionalExecute = `function execute() external {
        ${innerExecute}
       }`;
    }
  }

  const contract = `/**
  * @title ${title || 'TODO'}
  * @author ${author || 'TODO'} ${
    !isWhitelabel
      ? `
  * - Snapshot: ${snapshot || 'TODO'}
  * - Discussion: ${discussion || 'TODO'}`
      : ''
  }
  */
 contract ${contractName} is ${
   usesConfigEngine ? `Aave${version}Payload${marketName}` : 'IProposalGenericExecutor'
 } {
   ${isAssetListing ? 'using SafeERC20 for IERC20;' : ''}

   ${constants}

   ${optionalExecute}

   ${functions}
 }`;

  return prefixWithPragma(prefixWithImports(contract));
};
