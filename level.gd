var characters

var character_positions

func _init(characters, character_positions):
	self.characters = characters
	self.character_positions = character_positions
	
func get_characters():
	return characters
	
func get_character_positions():
	return character_positions
