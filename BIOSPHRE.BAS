' Variables:    Name
'               Creature ID
'               MAP Position
'               Head
'               Body
'               Wheels
'               Eyes
'               Distance Travelled
'               Food Eaten
'               Energy Expended
'               Creatures Killed
'               CYBERSEX
'               Children Amount
'               Activity
'               Action
'               Days Alive
 
hsex = 2 '(2/3)
csex = 2 '(High = More sex)
 
CLS : RANDOMIZE TIMER
DIM NAME$(100, 2)       'ID, (Name, Carnivore/Herbivore)
DIM Map(80, 20)         '(X,Y)
DIM Creature(100, 4)    'ID, (Head, Body, Wheels, Eyes)
DIM Stats(100, 6)       'ID, (Distance,Food,Energy,Killed,SEX,Children)
DIM Activity(100, 2)    'ID, (Activity,Action)
DIM Days(100, 1)            'ID, (Days Alive)
    TotalDays = 0
DIM Location(100, 2)    'ID, (X,Y)
DIM OldLocation(100, 2)
 
COLOR 14, 12
LOCATE 1, 1: PRINT SPACE$(80)
LOCATE 1, 34: PRINT "TECHNOSPHERE"
COLOR 15, 0
 
FOR a = 1 TO 100
x = (INT(RND * 80) + 1)
y = (INT(RND * 20) + 1)
Map(x, y) = a
Location(a, 1) = x
Location(a, 2) = y
NAME$(a, 1) = "nameless"
IF INT(RND * 6) = 0 THEN S$ = "C" ELSE S$ = "H"
NAME$(a, 2) = S$
IF S$ = "H" THEN Stats(a, 2) = 1
NEXT
 
FOR x = 1 TO 80
FOR y = 1 TO 20
IF Map(x, y) > 0 THEN
        LOCATE y + 2, x
        IF NAME$(Map(x, y), 2) = "H" THEN PRINT "O"
        IF NAME$(Map(x, y), 2) = "C" THEN PRINT "*"
        END IF
NEXT
NEXT
 
REM Main Loop ************************************************************
 
DO
TotalDays = TotalDays + 1
FoodCheck = FoodCheck + 1
        ERASE Map
        FOR a = 1 TO 100        'Movement Loop
        IF NAME$(a, 2) = "DEAD" THEN
                LOCATE Location(a, 2), Location(a, 1)
                COLOR 14
                PRINT "#"
                COLOR 15
                GOTO 200
                END IF
        OldLocation(a, 1) = Location(a, 1)
        OldLocation(a, 2) = Location(a, 2)
        IF NAME$(a, 2) <> "C" THEN                              'Sexy Loop (H)
                RANDY = INT(RND * 20)
                IF RANDY < hsex THEN
                FOR b = 1 TO 100
                IF NAME$(b, 2) = "H" THEN EXIT FOR
                NEXT
                IF Location(b, 1) > Location(a, 1) THEN Location(a, 1) = Location(a, 1) + 1
                IF Location(b, 1) < Location(a, 1) THEN Location(a, 1) = Location(a, 1) - 1
                IF Location(b, 2) > Location(a, 2) THEN Location(a, 2) = Location(a, 2) + 1
                IF Location(b, 2) < Location(a, 2) THEN Location(a, 2) = Location(a, 2) - 1
                END IF
                IF RANDY >= hsex THEN
                Location(a, 1) = Location(a, 1) + INT(RND * 3) - 1
                Location(a, 2) = Location(a, 2) + INT(RND * 3) - 1
                END IF
        END IF
        IF NAME$(a, 2) = "C" THEN
                RANDY = INT(RND * 20)
                IF RANDY < csex THEN                       'Sexy Loop (C)
                FOR b = 1 TO 100
                IF NAME$(b, 2) = "C" THEN EXIT FOR
                NEXT
                IF Location(b, 1) > Location(a, 1) THEN Location(a, 1) = Location(a, 1) + 1
                IF Location(b, 1) < Location(a, 1) THEN Location(a, 1) = Location(a, 1) - 1
                IF Location(b, 2) > Location(a, 2) THEN Location(a, 2) = Location(a, 2) + 1
                IF Location(b, 2) < Location(a, 2) THEN Location(a, 2) = Location(a, 2) - 1
                END IF
                IF RANDY >= csex THEN                      'Hungry Loop (C)
                        hunt = INT(RND * 10)
                        IF hunt < 2 THEN
                        FOR b = 1 TO 100
                        IF NAME$(b, 2) = "H" THEN EXIT FOR
                        NEXT
                        IF Location(b, 1) > Location(a, 1) THEN Location(a, 1) = Location(a, 1) + 1
                        IF Location(b, 1) < Location(a, 1) THEN Location(a, 1) = Location(a, 1) - 1
                        IF Location(b, 2) > Location(a, 2) THEN Location(a, 2) = Location(a, 2) + 1
                        IF Location(b, 2) < Location(a, 2) THEN Location(a, 2) = Location(a, 2) - 1
                        END IF
                        IF hunt >= 2 THEN
                        Location(a, 1) = Location(a, 1) + INT(RND * 3) - 1
                        Location(a, 2) = Location(a, 2) + INT(RND * 3) - 1
                        END IF
                END IF
        END IF
        IF Location(a, 1) > 80 THEN Location(a, 1) = 80
        IF Location(a, 2) > 20 THEN Location(a, 2) = 20
        IF Location(a, 1) <= 1 THEN Location(a, 1) = 1
        IF Location(a, 2) <= 1 THEN Location(a, 2) = 1
        x = Location(a, 1)
        y = Location(a, 2)
        IF Map(x, y) <> a AND Map(x, y) <> 0 THEN
                                IF NAME$(Map(x, y), 2) = "H" AND NAME$(a, 2) = "C" THEN
                                NAME$(Map(x, y), 2) = "DEAD"
                                Stats(a, 2) = Stats(a, 2) + 1
                                END IF
                                IF NAME$(Map(x, y), 2) = "C" AND NAME$(a, 2) = "C" THEN
                                        IF Stats(a, 2) > Stats(a, 6) THEN
                                        Stats(a, 6) = Stats(a, 6) + 1
                                        FOR b = 1 TO 100
                                        IF NAME$(b, 2) = "DEAD" THEN NAME$(b, 2) = "C": EXIT FOR
                                        IF NAME$(b, 2) = "" THEN NAME$(b, 2) = "C": EXIT FOR
                                        NEXT
                                        END IF
                                END IF
                                IF NAME$(Map(x, y), 2) = "H" AND NAME$(a, 2) = "H" THEN
                                        IF Stats(a, 2) > Stats(a, 6) THEN
                                        Stats(a, 6) = Stats(a, 6) + 1
                                        FOR b = 1 TO 100
                                        IF NAME$(b, 2) = "DEAD" THEN NAME$(b, 2) = "H": EXIT FOR
                                        IF NAME$(b, 2) = "" THEN NAME$(b, 2) = "H": EXIT FOR
                                        NEXT
                                        END IF
                                END IF
                                IF NAME$(Map(x, y), 2) = "DEAD" AND NAME$(a, 2) = "H" THEN
                                Stats(a, 2) = Stats(a, 2) + 1
                                NAME$(Map(x, y), 2) = ""
                                END IF
                                IF NAME$(Map(x, y), 2) = "DEAD" AND NAME$(a, 2) = "C" THEN
                                Stats(a, 2) = Stats(a, 2) + 1
                                NAME$(Map(x, y), 2) = ""
                                END IF
        END IF
        Map(x, y) = a
        LOCATE OldLocation(a, 2) + 2, OldLocation(a, 1): PRINT " "
        LOCATE y + 2, x
        IF NAME$(a, 2) = "H" THEN COLOR 15: PRINT "O"
        IF NAME$(a, 2) = "C" THEN COLOR 13: PRINT "*"
        IF NAME$(a, 2) = "DEAD" THEN COLOR 14: PRINT "#": COLOR 15
200     NEXT a
C = 0
H = 0
D = 0
F = 0
FOR a = 1 TO 100
IF NAME$(a, 2) = "C" THEN C = C + 1
IF NAME$(a, 2) = "H" THEN H = H + 1
IF NAME$(a, 2) = "DEAD" THEN D = D + 1
IF NAME$(a, 2) = "" THEN F = F + 1
NEXT
 
IF FoodCheck > 7 THEN
        FoodCheck = 0
        FOR a = 1 TO 100
        IF NAME$(a, 2) = "C" THEN
        IF Stats(a, 6) >= Stats(a, 2) THEN NAME$(a, 2) = "DEAD"
        END IF
        NEXT a
        END IF
 
COLOR 14, 12
LOCATE 1, 1: PRINT SPACE$(80)
LOCATE 1, 34: PRINT "TECHNOSPHERE"
COLOR 15, 0
 
LOCATE 23, 1: PRINT "Days"; TotalDays
LOCATE 23, 16: PRINT "C/vore(*) "; C
LOCATE 23, 31: PRINT "H/vore(O) "; H
LOCATE 23, 47: PRINT "Dead(#) "; D
LOCATE 23, 60: PRINT "Free "; F
LOCATE 23, 70: PRINT "Total "; C + H + D + F
       
IF F > 10 THEN
        FOR a = 1 TO 100
        IF NAME$(a, 2) = "" AND F > 0 THEN NAME$(a, 2) = "H": F = F - 1
        NEXT a
END IF
 
IF D > 10 THEN
        FOR a = 1 TO 100
        IF NAME$(a, 2) = "DEAD" AND D > 0 THEN NAME$(a, 2) = "H": D = D - 1
        NEXT a
END IF
 
 
LOOP UNTIL INKEY$ = CHR$(27)
 
 
REM **********************************************************************
 
END