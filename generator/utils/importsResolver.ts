/**
 * As a payload can consist of multiple features combined it's a mess to manage imports
 * Therefore instead of maintaining imports, we just extract them from the generated code instead.
 */

const GovernanceImports = [
  'GovV3Helpers',
  'IPayloadsControllerCore',
  'PayloadsControllerUtils',
] as const;

/**
 * @dev matches the code from known address book imports and generates an import statement satisfying the used libraries
 * @param code
 * @returns
 */
function generateAddressBookImports(code: string) {
  const imports: string[] = [];
  let root = '';
  // lookbehind for I to not match interfaces like IAaveV3ConfigEngine
  const addressBookMatch = code.match(/(?<!I)(AaveV[2..3][A-Za-z]+)(?<!(Assets)|(EModes))\b\./);
  if (addressBookMatch) {
    imports.push(addressBookMatch[1]);
    root = addressBookMatch[1];
  }
  const assetsMatch = code.match(/(AaveV[2..3][A-Za-z]+)Assets\./);
  if (assetsMatch) {
    imports.push(assetsMatch[1] + 'Assets');
    root = assetsMatch[1];
  }
  const eModesMatch = code.match(/(AaveV[2..3][A-Za-z]+)EModes\./);
  if (eModesMatch) {
    imports.push(eModesMatch[1] + 'EModes');
    root = eModesMatch[1];
  }
  if (imports.length > 0) return `import {${imports}} from 'aave-address-book/${root}.sol';\n`;
}

function generateEngineImport(code: string) {
  const matches = [...code.matchAll(/Aave(V[2..3])Payload([A-Za-z]+)/g)].flat();
  if (matches.length > 0)
    return `import {${matches[0]}} from 'aave-helpers/src/${matches[1].toLowerCase()}-config-engine/${
      matches[0]
    }.sol';\n`;
}

function findMatches(code: string, needles: string[] | readonly string[]) {
  return needles.filter((needle) => RegExp(needle, 'g').test(code));
}

function findMatch(code: string, needle: string) {
  return RegExp(needle, 'g').test(code);
}

/**
 * @dev Returns the input string prefixed with imports
 * @param code
 * @returns
 */
export function prefixWithImports(code: string) {
  let imports = '';
  const govMatches = findMatches(code, GovernanceImports);
  // gov related imports
  if (govMatches.length > 0)
    imports += `import {${govMatches}} from 'aave-helpers/src/GovV3Helpers.sol';\n`;
  // address book imports
  const addressBookImports = generateAddressBookImports(code);
  if (addressBookImports) {
    imports += addressBookImports;
  }
  // generic Executor
  if (findMatch(code, 'IProposalGenericExecutor')) {
    imports += `import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';\n`;
  }
  const configEngineImport = generateEngineImport(code);
  if (configEngineImport) {
    imports += configEngineImport;
  }
  // shared config engine imports
  if (findMatch(code, 'EngineFlags')) {
    imports += `import {EngineFlags} from 'aave-v3-origin/contracts/extensions/v3-config-engine/EngineFlags.sol';\n`;
  }
  // v3 config engine imports
  if (findMatch(code, 'IAaveV3ConfigEngine')) {
    imports += `import {IAaveV3ConfigEngine} from 'aave-v3-origin/contracts/extensions/v3-config-engine/IAaveV3ConfigEngine.sol';\n`;
  }
  // v2 config engine imports
  if (findMatch(code, 'IAaveV2ConfigEngine')) {
    imports += `import {IAaveV2ConfigEngine} from 'aave-helpers/src/v2-config-engine/IAaveV2ConfigEngine.sol';\n`;
  }
  if (findMatch(code, 'IV2RateStrategyFactory')) {
    imports += `import {IV2RateStrategyFactory} from 'aave-helpers/src/v2-config-engine/IV2RateStrategyFactory.sol';\n`;
  }
  // common imports
  if (findMatch(code, 'IERC20')) {
    imports += `import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';\n`;
  }
  if (findMatch(code, 'forceApprove')) {
    imports += `import {SafeERC20} from 'solidity-utils/contracts/oz-common/SafeERC20.sol';\n`;
  }
  if (findMatch(code, 'GovernanceV3Ethereum')) {
    imports += `import {GovernanceV3Ethereum} from 'aave-address-book/GovernanceV3Ethereum.sol';\n`;
  }
  if (findMatch(code, 'IEmissionManager')) {
    imports += `import {IEmissionManager} from 'aave-v3-origin/contracts/rewards/interfaces/IEmissionManager.sol';\n`;
  }

  return imports + code;
}
