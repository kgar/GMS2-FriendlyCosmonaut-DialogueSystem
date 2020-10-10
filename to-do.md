## To Do
- Add static portrait
  - Allow for specifying a side
  - The nameplate should automatically take the opposite side
- Add talk animation
  - Make sure it can be configured for longer sprite speaking animations or dynamically able to handle that
- Add idle animation
- Apply some simple 9-panel textbox with borders to replace the black box
  - Do the same for the nameplate
- Implement interactable objects for dialogue
  - Inheritance? Or composition?
    - How would we do composition in GMS2?

## Stretches
- Allow for variable insertion during spec generation
  - Allow value interpolation. For example, inject the `introRestartCount` into a line of dialogue.
    - The spec should be able to account for the difference in text length between the interpolation text and the resulting injected content and apply the text effects / etc. based on the original string of text.
- Implement conditional dialogue entries
  - They can be a normal or a choice dialogue entry.
  - They should have a function that can be called to check if the dialogue entry should be allowed
    - Example, if you have restarted the intro at least once, swap the page 
    - `"This is an example of a one-time 'text event'. It runs when the game starts."` with 
    - `"Uh, as previously stated, this is an example of a one-time 'text event'. It runs when the game starts. And I've said this \{global.introRestartCount + 1} times."`
      - GMS2 doesn't allow straight up interpretation of strings into scripts (not anymore, at least). Maybe something like a function that returns a struct?
      - e.g., `"...And I've said this \{numberOfTimesHeSaidThis} times."`, and 
      - `interpolations: function() { return { numberOfTimesHeSaidThis: global.introRestartCount + 1 } }`
      - Yeah! That could work!
- Provide scrollability to choice, so any number of options can appear in the textbox
  - This should include arrow pointers up and down in the center x / top and bottom y of the textbox; the arrows should only appear for their corresponding direction when that direction is accessible
  - Can I make it so scrolling is smooth, with strings of text scrolling in and out of view instead of instantly changing?
- Update choice pointer to animate
  - Subtle bounce effect where the arrow accelerates to the right, bounces back very slowly, then repeats


## Refactoring
- Create specMaxIndex variable for obj and use it.
- Create function for skipping to end of typewriting and extract all manual logic.
- Can I eliminate any more variables from the textbox object?
- Is there a less manual way to handle text ranges?
- Challenge: Refactor rainbow text to no longer depend on drawTextX in order to shift vertically correlated colors.
  - Hmm... divide the screen into 255 slices?
  - Somehow determine with the passage of time that hue should circularly shift to the left...
  - Somehow do this without holding any variables so that all rainbow text behaves as if some kind of masking were being used.
- Make text effects drawing reusable