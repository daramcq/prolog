customer(jim, dublin, aaa).
customer(mary, chicago, bbb).
customer(sandra, london, aaa).
customer(jeffrey, birmingham, bbb).
customer(maurice, london, bbb).
customer(samantha, 'new york', aaa).

item(1, book, 80).
item(2, record, 20).
item(3, table, 50).

stock(1, 120).
stock(2, 40).
stock(3, 45).
        
item_quantity(ItemName, Qty) :-
    item(ItemNumber, ItemName, _),
    stock(ItemNumber, Qty).

inventory_report :-
    item_quantity(Name, Qty),
    write(Name), write(':'), tab(2), write(Qty),
    nl,
    fail.
inventory_report.
