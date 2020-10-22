## To Do (formerly, Stretches)
- Provide scrollability to choice, so any number of options can appear in the textbox
  - This should include arrow pointers up and down in the center x / top and bottom y of the textbox; the arrows should only appear for their corresponding direction when that direction is accessible
  - Can I make it so scrolling is smooth, with strings of text scrolling in and out of view instead of instantly changing? Herp lerp 🤙
- Update choice pointer to animate
  - Subtle bounce effect where the arrow accelerates to the right, bounces back very slowly, then repeats
- Create character metadata structs in global scope
  - The struct contains name, all portrait data, etc.
  - Implement character's side preference and level of intensity
    - The hero's portrait is always on the left with intensity of 100
    - A villain's portrait is always on the right with intensity of 100
    - A character type that has no real preference will go on the side that the other character does not prefer. 
  - ... there are probably other things that could be added to this
- Ooo, and then upgrade that character metadata to be read from a JSON file
- Allow for a single character, e.g., a protag, to have their metadata changed as the game progresses, so all dialogues that reference the protag will have access to the latest sprites / other metadata.
- Implement dialogue participants context
  - Have the ability to declare who all is in a conversation and at what point in the conversation they are present or absent
  - Imagine this kind of context allowing for visualizations like showing character busts all at once on the screen and emphasizing the current speaker.
- Add portrait semi-random 1-2 blinks during idle
  - Idle State = dialogue is finished type-writing
  - Idle portrait Should work with or without blink frames
- Implement a treasure chest object that queues up text and then awards an item.

## Refactoring
- Character spec generation has gotten messy and voluminous. Move it its own script file and make it easier to read.
- Am I deleting specs? Can we go ahead and delete specs when done with them?
  - Consider writing a recursive / reflective function to crawl through a struct graph and delete all structs...
  - Or, is there a way to do this with existing GML functions?
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

## Research
- How could I handle JSON-driven dialogue workflow while also allowing for running full GML scripts?
  - Some ideas:
    - use the function execution technique that FriendlyCosmonaut uses with the big switch
    - ...?