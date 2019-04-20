%% A Rule Validator that ensures rules are written in the
%% following format:
%% rule_name: object attribute operator value

%% Current validates lists of strings
%% e.g. ["admin_feature", "person", "role" "equals" "admin"]

%% Accepted values are:
%% rule_name: *_feature
%% object: [Person|Account]
%% attribute: [role|type]
%% operator: [equals|is_not]
%% value: [admin|premium]
%% admin_feature person role equals admin.
%% premium_feature account type equals premium.
feature_name([Name|X]-X) :-
    sub_string(Name, _, _, 0, "_feature").

%% feature_name(["admin_feature"|X]-X).
object(["person"|X]-X).
object(["account"|X]-X).

attribute(["role"|X]-X).
attribute(["type"|X]-X).

operator(["equals"|X]-X).
operator(["is_not"|X]-X).

value(["admin"|X]-X).
value(["staff"|X]-X).
value(["standard"|X]-X).
value(["premium"|X]-X).

lookup(ObjAttr-ObjAttr1) :-
    object(ObjAttr-S1), attribute(S1-ObjAttr1).

check(OperatorValue-OperatorValue1) :-
    operator(OperatorValue-S1), value(S1-OperatorValue1).

body(Body-Body1) :-
    lookup(Body-S1), check(S1-Body1).

rule_definition(DefStr) :-
    feature_name(DefStr-DefStr1), body(DefStr1-[]).
