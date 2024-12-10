# Performance refactor suggestions

Use constants instead of enums for `operation`, since `try_into` might be
expensive.

Use `get_unchecked` and `get_unchecked_mut`.

Try inlining register/memory access functions.

# Audio

Kitty24 has six (four? five?) audio channels:

* Pulse 0 -> Square
* (maybe) Pulse 1 -> Square
* Saw -> Triangle
* Noise
* (maybe) Wave -> 8 bit, 256 samples
* PCM -> 8 bit, 48 KHz, 4096 byte buffer (to be filled every ~85.3 ms, or rougly
  every five frames, probably on `!PCM()`)

## Standard Audio Registers

Every channel except PCM has control registers for volume, pitch, and duty/setting.

- `$XX00Y0`-`$XX00Y0`: Volume (0-255)
- `$XX00Y1`-`$XX00Y2`: Pitch (0-16384, increments of 0.25 or 1/4 Hz)
- `$XX00Y3`-`$XX00Y3`: Duty (0-255)

Pitch could be MIDI 0.0 to 255.99609375 instead - better distribution?

For the duty control register;

* Pulse -> Square
* Saw -> Triangle
* Noise -> White/Pink -> Brown
* Wave -> ?

Triggers and envelopes are implemented in software, possibly. This relies on at
least two timer registers providing TIMER audio interrupts that can override eg.
an ongoing VBLANK interrupt, and software envelopes would still have to be very
lean to keep up with the audio rate. It may be worth having one STRUCTURE timer,
as well as one EFFECT timer per channel. LSDj seems to manage with just a single
TICK timer, so that may also be worth looking into.

This may require a redesign of how multiple simultaneous interrupts are handled;
currently, every interrupt queues other interrupts and only raises them after
the current interrupt handler returns control. This could still be desirable
behavior, with every interrupt that doesn't need to run *now* re-enabling other
interrupts.

Alternatively, perhaps the relative priority of interrupts can be configured in
memory mapped cpu registers. This requires 256 bytes, one for each of the
interrupt types, but would have reasonable defaults for system interrupts, and
one-time configuration when the defaults are not desired.

# Direct Memory Access

To initiate a Simple DMA, `source`, `destination`, and `length` are written to
the memory mapped DMA registers. Writing to `length` blocks the CPU for
`(length / word_size).ceil()` cycles while the Simple DMA transfer is happening.

An Advanced DMA (Byte Block Transfer) additionally has `width` and `modulo`;
both default to 0, ignoring them. If both `width` and `modulo` are non-zero,
writing to `length` blocks the CPU while the Advanced DMA transfer is happening.

## General Purpose DMA registers

* `$XX0000`-`$XX0002`: (source) length
* `$XX0003`-`$XX0005`: source address
* `$XX0006`-`$XX0008`: destination address

## Advanced DMA registers

* `$XX0010`-`$XX0011`: src_width (default: 0, ignore)
* `$XX0012`-`$XX0013`: src_modulo (default: 0, ignore)
* `$XX0014`-`$XX0015`: dst_width (default: 0, use src_width)
* `$XX0014`-`$XX0015`: dst_height (default: 0, use length / dst_width)
* `$XX0016`-`$XX0017`: dst_modulo (default: 0, use src_modulo)
* `$XX0018`-`$XX0019`: skip (default: $100, don't copy matching bytes)

## Byte Block Transfer

* `$XX0000`-`$XX0001`: src_modulo (default: 0, ignore)
* `$XX0002`-`$XX0003`: src_width (12 bits width, 4 bits FLIP_X)
* `$XX0004`-`$XX0005`: src_height (default: 0, ignore, 12 bits width, 4 bits FLIP_Y)
* `$XX0006`-`$XX0008`: src_address
* `$XX0009`-`$XX0009`: src_mask (palette entry to skip if mask flag is on)

* `$XX0010`-`$XX0011`: dst_modulo (default: 0, use src_modulo)
* `$XX0012`-`$XX0013`: dst_width (default: 0, use src_width, 12 bits width, 4 bits ROT)
* `$XX0014`-`$XX0015`: dst_height (default: 0, use src_height, 12 bits height, 4 bits MASK)
* `$XX0016`-`$XX0018`: dst_address

Writing to `dst_address` triggers the transfer, which blocks the CPU:

```c
cycles = src_width.max(dst_width) * src_height.max(dst_height).max(1)
cycles = cycles / 3 + cycles % 3

// Simple DMA transfer of 256 bytes
src_width = 256
src_address = $FF0000
dst_address = $FF0100
// cycles = 256 / 3 + 256 % 3 = 85 + 1 = 86 cycles

// Advanced DMA transfer of a 16 × 16 byte sprite
src_width = 16
src_height = 16
src_modulo = 16
src_address = $FE0000
dst_modulo = 320
dst_address = $FF0000
// cycles = 16 * 16 / 3 + 16 * 16 % 3 = 85 + 1 = 86 cycles

// Simple DMA transfer of 57600 bytes
src_width = 57600
src_modulo = 0
src_address = $FF0000
dst_address = $AF0000
// cycles = 57600 / 3 + 57600 % 3 = 19'200 cycles

// Advanced DMA transfer of a single byte to cover 320×180 bytes
src_width = 1
src_height = 1
src_modulo = 1
src_address = $A00000
dst_width = 320
dst_height = 180
dst_modulo = 320
dst_address = $FF0000
// cycles = 320 * 180 / 3 + 320 * 180 % 3 = 19'200 cycles
```

Note: decreasing the size of `src_height` and `dst_height` to one byte would
make the maximum byte block transfer W:65'536 × H:256 = 16'777'216 bytes; all of
RAM. This also makes the simple DMA able to transfer 65'536 bytes in one
transfer operation.

Currently, width and height are both 12 bits.

Alternatively, width could be 16 bits, height could be 8 bits, and there could
be a `mask` register for skipping a specific palette entry, as well as a
`dma_flags` register for flip_x/flip_y/rotate/mask_on (leaving 4 bits unused).

Note: performance allowing, DMA could transfer eg. 4 words (12 bytes) per cycle,
instead of 1 word (3 bytes). Actually; 1 byte per cycle is enough to be a major
performance benefit, while still being only slightly faster than hand-written
assembly.

It may be useful to have an optional byte remap table for the transfer, for
color text and possibly other effects.

### Sub-byte alignment

For high-res mode, sub-byte alignment and remap table may be desired.



# Files - for the Compiler

The compiler can target a folder instead of a file.

## .kitty.script

.kitty.script files in the folder get concatenated by some order, perhaps
alphabetical and/or some header line - if it even matters (it shouldn't in the
end).

## .kitty.asm

.kitty.asm files in the files get concatenated to the compiled `.kitty.script`
assembly before assembling the ROM.

Note: Cross-referencing script functions and assembly labels might be tricky to
implement.

## .kitty.gfx

The 8bpp graphics format `.kitty.gfx`, understood by `boot.kitty.rom`, includes
a tiny header detailing the width and height of the graphic (65536 × 256 max),
and optionally a custom palette (though this might get big if it isn't a
per-project palette-list index).

A label to the data address is inserted based on the file name. A `/` may be
prepended to avoid clashing with code labels.

## .kitty.png

Generates a `.kitty.gfx` file from the png file and includes that in the ROM.

## .kitty.sfx

The boot.kitty.rom may at some point include audio-related functions that
would require a specific sound format. The `.sfx` format could describe
instruments.

A label to the data address is inserted based on the file name. A `/` may be
prepended to avoid clashing with code labels.

## .kitty.*

Included as binary `data`.

A label to the data address is inserted based on the file name. A `/` may be
prepended to avoid clashing with code labels.

## .(^kitty)*

Non-kitty file, ignored.

# Interrupts

Interrupts are enabled outside of interrupts, and disabled inside of them.

Recovering to the main program flow from an interrupt would need register saving
and loading.

However, allowing to call an interrupt (like `KEY_DOWN!(69)`) could trigger the
interrupt just as if it had happened from outside; disabling interrupts. Still,
the issue of trashed registers would need to be resolved.
