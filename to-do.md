## To Do
- Add dialogue choice input handling into Step
  - Draw GUI:
    - Draw the options
      - Highlight the current choice
    - Ensure pointer exists
    - Ensure pointer destination is specified
  - control destination dialogue page based on choice
  - execute script from dialogue action
  - handle user input
    - selection
    - choosing between options
  - use a cool pointer sprite that animates
  - highlight the currently selected option
- Add optional nameplate
- Add static portrait
- Add talk animation
  - Make sure it can be configured for longer sprite speaking animations or dynamically able to handle that
- Add idle animation
- Add vocal pause
- Add dialogue page turn indicator (use the existing spr_dialoguefinished); it should animate like the original.

## Refactoring
- Can I eliminate any more variables from the textbox object?
- Is there a less manual way to handle text ranges?
- Challenge: Refactor rainbow text to no longer depend on drawTextX in order to shift vertically correlated colors.
  - Hmm... divide the screen into 255 slices?
  - Somehow determine with the passage of time that hue should circularly shift to the left...
  - Somehow do this without holding any variables so that all rainbow text behaves as if some kind of masking were being used.