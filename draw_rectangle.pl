% Draw N instances of Symbol
drawSymbol(_, 0).
drawSymbol(Symbol, N) :- 
    N > 0, 
    write(Symbol), 
    N1 is N - 1, 
    drawSymbol(Symbol, N1).

% Draw a horizontal line of width N with the given Symbol
drawHorizontalLine(Symbol, N) :- 
    N > 0, 
    write(Symbol), 
    N1 is N - 1, 
    drawHorizontalLine(Symbol, N1).
drawHorizontalLine(_, 0) :- nl.

% Draw the vertical lines (with spaces between)
drawVerticalLines(_, 0, _) :- !.
drawVerticalLines(Symbol, Height, Width) :- 
    Height > 0, 
    write(Symbol),                     % Left edge
    drawSymbol(' ', Width - 2),         % Spaces between
    write(Symbol),                     % Right edge
    nl,
    Height1 is Height - 1, 
    drawVerticalLines(Symbol, Height1, Width).

% Draw the rectangle
drawRectangle(LeftRightMargin, BottomTopMargin, SpaceBetweenCharacters, FontSize) :- 
    integer(LeftRightMargin), 
    integer(BottomTopMargin), 
    integer(SpaceBetweenCharacters), 
    integer(FontSize),
    
    % Width calculation based on margins, font size, and space
    Width is LeftRightMargin * 2 + SpaceBetweenCharacters + FontSize * 3,
    
    % Height calculation: simply based on margins and font size for clarity
    Height is BottomTopMargin * 2 + FontSize,
    
    % Draw top border
    drawHorizontalLine('-', Width),
    
    % Draw vertical lines
    drawVerticalLines('|', Height, Width),
    
    % Draw bottom border
    drawHorizontalLine('-', Width).
