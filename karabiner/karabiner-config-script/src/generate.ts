import { keyboardManager } from "./utility/keyboard_manager";
import { ComplexModificationConfig } from "./karabiner/karabiner_types";
import { configLoader } from "./config/config_loader";
import { complexModificationsPath, configPath, karabinerPath } from "./utility/environment";
import { resolve } from "path";

async function run() { 
  const karabinerFile = Bun.file(resolve(karabinerPath, "karabiner.json"))
  if (!(await karabinerFile.exists()))
    throw new Error("karabiner config is not found")
  
  const configArray: ComplexModificationConfig[] = []
  const registerConfig = (c: ComplexModificationConfig) => {
    configArray.push(c)
  }

  await keyboardManager.init(configPath) 
  await configLoader.load(configPath, registerConfig)

  let ruleSize = 0
  for (const c of configArray) {
    ruleSize+=c.rules.length
    const filename = c.title
      .toLowerCase()
      .replaceAll(" ", "-")
      .concat(".json")

    const filepath = resolve(complexModificationsPath, filename)
    console.log(`Writing the configuration in ${filepath}`)
    await Bun.write(filepath, JSON.stringify(c, null, 2))
  }
  console.log(`${configArray.length} configuration ${ruleSize} rules was wrote`)
}

run()
