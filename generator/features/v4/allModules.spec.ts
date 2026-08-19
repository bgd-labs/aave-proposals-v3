import {expect, describe, it} from 'vitest';
import {generateFiles} from '../../generator';
import {allModulesFixture} from './fixtures';

describe('feature: v4 all-modules smoke test', () => {
  it('builds a payload exercising every override', async () => {
    const {options, marketConfigs} = allModulesFixture();
    const files = await generateFiles(options, marketConfigs);
    expect(files).toMatchSnapshot();
  });
});
