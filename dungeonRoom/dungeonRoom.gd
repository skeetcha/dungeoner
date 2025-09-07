extends Node3D

func updateRoom() -> void:
	var dungeon: Dungeon = get_node("/root/Main/Dungeon")
	var currentRoomData: int = dungeon.grid[dungeon.currentRoom]
	
	if currentRoomData & dungeon.BitDoorNorth:
		setDoor("north")
	
	if currentRoomData & dungeon.BitDoorSouth:
		setDoor("south")
	
	if currentRoomData & dungeon.BitDoorEast:
		setDoor("east")
	
	if currentRoomData & dungeon.BitDoorWest:
		setDoor("west")
	
	if currentRoomData & dungeon.BitStairBelow:
		(get_node("/root/Main/DungeonRoom/stair-down") as Node3D).visible = true
		(get_node("/root/Main/DungeonRoom/no-stair-down") as Node3D).visible = false
	
	if currentRoomData & dungeon.BitStairUp:
		(get_node("/root/Main/DungeonRoom/stair-up") as Node3D).visible = true

func setDoor(doorName: String) -> void:
	(get_node("/root/Main/DungeonRoom/" + doorName + "-door") as Node3D).visible = true
	(get_node("/root/Main/DungeonRoom/no-" + doorName + "-door") as Node3D).visible = false

func _ready() -> void:
	updateRoom()
