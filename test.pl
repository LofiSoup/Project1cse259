% Define some facts
parent(john, mary).
parent(mary, susan).
parent(susan, james).

% Define a rule
    grandparent(X, Y) :- parent(X, Z), parent(Z, Y).

% Query examples
% ?- grandparent(john, james).
% ?- grandparent(mary, james).