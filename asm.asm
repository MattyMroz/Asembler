W ASEMBLERZE ITERUJEMY OD TYŁU!!!
================================================================================
[Notatki]
ADD  Rx,Ry,Rz    Add:  Rz ← Rx+Ry        |Dodaje wartości z rejestrów Rx i Ry, wynik zapisuje w Rz
SUB  Rx,Ry,Rz    Sub:  Rz ← Rx-Ry        |Odejmuje wartość Ry od Rx, wynik zapisuje w Rz
MUL  Rx,Ry,Rz    Mul:  Rz ← Rx*Ry        |Mnoży wartości z rejestrów Rx i Ry, wynik zapisuje w Rz
DIV  Rx,Ry,Rz    Div:  Rz ← Rx/Ry        |Dzieli wartość Rx przez Ry, wynik zapisuje w Rz
ADDI Rx,i,Ry     Add:  Ry ← Rx+i         |Dodaje wartość stałą i do rejestru Rx, wynik zapisuje w Ry
SUBI Rx,i,Ry     Sub:  Ry ← Rx-i         |Odejmuje wartość stałą i od rejestru Rx, wynik zapisuje w Ry
MULI Rx,i,Ry     Mul:  Ry ← Rx*i         |Mnoży rejestr Rx przez wartość stałą i, wynik zapisuje w Ry
DIVI Rx,i,Ry     Div:  Ry ← Rx/i         |Dzieli rejestr Rx przez wartość stałą i, wynik zapisuje w Ry
AND  Rx,Ry,Rz    And:  Rz ← Rx&Ry        |Wykonuje operację logiczną AND na Rx i Ry, wynik zapisuje w Rz
OR   Rx,Ry,Rz    Or :  Rz ← Rx|Ry        |Wykonuje operację logiczną OR na Rx i Ry, wynik zapisuje w Rz
XOR  Rx,Ry,Rz    Xor:  Rz ← Rx^Ry        |Wykonuje operację logiczną XOR na Rx i Ry, wynik zapisuje w Rz
ANDI Rx,i,Ry     And:  Ry ← Rx&i         |Wykonuje operację logiczną AND na Rx i stałej i, wynik zapisuje w Ry
ORI  Rx,i,Ry     Or :  Ry ← Rx|i         |Wykonuje operację logiczną OR na Rx i stałej i, wynik zapisuje w Ry
XORI Rx,i,Ry     Xor:  Ry ← Rx^i         |Wykonuje operację logiczną XOR na Rx i stałej i, wynik zapisuje w Ry
SLL  Rx,Ry,Rz    Shift Left Logical:     |Przesuwa bity Rx w lewo o liczbę pozycji określoną przez Ry, wynik zapisuje w Rz
                 Rz ← Rx<<Ry             |
SRL  Rx,Ry,Rz    Shift Right Logical:    |Przesuwa bity Rx w prawo logicznie o liczbę pozycji określoną przez Ry, wynik zapisuje w Rz
                 Rz ← Rx>>Ry             |
SRA  Rx,Ry,Rz    Shift Right Arithm.:    |Przesuwa bity Rx w prawo arytmetycznie o liczbę pozycji określoną przez Ry, wynik zapisuje w Rz
                 Rz ← Rx>>Ry with sign   |
SLLI Rx,i,Ry     Shift Left Logical:     |Przesuwa bity Rx w lewo o liczbę pozycji określoną przez stałą i, wynik zapisuje w Ry
                 Ry ← Rx<<i              |
SRLI Rx,i,Ry     Shift Right Logical:    |Przesuwa bity Rx w prawo logicznie o liczbę pozycji określoną przez stałą i, wynik zapisuje w Ry
                 Ry ← Rx>>i              |
SRAI Rx,i,Ry     Shift Right Arithm.:    |Przesuwa bity Rx w prawo arytmetycznie o liczbę pozycji określoną przez stałą i, wynik zapisuje w Ry
                 Ry ← Rx>>i with sign    |

Dla wszystkich skoków warunkowych:
BRcc: PC ← label(PC+offset) if condition(cc)==True

BRZ  Rx,label   Branch if Zero           |Skok do etykiety label, jeśli Rx jest równe zero
                : condition Rx = 0       |
BRNZ Rx,label   Branch if Not Zero       |Skok do etykiety label, jeśli Rx nie jest równe zero
                : condition Rx ≠ 0       |
BRGT Rx,label   Branch if Greater Than   |Skok do etykiety label, jeśli Rx jest większe od zera
                : condition Rx > 0       |
BRGE Rx,label   Branch if Grater or Equal|Skok do etykiety label, jeśli Rx jest większe lub równe zero
                : condition Rx ≥ 0       |
BRLT Rx,label   Branch if Less Than      |Skok do etykiety label, jeśli Rx jest mniejsze od zera
                : condition Rx < 0       |
BRLE Rx,label   Branch if Less of Equal  |Skok do etykiety label, jeśli Rx jest mniejsze lub równe zero
                : condition Rx ≤ 0       |

Inne:
NOP             No Operation             |Brak operacji, nie wykonuje żadnej akcji
LIH Rx,i        Load Immediate High:     |Ładuje górne 16 bitów rejestru Rx wartością stałą i
                Rx[31..16] ← i.H         |




================================================================================
================================================================================
! Zapisać breakpoint na adres nastepnej instrunkcji

================================================================================
Silnia n!

      ADDI R0,0x000A,R1     ; ładowanie n=10 do R1
      ADD  R1,R0,R2         ; ładowanie do R2 wartość początkowej (n)
next  SUBI R1,0x0001,R1     ; dekrementacja n (R1 ← R1-1)
      BRZ  R1,halt          ; skok gdy n=0 (koniec obliczeń)
      MUL  R2,R1,R2         ; mnożenie wyniku przez n-1 (R2 ← R2*R1)
      BRZ  R0,next          ; skok bezwarunkowy (następny cykl obliczeń)
halt  BRZ  R0,halt          ; stop

================================================================================
Silnia n! z uwzględnieniem

            ADDI R0,0x000A,R1   ; ładowanie n=10 do R1
            BRZ  R1,zerocase    ; sprawdzenie czy n=0
            ADD  R1,R0,R2       ; ładowanie do R2 wartości początkowej (n)
next        SUBI R1,0x0001,R1   ; dekrementacja n (R1 ← R1-1)
            BRZ  R1,halt        ; skok gdy n=0 (koniec obliczeń)
            MUL  R2,R1,R2       ; mnożenie wyniku przez n-1 (R2 ← R2*R1)
            BRZ  R0,next        ; skok bezwarunkowy (następny cykl obliczeń)
halt        BRZ  R0,halt        ; stop
zerocase    ADDI R0,0x0001,R2   ; jeśli n=0, ustawienie wyniku na 1
            BRZ  R0,halt        ; skok do końca


================================================================================
JAK CZYTAĆ TABLICE???

        ADDI r0, 0, r1      ; Inicjalizacja r1 wartością 0
        LDH r2, 200(r1)     ; Ładuje półsłowo z adresu 200 do rejestru r2

        ADDI r0, 200, r1    ; Ustawia r1 na wartość 200
loop:   SUBI r1, 2, r1      ; Odejmuje 2 od r1 (2 bo półsłowo ma 2 bajty)
        LDH r2, 0(r1)       ; Ładuje półsłowo z adresu r1 do rejestru r2
        BRNZ r1, loop       ; Jeśli r1 != 0, skocz do etykiety loop
halt:   BRZ r0, halt        ; Nieskończona pętla - koniec programu



================================================================================
================================================================================
Lab 1

================================================================================
1. Średnia arytmetyczna

Oblicz średnią arytmetyczną tablicy 16-bitowych (half: 2B) liczb całkowitych w pamięci w zakresie 0x200...0x3FF.
Liczby traktowane są jako unsigned int.
Wynik ma być zwracany w rejestrze R1.
Zmierz czas działania programu przy MemAccTime = 1


        ADDI R0, 0, R1       ; Inicjalizacja R1 (suma) wartością 0
        ADDI R0, 0, R2       ; Inicjalizacja R2 (licznik) wartością 0
        ADDI R0, 0x03FE, R3  ; Ustawienie R3 na koniec tablicy (0x3FE)
        ADDI R0, 0x0200, R4  ; Ustawienie R4 na początek tablicy (0x200)

loop:   LDH R5, 0(R3)        ; Ładuje półsłowo z adresu R3 do rejestru R5
        ADD R1, R5, R1       ; Dodaje wartość do sumy (R1 = R1 + R5)
        ADDI R2, 1, R2       ; Zwiększa licznik o 1 (R2 = R2 + 1)

        SUBI R3, 2, R3       ; Przejście do poprzedniego elementu (R3 = R3 - 2)

        SUB R3, R4, R6       ; R6 = R3 - R4 (sprawdza czy R3 >= R4)
        BRGE R6, loop        ; Jeśli R6 >= 0 (czyli R3 >= R4), kontynuuj pętlę

        DIV R1, R2, R1       ; Dzieli sumę przez licznik, wynik w R1 (średnia)
halt:   BRZ R0, halt         ; Nieskończona pętla - koniec programu

12071 cykli dla tego rozwiązania

================================================================================
2. Średnia arytmetyczna z warunkiem

Oblicz średnią jedynie dla liczb o wartościach większych od 4096.
Ile będzie takich liczb?

        ADDI R0, 0, R1       ; Inicjalizacja R1 (suma) wartością 0
        ADDI R0, 0, R2       ; Inicjalizacja R2 (licznik wartości > 4096) wartością 0
        ADDI R0, 0x03FE, R3  ; Ustawienie R3 na koniec tablicy (0x3FE)
        ADDI R0, 0x0200, R4  ; Ustawienie R4 na początek tablicy (0x200)
        ADDI R0, 0x1000, R7  ; Ustawienie R7 na wartość progową 4096 (0x1000)

loop:   LDH R5, 0(R3)        ; Ładuje półsłowo z adresu R3 do rejestru R5
        SUB R5, R7, R6       ; R6 = R5 - 4096 (sprawdza czy R5 > 4096)
        BRLE R6, skip        ; Jeśli R6 <= 0 (czyli R5 <= 4096), pomijamy tę liczbę

        ADD R1, R5, R1       ; Dodaje wartość do sumy (R1 = R1 + R5)
        ADDI R2, 1, R2       ; Zwiększa licznik o 1 (R2 = R2 + 1)

skip:   SUBI R3, 2, R3       ; Przejście do poprzedniego elementu (R3 = R3 - 2)
        SUB R3, R4, R6       ; R6 = R3 - R4 (sprawdza czy R3 >= R4)
        BRGE R6, loop        ; Jeśli R6 >= 0 (czyli R3 >= R4), kontynuuj pętlę

        BRZ R2, empty        ; Jeśli licznik = 0, nie ma liczb > 4096
        DIV R1, R2, R1       ; Dzieli sumę przez licznik, wynik w R1 (średnia)
        BRZ R0, halt         ; Skok do końca programu

empty:  ADDI R0, 0, R1       ; Jeśli brak liczb > 4096, średnia = 0
halt:   BRZ R0, halt         ; Nieskończona pętla - koniec programu


================================================================================
ODP:
avg = 0x8472 (4620 cykli)
avg = 0x8a9d (n=0xF4)


================================================================================
================================================================================
Lab 2

================================================================================
1. Maksimum
Znaleźć maksymalną wartość w tablicy 16-bitowych (half: 2B) liczb całkowitych w pamięci w zakresie 0x200...0x3FF.
Liczby traktowane są jako unsigned int.
Wynik ma być zwracany w rejestrze R1.
Zmierz czas działania programu przy MemAccTime = 1

        ADDI R0, 0x0200, R3  ; Ustawienie R3 na początek tablicy (0x200)
        ADDI R0, 0x03FE, R4  ; Ustawienie R4 na koniec tablicy (0x3FE)

        LDH R1, 0(R3)        ; Ładuje pierwszą wartość jako początkowe maksimum
        ADDI R3, 2, R3       ; Przejście do następnego elementu

loop:   LDH R5, 0(R3)        ; Ładuje półsłowo z adresu R3 do rejestru R5
        SUB R5, R1, R6       ; R6 = R5 - R1 (sprawdza czy R5 > R1)
        BRLE R6, skip        ; Jeśli R6 <= 0 (czyli R5 <= R1), pomijamy aktualizację
        ADD R0, R5, R1       ; Aktualizacja maksimum (R1 = R5)

skip:   ADDI R3, 2, R3       ; Przejście do następnego elementu (R3 = R3 + 2)
        SUB R4, R3, R6       ; R6 = R4 - R3 (sprawdza czy R3 <= R4)
        BRGE R6, loop        ; Jeśli R6 >= 0 (czyli R3 <= R4), kontynuuj pętlę

halt:   BRZ R0, halt         ; Nieskończona pętla - koniec programu

================================================================================
2. Maksimum i minimum
Znaleźć maksymalną i minimalną wartość w tej samej tablicy.

Wyniki w rejestrach R1, R2.

        ADDI R0, 0x0200, R3  ; Ustawienie R3 na początek tablicy (0x200)
        ADDI R0, 0x03FE, R4  ; Ustawienie R4 na koniec tablicy (0x3FE)

        LDH R1, 0(R3)        ; Ładuje pierwszą wartość jako początkowe maksimum
        ADD R0, R1, R2       ; Ustawia tę samą wartość jako początkowe minimum
        ADDI R3, 2, R3       ; Przejście do następnego elementu

loop:   LDH R5, 0(R3)        ; Ładuje półsłowo z adresu R3 do rejestru R5

        ; Sprawdzenie maksimum
        SUB R5, R1, R6       ; R6 = R5 - R1 (sprawdza czy R5 > R1)
        BRLE R6, checkMin    ; Jeśli R6 <= 0 (czyli R5 <= R1), pomijamy aktualizację maksimum
        ADD R0, R5, R1       ; Aktualizacja maksimum (R1 = R5)

checkMin:
        ; Sprawdzenie minimum
        SUB R5, R2, R6       ; R6 = R5 - R2 (sprawdza czy R5 < R2)
        BRGE R6, next        ; Jeśli R6 >= 0 (czyli R5 >= R2), pomijamy aktualizację minimum
        ADD R0, R5, R2       ; Aktualizacja minimum (R2 = R5)

next:   ADDI R3, 2, R3       ; Przejście do następnego elementu (R3 = R3 + 2)
        SUB R4, R3, R6       ; R6 = R4 - R3 (sprawdza czy R3 <= R4)
        BRGE R6, loop        ; Jeśli R6 >= 0 (czyli R3 <= R4), kontynuuj pętlę

halt:   BRZ R0, halt         ; Nieskończona pętla - koniec programu

================================================================================
3. Sortowanie przez wybieranie

Posortować (in-situ) tablicę 16-bitowych (half: 2B) liczb całkowitych w pamięci w zakresie 0x200... 0x3FF.
Liczby traktowane są jako unsigned int.

Zmierz czas działania programu (MemAccTime = 1), oczekuj ponad 700,000 cykli.


Proponowana struktra programu:
inicjowanie wskaźnika pętli głównej Rx=0x200

pętla główna
    dekrementacja Rx

    inicjowanie wskaźnika pętli wewnetrznej Ry=Rx
    pętla wewnętrzna
        dekrementacja Ry
        sprawdzanie czy maksimum
        jeśli Ry=0 to koniec

zamiana liczb w tablicy: a[Rx] i b[Rmax]

jeśli Rx=0 to koniec
================================================================================

        ADDI R0, 0x0200, R1  ; Inicjalizacja R1 jako wskaźnik początku tablicy (0x200)
        ADDI R0, 0x03FE, R2  ; Inicjalizacja R2 jako wskaźnik końca tablicy (0x3FE)

main_loop:
        ADD R0, R1, R3       ; Kopiowanie aktualnej pozycji do R3 (indeks elementu z min. wartością)
        ADD R0, R1, R4       ; Kopiowanie aktualnej pozycji do R4 (iterator wewnętrznej pętli)
        LDH R5, 0(R1)        ; Ładowanie wartości z aktualnej pozycji jako początkowe minimum

inner_loop:
        ADDI R4, 2, R4       ; Przejście do następnego elementu w wewnętrznej pętli
        SUB R2, R4, R6       ; Sprawdzenie czy nie przekroczyliśmy końca tablicy
        BRLT R6, swap        ; Jeśli R4 > R2, zakończ wewnętrzną pętlę

        LDH R7, 0(R4)        ; Ładowanie wartości z pozycji R4
        SUB R7, R5, R6       ; Porównanie z aktualnym minimum
        BRGE R6, inner_loop  ; Jeśli R7 >= R5, kontynuuj pętlę

        ; Znaleziono nowe minimum
        ADD R0, R7, R5       ; Aktualizacja minimum
        ADD R0, R4, R3       ; Zapamiętanie pozycji nowego minimum
        BRZ R0, inner_loop   ; Kontynuuj wewnętrzną pętlę

swap:
        SUB R3, R1, R6       ; Sprawdzenie czy znaleziono nowe minimum
        BRZ R6, next_iter    ; Jeśli nie znaleziono nowego minimum, przejdź do następnej iteracji

        ; Zamiana miejscami wartości
        LDH R7, 0(R1)        ; Ładowanie wartości z pozycji R1
        LDH R8, 0(R3)        ; Ładowanie wartości z pozycji R3
        STH R8, 0(R1)        ; Zapisanie wartości z R3 do pozycji R1
        STH R7, 0(R3)        ; Zapisanie wartości z R1 do pozycji R3

next_iter:
        ADDI R1, 2, R1       ; Przejście do następnego elementu w głównej pętli
        SUB R2, R1, R6       ; Sprawdzenie czy nie przekroczyliśmy końca tablicy
        BRGE R6, main_loop   ; Jeśli R1 <= R2, kontynuuj główną pętlę

halt:   BRZ R0, halt         ; Nieskończona pętla - koniec programu

================================================================================
================================================================================
TESTY:

================================================================================
Pierwszy i ostatni element tablicy

        ADDI R0, 0x0200, R3  ; Ustawienie R3 na adres 0x0200
        LDH R1, 0x0000(R3)   ; Ładuje półsłowo z adresu 0x0200 do rejestru R1

        ADDI R0, 0x03FE, R4  ; Ustawienie R4 na adres 0x03FE (ostatnie półsłowo)
        LDH R2, 0x0000(R4)   ; Ładuje półsłowo z adresu 0x03FE do rejestru R2

halt:   BRZ R0, halt         ; Nieskończona pętla - koniec programu