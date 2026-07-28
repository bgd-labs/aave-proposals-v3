import {Sentinel} from '../types';
import {renderSentinel} from './sentinels';
import {translateJsPercentToSol} from '../../prompts/percentPrompt';

const WAD_DECIMALS = 18;

/// Group a plain integer string with `_` every three digits (`1000000` -> `1_000_000`).
/// Already grouped values are re-grouped from scratch, so it is safe to apply twice.
export function groupThousands(value: string): string {
  return String(value)
    .replace(/_/g, '')
    .replace(/\B(?=(\d{3})+(?!\d))/g, '_');
}

/// Convert a human percentage string to a grouped BPS Solidity literal:
/// `90` -> `90_00`, `7.5` -> `7_50`, `104` -> `104_00`, `0` -> `0`.
export function percentToBps(value: string): string {
  if (!value || Number(value) === 0) return '0';
  return translateJsPercentToSol(value);
}

/// Convert a human decimal string to a WAD (1e18) Solidity literal in scientific
/// notation, which keeps the human value readable in the payload:
/// `1.0277` -> `1.0277e18`, `0.99` -> `0.99e18`, `1` -> `1e18`, `0` -> `0`.
export function decimalToWad(value: string): string {
  const normalized = String(value).replace(/_/g, '');
  if (Number(normalized) === 0) return '0';
  const [intPart, fracRaw = ''] = normalized.split('.');
  const frac = fracRaw.slice(0, WAD_DECIMALS).replace(/0+$/, '');
  const mantissa = frac ? `${intPart || '0'}.${frac}` : intPart || '0';
  return `${mantissa}e${WAD_DECIMALS}`;
}

/// Render a Sentinel whose literal value is a whole-unit amount (a cap), grouping it.
export function renderWholeSentinel(s: Sentinel): string {
  if (s.kind === 'literal') return groupThousands(String(s.value));
  return renderSentinel(s);
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
