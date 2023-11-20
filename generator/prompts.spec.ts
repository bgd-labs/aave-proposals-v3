import {expect, describe, it} from 'vitest';
import {render} from '@inquirer/testing';
import {
  numberPrompt,
  transformNumberToHumanReadable,
  translateJsNumberToSol,
} from './prompts/numberPrompt';
import {
  percentPrompt,
  transformNumberToPercent,
  translateJsPercentToSol,
} from './prompts/percentPrompt';

describe('prompts', () => {
  describe('numberInput', () => {
    it('handles "yes"', async () => {
      const {answer, events, getScreen} = await render(numberPrompt, {
        message: 'Enter number?',
      });

      expect(getScreen()).toMatchInlineSnapshot('"? Enter number?"');

      events.type('yes112.3');
      expect(getScreen()).toMatchInlineSnapshot('"? Enter number? 1,123"');

      events.keypress('enter');
      await expect(answer).resolves.toEqual('1123');
    });
  });

  describe('percentInput', () => {
    it('handles "yes"', async () => {
      const {answer, events, getScreen} = await render(percentPrompt, {
        message: 'Enter number?',
      });

      expect(getScreen()).toMatchInlineSnapshot('"? Enter number?"');

      events.type('yes12.3');
      expect(getScreen()).toMatchInlineSnapshot('"? Enter number? 12.3 %"');

      events.keypress('enter');
      await expect(answer).resolves.toEqual('12.3');
    });
  });
  /**
   * Transformers are here to format the input based on a users input
   * They do not change the users input value though, the effect is purely visual
   */
  describe('transforms', () => {
    it('transformNumberToHumanReadable: should return a human readable full number', () => {
      expect(transformNumberToHumanReadable('1000')).toBe('1,000');
      expect(transformNumberToHumanReadable('1000000')).toBe('1,000,000');
    });

    it('transformNumberToPercent: should return a human readable % number', () => {
      expect(transformNumberToPercent('100')).toBe('100 %');
      expect(transformNumberToPercent('3333.33')).toBe('3,333.33 %');
      expect(transformNumberToPercent('0.33')).toBe('0.33 %');
      expect(transformNumberToPercent('0.3')).toBe('0.3 %');
    });
  });

  /**
   * Translates, translate the js input value to solidity
   */
  describe('translate', () => {
    it('translateJsNumberToSol: should properly translate values', () => {
      expect(translateJsNumberToSol('0')).toBe('0');
      expect(translateJsNumberToSol('1000')).toBe('1_000');
      expect(translateJsNumberToSol('1000000')).toBe('1_000_000');
    });

    it('translateJsPercentToSol: should properly translate % values', () => {
      expect(translateJsPercentToSol('0')).toBe('0');
      expect(translateJsPercentToSol('100')).toBe('100_00');
      expect(translateJsPercentToSol('3333.33')).toBe('3_333_33');
      expect(translateJsPercentToSol('0.33')).toBe('33');
      expect(translateJsPercentToSol('0.3')).toBe('30');
    });
  });
});
