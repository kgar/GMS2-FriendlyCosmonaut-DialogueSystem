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
			audio_play_sound(choiceSelectSound, choiceSoundPriority, false); 
			delayedAction = ProcessChoice;
			alarm[0] = 10;			
			exit;
		}
		
		var change = keyboard_check_pressed(choiceMoveDownKey) - keyboard_check_pressed(choiceMoveUpKey);
		if(change != 0){ 
			var choicesLength = array_length(dialogueEntry.choices);
			currentChoiceIndex = (currentChoiceIndex + change + choicesLength) % choicesLength; 
			audio_play_sound(choiceChangeSound, choiceSoundPriority, false); 
		}
		break;
	default:
		throw "Invalid DialogueType";
	break;
}