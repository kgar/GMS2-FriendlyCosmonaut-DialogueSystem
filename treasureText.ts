import {
  audio_play_sound,
  c_white,
  c_yellow,
  Dialogue,
  DialogueType,
  snd_item_award
} from "./dialogue-models";

var treasureText: Dialogue = [
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