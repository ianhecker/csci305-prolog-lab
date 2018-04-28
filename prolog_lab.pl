% Ian Hecker
% CSCI 305 Prolog Lab 2

%Searches for mother 'M' of child 'C'; must be female
mother(M, C) :-
    parent(M, C),
    female(M).

%Searches for father 'F' of child 'C'; must be male
father(F, C) :-
    parent(F, C),
    male(F).

%searches for spouse 'S' of 'X'
spouse(S, X) :-
    married(S, X);
    married(X, S).

%Searches for parent 'P' of child 'C'
child(C, P) :-
    parent(P, C).

%Searches for son 'S' of parent 'P'; must be male
son(S, P) :-
    male(S),
    parent(P, S).

%Searches for daughter 'D' of parent 'P'; must be female
daughter(D, P) :-
    female(D),
    parent(P, D).

%Searches for sibling 'S' by matching parents of 'S' & 'X'
%'S' cannot be equal to 'X'; You cannot be your own sibling
%Added checks for male and female parent to limit results
%Without M/F check possible results = 4; 2 of which the same
sibling(S, S2) :-
    parent(Father, S),
    parent(Father, S2),
    male(Father),
    parent(Mother, S),
    parent(Mother, S2),
    female(Mother),
    not(S = S2).

%Searches for brother 'B' from siblings of 'X'; must be male
brother(B, X) :-
    sibling(B, X),
    male(B).

%Searches for sister 'S' from siblings of 'X'; must be female
sister(S, X) :-
    sibling(S, X),
    female(S).

%Searches for uncle 'U', by blood/marriage, of 'X'
%Checks for brother of parent, and brother of parent
%of spouse
uncle(U, X) :-
    parent(P, X),
    brother(U, P).
%"..."
uncle(U, X) :-
    spouse(S, X),
    parent(P, S),
    brother(U, P).

%Searches for aunt 'A', by blood/marriage, of 'X'
%Checks for sister of parent, and sister of parent
%of spouse
aunt(A, X) :-
    parent(P, X),
    sister(A, P).
%"..."
aunt(A, X) :-
    spouse(S, X),
    parent(P, S),
    sister(A, P).

%Searches for the parent of the parent,'GP', of 'X'
grandparent(GP, X) :-
    parent(P, X),
    parent(GP, P).

%Searches for grandfather 'GF' of 'X'; must be male
grandfather(GF, X) :-
    grandparent(GF, X),
    male(GF).

%Searches for grandmother 'GM' of 'X'; must be female
grandmother(GM, X) :-
    grandparent(GM, X),
    female(GM).

%Searches for grandchild 'GC' of X by checking the children
%of the children of 'X'
grandchild(GC, X) :-
    child(GC, P),
    child(P, X).

%Searches for parent, grandparent, etc. of 'A'
ancestor(A, X) :-
    parent(A, X).
%"..."
ancestor(A, X) :-
    parent(P, X),
    ancestor(A, P).

%Searches for children, grandchildren, etc. of 'D'
descendant(D, X) :-
    child(D, X).
%"..."
descendant(D, X) :-
    child(C, X),
    descendant(D, C).

%Measures lifespan of 'Person' by subtracting 'Birth'
%from 'Death'
%Else, if no died(Person, Death) exists, then use
%current year: '2018', to subtract with
lifespan(Person, Years) :-
    died(Person, Death),
    born(Person, Birth),
    Years is Death - Birth.
%"..."
lifespan(Person, Years) :-
    born(Person, Birth),
    StillLiving = 2018,
    Years is StillLiving - Birth.

%Checks if 'X' person lived less years than 'Y' person
older(X, Y) :-
    lifespan(X, Xyears),
    lifespan(Y, Yyears),
    (Xyears > Yyears
    ->  true
    ;   false).

%Checks if 'X' person lived less years than 'Y' person
younger(X, Y) :-
    lifespan(X, Xyears),
    lifespan(Y, Yyears),
    (Xyears < Yyears
    ->  true
    ;   false).

%Checks if 'Person' was born (therefore lived) between years
%'Ruler' reigned of 'Start' year and 'End' year
regentWhenBorn(Ruler, Person) :-
    reigned(Ruler, Start, End),
    born(Person, Birth),
    lessThanOrEqual(Start, Birth),
    lessThanOrEqual(Birth, End),
    not(Ruler = Person).

%Checks if 'X' is less than or equal to 'Y'
lessThanOrEqual(X, Y) :-
    (X =< Y
    ->  true
    ;   false).

%Searches for 'Cousin' of 'Person' by checking for siblings
%that both had children
cousin(Cousin, Person) :-
    sibling(X, Y),
    parent(X, Cousin),
    parent(Y, Person),
    not(Cousin = Person).

%Websites Used:
% 1)https://stackoverflow.com/questions/23392395/prolog-compare-two-numbers?rq=1
% 2)https://stackoverflow.com/questions/16076401/prolog-or-operator-for-rule-statments
% 3)http://www.swi-prolog.org/pldoc/man?section=clpb-exprs
%
