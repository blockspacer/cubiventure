extends RigidBody

const ALIVE_TIMEOUT = 5.0;

var time = 0.0;
var owner = null;

func _ready():
	connect("body_enter", self, "body_enter");
	set_process(true);

func _process(delta):
	time += delta;
	
	if time >= ALIVE_TIMEOUT:
		queue_free();

func body_enter(body):
	if owner == null:
		return;
	
	if owner extends preload("res://scripts/zombie.gd") && body extends preload("res://scripts/player.gd"):
		globals.game.player_apply_damage(rand_range(5.0,10.0));
		queue_free();
	
	if owner extends preload("res://scripts/player.gd") && body extends preload("res://scripts/zombie.gd"):
		body.queue_free();
		queue_free();
