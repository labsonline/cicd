#!/bin/sh

# Copyright (c) 2023 Schubert Anselme <schubert@anselm.es>
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program. If not, see <http://www.gnu.org/licenses/>.
RUNNER_OS="linux"
RUNNER_VERSION="2.294.0"
RUNNER_HASH_256="11041376754f6beaccb56101a3e79bf5fc5d6ff628460fa1ae419f9f439e24a2"

##
## Download
##

# Create a folder
mkdir actions-runner && cd actions-runner || exit

# Download the latest runner package
curl \
  -o "actions-runner-${RUNNER_OS}-x64-${RUNNER_VERSION}.tar.gz" \
  -L "https://github.com/actions/runner/releases/download/v${RUNNER_VERSION}/actions-runner-${RUNNER_OS}-x64-${RUNNER_VERSION}.tar.gz"

# Optional: Validate the hash
echo "${RUNNER_HASH_256}  actions-runner-${RUNNER_OS}-x64-${RUNNER_VERSION}.tar.gz" | shasum -a 256 -c

# Extract the installer
tar xzf "./actions-runner-${RUNNER_OS}-x64-${RUNNER_VERSION}.tar.gz"

##
## Configure
##

# Create the runner and start the configuration experience
./config.sh --url https://github.com/anselmes/images --token "${GH_TOKEN}"

# Last step, run it!
echo """
# Use this YAML in your workflow file for each job
runs-on: self-hosted
"""

# Configure to run as a service
./svc.sh install
./svc.sh start
./svc.sh status
