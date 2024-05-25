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

% square(+Sq) - проверка на квадрат
square(Sq) :-
    Sq >= 1,
    N is integer(sqrt(Sq)),
    N*N =:= Sq.

% square_free(+Number) - проверка свободное ли от квадратов число
square_free(Number) :-
    Number >= 1, 
    divider(Number, AllDiv),
    ( member(S, AllDiv), square(S) -> fail; true ).


%read_list(+N,-List) - чтение списка с клавиатуры
read_list(0,[]):-!.
read_list(N,[Head|Tail]) :- read(Head), NewN is N - 1,
    read_list(NewN,Tail).

%write_list(+List) - вывод списка на экран
write_list([]) :- !.
write_list([H|T]) :- write(H), nl, write_list(T).


%sum_list_down(+List, -Sum) - сумма списка вниз
sum_list_down(List,Sum) :- sum_list_down(List,0,Sum).
sum_list_down([],CurSum,CurSum):-!.
sum_list_down([H|T],CurSum,Sum) :- NewSum is CurSum + H, sum_list_down(T,NewSum,Sum).


%read_sum_write(+N) - сумма списка на экран
read_sum_write(N):- read_list(N, List),
sum_list_down(List, Sum), write('Entered list: '), nl,
write_list(List), write('Sum of the list items: '), write(Sum).


%sum_list_up(+List,-Sum) - сумма списка вверх
sum_list_up([],0):-!.
sum_list_up([H|T],Sum) :- sum_list_up(T,SumTail), Sum is SumTail + H.


% remove_items(+DigitSum, +ListIn, -ListOut) - удаляет элементы сумма цифр которых задана
remove_items(_, [], []) :- !.
remove_items(DigitSum, [HeadIn|TailIn], ListOut) :- sum_dig_t(HeadIn, HeadInSum), HeadInSum == DigitSum, remove_items(DigitSum, TailIn, ListOut).
remove_items(DigitSum, [HeadIn|TailIn], [HeadIn|TailOut]) :- sum_dig_t(HeadIn, HeadInSum), HeadInSum =\= DigitSum, remove_items(DigitSum, TailIn, TailOut).

% rem_it_print(+DigitSum, +List) - выводит результат на экран
rem_it_print(DigitSum, List) :- remove_items(DigitSum, List, Result), write_list(Result).

% TASK 2

% min_digit(+Number, -MinDigit) - минимальная цифра числа вверх 
min_digit(0, 9) :- !. 
min_digit(Number, MinDigit) :- NextNumber is Number div 10, min_digit(NextNumber, DigitNext), 
    DigitLast is Number mod 10, 
    ((DigitLast < DigitNext) -> MinDigit is DigitLast; 
    MinDigit is DigitNext). 

% min_digit_t(+Number, -MinDigit) - минимальная цифра числа вниз 
min_digit_t(Number, MinDigit) :- min_digit_tail(Number, 9, MinDigit). 
min_digit_tail(0, MinDigit, MinDigit) :- !. 
min_digit_tail(Number, Dig, MinDigit) :- DigitLast is Number mod 10, 
    ((DigitLast < Dig) -> NextDig is DigitLast; NextDig is Dig), 
    NumberNext is Number div 10, 
    min_digit_tail(NumberNext, NextDig, MinDigit). 

 
% count_less3(+Number, -Count) - количество цифр числа, меньших 3, вверх  
count_less3(0,0):- !.
count_less3(Number, Count):- NextNumber is Number div 10,
  count_less3(NextNumber, NextCount),
  DigitLast is Number mod 10,
  ( (DigitLast < 3) -> Count is NextCount + 1; Count is NextCount).

% count_less3_t(+Number, -Count) - количество цифр числа, меньших 3, вниз 
count_less3_t(Number, Count) :- count_less3_tail(Number, 0, Count). 
count_less3_tail(0, Count, Count) :- !. 
count_less3_tail(Number, Btw, Count) :- 
  DigitLast is Number mod 10, 
  ( (DigitLast < 3) -> NewBtw is Btw + 1; NewBtw is Btw), 
  NextNumber is Number div 10, 
  count_less3_tail(NextNumber, NewBtw, Count). 
 
 
% count_div(+Number, -Count) - количество делителей вверх 
count_div(Number, Count) :- count_div_(Number, 1, Count). 
count_div_(Number, Number, 1) :- !. 
count_div_(Number, Div, Count) :- DivPlus is Div + 1,
  count_div_(Number, DivPlus, CountNext), 
  Rem is Number mod Div, 
  ( (Rem =:= 0) -> Count is CountNext + 1; 
  Count is CountNext). 
 
% count_div_t(+Number, -Count) - количество делителей вниз 
count_div_t(Number, Count) :- count_div_tail(Number, Count, 1, 1). 
count_div_tail(Number, CurCount, Number, CurCount) :- !. 
count_div_tail(Number, Count, CurDel, CurCount) :- 
  Rem is Number mod CurDel, 
  ((Rem =:= 0) -> NextCount is CurCount + 1; 
  NextCount is CurCount), NextDel is CurDel + 1,
  count_div_tail(Number, Count, NextDel, NextCount).


% TASK 3

% Дан массив. Осуществить сдвиг элементов <- на 3 позиции.

% left3(+List, -NList) - выполняет циклический сдвиг на 3 элемента влево
left3([], _):- !, fail.
left3([H1,H2,H3|T], ResList) :- length([H1,H2,H3|T], Count), (Count > 3 -> append(T, [H1,H2,H3], ResList); write_list([H1,H2,H3|T]), fail).


% Дан массив. Осуществить сдвиг элементов -> на 1 позицию.

% right(+InputList, -ResList) - предикат, отвечающий за основную логику работы. Выполняет циклический сдвиг на 1 элемент вправо
right(InputList, ResList) :- append(T, [H], InputList), append([H], T, ResList), !.


% Дан массив. Проверить, чередуются ли в нем +- числа.

% check(+List) - предикат, отвечающий за основную логику работы. Выполняет проверку чередования положительных и отрицательных элементов в массиве
check([H1,H2|T]) :- ( ((H1 < 0, H2 > 0); (H1 > 0, H2 < 0)) -> (T == [] -> !; append([H2], T, CurList), check(CurList)); fail).


% TASK 4

% Три друга заняли 1, 2, 3 места в соревнованиях универсиады.
% Друзья разной национальности, зовут по-разному, любят разные виды спорта.
% Майкл предпочитает баскетбол и играет лучше, чем американец.
% Израильтянин Саймон играет лучше теннисиста. Игрок в крикет занял первое место.
% Кто является австралийцем? Каким спортом увлекается Ричард?

in_list([El|_],El).
in_list([_|T],El):-in_list(T,El).

pr_friends:- 

    Competitive=[_, _, _, _],

    in_list(Competitive,[michael, basketball, better, _]),
    in_list(Competitive,[simon, _, _, israel]),
    in_list(Competitive,[_, _, _, australian]),
    in_list(Competitive,[richard, _, _, _]),
    in_list(Competitive,[_, cricket, best, _]),
    in_list(Competitive,[_, tennis, _, _]),
    in_list(Competitive,[_, _, _, american]),
    in_list(Competitive,[_, _, worst, _]),


    write(Competitive), !, fail.

% consult("recursion_up_tail.pl").