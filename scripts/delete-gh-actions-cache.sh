#!/bin/bash

# Copyright (c) 2023 Schubert Anselme <schubert@anselm.es>
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program. If not, see <https://www.gnu.org/licenses/>.
gh extension install actions/gh-actions-cache

echo "Fetching list of cache key"
CACHE_KEYS="$(gh actions-cache list -R ${REPO} -B ${BRANCH} | cut -f 1)"

## Setting this to not fail the workflow while deleting cache keys.
set +e
echo "Deleting caches..."
for KEY in ${CACHE_KEYS}
do
  gh actions-cache delete "${KEY}" -R "${REPO}" -B "${BRANCH}" --confirm
done
echo "Done"
