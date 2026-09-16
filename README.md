# Probe v1.2

This project compiles castle lua (LuaJIT 15) into a compiled & compressed project that requires
a encryption key to decompile, which is only given on runtime **(via castle tickers)**.

## CLI

1 Simple Encryptor.
```bash
probe obfuscate <inputfile> <encryptionkey> <outputfile>
```

IMPORTANT: **The key must use numbers only and contain more than 8 digits.**

Example:

```bash
probe obfuscate space.lua 1234567890 protected.lua
```

## How to setup

1. Run `npm install` in the folder which probe CLI..
2. Add an actor to the Castle card, tag it `#castle-vm-prober`, and attach
   `Castle-Prober-API to the script.`.
3. Install the command and compile a Castle script:

   ```bash
   node castle-vm-compile.js input.lua protected.lua 1234567890
   ```

4. Attach the generated `protected.lua` to the actor that should run the input.

## Rebuild readable Lua

For files produced by this Probe VM compiler:

```bash
node probe-deobfuscate.js protected.lua deobfuscated.lua 1234567890
```

This restores readable Castle Lua from the encrypted AST. The original comments
and exact formatting cannot be restored because they are not stored.

## Supported Functions in v1.2.0 Alpha

- Castle lifecycle functions and ordinary functions
- local/global variables, assignment, tables, properties and actors
- `if`/`elseif`/`else`, `while`, numeric `for`, and `ipairs`/`pairs` loops
- mathematic, comparisons, logical operators, concatenation (text modification) and table length.
- Castle, actor, `math`, `string`, and `table` calls exposed by Castle, and Castle's extra functions.

Important Note:
**Unsupported syntax is rejected by the compiler. This is an interpreter, so it
is slower than native Castle LuaJIT 15, so avoid heavy work in `onUpdate`.**

The key is present in tickers of your choice, remember to set it only during runtime,
not as a default value.

## jsDelivr installer

Write this in your terminal.

```bash
curl -fsSL https://cdn.jsdelivr.net/gh/hjackprojects/probe@main/install.sh | sh
```
