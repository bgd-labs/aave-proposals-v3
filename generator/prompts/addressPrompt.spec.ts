import {expect, describe, it} from 'vitest';
import {render} from '@inquirer/testing';
import {addressPrompt, translateJsAddressToSol} from './addressPrompt';

describe('addresses', () => {
  describe('addressPrompt', () => {
    it('handles "required"', async () => {
      const {answer, events, getScreen} = await render(addressPrompt, {
        message: 'Enter address?',
        required: true,
      });

      expect(getScreen()).toMatchInlineSnapshot('"? Enter address?*"');

      events.keypress('enter');
      await Promise.resolve();
      expect(getScreen()).toMatchInlineSnapshot(
        '"? Enter address?*\n> You must provide a valid value"'
      );

      events.type('XX0xXXae7ab96520de3a18e5e111b5eaab095312d7fe84');
      expect(getScreen()).toMatchInlineSnapshot(
        '"? Enter address?* 0xae7ab96520de3a18e5e111b5eaab095312d7fe84"'
      );

      events.keypress('enter');
      await expect(answer).resolves.toEqual('0xae7ab96520de3a18e5e111b5eaab095312d7fe84');
    });

    it('handles "optional"', async () => {
      const {answer, events, getScreen} = await render(addressPrompt, {
        message: 'Enter address?',
      });

      expect(getScreen()).toMatchInlineSnapshot('"? Enter address?"');

      events.keypress('enter');
      await Promise.resolve();
      await expect(answer).resolves.toEqual('');
    });
  });

  /**
   * Translates, translate the js input value to solidity
   */
  describe('translate', () => {
    it('translateJsAddressToSol: should properly translate values to addresses', () => {
      expect(translateJsAddressToSol('')).toBe('EngineFlags.KEEP_CURRENT_ADDRESS');
      expect(translateJsAddressToSol('0xae7ab96520de3a18e5e111b5eaab095312d7fe84')).toBe(
        '0xae7ab96520DE3A18E5e111B5EaAb095312D7fE84'
      );
    });
  });
});
