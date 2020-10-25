event_inherited();

signText = [
  {
    text: "<-- Left \n--> Right \nWatch your step",
    type: DialogueType.Normal
  }
];
detectionRadius = 12;

onPlayerInteraction = function() {
	create_dialogue_vStruct(signText);
}