# SwiftyGif-BitcodeIssue

This workspace includes a library (framework) project and a client (app) project.

Framework includes [SwiftyGif](https://github.com/kirualex/SwiftyGif) as a Carthage dependency.

At startup, app exercises framework through its public API.

Some details:

* Issue shows up at build time.

* Issue does **not** show up when building for a simulated device. It shows with Generic iOS Device instead.

* Issue shows up even if no SwiftyGif code is exercised at all. It's enough to add framework to link binary phase.
When framework is removed from linked binaries list, issue goes away.

## Steps to reproduce

1. Open workspace in Xcode
1. Make sure `My App` schema is selected, as well as `Generic iOS Device`
1. Build product

## Expected result

Product builds fine, with no errors.

## Actual result

Product build fails. App reports following error from `bitcode_strip`: `string table not at the end of the file (can't be processed) in file`. Here's the full output (derived data and toolchain directories omitted for brevity):

> PBXCp ...derivedData/Build/Products/Debug-iphoneos/MyLib.framework ...derivedData/Build/Products/Debug-iphoneos/MyApp.app/Frameworks/MyLib.framework (in target: MyApp)
>     cd /Users/braincrumbz/Documents/Projects/Lab/Swift/BitcodeIssue/MyApp
>     builtin-copy -exclude .DS_Store -exclude CVS -exclude .svn -exclude .git -exclude .hg -exclude Headers -exclude PrivateHeaders -exclude Modules -exclude *.tbd -bitcode-strip replace-with-marker -bitcode-strip-tool ...toolchain/bitcode_strip -resolve-src-symlinks ...derivedData/Build/Products/Debug-iphoneos/MyLib.framework ...derivedData/Build/Products/Debug-iphoneos/MyApp.app/Frameworks

> ...toolchain/bitcode_strip ...derivedData/Build/Products/Debug-iphoneos/MyLib.framework/MyLib -m -o ...derivedData/Build/Products/Debug-iphoneos/MyApp.app/Frameworks/MyLib.framework/MyLib ...toolchain/bitcode_strip ...derivedData/Build/Products/Debug-iphoneos/MyLib.framework/SwiftyGif.framework.dSYM/Contents/Resources/DWARF/SwiftyGif -m -o ...derivedData/Build/Products/Debug-iphoneos/MyApp.app/Frameworks/MyLib.framework/SwiftyGif.framework.dSYM/Contents/Resources/DWARF/SwiftyGif ...toolchain/bitcode_strip: string table not at the end of the file (can't be processed) in file: ...derivedData/Build/Products/Debug-iphoneos/MyLib.framework/SwiftyGif.framework.dSYM/Contents/Resources/DWARF/SwiftyGif (for architecture i386)error: bitcode_strip ...derivedData/Build/Products/Debug-iphoneos/MyLib.framework/SwiftyGif.framework.dSYM/Contents/Resources/DWARF/SwiftyGif: ...toolchain/bitcode_strip exited with 1


## Fix

A fix was found for the issue, thanks to posts [like this](https://stackoverflow.com/questions/32071209/xcode-7-bitcode-strip-error). The main gist is to add a user-defined build setting named `STRIP_BITCODE_FROM_COPIED_FILES` and set that to `NO`. See also commit with comment *fix(app): fix bitcode_strip issue*.
