# test_discord_roles.gd
# Copyright 2025 Patrick Meade.
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU Affero General Public License as published
# by the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Affero General Public License for more details.
#
# You should have received a copy of the GNU Affero General Public License
# along with this program.  If not, see <https://www.gnu.org/licenses/>.

extends GutTest

const DR = preload("res://scripts/discord_roles.gd")

# Test: There are eight special Discord roles
func test_count_discord_roles():
	assert_eq(8, len(DR.DISCORD_ROLES.keys()))

# Test: The named Discord roles exist
func test_specific_discord_roles():
	assert_eq("1378418404624433172", DR.COMMUNITY_MANAGER)
	assert_eq("1378420590905659472", DR.CONTENT_CURATOR)
	assert_eq("1378420032945524818", DR.GITHUB_CONTRIBUTOR)
	assert_eq("1373796719371751545", DR.PATREON_QUESTER)
	assert_eq("1373796946464211034", DR.PATREON_SUPPORTER)
	assert_eq("1373797013132541992", DR.PATREON_WIZARD)
	assert_eq("1371274864035495998", DR.SERVER_BOOSTER)
	assert_eq("1378420357383585865", DR.SYSTEM_ADMIN)
