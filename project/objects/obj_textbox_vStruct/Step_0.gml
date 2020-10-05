/// @description Handle User Input

switch (dialogueEntry.type) {
	case DialogueType.Normal:
	
		if (!keyboard_check_pressed(interactKey)) return;
	
		if (textIndex >= specsLength) {
			TurnPage();
		} else if (textIndex > 2 || specsLength <= 2) {
			textIndex = specsLength;
		}
		break;
	case DialogueType.Choice:
		if (chosen) exit;
		if (keyboard_check_pressed(interactKey)) {
			// Process input
			chosen = true;
			delayedAction = ProcessChoice;
			alarm[0] = 10;			
			// Play sound
			// Process choice
		}
				
		
		// On Move up/down:
		// Process input
		// Play sound
		// Adjust choice index
		break;
	default:
		throw "Invalid DialogueType";
	break;
}