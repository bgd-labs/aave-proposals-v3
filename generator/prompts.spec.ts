// sum.test.js
import {expect, describe, it} from 'vitest';
import {transformNumberToHumanReadable, transformNumberToPercent} from './prompts';

describe('prompts', () => {
  describe('transforms', () => {
    it('transformNumberToHumanReadable: should return a human readable full number', () => {
      expect(transformNumberToHumanReadable('1000')).toBe('1,000');
      expect(transformNumberToHumanReadable('1000000')).toBe('1,000,000');
    });

    it('transformNumberToPercent: should return a human readable % number', () => {
      expect(transformNumberToPercent('100')).toBe('100.00 %');
      expect(transformNumberToPercent('3333.33')).toBe('3,333.33 %');
      expect(transformNumberToPercent('0.33')).toBe('0.33 %');
      expect(transformNumberToPercent('0.3')).toBe('0.30 %');
    });
  });
});
