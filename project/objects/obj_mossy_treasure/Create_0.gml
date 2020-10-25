event_inherited();

detectionRadius = 26;
image_xscale = 0.5;
image_yscale = 0.5;
indexClosed = 0;
indexOpen = 3;
treasureImageIndex = indexClosed;
itemAwarded = false;

treasureText = [
  {
	  text: "Empty ... The longer you stare at the darkness, the more your ponder your own existence.",
	  type: DialogueType.Normal,
	  showThisPage: function(instance) { return instance.itemAwarded; }
  },
  {
    text: "You find ${goldToAward} gold.",
    type: DialogueType.Normal,
    textColors: [
      { index: 9, color: c_yellow },
      { index: 23, color: c_white }
    ],
    onPageOpen: function (instance) {
      audio_play_sound(snd_item_award, 5, false);
    },
	onPageTurn: function(instance) {
	  // Award the gold
	  // Change chest state to empty
	  instance.itemAwarded = true;
	  instance.treasureImageIndex = instance.indexOpen;
	},
	getInterpolationData: function() {
		return {
			goldToAward: 25
		}
	},
	showThisPage: function(instance) { 
		return !instance.itemAwarded; 
	}
  }
];

//animationScheme = [
//	{ subImg: 0, ms: 150 },
//	{ subImg: 1, ms: 150 },
//	{ subImg: 2, ms: 100 },
//	{ subImg: 3, ms: 750 }
//];

onPlayerInteraction = function() {
	// TODO: Do opening animation with opening sound effect
	// TODO: Queue the dialogue
	create_dialogue_vStruct(treasureText, id);
}