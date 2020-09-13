export enum DialogueType {
  Normal,
  Choice
}

export enum TextEffect {
  Normal,
  Shakey,
  Wave,
  ColorShift,
  WaveAndColorShift,
  Spin,
  Pulse,
  Flicker
}

export interface DialogueScript {
  functionId: number;
  args: any[];
}

export interface DialogueChoice {
  choice: string;
  nextLine?: number;
  script?: DialogueScript;
}

export interface DialogueChoices {
  type: DialogueType.Choice;
  choices: DialogueChoice[];
  speaker?: number;
}

export interface TextColor {
  index: number;
  color: number;
}

export interface TextSpeed {
  index: number;
  speed: number;
}

export interface DialogueTextEffect {
  index: number;
  effect: TextEffect;
}

export interface DialogueMessage {
  type: DialogueType.Normal;
  text: string;
  speaker?: number;
  effects?: DialogueTextEffect[];
  script?: DialogueScript;
  textColors?: TextColor[];
  emotion?: number;
  emote?: number;
  textSpeed?: TextSpeed[];
  nextLine?: number;
}

export type DialogueEntry = DialogueChoices | DialogueMessage;
export type Dialogue = DialogueEntry[];
