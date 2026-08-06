import {Sentinel} from '../types';

const SENTINEL_PREFIX = 'EngineFlags';

export function literal(value: string | number | bigint | boolean): Sentinel {
  return {kind: 'literal', value};
}

export function keepCurrent(): Sentinel {
  return {kind: 'keepCurrent', sentinel: 'KEEP_CURRENT'};
}

export function keepCurrentAddress(): Sentinel {
  return {kind: 'keepCurrent', sentinel: 'KEEP_CURRENT_ADDRESS'};
}

export function keepCurrentUint64(): Sentinel {
  return {kind: 'keepCurrent', sentinel: 'KEEP_CURRENT_UINT64'};
}

export function keepCurrentUint32(): Sentinel {
  return {kind: 'keepCurrent', sentinel: 'KEEP_CURRENT_UINT32'};
}

export function keepCurrentUint16(): Sentinel {
  return {kind: 'keepCurrent', sentinel: 'KEEP_CURRENT_UINT16'};
}

export function enabled(): Sentinel {
  return {kind: 'keepCurrent', sentinel: 'ENABLED'};
}

export function disabled(): Sentinel {
  return {kind: 'keepCurrent', sentinel: 'DISABLED'};
}

export function renderSentinel(s: Sentinel): string {
  if (s.kind === 'literal') {
    const v = s.value;
    if (typeof v === 'string') return v;
    if (typeof v === 'boolean') return v ? 'true' : 'false';
    return String(v);
  }
  return `${SENTINEL_PREFIX}.${s.sentinel}`;
}

export function renderBoolAsUint(s: Sentinel): string {
  if (s.kind === 'literal') {
    if (s.value === true || s.value === 1) return `${SENTINEL_PREFIX}.ENABLED`;
    if (s.value === false || s.value === 0) return `${SENTINEL_PREFIX}.DISABLED`;
    return String(s.value);
  }
  return `${SENTINEL_PREFIX}.${s.sentinel}`;
}
