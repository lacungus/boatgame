var characters

var character_positions

var index

func _init(index, characters, character_positions):
	self.characters = characters
	self.character_positions = character_positions
	self.index = index
	
func get_characters():
	return characters
	
func get_character_positions():
	return character_positions

func get_index():
	return index
