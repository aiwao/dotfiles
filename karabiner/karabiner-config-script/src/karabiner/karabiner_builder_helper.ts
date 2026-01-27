import { FromKeyBuilder, FromKeyModifiersBuilder, ManipulatorBuilder, RuleBuilder, ToKeyBuilder } from "./karabiner_builder"
import type { Rule } from "./karabiner_types"

export type BasicRuleProps = {
  description: string,
  fromKeyCode: string,
  toKeyCode: string,
  fromModifiers?: string[],
  toModifiers?: string[],
  deviceIf?: string[],
}

export function basicRule({
  description,
  fromKeyCode,
  toKeyCode,
  fromModifiers,
  toModifiers,
  deviceIf,
}: BasicRuleProps): Rule {
  const fromKeyModifiersBuilder = new FromKeyModifiersBuilder()
  if (fromModifiers)
    fromKeyModifiersBuilder.mandatory(fromModifiers)

  const toKeyBuilder = new ToKeyBuilder().keyCode(toKeyCode)
  if (toModifiers) {
    toKeyBuilder.modifiers(toModifiers)
  }

  const manipulatorBuilder =
    new ManipulatorBuilder()
    .type("basic")
    .from(
      new FromKeyBuilder()
        .keyCode(fromKeyCode)
        .modifiers(fromKeyModifiersBuilder.build())
        .build()
    )
    .to(toKeyBuilder.build())
  if (deviceIf) {
    deviceIf.forEach((d) => manipulatorBuilder.deviceIf(d))
  }

  return new RuleBuilder()
      .description(description)
      .manipulator(manipulatorBuilder.build())
      .build()
}

export type RuleWithModifiersProps = {
  description: string,
  fromKeyCode: string,
  toKeyCode: string,
  deviceIf?: string[],
  ignoreModifiers?: string[],
}

export function ruleWithModifiers({
  description,
  fromKeyCode,
  toKeyCode,
  deviceIf,
  ignoreModifiers,
}: RuleWithModifiersProps): Rule[] {
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

  const rules: Rule[] = []
  for (const m of allPatterns) {
    if (ignoreModifiers && m.some((p) => ignoreModifiers.some((ig) => ig === p)))
      continue

    let modifiedDescription = description
    let keyModifier: string[] = []
    if (m[0] !== "") {
      keyModifier = m
      modifiedDescription = modifiedDescription + ` (+${m})`
    }

    rules.push(
      basicRule({
        description: modifiedDescription,
        fromKeyCode: fromKeyCode,
        toKeyCode: toKeyCode,
        fromModifiers: keyModifier,
        toModifiers: keyModifier,
        deviceIf: deviceIf,
      })
    )
  }

  return rules
}
