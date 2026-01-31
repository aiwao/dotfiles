import { resolve } from "path";
import type ConfigInterface from "./config_interface";
import type { ComplexModificationConfig } from "../karabiner/karabiner_types";

type ConfigCtor = new (...args: any[]) => ConfigInterface

class ConfigLoader {
  async load(configPath: string, registerConfig: (c: ComplexModificationConfig) => void) {
    const mod = await import(resolve(configPath, "init.ts"))
    const ctor = mod.default

    const configCtor = ctor as ConfigCtor
    new configCtor().init(registerConfig)
    console.log("Config initialized")
  }
}

export const configLoader = new ConfigLoader()
