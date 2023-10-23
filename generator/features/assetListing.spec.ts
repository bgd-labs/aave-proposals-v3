// sum.test.js
import {expect, describe, it} from 'vitest';
import {assetListing} from './assetListing';

describe('feature: assetListing', () => {
  it('should return reasonable code', () => {
    const output = assetListing.build({}, 'AaveV3Ethereum');
    expect(output).toMatchSnapshot();
  });
});
