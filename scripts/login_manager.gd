# login_manager.gd
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

const DISCORD_ROLES = preload("res://scripts/discord_roles.gd")
const WHOAMI_URL := "https://perapera.quest/whoami"

# this is just for testing the auth service locally;
# pay no attention to the developer behind the curtain!
const TESTING_AUTH: bool = false
#const WHOAMI_URL := "http://localhost:3000/whoami"

@onready var http := HTTPRequest.new()

func _ready():
	# if we're running inside the Godot editor AND
	# we're not testing integration with the auth service
	if OS.has_feature("editor") and !TESTING_AUTH:
		print("Creating a fake session for game development purposes")
		# fake a login session
		Global.session = SessionData.new(
			DISCORD_ROLES.DISCORD_ID_DEV,
			[DISCORD_ROLES.GITHUB_CONTRIBUTOR])
		return

	# if we are testing integration with the auth service
	var extra_headers = []
	if TESTING_AUTH:
		print("Testing the auth service with fake session cookie")
		# here you'll want to grab the session_uuid when you test /whoami locally
		var dev_cookie_value = "session_uuid=1c028f26-f07c-402c-8a95-170b307e53a3"
		extra_headers = [ "Cookie: " + dev_cookie_value ]

	# otherwise, we need to ask the auth service who this person is
	print("Query the auth service for login session")
	add_child(http)
	http.request_completed.connect(_on_request_completed)
	var err = http.request(WHOAMI_URL, extra_headers)
	if err != OK:
		push_error("login_manager: HTTPRequest error: %s" % err)

func _on_authenticated():
	# let's play PeraPera Quest
	print("Ready to start the game.")

func _on_request_completed(result: int,
						   response_code: int,
						   _headers: PackedStringArray,
						   body: PackedByteArray):
	# if the request to /whoami wasn't a smashing success
	if (result != HTTPRequest.Result.RESULT_SUCCESS) or (response_code != 200):
		# send the user back to the /login route
		push_error("login_manager: Result %d - HTTP %d" % [result, response_code])
		JavaScriptBridge.eval("window.location.replace('/login');", false)
		return

	# parse the session information provided for this user
	var raw = body.get_string_from_utf8()
	var data = JSON.parse_string(raw)
	if data == null:
		push_error("Unable to parse JSON session")
		return

	# check for the `session` key
	var root: Dictionary = data
	if not root.has("session"):
		push_error("No 'session' key in response JSON.")
		return

	# get references to the individual session parts
	var session_dict: Dictionary = root["session"]
	var discord_part: Dictionary = session_dict.get("discord", {})
	var user_part: Dictionary = discord_part.get("user", {})

	# extract `session.discord.user.id` as `discord_id`
	if not user_part.has("id"):
		push_error("Missing discord.user.id in JSON.")
		return
	var discord_id: String = String(user_part["id"])

	# extract `session.discord.roles` as `roles_array`
	var roles_array: Array[String] = []
	if discord_part.has("roles") and typeof(discord_part["roles"]) == TYPE_ARRAY:
		roles_array.assign(discord_part["roles"].duplicate(true))
	else:
		push_warning("discord.roles missing or not an Array; defaulting to empty Array.")
		roles_array = []

	# create a SessionData object and populate the Global session
	var new_session = SessionData.new(discord_id, roles_array)
	Global.session = new_session

	# let's play PeraPera Quest!
	print("Authenticated! Discord ID = %s" % discord_id)
	_on_authenticated()
