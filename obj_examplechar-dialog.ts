import { Dialogue, DialogueEntry, DialogueType } from "./dialogue-models";

declare var id: number,
  create_instance_layer: number,
  obj_emote: number,
  obj_player: number,
  obj_examplechar: number,
  c_lime: number,
  c_white: number,
  c_aqua: number,
  change_variable: number;

var initialDialogue: Dialogue = [
  {
    type: DialogueType.Normal,
    text:
      "You can run a script after any line of dialogue! Let's make an emote to the left.",
    speaker: id,
    script: {
      functionId: create_instance_layer,
      args: [170, 120, "Instances", obj_emote]
    }
  },
  {
    text:
      "You can even have it depend on player choice. Which object should I make?",
    speaker: id,
    type: DialogueType.Normal
  },
  {
    type: DialogueType.Choice,
    choices: [
      {
        choice: "An emote",
        script: {
          functionId: create_instance_layer,
          args: [170, 120, "Instances", obj_emote]
        },
        nextLine: 0
      },
      {
        choice: "Another you!",
        script: {
          functionId: create_instance_layer,
          args: [170, 120, "Instances", obj_examplechar]
        },
        nextLine: 0
      }
    ],
    speaker: obj_player
  },
  {
    type: DialogueType.Normal,
    text: "Pretty cool, right? Now, let's get back to our conversation.",
    speaker: id
  },
  {
    type: DialogueType.Normal,
    text: "Looky here, green hood.",
    effects: [13, 1, 18, 0],
    speaker: id,
    textColors: [
      { color: c_lime, index: 13 },
      { color: c_white, index: 18 }
    ]
  },
  {
    type: DialogueType.Normal,
    text: "We both know blue is the best colour.",
    emotion: 1,
    emote: 0,
    speaker: id,
    textColors: [
      { index: 14, color: c_aqua },
      { index: 18, color: c_white }
    ]
  },
  {
    type: DialogueType.Normal,
    text: "Say it... or else.",
    textSpeed: [
      { index: 1, speed: 0.5 },
      { index: 10, speed: 0.1 }
    ],
    emotion: 0,
    emote: 4
  },
  {
    type: DialogueType.Choice,
    choices: [
      {
        choice: "(sarcastically) Blue is the best colour.",
        script: {
          functionId: change_variable,
          args: [id, "choice_variable", "blue"]
        },
        nextLine: 8
      },
      {
        choice: "Green is the best colour.",
        script: {
          functionId: change_variable,
          args: [id, "choice_variable", "green"]
        },
        nextLine: 9
      }
    ],
    speaker: obj_player
  },
  {
    type: DialogueType.Normal,
    text: "Exactly! Thank you!",
    emotion: 0,
    emote: 0,
    nextLine: -1,
    speaker: id
  },
  {
    type: DialogueType.Normal,
    text: "Nooooooooooooooooooooooo!",
    textSpeed: [
      { index: 1, speed: 1 },
      { index: 6, speed: 0.3 },
      { index: 10, speed: 1 }
    ],
    emotion: 2,
    emote: 9,
    speaker: id
  }
];

var greenDialogue: Dialogue = [
  {
    type: DialogueType.Normal,
    text: "I can't believe you like green better...",
    textSpeed: [{ index: 1, speed: 0.3 }],
    emotion: 2,
    emote: 9,
    speaker: id,
    textColors: [
      { index: 26, color: c_lime },
      { index: 31, color: c_white }
    ]
  }
];

var blueDialogue: Dialogue = [
    {
        type: DialogueType.Normal,
        text: "Hey there, fellow blue lover!",
        textSpeed: [
            { index: 1, speed: 1},
            { index: 10, speed: 0.5}
        ]
    }
];
