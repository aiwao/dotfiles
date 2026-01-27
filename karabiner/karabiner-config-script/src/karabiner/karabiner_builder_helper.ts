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
