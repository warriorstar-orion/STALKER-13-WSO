## STALKER-13 (WSO)

This is a fork of the STALKER-13 codebase, rebuilt onto a more recent version of /tg/station. It is currently heavily in development and not production-ready. The `WSO` suffix is to distinguish it from the other existing STALKER-13 repositories:

- `STALKER-13`, the current production codebase built on /tg/ from 2020.
- `STALKER-NEW-REBASE`, relatively modern implementation of several features built on /tg/ from May 2023.

This fork pulls the existing production codebase directly onto /tg/station's history and modernizes it. It also includes several features from the `STALKER-NEW-REBASE` fork, namely the implementations for anomalies, artifacts, the blowout subsystem, and radiation.

This fork tries to minimize changes to /tg/'s code as much as possible, adding new implementations to a separate `stalker/` subdirectory, to hopefully make it easier to merge new /tg/ commits as time goes on.

For a list of current and upcoming tasks, [TODO.md](/.github/TODO.md).

## LICENSE

All code after [commit 333c566b88108de218d882840e61928a9b759d8f on 2014/31/12 at 4:38 PM PST](https://github.com/tgstation/tgstation/commit/333c566b88108de218d882840e61928a9b759d8f) is licensed under [GNU AGPL v3](https://www.gnu.org/licenses/agpl-3.0.html).

All code before [commit 333c566b88108de218d882840e61928a9b759d8f on 2014/31/12 at 4:38 PM PST](https://github.com/tgstation/tgstation/commit/333c566b88108de218d882840e61928a9b759d8f) is licensed under [GNU GPL v3](https://www.gnu.org/licenses/gpl-3.0.html).
(Including tools unless their readme specifies otherwise.)

See LICENSE and GPLv3.txt for more details.

The TGS DMAPI is licensed as a subproject under the MIT license.

See the footer of [code/__DEFINES/tgs.dm](./code/__DEFINES/tgs.dm) and [code/modules/tgs/LICENSE](./code/modules/tgs/LICENSE) for the MIT license.

All assets including icons and sound are under a [Creative Commons 3.0 BY-SA license](https://creativecommons.org/licenses/by-sa/3.0/) unless otherwise indicated.
