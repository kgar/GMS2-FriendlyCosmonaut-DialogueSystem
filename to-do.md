## To Do (formerly, Stretches)
- Update indicator colors
- Make indicators only appear when the content is scrollable
- Update choice pointer to animate
  - Subtle bounce effect where the arrow accelerates to the right, bounces back very slowly, then repeats
- Consider beginning the Module/Demo repo for this first draft of the textbox module and moving the implementation there

## Refactoring
- Character spec generation has gotten messy and voluminous. Move it its own script file and make it easier to read.
- Am I deleting specs? Can we go ahead and delete specs when done with them?
  - Consider writing a recursive / reflective function to crawl through a struct graph and delete all structs...
- Create specMaxIndex variable for obj and use it.
- Create function for skipping to end of typewriting and extract all manual logic.
- Can I eliminate any more variables from the textbox object?
- Is there a less manual way to handle text ranges?
- Challenge: Refactor rainbow text to no longer depend on drawTextX in order to shift vertically correlated colors.
  - Hmm... divide the screen into 255 slices?
  - Somehow determine with the passage of time that hue should circularly shift to the left...
  - Somehow do this without holding any variables so that all rainbow text behaves as if some kind of masking were being used.
- Make text effects drawing reusable
- Convert as many hardcoded assets to strings and use asset_get_index() on them.
- Establish that textColor `undefined` means to use the default dialogue font. Update all dialogues to leverage this.
- Try to replace scroll positioning with the TextScroller module
- Try to extract choice management to a struct that can be used by the object as a vector of composition

## Research and Needs Work
- How could I handle JSON-driven dialogue workflow while also allowing for running full GML scripts?
  - Some ideas:
    - use the function execution technique that FriendlyCosmonaut uses with the big switch
    - ...?
- Implement dialogue participants context
  - Have the ability to declare who all is in a conversation and at what point in the conversation they are present or absent
  - Imagine this kind of context allowing for visualizations like showing character busts all at once on the screen and emphasizing the current speaker.
- Change interpolation wording to be more template-focused
  - Look up JS templates on MDN and try to get a handle on an understandable series of variable names for the templating feature.

# Punted for standalone projects
- Implement a treasure chest object that leverages the dialogue engine and is extensible / persistable
  - Ideas:
    - Use a global map to associated rooms / some other identifier with a group of treasure chests
    - On room load / arrival / whatever, it should check to see what treasures to place
    - The treasure state will be held by the global treasure map
    - Upon creating the treasure object, it will then call the Init() function for the treasure, passing in its state
    - Research: Is there a way to manage treasure state per room via files rather than global memory? At what point would it be worth the trouble?
    - Treasure state:
      - Position in room
      - Items contained in chest
      - Chest opened or closed
      - Chest locked/unlocked state
      - Chest conditions for unlocking
      - Script references for special events
      - Special messaging or events associated with the chest
      - Chest type (e.g., wooden chest, mossy crate, iron chest, etc.) and that chest's attributes (sfx, opening animation sequence, etc.)
- Create character metadata structs in global scope
  - The struct contains name, all portrait data, etc.
  - Implement character's side preference and level of intensity
    - The hero's portrait is always on the left with intensity of 100
    - A villain's portrait is always on the right with intensity of 100
    - A character type that has no real preference will go on the side that the other character does not prefer. 
  - ... there are probably other things that could be added to this
  - Ooo, and then upgrade that character metadata to be read from a JSON file
  - Allow for a single character, e.g., a protag, to have their metadata changed as the game progresses, so all dialogues that reference the protag will have access to the latest sprites / other metadata.
- Add portrait semi-random 1-2 blinks during idle
  - Idle State = dialogue is finished type-writing
  - Idle portrait Should work with or without blink frames