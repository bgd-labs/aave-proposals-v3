import {advancedInput} from './advancedInput';
import {GenericPrompt} from './types';

function isNumber(value: string) {
  return !isNaN(value as unknown as number);
}

export function transformNumberToPercent(value: string) {
  if (value && isNumber(value)) {
    return (
      new Intl.NumberFormat('en-us', {
        maximumFractionDigits: 2,
      }).format(value as unknown as number) + ' %'
    );
  }
  return value;
}

export async function percentPrompt<T extends boolean>(
  {message, required}: GenericPrompt<T>,
  opts?
): Promise<string> {
  const value = await advancedInput(
    {
      message,
      transformer: transformNumberToPercent,
      validate: (v) => {
        if (required && v.length == 0) return false;
        return isNumber(v);
      },
      pattern: /^[0-9]*\.?[0-9]*$/,
      patternError: 'Only decimal numbers are allowed (e.g. 1.1)',
    },
    opts
  );
  return value;
}
export function translateJsPercentToSol(value?: string, bpsToRay?: boolean) {
  if (!value) return `EngineFlags.KEEP_CURRENT`;
  const formattedValue = new Intl.NumberFormat('en-us', {
    maximumFractionDigits: 2,
    minimumFractionDigits: 2,
  }).format(value as unknown as number);
  const _value = (
    Number(value) >= 1 ? formattedValue : formattedValue.replace(/^0\.0*(?=[0-9])/, '')
  ).replace(/[\.,]/g, '_');
  if (bpsToRay) return `_bpsToRay(${_value})`;
  return _value;
}
