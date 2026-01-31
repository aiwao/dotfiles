import type ConfigInterface from "../../src/config/config_interface";
import { ConfigBuilder, FromKeyBuilder, FromKeyModifiersBuilder, ManipulatorBuilder, RuleBuilder, ToKeyBuilder } from "../../src/karabiner/karabiner_builder";
import { basicRule } from "../../src/karabiner/karabiner_builder_helper";
import type { ComplexModificationConfig } from "../../src/karabiner/karabiner_types";

export default class C3ProConfig implements ConfigInterface {
  init(registerConfig: (c: ComplexModificationConfig) => void): void {
    registerConfig(
      new ConfigBuilder()
        .title("C3Pro")
        .deviceIf("C3Pro")
        .rule(
          new RuleBuilder()
            .description("Caps-lock to tab")
            .manipulator(
              new ManipulatorBuilder()
                .from(
                  new FromKeyBuilder()
                    .keyCode("caps_lock")
                    .modifiers(
                      new FromKeyModifiersBuilder()
                        .optional(["any"])
                        .build()
                    )
                    .build()
                )
                .to(
                  new ToKeyBuilder().keyCode("tab").build()
                )
                .build()
            )
            .build()
        )
        .build()
    )
  }
}
