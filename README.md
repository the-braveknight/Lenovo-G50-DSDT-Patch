##Lenovo G50-70 DSDT patches by the-braveknight based on RehabMan's github repos.

This set of patches/makefile can be used to patch your Haswell Lenovo G50-70 DSDT/SSDTs.  It relies heavily on already existing laptop DSDT patches at github here: https://github.com/RehabMan/Laptop-DSDT-Patch.. There are also post install scripts that can be used to create and install the kexts the are required for this laptop series.

The current repository actually uses only on-the-fly patches via config.plist and additional SSDTs.

Please refer to this guide thread on tonymacx86.com for a step-by-step process, feedback, and questions:

http://www.tonymacx86.com/threads/guide-lenovo-g50-70-g40-70-using-clover-uefi-10-11.200712.html


2016-10-07

- Split SSDT-HACK.dsl into multiple SSDTs
- Injecting device properties via SSDTs instead of config.plist/Devices/Arbitrary
- Added link to the-braveknight guide/thread on tonymacx86


2016-08-27

- Initial creation based on RehabMan's scripts and the Z50 repo.
