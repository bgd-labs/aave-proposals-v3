export interface GenericPrompt<T extends boolean = boolean> {
  message: string;
  required?: T;
  transform?: (value: string) => string;
  defaultValue?: string;
}
