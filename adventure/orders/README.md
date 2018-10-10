# Customer Order Records

?- customer(X, Y, aaa).
X = jim,
Y = dublin ;
X = sandra,
Y = london ;
X = samantha,
Y = 'new york'.

?- customer(jim, _, aaa)?
|    .
ERROR: Syntax error: Unbalanced operator
ERROR: customer(jim, _, aaa)?
ERROR: ** here **
ERROR:  . 
?- customer(jim, _, aaa).
true ;
false.

?- customer(jim, _, bbb).
false.

?- customer(jim, _, bbb).
false.

?- customer(X, dublin, aaa).
X = jim.

?- customer(X, london, aaa).
X = sandra ;
false.

?- item(_, book, X).
X = 80.

?- item(_, book, ReorderQty).
ReorderQty = 80.

?- item(Num, book, _).
Num = 1.

?- item(Num, record, _).
Num = 2.

?- stock(1, Stock).
Stock = 120.
