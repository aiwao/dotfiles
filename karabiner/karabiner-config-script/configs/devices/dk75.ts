import type ConfigInterface from "../../src/config/config_interface";
import { ConfigBuilder } from "../../src/karabiner/karabiner_builder";
import { basicRule } from "../../src/karabiner/karabiner_builder_helper";
import type { ComplexModificationConfig } from "../../src/karabiner/karabiner_types";

//add rules for my china keyboard
export default class DK75Config implements ConfigInterface {
  init(registerConfig: (c: ComplexModificationConfig) => void): void {
    const dk75Config = new ConfigBuilder()
      .title("DK75")
      .deviceIf("DK75")
      .deviceIf("DK75-USB")

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
      )
    }

    dk75Config
      .rule(
        basicRule({
          description: "Fix Plus position",
          fromKeyCode: "semicolon",
          toKeyCode: "equal_sign",
          fromModifiers: ["shift"],
          toModifiers: ["shift"],
        })
      )
      .rule(
        basicRule({
          description: "Fix Colon position",
          fromKeyCode: "quote",
          toKeyCode: "semicolon",
          toModifiers: ["shift"],
        })
      )
      .rule(
        basicRule({
          description: "Fix AStar position",
          fromKeyCode: "quote",
          toKeyCode: "8",
          fromModifiers: ["shift"],
          toModifiers: ["shift"],
        })
      )
      .rule(
        basicRule({
          description: "Fix Backslash position",
          fromKeyCode: "equal_sign",
          toKeyCode: "backslash",
        })
      )
      .rule(
        basicRule({
          description: "Fix Stick position",
          fromKeyCode: "equal_sign",
          toKeyCode: "backslash",
          fromModifiers: ["shift"],
          toModifiers: ["shift"],
        })
      )
      .rule(
        basicRule({
          description: "Add Japanese-eisuu",
          fromKeyCode: "left_option",
          toKeyCode: "japanese_eisuu",
        })
      )
      .rule(
        basicRule({
          description: "Add Japanese-kana",
          fromKeyCode: "right_option",
          toKeyCode: "japanese_kana",
        })
      )
      .rule(
        basicRule({
          description: "Fix Left-option position",
          fromKeyCode: "left_control",
          toKeyCode: "left_option",
        })
      )
      .rule(
        basicRule({
          description: "Replace Caps-lock to Left-control",
          fromKeyCode: "caps_lock",
          toKeyCode: "left_control",
        })
      )
      .rule(
        basicRule({
          description: "Fix Attention-mark position",
          fromKeyCode: "grave_accent_and_tilde",
          toKeyCode: "1",
          fromModifiers: ["shift"],
          toModifiers: ["shift"],
        })
      )
      .rule(
        basicRule({
          description: "Fix Double-quote position",
          fromKeyCode: "1",
          toKeyCode: "quote",
          fromModifiers: ["shift"],
          toModifiers: ["shift"],
        })
      )
      .rule(
        basicRule({
          description: "Fix Sharp position",
          fromKeyCode: "2",
          toKeyCode: "3",
          fromModifiers: ["shift"],
          toModifiers: ["shift"],
        })
      )
      .rule(
        basicRule({
          description: "Fix Dollar-mark position",
          fromKeyCode: "3",
          toKeyCode: "4",
          fromModifiers: ["shift"],
          toModifiers: ["shift"],
        })
      )
      .rule(
        basicRule({
          description: "Fix Parcent-mark position",
          fromKeyCode: "4",
          toKeyCode: "5",
          fromModifiers: ["shift"],
          toModifiers: ["shift"],
        })
      )
      .rule(
        basicRule({
          description: "Fix And-mark position",
          fromKeyCode: "5",
          toKeyCode: "7",
          fromModifiers: ["shift"],
          toModifiers: ["shift"],
        })
      )
      .rule(
        basicRule({
          description: "Fix Single-quote position",
          fromKeyCode: "6",
          toKeyCode: "quote",
          fromModifiers: ["shift"],
        })
      )
      .rule(
        basicRule({
          description: "Fix Round-bracket position",
          fromKeyCode: "7",
          toKeyCode: "9",
          fromModifiers: ["shift"],
          toModifiers: ["shift"],
        })
      )
      .rule(
        basicRule({
          description: "Fix Close-round-bracket position",
          fromKeyCode: "8",
          toKeyCode: "0",
          fromModifiers: ["shift"],
          toModifiers: ["shift"],
        })
      )
      .rule(
        basicRule({
          description: "Fix Minus position",
          fromKeyCode: "0",
          toKeyCode: "hyphen",
        })
      )
      .rule(
        basicRule({
          description: "Fix Equal position",
          fromKeyCode: "0",
          toKeyCode: "equal_sign",
          fromModifiers: ["shift"],
        })
      )
      .rule(
        basicRule({
          description: "Fix Underbar position",
          fromKeyCode: "9",
          toKeyCode: "hyphen",
          fromModifiers: ["shift"],
          toModifiers: ["shift"],
        })
      )
      .rule(
        basicRule({
          description: "Fix Hat position",
          fromKeyCode: "hyphen",
          toKeyCode: "6",
          toModifiers: ["shift"],
        })
      )
      .rule(
        basicRule({
          description: "Fix Tilde position",
          fromKeyCode: "hyphen",
          toKeyCode: "grave_accent_and_tilde",
          fromModifiers: ["shift"],
          toModifiers: ["shift"],
        })
      )
      .rule(
        basicRule({
          description: "Fix At-mark position",
          fromKeyCode: "open_bracket",
          toKeyCode: "2",
          toModifiers: ["shift"],
        })
      )
      .rule(
        basicRule({
          description: "Fix Back-quote position",
          fromKeyCode: "open_bracket",
          toKeyCode: "grave_accent_and_tilde",
          fromModifiers: ["shift"],
        })
      )
      .rule(
        basicRule({
          description: "Fix Open-bracket position",
          fromKeyCode: "close_bracket",
          toKeyCode: "open_bracket",
        })
      )
      .rule(
        basicRule({
          description: "Fix Close-bracket position",
          fromKeyCode: "backslash",
          toKeyCode: "close_bracket",
        })
      )
      .rule(
        basicRule({
          description: "Fix Open-brace position",
          fromKeyCode: "close_bracket",
          toKeyCode: "open_bracket",
          fromModifiers: ["shift"],
          toModifiers: ["shift"],
        })
      )
      .rule(
        basicRule({
          description: "Fix Close-brace position",
          fromKeyCode: "backslash",
          toKeyCode: "close_bracket",
          fromModifiers: ["shift"],
          toModifiers: ["shift"],
        })
      ) 
      
      registerConfig(dk75Config.build())
  } 
}

//add rules to builder with 3 modifiers (cmd, opt, ctrl)
function addRulesWithModifier(
  builder: ConfigBuilder,
  baseDescription: string,
  from: string,
  to: string,
) {
  const modifiers: string[] = ["command", "option", "control"]
  const allPatterns: string[][] = [[""]]
  
  const n = modifiers.length;
  for (let mask = 1; mask < 1 << n; mask++) {
    const patterns: string[] = []
    for (let i = 0; i < n; i++) {
      if (mask & (1 << i)) {
        patterns.push(modifiers[i]!)
      }
    }
    allPatterns.push(patterns);
  }

  allPatterns.forEach((m) => {
    let description = baseDescription
    let keyModifier: string[] = []
    if (m[0] !== "") {
      keyModifier = m
      description = description + ` (+${m})`
    }

    builder.rule(
      basicRule({
        description: description,
        fromKeyCode: from,
        toKeyCode: to,
        fromModifiers: keyModifier,
        toModifiers: keyModifier,
      })
    )
  })
}
