# To do

## Binary Heap Priority Queue

### Enqueued

* File save
* Data hex editor
* KittyScript strings
* KittyScript editor
* DMA squash and stretch, truncate and repeat
* Wave audio channel with duty cycle
* Noise audio channel
* 240 color palette + 16 color system palette (move system to 0..=15)
* Mouse input
* Controller input (gilrs)
* Real Time Clock
* Fix rendered quad not aligned to screen pixels
* Standard Library linking (`#[std]`)
* `sin8` table can be `lib/res/sin8.table`
* Generate `const.kitty.script` from rust somewhere, to avoid double bookkeeping
* WAV resource files for the PCM channel
* Stereo channels (pan = 200%/0% -> 100%/100% -> 0%/200%)
* Stereo PCM

### Dequeued

* Standard Library standardization
* IO controller
* Runtime file load (editor only?)
* Full keyboard input
* CTRL+R to go to boot ROM (or quit if in boot ROM)
* PCM


## Project

* `/Users/Emma/kitty24/` -> roms and folders for release
* `export .exe` -> just embed the rom at the end of the emulator's exe lol
* Standard Library, where does it live? Just at the start of the ROM? Can't we
  include it implicitly, perhaps with an STDLIB_VERSION emitted by the compiler?
  - this could even include a tiny list of what parts of the STDLIB are
    included, to save precious "fast rom"; `VER=0.1.0 LIBS=1,3,8,10,12,255 0`
	would inject version `0.1.0` of the libraries `1, 3, 8, 10, 12, 255` - these
	could be core, trig, memcpy, io, audio, 
	The `0` at the end indicates end of library list (there is no library 0).
	This approach also makes it possible to entirely shuffle the standard
	library around in ROM with every patch release, so long as the emulator can
	produce a standard library for any previous or current version. This
	backwards compatibility might increase file size tremendously, so perhaps
	minor or major version bumps could void backwards compatibility with older
	carts, depending on how big a problem the file size is. Considering exported
	ROMs would not need to include anything else than their own library, perhaps
	this is fine regardless of total size of the development environment.
	1. `core` (#1)
	  * `allocate(size)`
	  * `free(address)`
	2. `math` (#2)
	3. `trig` (3: triangle)
	  * `sin8(x)`, 8 bit `sin` (256-byte table)
	  * `sin16(x)`, 16 bit `sin` (derived)
	  * `sin(x)`, 24 bit `sin` (derived, slow)
	7. `gfx` (7: G)
	  * `clear(color)`
	8. `mem` (8: byte)
	  * `copy(src_addr, dst_addr, length)`
	  * `blit(src_addr, sw, sh, smod, dst_addr, dw, dh, dmod)`
	10. `io` (10: IO)
	  * `read(name_addr, dst_addr)`
	12. `audio` (12: tet)
	20. `2d` (20: 2D)
	  * `dot(u_src, v_src)`
	  * `sprite(src_addr, w, h, smod, dx, dy)`
	30. `3d` (30: 3D)
	  * `dot3(u_src, v_src)`
	  * `cross(u_src, v_src)`
	  * `
	65. `text` (65: ascii A)
	  * `print(str_addr, x, y)`
	  * `print2(str_addr, x, y)`
	97. `string` (97: ascii a)
	  * `str_compare(a_addr, b_addr)`
	  * `str_len(str_addr)`
	  * `str_to_number(str_addr)`
	255. `editor` (255: last, could replace boot rom?)
	  * `write(name_addr, src_addr, length)`
	  * `mouse()`
* `#[no_std]` would place the ROM at the beginning of memory, instead of after
  STDLIB. Could be useful for having more control over the 64 KiB "fast rom" due
  to `let` statements being able to address them directly; `let rF, Label`.
  This may even just be a natural outcome of not using any library functions,
  instead of having to rely on an explicit directive.
* `#[std(0.1.0)]` could force inclusion of libraries from that version instead
  of the current compiler's version.
* Perhaps `#[no_std]` means "don't embed the standard library", which it
  otherwise will by default. Maybe `#[exclude_std]` is a better wording, or
  even `extern std`.
* In that case, `#[std(0.1.0)]` could also imply "link to library from ROM" (ie.
  exclude it). If you don't write this, whatever version of the compiler you're
  currently using will embed that standard library version in ROM.
* Maybe the compiler produces a warning or prompt when loading a ROM for a newer
  version in an older version.
* To summarize:
  - `#[std]` links current compiler's standard library version without embedding
  - `#[std(0.1.0)]` links to standard library 0.1.0 without embedding
  - "No directive" embeds current compiler's standard library version functions
* Header is ASCII `KT24`, followed by version number (1 byte each for major,
  minor, and patch), followed by libraries to inject, followed by a `0`.
  - The smallest header is `KT24Mmp0`
  - If the ROM doesn't start with KT24, it defaults to the current kitty24
    version with no libraries linked - a 0-byte header, meant for debugging and
	sizecoding.
* SRAM? Easy way to save data for a ROM? How, like PICO-8's `cartdata()` and
  `dset()`/`dget()`? 64 KiB?
* DMA modes? (2-bit/8-bit, squash/truncate or stretch/repeat)
  


## Compiler

* strings
* data sections
* types (`u8`, `u16`, `u24`, `i8`, `i16`, `i24`)
* fixed size arrays (`let array: [u8] = [1]` vs `let val = M[1]:3`), with encoded length probably
* pointers (`usize`?)
* `struct`s
* signed `less`
* minor optimizations?
  - reduce redundant `push`/`pop`
  - remove `shl`/`or` from `let r, <65536`
  - remove uncalled functions? (difficult, only impacts size, not performance)
* disable unused interrupts, or selectively enable only used interrupts
* build `.kitty.asm` files into ROM as well, somehow
* variable length arrays (`let array: [u8..] = [1..]` vs `let vals = M[1..]:3`)

## Assembler

* files (??? what for?)

## Virtual Machine

* files (from where, and how, can the virtual machine/ROM load/save files?)
* terminal? (memory mapped text buffer/input stream)
* input/output controller
  - channel-based blocking input *or* output (1 cycle per byte? Or just as fast
    as possible, blocking host CPU instead)
  - channels:
    * Delay? (in cycles or kibicycles) (WO)
    * Host file system (RW)
	* Host STDIN/STDOUT? (RW)
	* Compiler, assembler, PNG reader/writer?
	* 48 KHz 8 bit PCM? - 48000 bytes/s = 800 bytes/frame (WO? read = empty buffer length?)
  - I/O status register - error, file_dropped, etc. (RO)
    * "file dropped" could be an interrupt, as could "PCM buffer ready"
	  ```rust
	  FILE_DROP!(kind) {
		let length = io(FILE_DROP, 0xC00000, 65536)
		if kind == KIND_PNG {
		  let width = [0xC00000]:2
		  let height = [0xC00002]:2
		  memcpy(0xC00004, FRAMEBUFFER, width, height)
		} else if kind == KIND_PNG2 { // 2-bit, 4-color high res PNG
		  let width = [0xC00000]:2
		  let height = [0xC00002]:2
		  memcpy(0xC00004, FRAMEBUFFER, width >> 1, height >> 1)
		} else {
		  let length = io(FILE_DROP_NAME, 0xC10000, 256)
		  let i = 0
		  while i < length {
		    print(0xC00000 + i)
		    i = i + 1
		  }
		}
	  }
	  AUDIO_BUFFER!(length) {
        let addr = 0xC00000
		let i = 0
		while i < length {
		  [0xC00000 + i] = sin8(i)
		}
		io(AUDIO_BUFFER, 0xC00000, length)
	  }
	  ```
* more "accurate" music timings, not tied to cycles (and thus framerate)?
* controller input, probably with `cargo add gilrs`
* disallow framebuffer writing (or all VRAM writing?) outside of VBLANK and
  HBLANK

## Boot ROM

* load palette
* display animation
* play startup audio

## Standard Library

* `clear`
* `print`
  - `print2`?
* `memcopy` / block transfer
* `sin8`
* Figure out how not to embed in user ROM

## Editor


# Done

## Project

* `kitty24/` -> roms and folders for development
  - `boot/` -> boot project
  - `debug/` -> debug project
  - `boot.rom` -> boot rom, embedded in the virtual machine
  - `debug.rom` -> debug rom, run with `cargo run` (or maybe `run debug` in the
    boot terminal?)

## Compiler

* interrupt handling
* memory access syntax
* loop syntax
* `const` values
* `const` expressions
* `const` "named" interrupts (`VERTICAL_BLANK`, `KEY_DOWN`, `KEY_UP`)
* hexadecimal and binary literals, `0x10` and `0b10`
* negative `let` values
* files (from host folder)
  - outputs assembly as `data` labelled after the file name
* high-res mode access
  - print to screen with high res system font (Terminess)

## Assembler

* u24/u16/u8 always, except for if/ld/st/pop/push, compiler is responsible for
  typing

## Virtual Machine

* interrupts
  - interrupt register context restore - maybe just one, if interrupts can't
    overlap, or an infinite stack, or one per interrupt class;
    256 interrupts × 16 registers × 3 bytes = 12'288 bytes of *host* RAM
* memory mapped framebuffer
* system palette
* byte block transfer
* audio
  - pulse, saw

## Boot ROM

* hand off to user ROM