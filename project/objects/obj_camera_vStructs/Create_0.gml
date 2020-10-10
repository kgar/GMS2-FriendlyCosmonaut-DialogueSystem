following = obj_player;
freeze = false;
debug = false;

window_set_fullscreen(true);

var dialogue = [
{
    text:
      "Welcome to the supersupersupersupersupersupersupersupersupersupersupersupersuper demo of the dialogue system! Hit 'E' to go to the next page.",
    type: DialogueType.Normal,
    speaker: undefined,
    effects: [
      { index: 0, effect: TextEffect.Shakey },
      { index: 7, effect: TextEffect.Spin },
      { index: 15, effect: TextEffect.Wave },
      { index: 81, effect: TextEffect.ColorShift },
      { index: 110, effect: TextEffect.WaveAndColorShift },
      { index: 121, effect: TextEffect.Pulse },
      { index: 131, effect: TextEffect.Flicker }
    ],
    textSpeed: [
      { index: 0, speed: 0.2 },
      { index: 15, speed: 2 },
      { index: 81, speed: 0.5 },
      { index: 110, speed: 1 }
    ],
    textColors: [
      { index: 0, color: c_lime },
	  { index: 7, color: c_white },
      { index: 15, color: c_fuchsia },
      { index: 81, color: c_aqua },
	  { index: 131, color: make_color_rgb(220, 20, 60) }
    ],
    textFont: [{ index: 131, font: fnt_chiller }],
    onPageTurn: function () {
      // Literally do whatever scripting you need right here!
      create_instance_layer(170, 120, "Instances", obj_emote_vStruct);
    }
  },
  {
    text:
      "Sometimes, I just want to ride the wave, y'all! Hyphens - and other special characters ! @ ## $ % ^ & * ( ) 0 1234567890 should wave, too!",
    type: DialogueType.Normal,
    effects: [
      { index: 0, effect: TextEffect.Wave },
      { index: 56, effect: TextEffect.WaveAndColorShift },
      { index: 57, effect: TextEffect.Wave },
      { index: 87, effect: TextEffect.WaveAndColorShift },
      { index: 121, effect: TextEffect.Wave }
    ],
	name: "Narrator"
  },
  {
    text:
      "This is an example of a one-time 'text event'. It runs when the game starts.",
    type: DialogueType.Normal,
	name: "Narrator"
  },
  {
    text:
      "Hit 'Space' to make a player monologue happen. And 'D' to toggle debug.",
    type: DialogueType.Normal,
    speaker: undefined,
    effects: [{ index: 0, effect: TextEffect.ColorShift }],
    uniqueId: "FullOnRainbowText",
	name: "The Other Narrator"
  },
  {
    text: "Do you want to start over?",
    type: DialogueType.Choice,
    textColors: [
      { index: 15, color: c_yellow },
      { index: 25, color: c_white }
    ],
    choices: [
      {
        text: "Yeah, sure, why not?",
        jump: {
          jumpType: DialogueJumpType.AbsoluteIndex,
          value: 0
        },
        script: function () {
          global.introRestartCount++;
        }
      },
      {
        text: "Ask me something else."
      },
	  {
		text: "Nope. Bye.",
		jump: {
			jumpType: DialogueJumpType.ExitDialogue
		}
	  }
    ],
	name: "Narrator"
  },
  {
    text: "Okay, so, ... like ... what about seeing that rad rainbow again?",
    type: DialogueType.Choice,
    textSpeed: [
      { index: 10, speed: 0.2 },
      { index: 14, speed: 0.8 },
      { index: 18, speed: 0.2 },
      { index: 21, speed: 1 }
    ],
	effects: [
		{ index: 46, effect: TextEffect.ColorShift },
		{ index: 57, effect: TextEffect.Normal }
	],
    choices: [
      {
        text: "Fine! Show the rainbow!",
        jump: {
          jumpType: DialogueJumpType.UniqueId,
          value: "FullOnRainbowText"
        }
      },
      {
        text: "I want to answer the previous question ;)",
        jump: {
          jumpType: DialogueJumpType.RelativeIndex,
          value: -1
        }
      }
    ],
	name: "The Other Narrator"
  }
];


create_dialogue_vStruct(dialogue);

show_debug_overlay(true);