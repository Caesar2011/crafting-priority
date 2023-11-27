type DebouncedFunction<T extends (args: never) => unknown> = (args: Parameters<T>[0]) => void

const debouncedFunctions: Record<string, {
  executeAtTick: number,
  fn: () => void
}|undefined> = {}

export function debounce<T extends (args: never) => unknown>(id: string, delayTicks: number, func: T): DebouncedFunction<T> {
  return function (args: Parameters<T>[0]) {
    debouncedFunctions[id] = {
      executeAtTick: game.tick + delayTicks,
      fn: () => {
        func(args)
        debouncedFunctions[id] = undefined
      },
    }
  }
}

export function onTickUpdateDebounce(currentTick: number) {
  for (const key in debouncedFunctions) {
    const value = debouncedFunctions[key]
    if (value !== undefined && value.executeAtTick < currentTick) {
      value.fn()
    }
  }
}
