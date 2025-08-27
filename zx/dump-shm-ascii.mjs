#!/usr/bin/env node

import shm from 'shm-typed-array'

// コマンドライン引数から SHM 名を取得
const shmName = process.argv[2]
const len = process.argv[3] || 100

if (!shmName) {
  console.error('SHM name is required')
  process.exit(1)
}

console.log(`SHM name: ${shmName}`)

const buf = shm.get(shmName, 'Buffer')
if (!buf) {
  console.error(`SharedMemory ${shmName} not found`)
  process.exit(1)
}

const ascii = Buffer.from(buf)
  .toString('ascii')
  .replace(/[^\x20-\x7E\n\t]/g, '')
  .substring(0, len)
process.stdout.write(ascii)
