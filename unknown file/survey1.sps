DATA LIST
  FILE='survey1.dat' FIXED RECORDS=1 TABLE /1
  person 1-3 sex 5(A) age 8-9 marstat 11(A) nkids 14 income 17-21
  height 23-25(1) sheight 27-29(1).
EXECUTE.

SAVE OUTFILE='survey1.sav'
 /COMPRESSED.

MISSING VALUES sex ("X").
MISSING VALUES age (99).
MISSING VALUES nkids (9).
MISSING VALUES income (99999).
MISSING VALUES height (99.9).
MISSING VALUES sheight (99.8, 99.9).

FREQUENCIES
 VARIABLES=marstat sex nkids.

DESCRIPTIVES
 VARIABLES=age height income nkids sheight
 /FORMAT=LABELS NOINDEX
 /STATISTICS=MEAN STDDEV MIN MAX
 /SORT=MEAN (A).

SAVE OUTFILE='survey1.sav'
 /COMPRESSED.

VARIABLE LABELS marstat "Marital status".
VALUE LABELS marstat
 "W" "Widowed"
 "D" "Divorced"
 "M" "Married"
 "S" "Single".

FREQUENCIES
 VARIABLES=marstat.

SAVE OUTFILE='survey1.sav' /COMPRESSED.

COMPUTE mheight = height * 2.54.
VARIABLE LABELS mheight 'Height in cm'.
EXECUTE.

COMPUTE smheight = sheight * 2.54.
VARIABLE LABELS smheight "Spouse's height in cm".
EXECUTE.

SAVE OUTFILE='survey1.sav' /COMPRESSED.

COMPUTE meanht = mean.1(height,  sheight).
VARIABLE LABELS meanht 'mean height'.
EXECUTE.

SAVE OUTFILE='survey1.sav' /COMPRESSED.

IF (marstat='M' & nkids>0) status = 1.
VARIABLE LABELS status 'family status'.
EXECUTE.
IF (marstat='M' & nkids=0) status = 2.
EXECUTE.
IF (marstat ~='M' & nkids>0) status = 3.
EXECUTE.
IF (marstat ~='M' & nkids=0) status = 4.
EXECUTE.

VALUE LABELS status
 1 "Married with children"
 2 "Married with no children"
 3 "Not married with children"
 4 "Not married with no children".

SAVE OUTFILE='survey1.sav' /COMPRESSED.

RECODE
 income
 (0=0)  (1 thru 5000=1)  (5001 thru 10000=2)  (10001 thru 20000=3)
 (20001 thru 30000=4)  (30001 thru Highest=5)  INTO  incomcat .
VARIABLE LABELS incomcat 'Income category'.
EXECUTE.

VALUE LABELS incomcat
 1 "1 to 5000"
 2 "5001 to 10000"
 3 "10001 to 20000"
 4 "20001 to 30000"
 5 "above 30001".

FREQUENCIES
 VARIABLES=incomcat
 /STATISTICS=MEAN.

DO IF (sex = 'M').
RECODE
 height
 (72 thru Highest=1)  (ELSE=0) INTO tall.
END IF.
VARIABLE LABELS tall 'code for tall'.
EXECUTE.
DO IF (sex = 'F').
RECODE
 height
 (68 thru Highest=1)  (ELSE=0)  INTO  tall.
END IF.
EXECUTE.

LIST
 VARIABLES=sex height tall
 /CASES= BY 1
 /FORMAT=  WRAP  UNNUMBERED.

