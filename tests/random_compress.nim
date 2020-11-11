import random, times, zippy

# Generate random blobs of data containing runs of random lengths. Ensure
# we can always compress this blob and that uncompressing the compressed
# data matches the original blob.

let seed = epochTime().int
var r = initRand(seed)

for i in 0 ..< 10000:
  echo "Test ", i, " (seed ", seed, ")"

  var
    data: seq[uint8]
    length = r.rand(100000)
    i: int
  data.setLen(length)
  while i < length:
    let
      v = rand(255).uint8
      runLength = min(rand(255), length - i)
    for j in 0 ..< runLength:
      data[i + j] = v
    inc(i, runLength)

  let
    compressed = compress(data)
    uncompressed = uncompress(compressed)
  doAssert uncompressed == data
