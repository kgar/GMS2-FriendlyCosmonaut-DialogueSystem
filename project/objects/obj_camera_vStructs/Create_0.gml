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
      { index: 0, effect: TextEffect.Shakey },
      { index: 15, effect: TextEffect.Wave },
      { index: 81, effect: TextEffect.WaveAndColorShift }
    ],
    textSpeed: [
      { index: 0, speed: 0.2 },
      { index: 15, speed: 2 },
      { index: 81, speed: 0.5 }
    ],
    textColors: [
      { index: 0, color: c_lime },
      { index: 15, color: c_fuchsia },
      { index: 81, color: c_aqua }
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