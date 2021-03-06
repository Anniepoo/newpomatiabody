:- use_module(library(clpr)).


engineer(X) :-
    X = [MassWOBattery,
         BatteryMass,
         TotalMass,
         G,
         CoeffRollingFric,
        WheelRad,
        Weight,
        RulingGrade,
        RollingResistance,
        LiftResistance,
        Resistance,
        StallTorque,
        RollerRadius, % mm
        LevelSpeed,  % min top level speed  mm/sec
        AvailTractiveEffort
        ],
    MassWOBattery = 12.0,  % mass of the robot without the battery installed
    { TotalMass =:= BatteryMass + MassWOBattery },
    G = 9.8,   % acceleration due to gravity
    CoeffRollingFric = 2.5,  % mm   converted from m value given on https://www.engineeringtoolbox.com/rolling-friction-resistance-d_1303.html
    { Weight =:= G * TotalMass },
    WheelRad = 112.0, % mm
    { RollingResistance =:= Weight * CoeffRollingFric / WheelRad },
    RulingGrade = 0.1,   % the rise/run of the steepest grade we want to ascend at any speed
    { LiftResistance =:= RulingGrade * Weight },
    { Resistance =:= LiftResistance + RollingResistance },
    StallTorque = 400.0,  % Nt-mm
    LevelSpeed = 2000.0, % mm/sec     design criteria speed on level ground
 %   LevelSpeed is RollerRadius * 2.0 * pi * 4000.0 / 200.0,
 % the roller must be at least this diameter to acheive the design speed
    RollerRadius is LevelSpeed / 2.0 / pi / 4000.0 * 200.0,
    { AvailTractiveEffort =:= 2.0 * StallTorque / RollerRadius }, % two motors!
    BatteryMass  = 10.0.

wre(X) :-
    format(
'MassWOBattery: ~w Kg~n\
BatteryMass: ~w Kg~n\
TotalMass: ~w Kg~n\
G: ~w m/sec^2~n\
CoeffRollingFric ~w\n\
Wheel Radius: ~w mm\n\
Weight: ~w Nt\n\
Ruling grade: ~w \n\
Rolling resistance: ~w Nt~n\
LiftResistance: ~w Nt~n\
Resistance: ~w\n\
StallTorque: ~w Nt-mm~n\
RollerRadius ~w mm~n\
LevelSpeed ~w mm/sec~n\
AvailableTE ~w Nt\n', X).





