import type ConfigInterface from "../src/config/config_interface";
import type { ComplexModificationConfig } from "../src/karabiner/karabiner_types";
import C3ProConfig from "./devices/c3_pro";
import DK75Config from "./devices/dk75";

export default class Init implements ConfigInterface {
  init(registerConfig: (c: ComplexModificationConfig) => void): void {
    // new DK75Config().init(registerConfig)
    new C3ProConfig().init(registerConfig)
  }
}
