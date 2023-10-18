import {pragma} from '../common';

export function prefixWithPragma(code: string) {
  return pragma + code;
}
