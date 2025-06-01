# discord_roles.gd
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

extends Node

#------------------------------------------------------------------------------
# DiscordRole represents a role in the PeraPera Quest Discord Server
#------------------------------------------------------------------------------
class DiscordRole:
	# this is the name of the role
	var name: String

	# when creating a DiscordRole object, save the provided name
	func _init(_name: String) -> void:
		name = _name

#------------------------------------------------------------------------------
# Discord roles from the PeraPera Quest Discord Server
#------------------------------------------------------------------------------
# Contributes by: Moderating Discord and Answering Community Questions
const COMMUNITY_MANAGER  : String = "1378418404624433172"

# Contributes by: Curating Language Learning Content in PeraPera Quest
const CONTENT_CURATOR    : String = "1378420590905659472"

# Contributes by: Supplying Art, Code, Music, or Other Game Assets
const GITHUB_CONTRIBUTOR : String = "1378420032945524818"

# Contributes by: Supporting PeraPera Quest Financially ($5/month)
const PATREON_QUESTER    : String = "1373796719371751545"

# Contributes by: Supporting PeraPera Quest Financially ($20/month)
const PATREON_SUPPORTER  : String = "1373796946464211034"

# Contributes by: Supporting PeraPera Quest Financially ($50/month)
const PATREON_WIZARD     : String = "1373797013132541992"

# Contributes by: Boosting the PeraPera Quest Discord Server
const SERVER_BOOSTER     : String = "1371274864035495998"

# Contributes by: Performing System Administration work for PeraPera Quest
const SYSTEM_ADMIN       : String = "1378420357383585865"

#------------------------------------------------------------------------------
# Dictionary mapping Discord role IDs to DiscordRole objects
#------------------------------------------------------------------------------
static var DISCORD_ROLES : Dictionary[String, DiscordRole] = {
	COMMUNITY_MANAGER:  DiscordRole.new("Community Manager"),
	CONTENT_CURATOR:    DiscordRole.new("Content Curator"),
	GITHUB_CONTRIBUTOR: DiscordRole.new("GitHub Contributor"),
	PATREON_QUESTER:    DiscordRole.new("Patreon Quester"),
	PATREON_SUPPORTER:  DiscordRole.new("Patreon Supporter"),
	PATREON_WIZARD:     DiscordRole.new("Patreon Wizard"),
	SERVER_BOOSTER:     DiscordRole.new("Server Booster"),
	SYSTEM_ADMIN:       DiscordRole.new("System Administrator"),
}

#------------------------------------------------------------------------------
# Fake Discord ID used for Game Development
#------------------------------------------------------------------------------
const DISCORD_ID_DEV: String = "384483884915490827"
