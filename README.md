# Home Assistant Add-on: Profilarr

[![GitHub Release][releases-shield]][releases]
![Project Stage][project-stage-shield]
![License][license-shield]

![Supports aarch64 Architecture][aarch64-shield]
![Supports amd64 Architecture][amd64-shield]
![Supports armhf Architecture][armhf-shield]
![Supports armv7 Architecture][armv7-shield]
![Supports i386 Architecture][i386-shield]

[![Github Actions][github-actions-shield]][github-actions]
![Project Maintenance][maintenance-shield]
[![GitHub Activity][commits-shield]][commits]
![Reported Installations][installations-shield-stable]

Configuration management tool for Radarr/Sonarr that automates importing and version control of custom formats and quality profiles.

## About

Profilarr is a powerful configuration management tool for Radarr and Sonarr that simplifies the process of importing and maintaining custom formats and quality profiles. It provides automatic synchronization with remote configuration databases, direct import to your Radarr/Sonarr instances, and git-based version control of your configurations.

With Profilarr, you can easily preserve local customizations during updates and take advantage of the built-in conflict resolution system. This add-on integrates seamlessly with your Home Assistant environment, making media server management more efficient than ever.

[:books: Read the full add-on documentation][docs]

## Features

- 🔄 Automatic synchronization with remote configuration databases
- 🎯 Direct import to Radarr/Sonarr instances
- 🔧 Git-based version control of your configurations
- ⚡ Preserve local customizations during updates
- 🛠️ Built-in conflict resolution

## Installation

To install this add-on, manually add my HA-Addons repository to Home Assistant using [this GitHub repository][ha-addons] or by clicking the button below.

[![Add Repository to HA][my-ha-badge]][my-ha-url]

## Support

Got questions?

Feel free to [open an issue here][issue] on GitHub.

[aarch64-shield]: https://img.shields.io/badge/aarch64-yes-green.svg
[amd64-shield]: https://img.shields.io/badge/amd64-yes-green.svg
[armhf-shield]: https://img.shields.io/badge/armhf-no-red.svg
[armv7-shield]: https://img.shields.io/badge/armv7-yes-green.svg
[commits-shield]: https://img.shields.io/github/commit-activity/y/123marvin123/addon-profilarr.svg
[commits]: https://github.com/123marvin123/addon-profilarr/commits/main
[contributors]: https://github.com/123marvin123/addon-profilarr/graphs/contributors
[dictionarry]: https://github.com/Dictionarry-Hub
[docs]: profilarr/DOCS.md
[github-actions-shield]: https://github.com/123marvin123/addon-profilarr/workflows/CI/badge.svg
[github-actions]: https://github.com/123marvin123/addon-profilarr/actions
[ha-addons]: https://github.com/123marvin123/ha-addons
[i386-shield]: https://img.shields.io/badge/i386-no-red.svg
[issue]: https://github.com/123marvin123/addon-profilarr/issues
[license-shield]: https://img.shields.io/github/license/123marvin123/addon-profilarr
[maintenance-shield]: https://img.shields.io/maintenance/yes/2025.svg
[project-stage-shield]: https://img.shields.io/badge/project%20stage-beta-orange.svg
[releases-shield]: https://img.shields.io/github/v/release/123marvin123/addon-profilarr?include_prereleases
[releases]: https://github.com/123marvin123/addon-profilarr/releases
[my-ha-badge]: https://my.home-assistant.io/badges/supervisor_add_addon_repository.svg
[my-ha-url]: https://my.home-assistant.io/redirect/supervisor_add_addon_repository/?repository_url=https%3A%2F%2Fgithub.com%2F123marvin123%2Fha-addons
[installations-shield-stable]: https://img.shields.io/badge/dynamic/json?url=https%3A%2F%2Fanalytics.home-assistant.io%2Faddons.json&query=%24%5B%22123marvin123_profilarr%22%5D.total&label=Reported%20Installations&link=https%3A%2F%2Fanalytics.home-assistant.io/add-ons