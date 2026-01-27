import { resolve } from "path";
import { readdir } from "fs/promises";
import type ConfigInterface from "./config_interface";
import type { ComplexModificationConfig } from "../karabiner/karabiner_types";

type ConfigCtor = new (...args: any[]) => ConfigInterface

class ConfigLoader {
  async load(configPath: string, registerConfig: (c: ComplexModificationConfig) => void) {
    const configs =
      (await readdir(configPath, { withFileTypes: true }))
        .filter((f) => f.isFile() && f.name.endsWith(".ts"))
        .map((f) => resolve(configPath, f.name))
    
    for (const f of configs) {
      const mod = await import(resolve(configPath, f))
      const ctor = mod.default
      if (typeof ctor !== "function") {
        throw new Error(`${f} has not "ConfigInterface"`)
      }

      if (typeof (ctor as any).prototype?.init !== "function") {
        throw new Error(`${f} is not implemented "init" yet`)
      }
      
      const configCtor = ctor as ConfigCtor
      new configCtor().init(registerConfig)
    }
  }
}

export const configLoader = new ConfigLoader()
