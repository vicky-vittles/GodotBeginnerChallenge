extends Entity

onready var grunt = $SFX/grunt

func random_death_grunt():
	var rand_number = randi()%100
	if rand_number < 30:
		grunt.play_random()
