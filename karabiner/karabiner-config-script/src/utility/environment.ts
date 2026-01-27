import { homedir } from "os";
import { join, resolve } from "path";

export const karabinerPath = resolve(
  Bun.env.XDG_CONFIG_HOME ?? join(homedir(), ".config"),
  "karabiner",
)
export const configPath = resolve(process.cwd(), "configs")
export const complexModificationsPath = resolve(karabinerPath, "assets", "complex_modifications")
