import { join, resolve } from "path";
import { homedir } from "os";
import { keyboardManager } from "./utility/keyboard_manager";
import { ComplexModificationConfig } from "./karabiner/karabiner_types";
import { configLoader } from "./config/config_loader";

async function run() {
  const karabinerPath = resolve(
    Bun.env.XDG_CONFIG_HOME ?? join(homedir(), ".config"),
    "karabiner",
  )
  const karabinerFile = Bun.file(resolve(karabinerPath, "karabiner.json"))
  if (!(await karabinerFile.exists()))
    throw new Error("karabiner config is not found")
  
  const configPath = resolve(process.cwd(), "configs")
  const configArray: ComplexModificationConfig[] = []
  const registerConfig = (c: ComplexModificationConfig) => {
    configArray.push(c)
  }

  await keyboardManager.init(configPath) 
  await configLoader.load(configPath, registerConfig)

  for (const c of configArray) {
    const filename = c.title
      .toLowerCase()
      .replaceAll(" ", "-")
      .concat(".json")

    const filepath = resolve(karabinerPath, "assets", "complex_modifications", filename)
    console.log(`Writing the configuration in ${filepath}`)
    await Bun.write(filepath, JSON.stringify(c, null, 2))
  }
}

run()
