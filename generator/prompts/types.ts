import {PoolIdentifier} from '../types';

export interface GenericPrompt<T extends boolean = boolean> {
  message: string;
  required?: T;
  transform?: (value: string) => string;
  defaultValue?: string;
}

export interface GenericPoolPrompt<T extends boolean = boolean> extends GenericPrompt<T> {
  pool: PoolIdentifier;
}
