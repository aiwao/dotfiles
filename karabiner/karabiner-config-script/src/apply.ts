import { checkbox, select } from "@inquirer/prompts"
import { readdir } from "fs/promises"
import { complexModificationsPath, karabinerPath } from "./utility/environment"
import { z } from "zod";
import { ComplexModificationConfig, Rule } from "./karabiner/karabiner_types";
import { resolve } from "path";

const Karabiner = z.looseObject({
  profiles: z.array(
    z.looseObject({
      complex_modifications: z.looseObject({
        rules: z.array(Rule),
      }).optional(),
      name: z.string(),
    }),
  ),
})
type Karabiner = z.infer<typeof Karabiner>

async function run() {
  const karabinerFilePath = resolve(karabinerPath, "karabiner.json")
  const karabinerFile = await Bun.file(karabinerFilePath).json() 
  const karabinerParsed = Karabiner.safeParse(karabinerFile)
  if (!karabinerParsed.success) {
    throw karabinerParsed.error
  }
  const karabiner: Karabiner = karabinerParsed.data
  if (karabiner.profiles.length === 0)
    throw new Error("No Karabiner profiles is found")

  const configChoices =
    (await readdir(complexModificationsPath, { withFileTypes: true }))
      .filter((f) => f.isFile() && f.name.endsWith(".json"))
      .map((f) => {
        return { name: f.name, value: f.name, checked: true }
      })

  const configFilenameArray = await checkbox({
    message: "Select a config file",
    choices: configChoices,
  }) 
  const rules: Rule[] = []

  for (const configFilename of configFilenameArray) {
    const configFile = Bun.file(resolve(complexModificationsPath, configFilename))
    const configFiledata = await configFile.json()
    const configParsed = ComplexModificationConfig.safeParse(configFiledata)
    if (!configParsed.success) {
      console.error(configParsed.error)
      console.error(`Parse ${configFilename} failed`)
      continue
    }
    rules.push(...configParsed.data.rules) 
  }

   const profileChoice = 
      karabiner.profiles
        .map((value, index) => {
          return { name: value.name, value: karabiner.profiles[index]!, checked: true }
        })
    const profileArray = await checkbox({
      message: "Select the profile to apply a config",
      choices: profileChoice,
    })

    for (const profile of profileArray) {
      const rewrite = await select({
        message: "Overwrite a rules?",
        choices: [
          {
            name: "Yes",
            value: true,
          },
          {
            name: "No",
            value: false,
          },
        ]
      })

      if (!profile.complex_modifications)
        profile.complex_modifications = { rules: [] }

      if (rewrite) {
        profile.complex_modifications!.rules = rules
      } else {
        if (!profile.complex_modifications.rules)
          profile.complex_modifications!.rules = []
        profile.complex_modifications.rules.push(...rules)
      }

      console.log(`Applying rules to ${karabinerFilePath}`)
      await Bun.write(karabinerFilePath, JSON.stringify(karabiner, null, 2)) 
      console.log(`Applied ${rules.length} rules`)
    }
}

run()
