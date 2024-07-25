Completed Tasks:

- [X] Port anomaly/artifacts from `STALKER-NEW-REBASE`.
- [X] Trying to get SSnightcycle to be a bit faster and nicer looking.
- [X] Creating teleporting step_triggers that have IDs instead of arbitrary world coordinates.
- [X] Reduce map size as much as possible, pull underground sections that extend maps into underground.dmm.

In-progress tasks:

- [ ] Confirming medicine and reagent replacements and making new reagents when /tg/'s deviates from the Stalker setting (e.g. charcoal)
- [ ] Map conformance, linting, and performance.
- [ ] Porting mobs to /tg/'s basic mobs and AI controllers.
- [ ] Pulling out all icons from the STALKER-13 icon files, which just added them to TG's existing files, and making proper subtypes for clothing/weapons to reduce confusion and redundance specifying icon files.
- [ ] Treating factions as departments and making sure loadouts work as expected in game preferences.
- [ ] Modernize smoothing tiles for furniture and walls (currently a lot of furniture is straight-up invisible).
- [ ] Migrating the PDA network off the old datacore implementation.
- [ ] Migrating PDA's UI to TGUI or something.
- [ ] Move spawners to use `spawn_loot_chance` isntead of having a chance to spawn an `/obj/nothing`.
- [ ] Get equipment upgrade system working properly.

Future tasks:
- [ ] Everything tagged `TODO(wso)` in the codebase.
- [ ] Testing effects of all meds, anomalies, and artifacts.
- [ ] Profiling and performance.
- [ ] Pull HUD from `STALKER-NEW-RELEASE`.
- [ ] Fix gates to not just instantiate random /atom/movables and cause runtimes.
- [ ] Find out why mobs are spawning with low health.
- [ ] Find out why Monolith isn't showing up in job preferences.
- [ ] Set up leaders as "head" roles for factions.
- [ ] Add descriptions for all jobs to stop causing runtimes.
- [ ] Everything with Sidomat, UIs, user accounts, buying and selling, stalker rank...
- [ ] Get environmental sounds ported over to /area/ambientsounds.
- [ ] Vortex anomalies follow ghosts.
