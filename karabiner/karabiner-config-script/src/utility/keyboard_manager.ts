import { z } from "zod";
import { resolve } from "path";
import type { DeviceIdentifier } from "../karabiner/karabiner_types";

export const Keyboard = z.object({
  name: z.string(),
  vendor_id: z.int(),
  product_id: z.int(),
})
export type Keyboard = z.infer<typeof Keyboard>

const KeyboardArray = z.array(Keyboard)
type KeyboardArray = z.infer<typeof KeyboardArray>

class KeyboardManager {
  private keyboardArray: KeyboardArray = []

  async init(configPath: string) {
    const keyboardArrayFileData = await Bun.file(resolve(configPath, "keyboards.json")).json()
    const keyboardArrayParse = KeyboardArray.safeParse(keyboardArrayFileData)
    if (!keyboardArrayParse.success) {
      console.error(keyboardArrayParse.error)
      return
    }
    this.keyboardArray = keyboardArrayParse.data
  }

  get(keyboardName: string): Keyboard | undefined {
    return this.keyboardArray.find((k) => k.name == keyboardName)
  }

  getIdentifier(keyboard: Keyboard): DeviceIdentifier {
    return {
      vendor_id: keyboard.vendor_id,
      product_id: keyboard.product_id,
    }
  }
}

export const keyboardManager = new KeyboardManager()
