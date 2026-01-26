import path from "path";
import { init } from "./keyboards";
import { outputPath } from "./karabiner-config-generator.config";
import { basicRule, ConfigBuilder, FromKeyBuilder, FromKeyModifiersBuilder, ManipulatorBuilder, RuleBuilder, ToKeyBuilder } from "./karabiner_builder";
import { ComplexModificationConfig } from "./karabiner_types";

await init()

const configs: ComplexModificationConfig[] = []

//add rules to builder with 3 modifiers (cmd, opt, ctrl)
function addRulesWithModifier(
  builder: ConfigBuilder,
  baseDescription: string,
  from: string,
  to: string,
  deviceIf?: string,
) {
  const modifiers = ["", "command", "option", "control"]
  modifiers.forEach((m) => {
    let description = baseDescription
    let keyModifier = []
    if (m !== "") {
      keyModifier.push(m)
      description = description + ` (+${m})`
    }

    builder.rule(
      basicRule(
        description,
        from,
        to,
        keyModifier,
        keyModifier,
        deviceIf,
      )
    )
  })
}

//add rules for my china keyboard
function addDK75Rules() {
  const dk75Config = new ConfigBuilder().title("DK75")

  //digits
  for (let i = 0; i <= 10; i++) {
    let from = i.toString()
    let to = (i+1).toString()
    if (i === 0) {
      from = "grave_accent_and_tilde"
      to = "1"
    }
    if (i === 10) {
      from = "9"
      to = "0"
    }
    addRulesWithModifier(
      dk75Config,
      `Fix ${i} key positon`,
      from,
      to,
      "DK75",
    )
  }

  dk75Config
    .rule(
      basicRule(
        "Fix Plus position",
        "semicolon",
        "equal_sign",
        ["shift"],
        ["shift"],
        "DK75",
      )
    )
    .rule(
      basicRule(
        "Fix Colon position",
        "quote",
        "semicolon",
        [],
        ["shift"],
        "DK75",
      )
    )
    .rule(
      basicRule(
        "Fix AStar position",
        "quote",
        "8",
        ["shift"],
        ["shift"],
        "DK75",
      )
    )
    .rule(
      basicRule(
        "Fix Backslash position",
        "equal_sign",
        "backslash",
        [],
        [],
        "DK75",      
      )
    )
    .rule(
      basicRule(
        "Fix Stick position",
        "equal_sign",
        "backslash",
        ["shift"],
        ["shift"],
       "DK75",
      )
    ) 
    .rule(
      basicRule(
        "Add Japanese-eisuu",
        "left_option",
        "japanese_eisuu",
        [],
        [],
        "DK75",
      )
    )
    .rule(
      basicRule(
        "Add Japanese-kana",
        "right_option",
        "japanese_kana",
        [],
        [],
        "DK75",
      )
    )
    .rule(
      basicRule(
        "Fix Left-option position",
        "left_control",
        "left_option",
        [],
        [],
        "DK75",
      )
    )
    .rule(
      basicRule(
        "Replace Caps-lock to Left-control",
        "caps_lock",
        "left_control",
        [],
        [],
        "DK75",
      )
    ) 
    .rule(
      basicRule(
        "Fix Attention-mark position",
        "grave_accent_and_tilde",
        "1",
        ["shift"],
        ["shift"],
        "DK75"
      )
    )
    .rule(
      basicRule(
        "Fix Double-quote position",
        "1",
        "quote",
        ["shift"],
        ["shift"],
        "DK75",
      )
    )
    .rule(
      basicRule(
        "Fix Sharp position",
        "2",
        "3",
        ["shift"],
        ["shift"],
        "DK75",
      )
    )
    .rule(
      basicRule(
        "Fix Dollar-mark position",
        "3",
        "4",
        ["shift"],
        ["shift"],
        "DK75",
      )
    )
    .rule(
      basicRule(
        "Fix Parcent-mark position",
        "4",
        "5",
        ["shift"],
        ["shift"],
        "DK75",
      )
    )
    .rule(
      basicRule(
        "Fix And-mark position",
        "5",
        "7",
        ["shift"],
        ["shift"],
        "DK75",
      )
    )
    .rule(
      basicRule(
        "Fix Single-quote position",
        "6",
        "quote",
        ["shift"],
        [],
        "DK75",
      )
    )
    .rule(
      basicRule(
        "Fix Round-bracket position",
        "7",
        "9",
        ["shift"],
        ["shift"],
        "DK75",
      )
    )
    .rule(
      basicRule(
        "Fix Close-round-bracket position",
        "8",
        "0",
        ["shift"],
        ["shift"],
        "DK75",
      )
    )
    .rule(
      basicRule(
        "Fix Minus position",
        "0",
        "hyphen",
        [],
        [],
        "DK75"
      )
    )
    .rule(
      basicRule(
        "Fix Equal position",
        "0",
        "equal_sign",
        ["shift"],
        [],
        "DK75"
      )
    )
    .rule(
      basicRule(
        "Fix Underbar position",
        "9",
        "hyphen",
        ["shift"],
        ["shift"],
        "DK75"
      )
    )
    .rule(
      basicRule(
        "Fix Hat position",
        "hyphen",
        "6",
        [],
        ["shift"],
        "DK75"
      )
    )
    .rule(
      basicRule(
        "Fix Tilde position",
        "hyphen",
        "grave_accent_and_tilde",
        ["shift"],
        ["shift"],
        "DK75"
      )
    )
    .rule(
      basicRule(
        "Fix At-mark position",
        "open_bracket",
        "2",
        [],
        ["shift"],
        "DK75"
      )
    )
    .rule(
      basicRule(
        "Fix Back-quote position",
        "open_bracket",
        "grave_accent_and_tilde",
        ["shift"],
        [],
        "DK75"
      )
    )
    .rule(
      basicRule(
        "Fix Open-bracket position",
        "close_bracket",
        "open_bracket",
        [],
        [],
        "DK75"
      )
    )
    .rule(
      basicRule(
        "Fix Close-bracket position",
        "backslash",
        "close_bracket",
        [],
        [],
        "DK75"
      )
    )
    .rule(
      basicRule(
        "Fix Open-brace position",
        "close_bracket",
        "open_bracket",
        ["shift"],
        ["shift"],
        "DK75"
      )
    )
    .rule(
      basicRule(
        "Fix Close-brace position",
        "backslash",
        "close_bracket",
        ["shift"],
        ["shift"],
        "DK75"
      )
    )

  configs.push(
    dk75Config.build()
  )
}

addDK75Rules()

configs.forEach(async (c) => {
  const filename = c.title
    .toLowerCase()
    .replaceAll(" ", "-")
    .concat(".json")
  const filepath = path.resolve(outputPath, filename)
  console.log(`Writing the configuration in ${filepath}`)
  await Bun.write(filepath, JSON.stringify(c, null, 2))
})
