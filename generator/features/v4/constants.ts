import {Hex} from 'viem';
import {CHAIN_TO_CHAIN_ID, getExplorerLink, getMarketChain} from '../../common';
import {MarketIdentifier} from '../../types';
import {translateJsAddressToSol} from '../../prompts/addressPrompt';

export function buildAddressConstant(
  market: MarketIdentifier,
  identifier: string,
  address: Hex,
): string {
  const chainId = CHAIN_TO_CHAIN_ID[getMarketChain(market)];
  return `// ${getExplorerLink(chainId, address)}\naddress public constant ${identifier} = ${translateJsAddressToSol(address)};`;
}

export function sanitizeIdentifier(s: string): string {
  return s.replace(/[^A-Za-z0-9_]/g, '_').toUpperCase();
}
