import {Sentinel} from '../types';
import {renderSentinel} from './sentinels';
import {translateJsPercentToSol} from '../../prompts/percentPrompt';

const WAD_DECIMALS = 18;

/// Group a plain integer string with `_` every three digits (`1000000` -> `1_000_000`).
export function groupThousands(value: string): string {
  return value.replace(/\B(?=(\d{3})+(?!\d))/g, '_');
}

/// Convert a human percentage string to a grouped BPS Solidity literal:
/// `90` -> `90_00`, `7.5` -> `7_50`, `104` -> `104_00`, `0` -> `0`.
export function percentToBps(value: string): string {
  if (!value || Number(value) === 0) return '0';
  return translateJsPercentToSol(value);
}

/// Convert a human decimal string to a WAD (1e18) Solidity literal:
/// `1.0277` -> `1_027_700_000_000_000_000`, `0.99` -> `990_000_000_000_000_000`.
export function decimalToWad(value: string): string {
  const [intPart, fracRaw = ''] = value.split('.');
  const frac = (fracRaw + '0'.repeat(WAD_DECIMALS)).slice(0, WAD_DECIMALS);
  const wad = BigInt(intPart || '0') * 10n ** BigInt(WAD_DECIMALS) + BigInt(frac || '0');
  return groupThousands(wad.toString());
}

/// Render a Sentinel whose literal value is a human percentage, converting to BPS.
export function renderBpsSentinel(s: Sentinel): string {
  if (s.kind === 'literal') return percentToBps(String(s.value));
  return renderSentinel(s);
}

/// Render a Sentinel whose literal value is a human decimal, converting to WAD.
export function renderWadSentinel(s: Sentinel): string {
  if (s.kind === 'literal') return decimalToWad(String(s.value));
  return renderSentinel(s);
}
