draw_vertical_lines(Height, Width) :-
    (Height == 0 -> true
    ;   write('|'),
        draw_symbol(' ', Width - 2),
        write('|'),
        nl,
        Height1 is Height - 1,
        draw_vertical_lines(Height1, Width)
    ).
draw_horizontal_line(Symbol, Width) :-
    (Width == 0 -> nl
    ;   write(Symbol),
        Width1 is Width - 1,
        draw_horizontal_line(Symbol, Width1)
    ).

draw_rectangle(LeftRightMargin, BottomTopMargin, SpaceBetweenCharacters, FontSize) :-

    integer(LeftRightMargin),
    integer(BottomTopMargin),
    integer(SpaceBetweenCharacters),
    integer(FontSize),
    Width is (LeftRightMargin * 2) + (SpaceBetweenCharacters * 2) + (FontSize * 3 * 3) + 2,
    Height is (BottomTopMargin * 2) + (FontSize * 5),
    draw_horizontal_line(Hyphen, Width), 
    nl, 
    draw_vertical_lines(Height, Width),
    draw_horizontal_line(Hyphen, Width)
men