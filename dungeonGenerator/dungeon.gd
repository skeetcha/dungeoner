class_name Dungeon

extends Node

@export var grid: PackedByteArray = []
@export var width: int = 6
@export var height: int = 6
@export var entrance: int = -1
@export var init: bool = false

const BitUsedRoom: int = 0x01
const BitEntrance: int = 0x02
const BitDoorNorth: int = 0x04
const BitDoorEast: int = 0x08
const BitDoorSouth: int = 0x10
const BitDoorWest: int = 0x20
const BitStairBelow: int = 0x40
const BitStairUp: int = 0x80

const Neighbors: int = BitDoorNorth | BitDoorEast | BitDoorSouth | BitDoorWest

var rng: RandomNumberGenerator = RandomNumberGenerator.new()

func _ready() -> void:
	if init:
		generate()
		var nextScene: Node3D = preload("res://dungeonRoom/dungeonRoom.tscn").instantiate()
		get_node("/root/Main").call_deferred("add_child", nextScene)
		
func fillArray(r: Array, size: int):
	for i in range(size):
		r.append(0)

func fillByteArray(r: PackedByteArray, size: int):
	for i in range(size):
		r.append(0)

func generate():
	var dungeonArea: int = width * height
	fillByteArray(grid, dungeonArea)
	var generatedCellsNum: int = 0
	var generatedCells: Array[int]
	fillArray(generatedCells, dungeonArea)
	var i = 0
	
	while ((generatedCellsNum < dungeonArea) and ((i == 0) or (i < generatedCellsNum))):
		if (i == 0) and (generatedCellsNum == 0):
			entrance = rng.randi_range(0, dungeonArea - 1)
			generatedCells[0] = entrance
			grid[entrance] = BitEntrance | BitUsedRoom
			generatedCellsNum = 1
		
		var generatedCellsRef: Array[int] = [generatedCellsNum]
		generateRoom(i, generatedCells, generatedCellsRef)
		generatedCellsNum = generatedCellsRef[0]
		
		if !(grid[generatedCells[i]] & BitUsedRoom):
			grid[generatedCells[i]] |= BitUsedRoom
		
		if (i == (generatedCellsNum - 1)) and (generatedCellsNum < (dungeonArea * 0.75)):
			i = -1
		
		i += 1

func generateRoom(cellIndexQueue: int, cellsQueue: Array[int], queueSize: Array[int]) -> void:
	var potentialDoors: int = rng.randi_range(0, Neighbors - 1)
	var cellIndex: int = cellsQueue[cellIndexQueue]
	
	var door: int = 1
	var oppositeDoor: int
	
	while door <= Neighbors:
		if ((door & Neighbors) != door) or (grid[cellIndex] & door):
			door <<= 1
			continue
		
		var neighborRoom: int = getNeighborRoomIndex(cellIndex, door)
		
		if (!~neighborRoom) or (grid[neighborRoom] & BitUsedRoom):
			door <<= 1
			continue
		
		oppositeDoor = getOppositeDirectionBit(door)
		
		if (door & potentialDoors) == door:
			grid[cellIndex] |= door
			grid[neighborRoom] |= oppositeDoor
		
		if grid[neighborRoom] == oppositeDoor:
			cellsQueue[queueSize[0]] = neighborRoom
			queueSize[0] += 1
		
		door <<= 1

func getNeighborRoomIndex(currentRoom: int, direction: int) -> int:
	var neighborRoom: int
	
	if direction == BitDoorNorth:
		neighborRoom = currentRoom - width
	elif direction == BitDoorEast:
		neighborRoom = currentRoom + 1
	elif direction == BitDoorSouth:
		neighborRoom = currentRoom + width
	elif direction == BitDoorWest:
		neighborRoom = currentRoom - 1
	
	if ((direction == BitDoorNorth) and (neighborRoom >= 0)) or ((direction == BitDoorSouth) and (neighborRoom < (width * height))) or ((direction == BitDoorEast) and ((neighborRoom % width) > 0)) or ((direction == BitDoorWest) and ((neighborRoom % width) < (width - 1))):
		return neighborRoom
	
	return -1

func getOppositeDirectionBit(direction: int) -> int:
	var oppositeDirection: int = -1
	
	if direction == BitDoorNorth:
		oppositeDirection = BitDoorSouth
	elif direction == BitDoorEast:
		oppositeDirection = BitDoorWest
	elif direction == BitDoorSouth:
		oppositeDirection = BitDoorNorth
	elif direction == BitDoorWest:
		oppositeDirection = BitDoorEast
	
	return oppositeDirection
