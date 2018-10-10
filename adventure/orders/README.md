# Customer Order Records
Working through _Adventure in Prolog_'s Customer Order Database. Given the facts in the database, we can write simple queries such as the below.

## Identify Customers with specific credit ratings
```prolog
?- customer(X, Y, aaa).
X = jim,
Y = dublin ;
X = sandra,
Y = london ;
X = samantha,
Y = 'new york'.
```
## Confirm a named customer has a specific rating
```prolog
?- customer(jim, _, aaa).
true ;
false.
```

## Identify customers in a specific city with a specific rating
```prolog
?- customer(X, dublin, aaa).
X = jim.

?- customer(X, london, aaa).
X = sandra ;
false.
```

## Check the restock level for a named product
```prolog
?- item(_, book, ReorderQty).
ReorderQty = 80.
```
## Find the item number for a named product
```prolog
?- item(Num, book, _).
Num = 1.

?- item(Num, record, _).
Num = 2.
```
## Find the stock for a product via item number
```prolog
?- stock(1, Stock).
Stock = 120.
```

## Find the stock for a product via item name
```prolog
?- item(ItemNum, book, _), stock(ItemNum, Stock).
ItemNum = 1,
Stock = 120.
```
