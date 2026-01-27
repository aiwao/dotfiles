import { Keyboard, keyboardManager } from "../utility/keyboard_manager";
import { ComplexModificationConfig, Condition, FromKey, FromKeyModifiers, Manipulator, Rule, ToKey } from "./karabiner_types";

export class FromKeyModifiersBuilder {
  private data: FromKeyModifiers = {
    mandatory: [],
    optional: [],
  }

  mandatory(modifiers: string[]) {
    this.data.mandatory = modifiers
    return this
  }

  optional(modifiers: string[]) {
    this.data.optional = modifiers
    return this
  }
  
  build() {
    return this.data
  }
}

export class FromKeyBuilder {
  private data: FromKey = {
    key_code: "",
  }

  keyCode(keyCode: string) {
    this.data.key_code = keyCode
    return this
  }

  modifiers(modifiers: FromKeyModifiers) {
    this.data.modifiers = modifiers
    return this
  }

  build() {
    return this.data
  }
}

export class ToKeyBuilder {
  private data: ToKey = {
    key_code: "",
  }

  keyCode(keyCode: string) {
    this.data.key_code = keyCode
    return this
  }

  modifiers(modifiers: string[]) {
    this.data.modifiers = modifiers
    return this
  }

  build() {
    return this.data
  }
}

export class ManipulatorBuilder {
  private data: Manipulator = {
    type: "basic",
    from: { key_code: "" },
    to: [],
    conditions: [],
  }

  type(type: string) {
    this.data.type = type
    return this
  }
  
  from(from: FromKey) {
    this.data.from = from
    return this
  }

  to(to: ToKey) {
    this.data.to.push(to)
    return this
  }

  deviceIf(keyboardName: string) {
    const foundKeyboard = keyboardManager.get(keyboardName)
    if (!foundKeyboard)
      throw new Error("No keyboard was found")
    
    const keyboardIdentifier = keyboardManager.getIdentifier(foundKeyboard)
    
    if (this.data.conditions) {
      const deviceIfCondition = this.data.conditions!.find((c) => c.type == "device_if")
      if (deviceIfCondition) {
        if (!deviceIfCondition.identifiers)
          deviceIfCondition.identifiers = []
        
        deviceIfCondition.identifiers!.push(keyboardIdentifier)
      } else {
        this.data.conditions = [{
          type: "device_if",
          identifiers: [keyboardIdentifier]
        }]
      }
    }

    return this
  }

  build() {
    return this.data
  }
}

export class RuleBuilder {
  private data: Rule = {
    description: "A karabiner rule",
    manipulators: [],
  }

  description(description: string) {
    this.data.description = description
    return this
  }

  manipulator(manipulator: Manipulator) {
    this.data.manipulators.push(manipulator)
    return this
  }

  build() {
    return this.data
  }
}

export class ConfigBuilder {
  private data: ComplexModificationConfig = {
    title: "Config",
    rules: [],
  }
  private deviceArray: Keyboard[] = []

  title(title: string) {
    this.data.title = title
    return this
  }

  addAllRules(rules: Rule[]) {
    rules.forEach((r) => this.rule(r))
    return this
  }

  rule(rule: Rule) {
    if (this.deviceArray.length !== 0) {
      rule.manipulators.forEach((m) => {
        let isOverwritten = false
        if (m.conditions) {
          isOverwritten = m.conditions.some((c) => c.type.toLowerCase() == "device_if")
        }
        if (!isOverwritten) {
          if (!m.conditions)
            m.conditions = []
          
          const condition: Condition = {
            type: "device_if",
            identifiers: [],
          }
          
          this.deviceArray.forEach((k) => {
            condition.identifiers!.push({ 
              vendor_id: k.vendor_id,
              product_id: k.product_id,
            })
          })

          m.conditions.push(condition)
        }
      })
    }
    this.data.rules.push(rule)
    return this
  }

  deviceIf(keyboardName: string) {
    const foundKeyboard = keyboardManager.get(keyboardName)
    if (!foundKeyboard)
      throw new Error("No keyboard is found")

    this.deviceArray.push(foundKeyboard)
    return this
  }

  build() {
    return this.data
  }
}
