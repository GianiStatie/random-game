extends Node2D

@onready var tilemap = $TileMap

var wall_extension_mapping = {
	"(0, 2)": [Vector2(8, 1), Vector2(8, 2)], # wall-extension-left
	"(1, 2)": [Vector2(9, 1), Vector2(9, 2)], # wall-extension-center
	"(2, 2)": [Vector2(10, 1), Vector2(10, 2)], # wall-extension-right
	"(3, 5)": [Vector2(3, 6), Vector2(3, 7)], # closed-door-extension-left
	"(4, 5)": [Vector2(4, 6), Vector2(4, 7)], # closed-door-extension-right
	"(5, 5)": [Vector2(5, 6), Vector2(5, 7)], # closed-door-extension-right
	"(6, 5)": [Vector2(6, 6), Vector2(6, 7)], # closed-door-extension-right
}

const wall_layer_idx = 1

func _ready():
	_set_extended_wall_tiles()

func _set_extended_wall_tiles():
	for cell_coords in tilemap.get_used_cells(wall_layer_idx):
		var atlas_coords = tilemap.get_cell_atlas_coords(wall_layer_idx, cell_coords)
		var wall_mapping_values = wall_extension_mapping.get(str(atlas_coords))
		_set_custom_tiles(cell_coords, wall_mapping_values)

func _set_custom_tiles(parent_cell_coords, wall_mapping_values):
	var y_shift = 1
	
	if wall_mapping_values == null:
		return
	
	for new_atlas_coords in wall_mapping_values:
		var new_cell_coords = parent_cell_coords + Vector2i(0, y_shift)
		tilemap.set_cell(wall_layer_idx, new_cell_coords, 0, new_atlas_coords)
		y_shift += 1
