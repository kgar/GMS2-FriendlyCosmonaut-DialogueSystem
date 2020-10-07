## To Do
- Implement choice
  - Draw GUI:
    - Add a pointer on the currently highlighted option
    - The pointer should oscillate smoothly and slighty from left to right
    - When the choice changes, lerp() the pointer from the one option to the other. It should be so fast that there's no concern about waiting on it if you are cycling through options
    - Support as many options as can be visible on a single page
  - use a cool pointer sprite that animates
- Add optional nameplate
- Add static portrait
- Add talk animation
  - Make sure it can be configured for longer sprite speaking animations or dynamically able to handle that
- Add idle animation
- Add vocal pause
- Add dialogue page turn indicator (use the existing spr_dialoguefinished); it should animate like the original.
- Apply some simple 9-panel textbox with borders to replace the black box

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