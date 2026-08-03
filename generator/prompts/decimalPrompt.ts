import {advancedInput} from './advancedInput';
import {GenericPrompt} from './types';

/// Decimal input for values that are neither percentages nor whole units, e.g. health
/// factors. Restricted to plain decimal notation: exponents, hex and signs would pass
/// `Number()` but produce Solidity literals that do not compile once suffixed.
export async function decimalPrompt<T extends boolean>(
  {message, required}: GenericPrompt<T>,
  opts?,
) {
  return await advancedInput(
    {
      message,
      validate: (v) => {
        if (required && v.length == 0) return 'A value is required';
        return true;
      },
      pattern: /^[0-9]*\.?[0-9]*$/,
      patternError: 'Only decimal numbers are allowed (e.g. 1.05)',
    },
    opts,
  );
}
