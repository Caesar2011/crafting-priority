export function promoteIterator(length: number, next: (idx: number) => void): void {
  if (length !== 0) next(0)
  for (let i = length-1; i >= 1; i--) next(i)
}

export function demoteIterator(length: number, next: (idx: number) => void): void {
  for (let i = length - 2; i >= 0; i--) next(i)
  if (length !== 0) next(length-1)
}

export function sameOrderIterator(length: number, next: (idx: number) => void): void {
  for (let i = length-1; i >= 0; i--) next(i)
}