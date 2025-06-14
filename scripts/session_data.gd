# session_data.gd
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

extends Object
class_name SessionData

# the Discord ID of the User
var discord_id: String
# the Discord IDs of the User's Roles
var discord_roles: Array[String]

# initialize a SessionData object
func _init(_discord_id: String = "", _discord_roles: Array[String] = []):
	discord_id = _discord_id
	if typeof(_discord_roles) == TYPE_ARRAY:
		discord_roles = _discord_roles.duplicate(true)
	else:
		discord_roles = []
