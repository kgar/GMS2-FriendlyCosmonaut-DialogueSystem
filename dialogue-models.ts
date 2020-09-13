export enum DialogueType {
    Normal,
    Choice
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

export interface DialogueMessage {
    type: DialogueType.Normal;
    text: string;
    speaker?: number;
    effects?: number[];
    script?: DialogueScript;
    textColors?: TextColor[];
    emotion?: number;
    emote?: number;
    textSpeed?: TextSpeed[],
    nextLine?: number;
}

export type DialogueEntry = DialogueChoices | DialogueMessage;
export type Dialogue = DialogueEntry[];