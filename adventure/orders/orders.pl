customer(jim, dublin, aaa).
customer(mary, chicago, bbb).
customer(sandra, london, aaa).
customer(jeffrey, birmingham, bbb).
customer(maurice, london, ccc).
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

good_customer(Customer) :-
    customer(Customer, _, aaa);
    customer(Customer, _, bbb).

order_valid(Customer, ItemName, ReqQty) :-
    good_customer(Customer),
    item_quantity(ItemName, StockQty),
    X is StockQty - ReqQty,
    X > 0.

restock_message(StockLevel, RestockPoint, Message) :-
    StockLevel > RestockPoint,
    Message = 'Restock not needed'.

restock_message(StockLevel, RestockPoint, Message) :-
    RestockPoint >= StockLevel,
    Message = 'Restock Needed'.

item_needs_restock(ItemName) :-
    item(ItemNum, ItemName, RestockPoint),
    stock(ItemNum, StockLevel),
    restock_message(StockLevel, RestockPoint, Message),
    write(ItemName), write(' - '), write(Message).


items_needing_restock :-
    item(_, ItemName, _),
    item_needs_restock(ItemName),
    nl,
    fail.
items_needing_restock.
