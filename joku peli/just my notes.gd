extends Node
##
####varasto
##
#@onready var spawn_container = $SpawnContainer
#@onready var typekenttä_node = $"UI/Typekenttä"  # Directly reference Typekenttä node
#@onready var spawn_timer = $SpawnTimer
#
#var active_typesana: Typekenttä = null
#var current_letter_index: int = -1
#
#func find_new_active_typesana(typed_character: String):
	#if typekenttä_node is Typekenttä:
		#var prompt = typekenttä_node.get_prompt()
		#var regex = RegEx.new()
		#regex.compile("\\[.*?\\]")
		#var text_without_tags = regex.sub(prompt, "", true)
		#var next_character = text_without_tags.substr(0, 1)
		#if next_character == typed_character:
			#print("found new Typekenttä that starts with %s" % next_character)
			#active_typesana = typekenttä_node
			#current_letter_index = 1
			#active_typesana.set_next_character(current_letter_index)
#
#func _unhandled_input(event: InputEvent) -> void:
	#if event is InputEventKey and event.is_pressed() and not event.is_echo():
		#var typed_event = event as InputEventKey
		#var key_typed = String(char(typed_event.unicode))
		#print("Key typed: %s" % key_typed)
#
		#if active_typesana == null:
			#find_new_active_typesana(key_typed)
		#else:
			#var prompt = active_typesana.get_prompt()
			#
			## Strip BBCode tags again
			#var regex = RegEx.new()
			#regex.compile("\\[.*?\\]")
			#var text_without_tags = regex.sub(prompt, "", true)
			#
			#var next_character = text_without_tags.substr(current_letter_index, 1)
			#print("Expected next character: %s" % next_character)
			#if key_typed == next_character:
				#print("Successfully typed %s" % key_typed)
				#current_letter_index += 1
				#active_typesana.set_next_character(current_letter_index)
				#if current_letter_index == text_without_tags.length():
					#print("done")
					#current_letter_index = -1
					#active_typesana.queue_free()
					#active_typesana = null
					#
					#_on_deploy_unit_pressed()  # Call the function to deploy the unit
					#
					#spawn_enemy()  # Spawn a new Typekenttä
#
#func _on_spawn_timer_timeout():
	#spawn_enemy()
#
#func spawn_enemy():
	#var enemy_instance = typekenttä_scene.instantiate()
	#var spawns = spawn_container.get_children()
	#if spawns.size() > 0:
		#var index = randi() % spawns.size()
		#enemy_instance.global_position = spawns[index].global_position
		#add_child(enemy_instance)
