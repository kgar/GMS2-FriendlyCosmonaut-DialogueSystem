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

export enum DialogueJumpType {
  AbsoluteIndex,
  RelativeIndex,
  UniqueId,
  ExitDialogue
}

export interface DialogueJump {
  jumpType: DialogueJumpType;
  value?: string | number;
}

export interface DialogueChoice {
  text: string;
  jump?: DialogueJump;
  script?: () => void;
}

export interface DialogueChoices {
  type: DialogueType.Choice;
  text?: string;
  choices: DialogueChoice[];
  speaker?: number;
  effects?: DialogueTextEffect[];
  textColors?: TextColor[];
  emotion?: number;
  emote?: number;
  textSpeed?: TextSpeed[];
  textFont?: TextFont[];
  id?: string;
  // Make an extension of DialogueMessage?
}

export interface TextColor {
  index: number;
  color: number;
}

export interface TextSpeed {
  index: number;
  speed: number;
}

export interface TextFont {
  index: number;
  font: number;
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
  onPageTurn?: Function;
  textColors?: TextColor[];
  emotion?: number;
  emote?: number;
  textSpeed?: TextSpeed[];
  textFont?: TextFont[];
  uniqueId?: string;
}

export type DialogueEntry = DialogueChoices | DialogueMessage;
export type Dialogue = DialogueEntry[];

export declare var id: number,
  create_instance_layer: Function,
  obj_emote: number,
  obj_player: number,
  obj_examplechar: number,
  c_lime: number,
  c_white: number,
  c_yellow: number,
  c_aqua: number,
  c_fuschia: number,
  change_variable: Function,
  obj_emote_vStruct: number,
  global: any,
  fnt_chiller: number;
