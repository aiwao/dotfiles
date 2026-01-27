import type { ComplexModificationConfig } from "./karabiner_types";

export default interface ConfigInterface {
  init(registerConfig: (c: ComplexModificationConfig) => void): void
}
