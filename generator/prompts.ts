import {checkbox, select} from '@inquirer/prompts';
import {ENGINE_FLAGS, MarketIdentifier} from './types';
import {getEModes} from './common';

// TRANSLATIONS
function translateEModeToEModeLib(value: string, market: MarketIdentifier) {
  if (value === ENGINE_FLAGS.KEEP_CURRENT) return `EngineFlags.KEEP_CURRENT`;
  return `${market}EModes.${value}`;
}

// PROMPTS
interface GenericPrompt<T extends boolean = boolean> {
  message: string;
  disableKeepCurrent?: T;
  transform?: (value: string) => string;
  defaultValue?: string;
}

export type PercentInputValues = typeof ENGINE_FLAGS.KEEP_CURRENT | string;

export type NumberInputValues = typeof ENGINE_FLAGS.KEEP_CURRENT | string;

interface EModeSelectPrompt<T extends boolean> extends GenericPrompt<T> {
  market: MarketIdentifier;
}

export async function eModeSelect<T extends boolean>({
  message,
  disableKeepCurrent,
  market,
}: EModeSelectPrompt<T>) {
  const eModes = getEModes(market as any);
  if (eModes.length != 0) {
    const eMode = await select({
      message,
      choices: eModes,
    });
    return translateEModeToEModeLib(eMode, market);
  } else {
    console.log('No e-mode category active on the current market');
    return '0';
  }
}

export async function eModesSelect<T extends boolean>({message, market}: EModeSelectPrompt<T>) {
  const eModes = getEModes(market as any);
  if (eModes.length != 0) {
    const values = await checkbox({
      message,
      choices: eModes,
      required: true,
    });
    return values.map((mode) => translateEModeToEModeLib(mode, market));
  } else {
    console.log('No e-mode category active on the current market');
  }
}
