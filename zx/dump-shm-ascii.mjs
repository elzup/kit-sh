#!/usr/bin/env node
import shm from 'shm-typed-array'

const shmName = process.argv[2]
const len = parseInt(process.argv[3] || '100', 10)

const buf = shm.get(shmName, 'Uint8Array') // Bufferより安全
if (!buf) {
  console.error(`SharedMemory ${shmName} not found`)
  process.exit(1)
}

const ascii = Buffer.from(buf.subarray(0, 16))
  .toString('ascii')
  .replace(/[^\x20-\x7E\n\t]/g, '')
process.stdout.write(ascii)
