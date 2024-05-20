% max3(+Fr, +Sc, +Th, -Fr) - максимальное из 3 чисел
max3(Fr, Sc, Th, Fr):- Fr > Sc, Fr > Th, !.
max3(_, Sc, Th, Sc):- Sc > Th, !.
max3(_, _, Th, Th).


% fact(+N, -F) - факториал вверх
fact(0, 1):- !.
fact(N, F):- NPrev is N-1, fact(NPrev, FPrev), F is N * FPrev.

% fact_t(+N, -F) - факториал вниз
fact_t(N, F):- fact_tail(0, 1, N, F).
fact_tail(N, F, N, F):- !.
fact_tail(N, _, N, _):- !, fail.
fact_tail(I, C, N, F):- Iter is I + 1, CurF is C * Iter, fact_tail(Iter, CurF, N, F).


% sum_dig(+D, -S) - сумма цифр вверх
sum_dig(0, 0):- !.
sum_dig(D, S):- Dig is D // 10, Rem is D mod 10, sum_dig(Dig, Sum), S is Sum + Rem.

% sum_dig_t(+D, -S) - сумма цифр вниз
sum_dig_t(D, Sum):- sum_dig_tail(D, 0, Sum).
sum_dig_tail(0, Sum, Sum):- !.
sum_dig_tail(D, C, Sum):- Dig is D // 10, Rem is D mod 10, CurS is C + Rem, sum_dig_tail(Dig, CurS, Sum).


% divider(+Number, -AllDiv) - список делителей
divider(Number, AllDiv):- divider_t(Number, Number, [], AllDiv).
divider_t(_, 1, Divs, Divs):- !.
divider_t(Number, Divisor, Divs, AllDiv):- Divisor > 1, Remains is Number mod Divisor, 
    ( Remains =:= 0 -> PreDivisor is Divisor - 1, 
        divider_t(Number, PreDivisor, [Divisor|Divs], AllDiv);
        PreDivisor is Divisor - 1, divider_t(Number, PreDivisor, Divs, AllDiv) ).

% square(-Sq) - проверка на квадрат
square(Sq) :-
    Sq >= 1,
    N is integer(sqrt(Sq)),
    N*N =:= Sq.

% square_free(-Number) - проверка свободное ли от квадратов число
square_free(Number) :-
    Number >= 1, 
    divider(Number, AllDiv),
    ( member(S, AllDiv), square(S) -> fail; true ).


%read_list(+N,-List) - чтение с клавиатуры
read_list(0,[]):-!.
read_list(N,[Head|Tail]) :- read(Head), NewN is N - 1,
    read_list(NewN,Tail).

%write_list(+List) - вывод на экран
write_list([]) :- !.
write_list([H|T]) :- write(H), nl, write_list(T).


%sum_list_down(+List, -Sum) - сумма списка вниз
sum_list_down(List,Sum) :- sum_list_down(List,0,Sum).
sum_list_down([],CurSum,CurSum):-!.
sum_list_down([H|T],CurSum,Sum) :- NewSum is CurSum + H, sum_list_down(T,NewSum,Sum).


%read_sum_write(+C) - сумма списка на экран
read_sum_write(N):- read_list(N, List),
sum_list_down(List, Sum),
write(Sum).


%sum_list_up(+List,-Sum) - сумма списка вверх
sum_list_up([],0):-!.
sum_list_up([H|T],Sum) :- sum_list_up(T,SumTail), Sum is SumTail + H.


% remove_items(+DigitSum, +ListIn, -ListOut) - удаляет элементы сумма цифр которых задана
remove_items(_, [], []) :- !.
remove_items(DigitSum, [HeadIn|TailIn], ListOut) :- sum_dig_t(HeadIn, HeadInSum), HeadInSum == DigitSum, remove_items(DigitSum, TailIn, ListOut).
remove_items(DigitSum, [HeadIn|TailIn], [HeadIn|TailOut]) :- sum_dig_t(HeadIn, HeadInSum), HeadInSum =\= DigitSum, remove_items(DigitSum, TailIn, TailOut).

% rem_it_print(+DigitSum, +List) - выводит результат на экран
rem_it_print(DigitSum, List) :- remove_items(DigitSum, List, Result), write_list(Result).

% consult("comb_recursion.pl").