/* drawSymbol: Draw a symbol multiple times */
drawSymbol(Symbol, 0).
drawSymbol(Symbol, N) :- 
  N > 0, 
  write(Symbol), 
  N1 is N - 1, 
  drawSymbol(Symbol, N1).

/* drawHorizontalLine: Draw a horizontal line */
drawHorizontalLine(Symbol, 0) :- nl.
drawHorizontalLine(Symbol, N) :- drawSymbol(Symbol, N).

/* drawVerticalLinesWithSpace: Draw vertical lines with spaces */
drawVerticalLinesWithSpace(Symbol, 0, Width).
drawVerticalLinesWithSpace(Symbol, Height, Width) :- 
  Height > 0,
  write(Symbol),
  drawSymbol(' ', Width - 2),
  write(Symbol),
  nl,
  Height1 is Height - 1,
  drawVerticalLinesWithSpace(Symbol, Height1, Width).

/*-------------------------------------------------------------------------------------------------*/
/* draw A */
drawA(TextWidth, TextHeight, FontSize, CurrentLine, ColumnNumber) :-
  ColumnNumber >= TextWidth.

/* Covers the left-most and the right-most columns that only have stars */
drawA(TextWidth, TextHeight, FontSize, CurrentLine, ColumnNumber) :-
  (
    (ColumnNumber >= 0, ColumnNumber < FontSize);
    (ColumnNumber >= FontSize * 2, ColumnNumber < TextWidth)
  ),
  drawSymbol('*', FontSize),
  NextColumn is ColumnNumber + FontSize,
  drawA(TextWidth, TextHeight, FontSize, CurrentLine, NextColumn).

/* Covers the middle segment of "A" with stars or spaces */
drawA(TextWidth, TextHeight, FontSize, CurrentLine, ColumnNumber) :-
  (ColumnNumber >= FontSize, ColumnNumber < FontSize * 2),
  (
    (CurrentLine >= 0, CurrentLine < FontSize);
    (CurrentLine >= FontSize * 2, CurrentLine < FontSize * 3)
  ),
  drawSymbol('*', FontSize),
  NextColumn is ColumnNumber + FontSize,
  drawA(TextWidth, TextHeight, FontSize, CurrentLine, NextColumn).

drawA(TextWidth, TextHeight, FontSize, CurrentLine, ColumnNumber) :-
  (ColumnNumber >= FontSize, ColumnNumber < FontSize * 2),
  (
    (CurrentLine >= FontSize, CurrentLine < 2 * FontSize);
    (CurrentLine >= FontSize * 3, CurrentLine < TextHeight)
  ),
  drawSymbol(' ', FontSize),
  NextColumn is ColumnNumber + FontSize,
  drawA(TextWidth, TextHeight, FontSize, CurrentLine, NextColumn).

/* draw A */
/*-------------------------------------------------------------------------------------------------*/

/*-------------------------------------------------------------------------------------------------*/
/* draw S */
drawS(TextWidth, TextHeight, FontSize, CurrentLine, ColumnNumber) :-
  ColumnNumber >= TextWidth.

/* Draws the top, middle, and bottom horizontal segments of "S" */
drawS(TextWidth, TextHeight, FontSize, CurrentLine, ColumnNumber) :-
  (
    (CurrentLine >= 0, CurrentLine < FontSize); % Top segment
    (CurrentLine >= FontSize * 2, CurrentLine < FontSize * 3); % Middle segment
    (CurrentLine >= TextHeight - FontSize, CurrentLine < TextHeight) % Bottom segment
  ),
  drawSymbol('*', FontSize),
  NextColumn is ColumnNumber + FontSize,
  drawS(TextWidth, TextHeight, FontSize, CurrentLine, NextColumn).

/* Draws the left and right vertical segments of "S" */
drawS(TextWidth, TextHeight, FontSize, CurrentLine, ColumnNumber) :-
  (
    (CurrentLine >= FontSize, CurrentLine < FontSize * 2, ColumnNumber >= 0, ColumnNumber < FontSize); % Left segment
    (CurrentLine >= FontSize * 3, CurrentLine < TextHeight - FontSize, ColumnNumber >= TextWidth - FontSize) % Right segment
  ),
  drawSymbol('*', FontSize),
  NextColumn is ColumnNumber + FontSize,
  drawS(TextWidth, TextHeight, FontSize, CurrentLine, NextColumn).

/* Fill in spaces where no stars should be drawn in "S" */
drawS(TextWidth, TextHeight, FontSize, CurrentLine, ColumnNumber) :-
  drawSymbol(' ', FontSize),
  NextColumn is ColumnNumber + FontSize,
  drawS(TextWidth, TextHeight, FontSize, CurrentLine, NextColumn).

/* draw S */
/*-------------------------------------------------------------------------------------------------*/

/*-------------------------------------------------------------------------------------------------*/
/* draw U */
drawU(TextWidth, TextHeight, FontSize, CurrentLine, ColumnNumber) :-
  ColumnNumber >= TextWidth.

/* Draws the left and right vertical segments of "U" */
drawU(TextWidth, TextHeight, FontSize, CurrentLine, ColumnNumber) :-
  CurrentLine < TextHeight - FontSize,
  (
    (ColumnNumber >= 0, ColumnNumber < FontSize); % Left vertical segment
    (ColumnNumber >= TextWidth - FontSize, ColumnNumber < TextWidth) % Right vertical segment
  ),
  drawSymbol('*', FontSize),
  NextColumn is ColumnNumber + FontSize,
  drawU(TextWidth, TextHeight, FontSize, CurrentLine, NextColumn).

/* Draws the bottom horizontal segment of "U" */
drawU(TextWidth, TextHeight, FontSize, CurrentLine, ColumnNumber) :-
  CurrentLine >= TextHeight - FontSize,
  drawSymbol('*', FontSize),
  NextColumn is ColumnNumber + FontSize,
  drawU(TextWidth, TextHeight, FontSize, CurrentLine, NextColumn).

/* Fill in spaces where no stars should be drawn in "U" */
drawU(TextWidth, TextHeight, FontSize, CurrentLine, ColumnNumber) :-
  drawSymbol(' ', FontSize),
  NextColumn is ColumnNumber + FontSize,
  drawU(TextWidth, TextHeight, FontSize, CurrentLine, NextColumn).

/* draw U */
/*-------------------------------------------------------------------------------------------------*/

/* draw the text with appropriate spacing */
draw(LeftRightMargin, SpaceBetweenCharacters, FontSize, CurrentLine, TextWidth, TextHeight) :-
  CurrentLine >= TextHeight.

draw(LeftRightMargin, SpaceBetweenCharacters, FontSize, CurrentLine, TextWidth, TextHeight) :-
  CurrentLine < TextHeight,
  ColumnNumber is 0,
  write('|'), drawSymbol(' ', LeftRightMargin),

  /* Draw "A" */
  drawA(TextWidth, TextHeight, FontSize, CurrentLine, ColumnNumber),

  /* Add space between "A" and "S" */
  drawSymbol(' ', SpaceBetweenCharacters),

  /* Draw "S" */
  drawS(TextWidth, TextHeight, FontSize, CurrentLine, ColumnNumber),

  /* Add space between "S" and "U" */
  drawSymbol(' ', SpaceBetweenCharacters),

  /* Draw "U" */
  drawU(TextWidth, TextHeight, FontSize, CurrentLine, ColumnNumber),

  drawSymbol(' ', LeftRightMargin),
  write('|'),
  nl,
  NextLine is CurrentLine + 1,
  draw(LeftRightMargin, SpaceBetweenCharacters, FontSize, NextLine, TextWidth, TextHeight).

/* This will be initiating the variables and will be called from asu() */
drawVerticalLinesWithCharacters(LeftRightMargin, BottomTopMargin, SpaceBetweenCharacters, FontSize) :-
  CurrentLine is 0,
  TextWidth is FontSize * 3,
  TextHeight is FontSize * 5,
  draw(LeftRightMargin, SpaceBetweenCharacters, FontSize, CurrentLine, TextWidth, TextHeight).

/* This will be used from the console */
asu(LeftRightMargin, BottomTopMargin, SpaceBetweenCharacters, FontSize) :-
  integer(LeftRightMargin), integer(BottomTopMargin), integer(SpaceBetweenCharacters), integer(FontSize),

  /* Calculate the height and width */
  Width is (LeftRightMargin * 2 + SpaceBetweenCharacters * 2 + FontSize * 3 * 3 + 2),
  Height is (BottomTopMargin * 2 + FontSize * 5),

  /* Top horizontal line of the box */
  drawHorizontalLine('-', Width),
  nl,

  /* The empty space at the top */
  drawVerticalLinesWithSpace('|', BottomTopMargin, Width),

  /* The actual text */
  drawVerticalLinesWithCharacters(LeftRightMargin, BottomTopMargin, SpaceBetweenCharacters, FontSize),

  /* The empty space at the bottom */
  drawVerticalLinesWithSpace('|', BottomTopMargin, Width),

  /* Bottom horizontal line of the box */
  drawHorizontalLine('-', Width).
