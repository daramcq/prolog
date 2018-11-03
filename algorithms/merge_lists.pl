merged_lists([], [], MergeList, FinalList) :-
    FinalList = MergeList.

merged_lists([H1|T1], [H2|T2], MergeList, FinalList) :-
    H1 < H2,
    merged_lists(T1, [H2|T2], [H1|MergeList], FinalList).

merged_lists([H1|T1], [H2|T2], MergeList, FinalList) :-
    H2 < H1,
    merged_lists([H1|T1], T2, [H2|MergeList], FinalList).

merged_lists([H|T], [], MergeList, FinalList) :-
    merged_lists(T, [], [H|MergeList], FinalList).

merged_lists([], [H|T], MergeList, FinalList) :-
    merged_lists([], T, [H|MergeList], FinalList).

merged_lists([T1], [T2], MergeList, FinalList) :-
    T1 < T2,
    merged_lists([], T2, [T1|MergeList], FinalList).

merged_lists([T1], [T2], MergeList, FinalList) :-
    T2 < T1,
    merged_lists(T1, [], [T2|MergeList], FinalList).

merged_lists([T], [], MergeList, _) :-
    merged_lists([], [], [T|MergeList], [T|MergeList]).

merged_lists([], [T], MergeList, _) :-
    merged_lists([], [], [T|MergeList], [T|MergeList]).
