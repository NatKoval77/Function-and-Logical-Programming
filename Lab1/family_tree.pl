man(vasya).
man(vanya).
man(venya).
man(vlad).
man(denis).
man(danil).
man(dima).
man(david).
man(dack).

woman(anna).
woman(asya).
woman(alla).
woman(arfa).
woman(zoya).
woman(zara).
woman(zlata).
woman(zita).
woman(zula).

% (родитель, ребенок)
parent(vasya,vanya).
parent(vasya,venya).
parent(vasya,vlad).

parent(anna,asya).
parent(anna,alla).
parent(anna,arfa).

parent(vanya,denis).
parent(vanya,zoya).
parent(asya,denis).
parent(asya,zoya).

parent(venya,danil).
parent(venya,zara).
parent(alla,danil).
parent(alla,zara).

parent(vlad,dima).
parent(vlad,zlata).
parent(arfa,dima).
parent(arfa,zlata).

% First task
men():- man(M_name), print(M_name), nl, fail.
women():- woman(W_name), print(W_name), nl, fail.
% children(+P_name)
children(P_name):- parent(P_name, Ch_name), print(Ch_name), nl, fail.

% mother(+W_name, +Ch_name)
mother(W_name,Ch_name):- woman(W_name), parent(W_name,Ch_name).
% mother(+Ch_name)
mother(Ch_name):- mother(Mt_name,Ch_name), print(Mt_name), nl, fail.

% brother(+Bt_name, +Ch_name)
brother(Bt_name,Ch_name):- man(Bt_name), parent(P_name,Bt_name), parent(P_name,Ch_name), Bt_name \= Ch_name.
% brothers(+Ch_name)
brothers(Ch_name):- brother(Bt_name,Ch_name), print(Bt_name), nl, fail.

% br_sis(+Ch_name1, +Ch_name2)
br_sis(Ch_name1,Ch_name2):- parent(P_name,Ch_name1), parent(P_name,Ch_name2), Ch_name1 \= Ch_name2.
% b_s(+Ch_name1, +Ch_name2)
b_s(Ch_name1):- br_sis(Ch_name1, Ch_name2), print(Ch_name2), nl, fail.

