## STALKER-13 (WSO)

This is a fork of the STALKER-13 codebase, rebuilt onto a more recent version of /tg/station. It is currently heavily in development and not production-ready. The `WSO` suffix is to distinguish it from the other existing STALKER-13 repositories:

- `STALKER-13`, the current production codebase built on /tg/ from 2020.
- `STALKER-NEW-REBASE`, relatively modern implementation of several features built on /tg/ from May 2023.

This fork pulls the existing production codebase directly onto /tg/station's history and modernizes it. It also includes several features from the `STALKER-NEW-REBASE` fork, namely the implementations for anomalies, artifacts, the blowout subsystem, and radiation.

This fork tries to minimize changes to /tg/'s code as much as possible, adding new implementations to a separate `stalker/` subdirectory, to hopefully make it easier to merge new /tg/ commits as time goes on.

In-progress tasks:

- [ ] Confirming medicine and reagent replacements and making new reagents when /tg/'s deviates from the Stalker setting (e.g. charcoal)
- [ ] Map conformance, linting, and performance.
- [ ] Porting mobs to /tg/'s basic mobs and AI controllers.
- [ ]Pulling out all icons from the STALKER-13 icon files, which just added them to TG's existing files, and making proper subtypes for clothing/weapons to reduce confusion and redundance specifying icon files.
- [ ] Trying to get SSnightcycle to be a bit faster and nicer looking.
- [ ] Treating factions as departments and making sure loadouts work as expected in game preferences.
- [ ] Modernize smoothing tiles for furniture and walls (currently a lot of furniture is straight-up invisible).
- [ ] Migrating the PDA network off the old datacore implementation.
- [ ] Migrating PDA's UI to TGUI or something.

Future tasks:
- [ ] Testing effects of all meds and all anomalies
- [ ] Profiling and performance.
- [ ] Pull HUD from `STALKER-NEW-RELEASE`.

The below links are documentation originally written for /tg/.

## DOWNLOADING
[Downloading](.github/guides/DOWNLOADING.md)

[Running a server](.github/guides/RUNNING_A_SERVER.md)

[Maps and Away Missions](.github/guides/MAPS_AND_AWAY_MISSIONS.md)

## Compilation

**The quick way**. Find `bin/server.cmd` in this folder and double click it to automatically build and host the server on port 1337.

**The long way**. Find `bin/build.cmd` in this folder, and double click it to initiate the build. It consists of multiple steps and might take around 1-5 minutes to compile. If it closes, it means it has finished its job. You can then [setup the server](.github/guides/RUNNING_A_SERVER.md) normally by opening `tgstation.dmb` in DreamDaemon.

**Building tgstation in DreamMaker directly is deprecated and might produce errors**, such as `'tgui.bundle.js': cannot find file`.

**[How to compile in VSCode and other build options](tools/build/README.md).**

## Contributors
[Guides for Contributors](.github/CONTRIBUTING.md)

[/tg/station HACKMD account](https://hackmd.io/@tgstation) - Design documentation here

[Interested in some starting lore?](https://github.com/tgstation/common_core)

## LICENSE

All code after [commit 333c566b88108de218d882840e61928a9b759d8f on 2014/31/12 at 4:38 PM PST](https://github.com/tgstation/tgstation/commit/333c566b88108de218d882840e61928a9b759d8f) is licensed under [GNU AGPL v3](https://www.gnu.org/licenses/agpl-3.0.html).

All code before [commit 333c566b88108de218d882840e61928a9b759d8f on 2014/31/12 at 4:38 PM PST](https://github.com/tgstation/tgstation/commit/333c566b88108de218d882840e61928a9b759d8f) is licensed under [GNU GPL v3](https://www.gnu.org/licenses/gpl-3.0.html).
(Including tools unless their readme specifies otherwise.)

See LICENSE and GPLv3.txt for more details.

The TGS DMAPI is licensed as a subproject under the MIT license.

See the footer of [code/__DEFINES/tgs.dm](./code/__DEFINES/tgs.dm) and [code/modules/tgs/LICENSE](./code/modules/tgs/LICENSE) for the MIT license.

All assets including icons and sound are under a [Creative Commons 3.0 BY-SA license](https://creativecommons.org/licenses/by-sa/3.0/) unless otherwise indicated.
