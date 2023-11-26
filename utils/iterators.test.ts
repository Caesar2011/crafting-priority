import {demoteIterator, promoteIterator, sameOrderIterator} from "./iterators"

describe("promote iterator", () => {
  test("queue n > 1", () => {
    let arr: number[] = []
    promoteIterator(5, (idx) => arr = [...arr, idx])
    expect(arr).toStrictEqual([1, 5, 4, 3, 2])
  })
  test("queue n = 0", () => {
    let arr: number[] = []
    promoteIterator(0, (idx) => arr = [...arr, idx])
    expect(arr).toStrictEqual([])
  })
  test("queue n = 1", () => {
    let arr: number[] = []
    promoteIterator(1, (idx) => arr = [...arr, idx])
    expect(arr).toStrictEqual([1])
  })
})

describe("demote iterator", () => {
  test("queue n > 1", () => {
    let arr: number[] = []
    demoteIterator(5, (idx) => arr = [...arr, idx])
    expect(arr).toStrictEqual([4, 3, 2, 1, 5])
  })
  test("queue n = 0", () => {
    let arr: number[] = []
    demoteIterator(0, (idx) => arr = [...arr, idx])
    expect(arr).toStrictEqual([])
  })
  test("queue n = 1", () => {
    let arr: number[] = []
    demoteIterator(1, (idx) => arr = [...arr, idx])
    expect(arr).toStrictEqual([1])
  })
})

describe("same order iterator", () => {
  test("queue n > 1", () => {
    let arr: number[] = []
    sameOrderIterator(5, (idx) => arr = [...arr, idx])
    expect(arr).toStrictEqual([5, 4, 3, 2, 1])
  })
  test("queue n = 0", () => {
    let arr: number[] = []
    sameOrderIterator(0, (idx) => arr = [...arr, idx])
    expect(arr).toStrictEqual([])
  })
  test("queue n = 1", () => {
    let arr: number[] = []
    sameOrderIterator(1, (idx) => arr = [...arr, idx])
    expect(arr).toStrictEqual([1])
  })
})