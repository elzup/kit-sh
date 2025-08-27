#!/usr/bin/env node

import shm from 'shm-typed-array'

const shmName = '/clock_shm'

console.log('🕐 Clock writing to shared memory')
console.log(`SHM name: ${shmName}`)
console.log('Press Ctrl+C to exit')

// 既存のSHMがあれば削除
try {
  shm.detach(shmName)
} catch {}

// SHM作成
const buf = shm.create(1024, 'Buffer', shmName)
if (!buf) {
  console.log('❌ Failed to create shared memory')
  process.exit(1)
}

console.log('✅ Shared memory created')
console.log(`Use: node zx/dump-shm-ascii.mjs ${shmName}`)

// 時計ループ
setInterval(() => {
  const now = new Date()
  const timeString = now.toLocaleString('ja-JP', {
    year: 'numeric',
    month: '2-digit',
    day: '2-digit',
    hour: '2-digit',
    minute: '2-digit',
    second: '2-digit',
  })

  // バッファをクリア
  buf.fill(0)

  // 時刻を共有メモリに書き込み
  Buffer.from(timeString).copy(buf, 0)

  console.log(`Written to SHM: ${timeString}`)
}, 1000)

// 終了時のクリーンアップ
process.on('SIGINT', () => {
  console.log('\n🧹 Cleaning up...')
  try {
    shm.detach(shmName)
  } catch {}
  process.exit(0)
})
