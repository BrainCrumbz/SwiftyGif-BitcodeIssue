# SwiftyGif-BitcodeIssue

This workspace includes a library (framework) project and a client (app) project.

Framework includes [SwiftyGif](https://github.com/kirualex/SwiftyGif) as a Carthage dependency.
It has a couple of dummy classes to be used by clients, one of which involves SwiftyGif.

At startup, app exercises framework (and SwiftyGif) through those dummy classes.

The issue shows up at build time. The issue does **not** show up when building for a simulated device.

## Steps to reproduce

1. Open workspace in Xcode
1. Make sure `My App` schema is selected, as well as `Generic iOS Device`
1. Build product

## Expected result

Product builds fine, with no errors.

## Actual result

Product build fails. App reports following error from `bitcode_strip`: `string table not at the end of the file (can't be processed) in file`. Here's the full output (derived data and toolchain directories omitted for brevity):

> PBXCp ...DerivedData.../Build/Products/Debug-iphoneos/MyLib.framework ...DerivedData.../Build/Products/Debug-iphoneos/MyApp.app/Frameworks/MyLib.framework (in target: MyApp)
>     cd /Users/braincrumbz/Documents/Projects/Lab/Swift/BitcodeIssue/MyApp
>     builtin-copy -exclude .DS_Store -exclude CVS -exclude .svn -exclude .git -exclude .hg -exclude Headers -exclude PrivateHeaders -exclude Modules -exclude *.tbd -bitcode-strip replace-with-marker -bitcode-strip-tool ...toolchain.../bitcode_strip -resolve-src-symlinks ...DerivedData.../Build/Products/Debug-iphoneos/MyLib.framework ...DerivedData.../Build/Products/Debug-iphoneos/MyApp.app/Frameworks
> ...toolchain.../bitcode_strip ...DerivedData.../Build/Products/Debug-iphoneos/MyLib.framework/MyLib -m -o ...DerivedData.../Build/Products/Debug-iphoneos/MyApp.app/Frameworks/MyLib.framework/MyLib ...toolchain.../bitcode_strip ...DerivedData.../Build/Products/Debug-iphoneos/MyLib.framework/SwiftyGif.framework.dSYM/Contents/Resources/DWARF/SwiftyGif -m -o ...DerivedData.../Build/Products/Debug-iphoneos/MyApp.app/Frameworks/MyLib.framework/SwiftyGif.framework.dSYM/Contents/Resources/DWARF/SwiftyGif ...toolchain.../bitcode_strip: string table not at the end of the file (can't be processed) in file: ...DerivedData.../Build/Products/Debug-iphoneos/MyLib.framework/SwiftyGif.framework.dSYM/Contents/Resources/DWARF/SwiftyGif (for architecture i386)error: bitcode_strip ...DerivedData.../Build/Products/Debug-iphoneos/MyLib.framework/SwiftyGif.framework.dSYM/Contents/Resources/DWARF/SwiftyGif: ...toolchain.../bitcode_strip exited with 1
