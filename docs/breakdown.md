# Original Goal
https://github.com/ajayyy/SponsorBlockServer/issues/373

- ~5 minute mirror of SponsorBlock databases

## tl;dr
May 26, 2021 -> Oct 23, 2021 - 171MB | 0:14 | 4.11x speedup over a 100MB connection

## Design
https://gist.github.com/mchangrh/3d4a967732f8994cfcfdc05a8e22dc4f
- rsyncd that serves the database dump folder publicly.
- rsync client that can download only the deltas needed to patch their old dumps without the need to generate dumps leading up to the current one.
  
With the rsync protocol most of the delta transfers are handled without needing to use xdelta, diff or any other similar tools.
### Compression algorithms
rsync supports zstd, lz4, zlib and zlibx. Without any compression we still benefit from delta differencing but adding compression can dramatically decrease the size since we are sending uncompressed text.

#### why LZ4?
after looking a few documents, writeups and benchmarks, it became clear that lz4 while not the best contender in terms of compression ratio, gave a clear advantage in terms of speed and memory usage. Compressing and decompressing with lz4 is practically free but only achieves a ratio of 0.7 while zstd can easily achive a ratio of 0.3 but at a much greater cost in terms of performance. When competing with gigabit line speeds, lz4 was the only contender that would come close in terms of time savings.

# Addendum
## Failed Designs
### WAL Replication
https://gist.github.com/mchangrh/3c3a9e870dfc1b8aee574c791dab83ad
 - extremely difficult to selectively ship WALs without exposing the private database
 - needs base archive to be able to apply WALs
 - postgres only

A collection of POC/ Ideas
https://gist.github.com/mchangrh/d8e2837b372756c867429eb20e946798
### xDelta
- 1 day delta comes to ~3MB
- works best when base is also distributed with zstd
- 537MB for 3 days

### SmartVersion
- 3 days down to 253MB

### IPFS
- no versioning, good for globally available archives (102% of size / dump)

### CRDT (Conflict-free Replicated Data Type)
- needs re-tooling of entire database
- difficult to dedupe-chunk