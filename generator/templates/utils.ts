import {pragma} from '../common';

export function prefixWithPragma(code: string) {
  return pragma + code;
}

const GovernanceImports = [
  'GovV3Helpers',
  'IPayloadsControllerCore',
  'PayloadsControllerUtils',
] as const;

function findMatches(code: string, needles: string[] | readonly string[]) {
  return needles.filter((needle) => RegExp(needle + '\\.', 'g').test(code));
}

/**
 * TODO: support more imports
 * @param code
 * @returns
 */
export function prefixWithImports(code: string) {
  let imports = '';
  const govMatches = findMatches(code, GovernanceImports);
  if (govMatches.length > 0)
    imports += `import {${govMatches}} from 'aave-helpers/GovV3Helpers.sol';`;

  return imports;
}
