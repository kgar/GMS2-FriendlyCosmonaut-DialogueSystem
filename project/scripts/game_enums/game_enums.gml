enum GameState {
	// The player can take actions
	Active,
	// The game is paused and nothing else is happening until the game is unpaused
	Paused,
	// Some kind of scene with its own input handling is occurring; the player character should not move
	Scene
}