%Facts
age(Person, Age) :-
Person = [_, Age, _, _].

gender(Person, Gender) :-
Person = [Gender, _, _, _].

height(Person, Height) :-
Person = [_, _, Height, _].

weight(Person, Weight) :-
Person = [_, _, _, Weight].

%Rules
%Ideal weight based on height and gender
ideal_weight(Person, IdealWeight) :- height(Person, Height), gender(Person, Gender), IdealBMI is Height * Height * 22 / 10000, IdealWeight is round(IdealBMI).

%Calories to be consumed per day based on age, height, gender, and weight
calories_per_day(Person, Calories) :- age(Person, Age), height(Person, Height), weight(Person, Weight), gender(Person, Gender),
(Gender = male -> (BMR is 88.36 + (13.4 * Weight) + (4.8 * Height) - (5.7 * Age));
BMR is 447.6 + (9.25 * Weight) + (3.1 * Height) - (4.33 * Age)),
Calories is round(BMR * 1.2).

%Check if weight is ideal or not
check_weight(Person, Message) :- weight(Person, Weight), ideal_weight(Person, IdealWeight),
(Weight < IdealWeight -> Message = "You are underweight.";
Weight > IdealWeight -> Message = "You are overweight.";
Message = "You have an ideal weight.").

%Main Program
diet_plan(Person, Message, IdealWeight, Calories) :- check_weight(Person, Message), ideal_weight(Person, IdealWeight), calories_per_day(Person, Calories).

diet_plan([Male, Age, Height, Weight], Message, IdealWeight, Calories) :-
gender(Person, Male),
age(Person, Age),
height(Person, Height),
weight(Person, Weight),
check_weight(Person, Message),
ideal_weight(Person, IdealWeight),
calories_per_day(Person, Calories).
