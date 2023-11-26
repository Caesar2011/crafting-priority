export function promoteIterator(length: number, next: (idx: number) => void): void {
  if (length !== 0) next(1)
  for (let i = length; i >= 2; i--) next(i)
}

export function demoteIterator(length: number, next: (idx: number) => void): void {
  for (let i = length - 1; i >= 1; i--) next(i)
  if (length !== 0) next(length)
}

export function sameOrderIterator(length: number, next: (idx: number) => void): void {
  for (let i = length; i >= 1; i--) next(i)
}