extends Node

@export var pelaajanappula_scene: PackedScene
@export var typekenttä_scene: PackedScene

func _ready():
	spawn_enemy()
	spawn_timer.start()

### PELAAJAN NAPPULOIDEN SPAWNAAMINE
var playeramount = 0
func _on_deploy_unit_pressed():
	playeramount += 1
	$"UI/Player/Player amount".text = "player " + str(playeramount)
	
	# Create a new instance of the Pelaajanappula scene.
	var nappula = pelaajanappula_scene.instantiate()
	
	# Choose a random location on Path2D.
	var nappula_spawn_location = $Pelaajapath/PelaajaSpawnLocation
	nappula_spawn_location.progress_ratio = randf()	#mikä vitun progress_ratio
	
	# Set the mob's position to a random location.
	nappula.position = nappula_spawn_location.position

	# Spawn the mob by adding it to the Main scene.
	add_child(nappula)

func _on_ylämaali_omamaali(value):
	playeramount -= 1		#tähän vitun paskaan menny yli 2h
	print("signal")
	$"UI/Player/Player amount".text = "player " + str(playeramount)


func _on_timer_timeout():
	var mob = preload("res://tippuvatesti.tscn").instantiate()
	
	var mob_spawn_location = $Mobpath/MobSpawnLocation
	mob_spawn_location.progress_ratio = randf()

	mob.position = mob_spawn_location.position
	
	add_child(mob)

### typesanat ja typeemissäädöt
# https://www.youtube.com/watch?v=qRPI_c9qI1o
# 4v vanha godot versio
# enemy == typesana
#
#var active_typesana = null
#var current_letter_index: int = -1
#
#func find_new_active_typesana(typed_character: String):
	#var prompt = $"UI/Typekenttä".get_prompt()
	#var next_character = prompt.substr(0, 1)
		## --------------- TÄÄ PASKA STRIPPAA BEEBEEKOODIN ET TAPAHTUU JOTAI
	#var regex = RegEx.new()
	#regex.compile("\\[.*?\\]")
	#var text_without_tags = regex.sub(next_character, "", true)
		## ----------------
	#if text_without_tags == typed_character:	#täs ois alunperin prompt eikä text_w...
		#print("found new enemy that starts with %s" % next_character)
		#active_typesana = $"UI/Typekenttä"
		#current_letter_index = 1
		#print("typed")
#
#func _unhandled_input(event: InputEvent) -> void:
	#if event is InputEventKey and event.is_pressed() and not event.is_echo():
		#var typed_event = event as InputEventKey
		#var key_typed = PackedByteArray([typed_event.unicode]).get_string_from_utf8()
		#
		#if active_typesana == null:
			#find_new_active_typesana(key_typed)
		#else:
			#var prompt = active_typesana.get_prompt()
			#var next_character = prompt.substr(current_letter_index, 1)
			#if key_typed == next_character:
				#print("Successfully typed %s" % key_typed)
				#current_letter_index += 1
				#if current_letter_index == prompt.length():
					#print("done")
					#current_letter_index = -1
					#active_typesana.queue_free()
					#active_typesana = null
			#else: 
				#print("u had typed %s instead of %s" % [key_typed, next_character])

### chat gpt corrected code
### aaaaa
@onready var spawn_container = $SpawnContainer
@onready var typekenttä_node: Typekenttä = $"UI/Typekenttä"
@onready var spawn_timer = $SpawnTimer

var active_typesana: Typekenttä = null
var current_letter_index: int = -1

func find_new_active_typesana(typed_character: String):
	if typekenttä_node is Typekenttä:
		var prompt = typekenttä_node.get_prompt()
		var regex = RegEx.new()
		regex.compile("\\[.*?\\]")
		var text_without_tags = regex.sub(prompt, "", true)
		var next_character = text_without_tags.substr(0, 1)
		if next_character == typed_character:
			print("found new Typekenttä that starts with %s" % next_character)
			active_typesana = typekenttä_node
			current_letter_index = 1
			active_typesana.set_next_character(current_letter_index)

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventKey and event.is_pressed() and not event.is_echo():
		var typed_event = event as InputEventKey
		var key_typed = String(char(typed_event.unicode))
		print("Key typed: %s" % key_typed)

		if active_typesana == null:
			find_new_active_typesana(key_typed)
		else:
			var prompt = active_typesana.get_prompt()
			
			# Strip BBCode tags again
			var regex = RegEx.new()
			regex.compile("\\[.*?\\]")
			var text_without_tags = regex.sub(prompt, "", true)
			
			var next_character = text_without_tags.substr(current_letter_index, 1)
			print("Expected next character: %s" % next_character)
			if key_typed == next_character:
				print("Successfully typed %s" % key_typed)
				current_letter_index += 1
				active_typesana.set_next_character(current_letter_index)
				if current_letter_index == text_without_tags.length():
					print("done")
					current_letter_index = -1
					active_typesana.queue_free()
					active_typesana = null
					
					_on_deploy_unit_pressed()  # Call the function to deploy the unit
					
					spawn_enemy()  # Spawn a new Typekenttä

func _on_spawn_timer_timeout():
	spawn_enemy()

func spawn_enemy():
	var enemy_instance = typekenttä_scene.instantiate()
	var spawns = spawn_container.get_children()
	if spawns.size() > 0:
		var index = randi() % spawns.size()
		enemy_instance.global_position = spawns[index].global_position
		add_child(enemy_instance)
