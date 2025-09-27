extends Node2D

@export var scene_to_load : int

@onready var player: Node2D = %Player

@export var beepSFX: AudioStream
@export var beepInterval: float
@export var beepPitch: float
@export var hintTimer: float

var audioPlayer: AudioStreamPlayer2D
var beepTimer: Timer
var lastDistance: float = INF
var distanceThreshold: float = 5.0	#distance required to move to consider "progress" towards beeping object
var timeSinceLastProg: float = 0.0

@onready var interactable: Area2D = $Interactable
@onready var objectSprite: Sprite2D = $Sprite2D
var minigameOverlay: CanvasLayer

func _ready() -> void:
	interactable.interact = Callable(self, "OnInteract")
	minigameOverlay = get_parent().get_node("InteractionScene")
	
	#Audio Player Setup
	audioPlayer = AudioStreamPlayer2D.new()
	audioPlayer.stream = beepSFX
	add_child(audioPlayer)
	
	#Timer Setup
	beepTimer = Timer.new()
	beepTimer.one_shot = true	#prevents default looping
	beepTimer.timeout.connect(Callable(self, "BeepTimeout"))
	add_child(beepTimer)
	
	StartBeeping()
	
func _process(delta: float) -> void:
	var currentDistance = player.global_position.distance_to(global_position)
	print(currentDistance)
	
	if currentDistance < lastDistance - distanceThreshold:
		timeSinceLastProg = 0.0
		lastDistance = currentDistance
	else:
		timeSinceLastProg += delta
		if timeSinceLastProg >= hintTimer:
			ShowHint()
			timeSinceLastProg = 0.0

func StartBeeping() -> void:
	lastDistance = player.global_position.distance_to(global_position)
	PlayBeep()
	
func PlayBeep() -> void:
	var distance = player.global_position.distance_to(global_position)
	
	var pitch = beepPitch + clamp(1.0 / max(distance, 1.0), 0.0, 2.0)
	var interval = clamp(beepInterval * (distance / 300.0), 0.2, beepInterval)

	audioPlayer.pitch_scale = pitch
	audioPlayer.play()
	
	beepTimer.start(interval)

func BeepTimeout() -> void:
	PlayBeep()

func OnInteract() -> void:
	print("Interacted with: " + name)
	beepTimer.stop()
	audioPlayer.stop()
	
	get_tree().paused = true	
	minigameOverlay.load_scene(scene_to_load) # <-- Change to index of interaction enum you want to play (seen in InteractioScene)

func ShowHint() -> void:
	print("You're going the wrong way")
