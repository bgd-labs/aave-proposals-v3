import {expect, describe, it} from 'vitest';
import {generateFiles} from '../../generator';
import {useCasesFixture} from './fixtures';

describe('feature: v4 use-cases smoke test', () => {
  it('builds a payload exercising every use-case bundle', async () => {
    const {options, marketConfigs} = useCasesFixture();
    const files = await generateFiles(options, marketConfigs);
    expect(files).toMatchSnapshot();
  });
});
