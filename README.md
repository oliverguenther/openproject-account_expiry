# OpenProject Account-Expiry Plugin
[![Code Climate](https://codeclimate.com/github/oliverguenther/openproject-account_expiry/badges/gpa.svg)](https://codeclimate.com/github/oliverguenther/openproject-account_expiry)

This plugin extends users with an expiry date after N months (defined in the plugins' settings), which is set before creating new users and locks accounts after a certain amount of absence.

**Important**

 * It does not set expirations to previously created accounts
 * It does not set expirations to admins

## TODOS

- [ ] Show account lock under /my (extend sidebar w. view hook?)
- [ ] Validate integer month setting

## Requirements

* OpenProject Version >= 4.0
 
## Installation

Create a file `Gemfile.plugins` in your OpenProject installation with the following content:

	gem "openproject-account_expiry", git: "https://github.com/oliverguenther/openproject-account_expiry.git", branch: "dev"

### Setting the cron job

This plugin currently relies on a regular cronjob to find and lock users daily.
Change the following entry according t	o your setup:

    0 0 * * * su - openproject -c 'cd <path_to_rails_root> && RAILS_ENV=production rake account_expiry:lock'

Please see the [OpenProject plugin overview](https://www.openproject.org/projects/openproject/wiki/OpenProject_Plug-Ins)
for more details.

## License

Copyright (c) 2015 Oliver Günther (mail@oliverguenther.de)

This plugin is licensed under the MIT license. See COPYING for details.

## Funding

Initial development of this plugin was backed with funds from [Qualitätssicherung von Studium und Lehre](https://www.informatik.tu-darmstadt.de/de/fachbereich/einrichtungen/qsl-kommission/) and was supported by the [ISP Fachbereich Informatik](https://www.isp.informatik.tu-darmstadt.de/de) at the Technische Universität Darmstadt.