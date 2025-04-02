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
LDH Rx,address  Load Halfword:           |Ładuje półsłowo (16 bitów) z pamięci spod adresu address do rejestru Rx
                Rx ← MEM[address]        |
LDW Rx,address  Load Word:               |Ładuje słowo (32 bity) z pamięci spod adresu address do rejestru Rx
                Rx ← MEM[address]        |


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

================================================================================
2. Maksimum i minimum
Znaleźć maksymalną i minimalną wartość w tej samej tablicy.

Wyniki w rejestrach R1, R2.
0000: 44030200 |            | ADDI R0, 0x0200, R3        ; Inicjalizacja adresu końca tablicy
0004: 48630002 |            | SUBI R3, 0x0002, R3        ; Ustawienie R3 na przedostatni element
0008: 08640200 |            | LDH  R4, 0x0200(R3)        ; Odczyt pierwszego elementu
000C: 1C040800 |            | ADD  R0, R4, R1            ; Inicjalizacja max pierwszym elementem
0010: 1C041000 |            | ADD  R0, R4, R2            ; Inicjalizacja min pierwszym elementem
0014: 48630002 | loop       | SUBI R3, 0x0002, R3        ; Przejście do kolejnego elementu
0018: 08640200 |            | LDH  R4, 0x0200(R3)        ; Odczyt kolejnego elementu
001C: 20812800 |            | SUB  R4, R1, R5            ; Sprawdzenie czy większy od max
0020: 78050014 |            | BRGT R5, maxi              ; Jeśli R5 > 0, to nowy max
0024: 20824000 |            | SUB  R4, R2, R6            ; Sprawdzenie czy mniejszy od min
0028: 80060014 |            | BRLT R6, mini              ; Jeśli R6 < 0, to nowy min
002C: 7403FFE4 |            | BRNZ R3, loop              ; Kontynuuj dopóki R3 != 0
0030: 7000FFFC | halt       | BRZ  R0, halt              ; Koniec programu
0034: 00000000 |            | NOP                        ; NOP dla breakpoint PC = 34
0038: 1C040800 | maxi       | ADD  R0, R4, R1            ; Nowy max = R4
003C: 7403FFD4 |            | BRNZ R3, loop              ; Powrót do pętli
0040: 1C041000 | mini       | ADD  R0, R4, R2            ; Nowy min = R4
0044: 7403FFCC |            | BRNZ R3, loop              ; Powrót do pętli


0000: 44030200 |            | ADDI R0, 0x0200, R3
0004: 48630002 |            | SUBI R3, 0x0002, R3
0008: 08640200 |            | LDH  R4, 0x0200(R3)
000C: 1C040800 |            | ADD  R0, R4, R1
0010: 1C041000 |            | ADD  R0, R4, R2
0014: 48630002 | loop       | SUBI R3, 0x0002, R3
0018: 08640200 |            | LDH  R4, 0x0200(R3)
001C: 20812800 |            | SUB  R4, R1, R5
0020: 78050014 |            | BRGT R5, maxi
0024: 20824000 |            | SUB  R4, R2, R6
0028: 80060014 |            | BRLT R6, mini
002C: 7403FFE4 |            | BRNZ R3, loop
0030: 7000FFFC | halt       | BRZ  R0, halt
0034: 00000000 |            | NOP
0038: 1C040800 | maxi       | ADD  R0, R4, R1
003C: 7403FFD4 |            | BRNZ R3, loop
0040: 1C041000 | mini       | ADD  R0, R4, R2
0044: 7403FFCC |            | BRNZ R3, loop

7173 cykli

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



================================================================================
================================================================================
Lab 3
================================================================================
# Instrukcje PUSH i PULL - implementacja w mikrokodzie

## Ogólne informacje:
- Zaimplementować instrukcje operujące na stosie:
  * PUSH – zapisanie (odłożenie) słowa na stosie
  * PULL – odczytanie (zdjęcie) słowa ze stosu

- Pliki znajdują się w katalogu lab3.
  * wczytać konfigurację: lab3.ecf
  * wczytać projekt: lab3.mpr

## Organizacja stosu (LIFO):
- wskaźnik stosu (SP – Stack Pointer) wskazuje pierwsze wolne miejsce na stosie (nad wierzchołkiem - top)
- stos rośnie w kierunku malejących adresów
- wskaźnik stosu jest inicjowany wartością 0x3FC
- wskaźnik stosu jest dowolnym rejestrem R1 – R31
================================================================================
## Implementacja instrukcji:

### 1️⃣ PUSH Rx, Ry
add data Ry to the stack Rx
1) Ry → Mem[Rx]
   Rx → MAR
   Ry → MDR
   write memory (WW,MAR)
2) Rx-4 → Rx

================================================================================
### 2️⃣ PULL Rx, Ry
remove data from the stack
1) Rx+4 → Rx
2) Mem[Rx] → Ry
   Rx → MAR
   read memory (RW,MAR,MDR)
   MDR → Ry

Na obrazku widoczny jest także diagram pokazujący strukturę stosu z adresami pamięci (0x0000, 0x0200, 0x03FF, 0x0400) oraz wskaźnikiem stosu SP.

================================================================================
# Testowanie instrukcji PUSH – PULL

Sprawdzić (clock-by-clock) działanie instrukcji PUSH/PULL za pomocą programu:

```
ADDI R0, 0x????, R7
ADDI R0, 0xABCD, R1
PUSH R7,R1
PULL R7,R2
```

## 3️⃣ Wykonać program wykorzystujący instrukcje PUSH/PULL według przykładu.
Zmierz czas działania programu i sprawdź wynik w R2 (0x2040)

```
0000: 44070400 |             | ADDI R0, 0x????, R7
0004: 44010080 |             | ADDI R0, 0x0080, R1
0008: 88E10000 | next        | PUSH R7,R1                 ┐
000C: 48210001 |             | SUBI R1, 0x0001, R1        │ odłożenie na stos
0010: 7801FFF4 |             | BRGT R1, next              │ 128 słów o wartościach
0014: 00000000 |             | NOP                        ┘ od 0x0080 do 0x0001
0018: 34421000 |             | XOR  R2, R2, R2
001C: 44010080 |             | ADDI R0, 0x0080, R1
0020: 8CE30000 | next2       | PULL R7,R3                 ┐
0024: 1C621000 |             | ADD  R3, R2, R2            │ zdjęcie ze stosu
0028: 48210001 |             | SUBI R1, 0x0001, R1        │ 128 słów i sumowanie
002C: 7801FFF0 |             | BRGT R1, next2             │ ich w rejestrze R2
0030: 00000000 |             | NOP                        ┘
0034: 7000FFFC | halt        | BRZ  R0, halt
```





0000: 440703FC |            | ADDI R0, 0x03FC, R7
0004: 44010080 |            | ADDI R0, 0x0080, R1
0008: 88E10000 | next       | PUSH R7,R1
000C: 48210001 |            | SUBI R1, 0x0001, R1
0010: 7801FFF4 |            | BRGT R1, next
0014: 00000000 |            | NOP
0018: 34421000 |            | XOR  R2, R2, R2
001C: 44010080 |            | ADDI R0, 0x0080, R1
0020: 8CE30000 | next2      | PULL R7,R3
0024: 1C621000 |            | ADD  R3, R2, R2
0028: 48210001 |            | SUBI R1, 0x0001, R1
002C: 7801FFF0 |            | BRGT R1, next2
0030: 00000000 |            | NOP
0034: 7000FFFC | halt       | BRZ  R0, halt

























PROMPT:
# Zasady pisania kodu asemblerowego

## Format instrukcji
```
OPCODE Rx,Ry,Rz   lub   OPCODE Rx,i,Ry
```

## Instrukcje arytmetyczne
- `ADD  Rx,Ry,Rz`    - Dodaje wartości z rejestrów Rx i Ry: Rz ← Rx+Ry
- `SUB  Rx,Ry,Rz`    - Odejmuje wartość Ry od Rx: Rz ← Rx-Ry
- `MUL  Rx,Ry,Rz`    - Mnoży wartości z rejestrów Rx i Ry: Rz ← Rx*Ry
- `DIV  Rx,Ry,Rz`    - Dzieli wartość Rx przez Ry: Rz ← Rx/Ry

## Instrukcje arytmetyczne ze stałymi
- `ADDI Rx,i,Ry`     - Dodaje wartość stałą i do rejestru Rx: Ry ← Rx+i
- `SUBI Rx,i,Ry`     - Odejmuje wartość stałą i od rejestru Rx: Ry ← Rx-i
- `MULI Rx,i,Ry`     - Mnoży rejestr Rx przez wartość stałą i: Ry ← Rx*i
- `DIVI Rx,i,Ry`     - Dzieli rejestr Rx przez wartość stałą i: Ry ← Rx/i

## Instrukcje logiczne
- `AND  Rx,Ry,Rz`    - Operacja logiczna AND: Rz ← Rx&Ry
- `OR   Rx,Ry,Rz`    - Operacja logiczna OR: Rz ← Rx|Ry
- `XOR  Rx,Ry,Rz`    - Operacja logiczna XOR: Rz ← Rx^Ry

## Instrukcje przesunięcia
- `SLL  Rx,Ry,Rz`    - Przesunięcie w lewo: Rz ← Rx<<Ry
- `SRL  Rx,Ry,Rz`    - Przesunięcie logiczne w prawo: Rz ← Rx>>Ry
- `SRA  Rx,Ry,Rz`    - Przesunięcie arytmetyczne w prawo: Rz ← Rx>>Ry z zachowaniem znaku

## Instrukcje skoku
- `BRZ  Rx,label`    - Skok do etykiety label, jeśli Rx == 0
- `BRNZ Rx,label`    - Skok do etykiety label, jeśli Rx != 0
- `BRGT Rx,label`    - Skok do etykiety label, jeśli Rx > 0
- `BRGE Rx,label`    - Skok do etykiety label, jeśli Rx >= 0
- `BRLT Rx,label`    - Skok do etykiety label, jeśli Rx < 0
- `BRLE Rx,label`    - Skok do etykiety label, jeśli Rx <= 0

## Instrukcje pamięci
- `LDH  Rx,offset(Ry)` - Ładuje półsłowo (16 bitów) z pamięci: Rx ← MEM[Ry+offset]
- `LDW  Rx,offset(Ry)` - Ładuje słowo (32 bity) z pamięci: Rx ← MEM[Ry+offset]
- `STH  Rx,offset(Ry)` - Zapisuje półsłowo do pamięci: MEM[Ry+offset] ← Rx

## Inne instrukcje
- `NOP`              - Brak operacji
- `LIH  Rx,i`        - Ładuje górne 16 bitów rejestru Rx

## Konwencje i ważne uwagi
- W asemblerze iterujemy OD TYŁU! - iteruj dokłądnie tak jak w przykładzie, nie potrzeby jest koniec tablicy przypisany do zmiennej
- Po instrukcji HALT dodajemy NOP, aby wstawić breakpoint
- Format kodu: `adres: kod | etykieta | instrukcja (bez komentarzów)`
- Etykiety definiujemy bez _ w nazwie, użwaj podejścia camelCase i pisz po angieslku
- Liczby szesnastkowe zapisujemy z prefiksem 0x
- R0 - to nasze 0 nie zmieniamy jego wartości
- nie pisz komentarzy ; NIE PISZ komentarzy
- nie dodwaj \n - pustych linii
Przykłąd poprawnego kodu znajdującego max i min:
```
0000: 44030200 |            | ADDI R0, 0x0200, R3
0004: 48630002 |            | SUBI R3, 0x0002, R3
0008: 08640200 |            | LDH  R4, 0x0200(R3)
000C: 1C040800 |            | ADD  R0, R4, R1
0010: 1C041000 |            | ADD  R0, R4, R2
0014: 48630002 | loop       | SUBI R3, 0x0002, R3
0018: 08640200 |            | LDH  R4, 0x0200(R3)
001C: 20812800 |            | SUB  R4, R1, R5
0020: 78050014 |            | BRGT R5, maxi
0024: 20824000 |            | SUB  R4, R2, R6
0028: 80060014 |            | BRLT R6, mini
002C: 7403FFE4 |            | BRNZ R3, loop
0030: 7000FFFC | halt       | BRZ  R0, halt
0034: 00000000 |            | NOP
0038: 1C040800 | maxi       | ADD  R0, R4, R1
003C: 7403FFD4 |            | BRNZ R3, loop
0040: 1C041000 | mini       | ADD  R0, R4, R2
0044: 7403FFCC |            | BRNZ R3, loop
```
Twoim zadaniem jest napisać kod dla zadania, wzorując się na poprawym kodzie:















================================================================================
LAB 4
================================================================================
================================================================================





# Polecenie

## Zadanie 1
Instrukcje BSR i RTS — implementacja w mikrokodzie

Zaimplementować instrukcje skoku i powrotu z podprogramu:
* BSR — (Branch to SubRoutine) jest skokiem względnym (tj. PC=PC+offset) do adresu podanego jako etykieta, z odłożeniem na stos rejestru PC
* RTS — (ReTurn from Subroutine) jest skokiem absolutnym (tj. PC=address) do adresu odczytanego ze stosu

* W obu przypadkach wskaźnikiem stosu jest rejestr Rx

BSR Rx,label
→ deklaracja: BSR I-type r1,j

1) PC → stack(Rx)
2) PC + signext(IR) → PC

RTS Rx
→ deklaracja: RTS R-type r1

1) stack(Rx) → PC

Pamiętaj, że instrukcje BSR i RTS wykonują operacje na stosie w podobny sposób do PUSH i PULL, czyli modyfikują wskaźnik stosu.

Implementacje wykonaj w projekcie lab3 z poprzednich zajęć z PUSH/PULL

## Zadanie 2
Testowanie BSR i RTS

```
ADDI R0,0x??,R7  ;init stack
ADDI R0,0x05,R1  ;value to cube
BSR  R7,cube     ;call 'cube'
NOP
stop BRZ  R0,stop     ;stop
...
cube ADD  R0,R1,R2    ;make copy of R1
     MUL  R1,R1,R1    ;compute square
     MUL  R1,R2,R1    ;compute cube
     RTS  R7          ;return
```


```
ADDI R0,0x03FC,R7
ADDI R0,0x05,R1
BSR  R7,cube
NOP
stop BRZ  R0,stop
cube ADD  R0,R1,R2
     MUL  R1,R1,R1
     MUL  R1,R2,R1
     RTS  R7


0000: 440703FC |            | ADDI R0, 0x03FC, R7
0004: 44010005 |            | ADDI R0, 0x0005, R1
0008: 90E00008 |            | BSR  R7, cube
000C: 00000000 |            | NOP
0010: 7000FFFC | stop       | BRZ  R0, stop
0014: 1C011000 | cube       | ADD  R0, R1, R2
0018: 24210800 |            | MUL  R1, R1, R1
001C: 24220800 |            | MUL  R1, R2, R1
0020: 94E00000 |            | RTS  R7


```












## Zadanie 3
Obliczanie silnii z wykorzystaniem rekursji

n! = n·(n-1)! → fact(n) = n·fact(n-1)

Funkcja fact() pobiera jeden parametr (32-bit int) ze stosu i zwraca wynik (32-bit int) na stosie w miejscu pobranego parametru

```c
// C implementation
int fact(int n)
{
    if n==1 return n
    else return n*fact(n-1);
}
```

Struktura programu:
```
ADDI R0, 0x????, R7  ;init SP
ADDI R0, 0x0006, R1  ;set n=6
PUSH R7, R1          ;pass n to fact
BSR  R7, fact        ;call fact
PULL R7, R1          ;get result n!
NOP
BRZ  R0, stop
...
fact    LDW  R2, offset(R7)  ;read parameter
        ...
        ...
        ...
        STW  R2, offset(R7)  ;return result
return  RTS  R7
        NOP
```

Wartość przesunięcia offset zależy od implementacji stosu: +4 lub +8



        ADDI R0, 0x0FFC, R7
        ADDI R0, 6, R1
        PUSH R7, R1
        BSR  R7, fact
        PULL R7, R1
        NOP
stop:
        BRZ  R0, stop

fact:
        LDW  R2, 4(R7)
        ADDI R0, 1, R3
        SUB  R2, R3, R4
        BRZ  R4, baseCase

recursiveCase:
        PUSH R7, R2
        PUSH R7, R4
        BSR  R7, fact
        PULL R7, R3
        PULL R7, R2
        MUL  R2, R3, R2
        STW  R2, 4(R7)
        BRZ  R0, returnSeq

baseCase:
        ADDI R0, 1, R2
        STW  R2, 4(R7)

returnSeq:
        RTS  R7
        NOP



BSR (Branch to Subroutine / Skok do podprogramu) - Mikroinstrukcje 003C-003F
        003C: Oblicz adres SP - 4 na stosie i przygotuj go (w MAR) do zapisu adresu powrotu.
        003D: Skopiuj adres następnej instrukcji (PC) do rejestru danych (MDR), aby przygotować go do zapisu na stosie.
        003E: Oblicz nową wartość wskaźnika stosu (SP - 4), zapisz ją tymczasowo w C, i jednocześnie zapisz adres powrotu (z MDR) do pamięci na stosie (pod adres SP - 4), czekając jeśli pamięć jest zajęta.
        003F: Oblicz adres docelowy podprogramu (z PC i instrukcji IR), wpisz go do PC (powodując skok), zaktualizuj rejestr SP (A) nową wartością (z C) i przejdź do pobrania pierwszej instrukcji podprogramu.

RTS (Return from Subroutine / Powrót z podprogramu) - Mikroinstrukcje 0040-0042
        0040: Skopiuj aktualny adres wskaźnika stosu (A) do rejestru adresu (MAR), aby wskazać miejsce odczytu adresu powrotu.
        0041: Oblicz nową wartość wskaźnika stosu (SP + 4), zapisz ją tymczasowo w C, i jednocześnie odczytaj adres powrotu z pamięci (ze szczytu stosu wskazywanego przez MAR) do rejestru danych (MDR), czekając jeśli pamięć jest zajęta.
        0042: Skopiuj odczytany adres powrotu (z MDR) do licznika programu (PC), aby wrócić do wywołującego, zaktualizuj rejestr SP (A) nową wartością (z C) i przejdź do pobrania instrukcji pod adresem powrotu.



PUSH (Wepchnięcie na stos) - Mikroinstrukcje 0034-0037
        0034: Skopiuj aktualny adres wskaźnika stosu (A) do rejestru adresu pamięci (MAR), aby wskazać miejsce zapisu (uwaga: logiczniej byłoby tu obliczyć A-4).
        0035: Skopiuj dane do zapisania (z rejestru B) do rejestru danych pamięci (MDR).
        0036: Zleć pamięci zapisanie danych (z MDR) pod adres wskazany przez MAR, czekając jeśli pamięć jest zajęta.
        0037: Oblicz nowy adres wskaźnika stosu (A - 4), zapisz go tymczasowo w C, następnie zaktualizuj rejestr wskaźnika stosu (A) tą nową wartością (używając mechanizmu WF1) i skocz do sekwencji kończącej instrukcję (WF1, która prowadzi do Fetch).

PULL (Ściągnięcie ze stosu) - Mikroinstrukcje 0038-003B
        0038: Oblicz adres wskaźnika stosu po zdjęciu elementu (A + 4) i zapisz go tymczasowo w rejestrze C.
        0039: Przygotuj aktualny adres wskaźnika stosu (A) w rejestrze adresu pamięci (MAR), aby wskazać, skąd czytać dane (uwaga: linijka w kodzie wydaje się błędna, powinno być S1 A, MAR).
        003A: Zleć pamięci odczytanie danych spod adresu wskazanego przez MAR (szczyt stosu) do rejestru danych pamięci (MDR), czekając jeśli pamięć jest zajęta.
        003B: Skopiuj odczytane dane (z MDR) do rejestru docelowego (C), następnie zaktualizuj rejestr wskaźnika stosu (A) nową wartością obliczoną wcześniej (używając mechanizmu WF1 i wartości z C) i skocz do sekwencji kończącej instrukcję (WF2, która prowadzi do Fetch).
























[Microcode]
;uAR |Label |ALU   |S1    |S2    |Dest  |ExtIR |Const |JCond |Adr   |Mem   |MAdr  |MDest |Regs
0000 |Fetch |      |      |      |      |      |      |Mbusy |Fetch |RW    |PC    |IR    |      
0001 |      |ADD   |PC    |Const |PC    |      |4     |Jump1 |      |      |      |      |RR    
0002 |ST    |S2    |      |B     |MDR   |      |      |      |      |      |      |      |      
0003 |LD    |ADD   |A     |IR    |MAR   |Word  |      |Jump2 |      |      |      |      |      
0004 |LDB   |      |      |      |      |      |      |Mbusy |LDB   |RB    |MAR   |MDR   |      
0005 |      |S1    |MDR   |      |C     |      |      |      |      |      |      |      |      
0006 |WF2   |      |      |      |      |      |      |True  |Fetch |      |      |      |WF2   
0007 |LDH   |      |      |      |      |      |      |Mbusy |LDH   |RH    |MAR   |MDR   |      
0008 |      |S1    |MDR   |      |C     |      |      |True  |WF2   |      |      |      |      
0009 |LDW   |      |      |      |      |      |      |Mbusy |LDW   |RW    |MAR   |MDR   |      
000A |      |S1    |MDR   |      |C     |      |      |True  |WF2   |      |      |      |      
000B |STB   |      |      |      |      |      |      |Mbusy |STB   |WB    |MAR   |      |      
000C |      |      |      |      |      |      |      |True  |Fetch |      |      |      |      
000D |STH   |      |      |      |      |      |      |Mbusy |STH   |WH    |MAR   |      |      
000E |      |      |      |      |      |      |      |True  |Fetch |      |      |      |      
000F |STW   |      |      |      |      |      |      |Mbusy |STW   |WW    |MAR   |      |      
0010 |      |      |      |      |      |      |      |True  |Fetch |      |      |      |      
0011 |ADD   |ADD   |A     |B     |C     |      |      |      |      |      |      |      |      
0012 |WF3   |      |      |      |      |      |      |True  |Fetch |      |      |      |WF3   
0013 |SUB   |SUB   |A     |B     |C     |      |      |True  |WF3   |      |      |      |      
0014 |MUL   |MUL   |A     |B     |C     |      |      |True  |WF3   |      |      |      |      
0015 |DIV   |DIV   |A     |B     |C     |      |      |True  |WF3   |      |      |      |      
0016 |AND   |AND   |A     |B     |C     |      |      |True  |WF3   |      |      |      |      
0017 |OR    |OR    |A     |B     |C     |      |      |True  |WF3   |      |      |      |      
0018 |XOR   |XOR   |A     |B     |C     |      |      |True  |WF3   |      |      |      |      
0019 |SLL   |SLL   |A     |B     |C     |      |      |True  |WF3   |      |      |      |      
001A |SRL   |SRL   |A     |B     |C     |      |      |True  |WF3   |      |      |      |      
001B |SRA   |SRA   |A     |B     |C     |      |      |True  |WF3   |      |      |      |      
001C |ADDI  |ADD   |A     |IR    |C     |Word  |      |True  |WF2   |      |      |      |      
001D |SUBI  |SUB   |A     |IR    |C     |Word  |      |True  |WF2   |      |      |      |      
001E |MULI  |MUL   |A     |IR    |C     |Word  |      |True  |WF2   |      |      |      |      
001F |DIVI  |DIV   |A     |IR    |C     |Word  |      |True  |WF2   |      |      |      |      
0020 |ANDI  |AND   |A     |IR    |C     |Word  |      |True  |WF2   |      |      |      |      
0021 |ORI   |OR    |A     |IR    |C     |Word  |      |True  |WF2   |      |      |      |      
0022 |XORI  |XOR   |A     |IR    |C     |Word  |      |True  |WF2   |      |      |      |      
0023 |SLLI  |SLL   |A     |IR    |C     |Word  |      |True  |WF2   |      |      |      |      
0024 |SRLI  |SRL   |A     |IR    |C     |Word  |      |True  |WF2   |      |      |      |      
0025 |SRAI  |SRA   |A     |IR    |C     |Word  |      |True  |WF2   |      |      |      |      
0026 |LIH   |S2S1  |A     |IR    |C     |Half  |      |      |      |      |      |      |      
0027 |WF1   |      |      |      |      |      |      |True  |Fetch |      |      |      |WF1   
0028 |BRZ   |S2    |      |B     |      |      |      |NE    |Fetch |      |      |      |      
0029 |      |ADD   |PC    |IR    |PC    |Word  |      |True  |Fetch |      |      |      |      
002A |BRNZ  |S2    |      |B     |      |      |      |EQ    |Fetch |      |      |      |      
002B |      |ADD   |PC    |IR    |PC    |Word  |      |True  |Fetch |      |      |      |      
002C |BRGT  |S2    |      |B     |      |      |      |LE    |Fetch |      |      |      |      
002D |      |ADD   |PC    |IR    |PC    |Word  |      |True  |Fetch |      |      |      |      
002E |BRGE  |S2    |      |B     |      |      |      |LT    |Fetch |      |      |      |      
002F |      |ADD   |PC    |IR    |PC    |Word  |      |True  |Fetch |      |      |      |      
0030 |BRLT  |S2    |      |B     |      |      |      |GE    |Fetch |      |      |      |      
0031 |      |ADD   |PC    |IR    |PC    |Word  |      |True  |Fetch |      |      |      |      
0032 |BRLE  |S2    |      |B     |      |      |      |GT    |Fetch |      |      |      |      
0033 |      |ADD   |PC    |IR    |PC    |Word  |      |True  |Fetch |      |      |      |      
0034 |PUSH  |S1    |A     |      |MAR   |      |      |      |      |      |      |      |      
0035 |      |S2    |      |B     |MDR   |      |      |      |      |      |      |      |      
0036 |push1 |      |      |      |      |      |      |Mbusy |push1 |WW    |MAR   |      |      
0037 |      |SUB   |A     |Const |C     |      |4     |True  |WF1   |      |      |      |      
0038 |PULL  |ADD   |A     |Const |C     |      |4     |      |      |      |      |      |      
0039 |      |ADD   |A     |Const |MAR   |      |4     |      |      |      |      |      |WF1   
003A |pull1 |      |      |      |      |      |      |Mbusy |pull1 |RW    |MAR   |MDR   |      
003B |      |S1    |MDR   |      |C     |      |      |True  |WF2   |      |      |      |      
003C |BSR   |S1    |A     |      |MAR   |      |      |      |      |      |      |      |      
003D |      |S2    |PC    |      |MDR   |      |      |      |      |      |      |      |      
003E |bsr1  |SUB   |A     |Const |C     |      |4     |Mbusy |bsr1  |WW    |MAR   |      |      
003F |      |ADD   |PC    |IR    |PC    |Word  |      |True  |WF1   |      |      |      |      
0040 |RTS   |ADD   |A     |Const |MAR   |      |4     |      |      |      |      |      |      
0041 |rts1  |ADD   |A     |Const |C     |      |4     |Mbusy |rts1  |RW    |MAR   |MDR   |      
0042 |      |S1    |MDR   |      |PC    |      |      |True  |WF1   |      |      |      |      

[Jump Tables]
;Opcode  |Jump Table 1 |Jump Table 2 
NOP      |Fetch        |             
LDB      |LD           |LDB          
LDH      |LD           |LDH          
LDW      |LD           |LDW          
STB      |ST           |STB          
STH      |ST           |STH          
STW      |ST           |STW          
ADD      |ADD          |             
SUB      |SUB          |             
MUL      |MUL          |             
DIV      |DIV          |             
AND      |AND          |             
OR       |OR           |             
XOR      |XOR          |             
SLL      |SLL          |             
SRL      |SRL          |             
SRA      |SRA          |             
ADDI     |ADDI         |             
SUBI     |SUBI         |             
MULI     |MULI         |             
DIVI     |DIVI         |             
ANDI     |ANDI         |             
ORI      |ORI          |             
XORI     |XORI         |             
SLLI     |SLLI         |             
SRLI     |SRLI         |             
SRAI     |SRAI         |             
LIH      |LIH          |             
BRZ      |BRZ          |             
BRNZ     |BRNZ         |             
BRGT     |BRGT         |             
BRGE     |BRGE         |             
BRLT     |BRLT         |             
BRLE     |BRLE         |             
PUSH     |PUSH         |             
PULL     |PULL         |             
BSR      |BSR          |             
RTS      |RTS          |             






