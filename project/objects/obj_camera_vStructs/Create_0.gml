following = obj_player;
freeze = false;
debug = false;

var dialogue = [
  {
    text:
      "Welcome to the supersupersupersupersupersupersupersupersupersupersupersupersuper demo of the dialogue system! Hit 'E' to go to the next page.",
    type: DialogueType.Normal,
    speaker: undefined,
    effects: [
      { index: 1, effect: TextEffect.Shakey },
      { index: 9, effect: TextEffect.Wave },
      { index: 16, effect: TextEffect.WaveAndColorShift }
    ],
    textSpeed: [
      { index: 1, speed: 0.2 },
      { index: 4, speed: 2 },
      { index: 10, speed: 0.5 }
    ],
    textColors: [
      { index: 1, color: c_lime },
      { index: 9, color: c_fuchsia },
      { index: 16, color: c_aqua }
    ]
  },
  {
    text:
      "This is an example of a one-time 'text event'. It runs when the game starts.",
    type: DialogueType.Normal,
    speaker: undefined
  },
  {
    text:
      "Hit 'Space' to make a player monologue happen. And 'D' to toggle debug.",
    type: DialogueType.Normal,
    speaker: undefined,
    effects: [{ index: 1, effect: TextEffect.ColorShift }]
  }
];

create_dialogue_vStruct(dialogue);

show_debug_overlay(true);