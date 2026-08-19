import {execFileSync} from 'node:child_process';
import {mkdtempSync, mkdirSync, rmSync, writeFileSync} from 'node:fs';
import path from 'node:path';
import type {Files} from '../types';

export function compileGeneratedFiles(files: Files) {
  const tempDir = mkdtempSync(path.join(process.cwd(), '.generator-compile-'));
  const sources: string[] = [];

  try {
    const fixtureDir = path.join(tempDir, 'src');
    mkdirSync(fixtureDir);

    files.payloads.forEach(({payload, test, contractName}) => {
      const payloadPath = path.join(fixtureDir, `${contractName}.sol`);
      const testPath = path.join(fixtureDir, `${contractName}.t.sol`);
      writeFileSync(payloadPath, payload);
      writeFileSync(testPath, test);
      sources.push(testPath);
    });

    const scriptPath = path.join(fixtureDir, 'Generated.s.sol');
    writeFileSync(scriptPath, files.scripts.defaultScript);
    sources.push(scriptPath);

    execFileSync('forge', ['build', ...sources], {
      cwd: process.cwd(),
      env: {...process.env, FOUNDRY_PROFILE: 'test'},
      stdio: 'pipe',
      timeout: 55_000,
    });
  } catch (error) {
    const forgeError = error as Error & {stdout?: Buffer; stderr?: Buffer};
    const output = [forgeError.stdout?.toString(), forgeError.stderr?.toString()]
      .filter(Boolean)
      .join('\n');
    throw new Error(`Generated Solidity failed to compile:\n${output}`, {cause: error});
  } finally {
    rmSync(tempDir, {recursive: true, force: true});
  }
}
