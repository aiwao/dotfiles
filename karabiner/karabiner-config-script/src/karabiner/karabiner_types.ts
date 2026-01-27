import { z } from "zod";

export const FromKeyModifiers = z.object({
  mandatory: z.array(z.string()).optional(),
  optional: z.array(z.string()).optional(),
})
export type FromKeyModifiers = z.infer<typeof FromKeyModifiers>

export const FromKey = z.object({
  key_code: z.string(),
  modifiers: FromKeyModifiers.optional(),
})
export type FromKey = z.infer<typeof FromKey>

export const ToKey = z.object({
  key_code: z.string(),
  modifiers: z.array(z.string()).optional(),
})
export type ToKey = z.infer<typeof ToKey>

export const DeviceIdentifier = z.object({
  vendor_id: z.int(),
  product_id: z.int(),
})
export type DeviceIdentifier = z.infer<typeof DeviceIdentifier>

export const Condition = z.object({
  type: z.string(),
  identifiers: z.array(DeviceIdentifier).optional(),
})
export type Condition = z.infer<typeof Condition>

export const Manipulator = z.object({
  type: z.string(),
  from: FromKey,
  to: z.array(ToKey),
  conditions: z.array(Condition).optional(),
})
export type Manipulator = z.infer<typeof Manipulator>

export const Rule = z.object({
  description: z.string(),
  manipulators: z.array(Manipulator),
})
export type Rule = z.infer<typeof Rule>

export const ComplexModificationConfig = z.object({
  title: z.string(),
  rules: z.array(Rule),
})
export type ComplexModificationConfig = z.infer<typeof ComplexModificationConfig>
