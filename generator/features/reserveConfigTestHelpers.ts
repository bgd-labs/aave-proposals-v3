export const KEEP_CURRENT = 'EngineFlags.KEEP_CURRENT';

export function expectedConfigAssignment(
  varName: string,
  field: string,
  value: string,
  translate: (value?: string) => string,
  transform: (value: string) => string = (value) => value,
) {
  const translated = translate(value);
  if (translated === KEEP_CURRENT) return '';
  return `${varName}.${field} = ${transform(translated)};`;
}
