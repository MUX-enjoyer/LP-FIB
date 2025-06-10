# Intèrpret G
Intèrpret per al llenguatge G (mini J), una versió simplificada del llenguatge J derivat d'APL, implementat en Python utilitzant ANTLR i NumPy.

## Estructura del Projecte

### Fitxers principals:

- **g.py**
Programa principal de l'intèrpret. Gestiona l'entrada, inicialitza el lexer i parser d'ANTLR, i executa el programa començant per la funció main.
- **g.g4**
Gramàtica ANTLR que defineix la sintaxi del llenguatge G. Inclou regles per expressions, operadors, assignacions i construccions específiques del llenguatge.

### Mòduls d'implementació

- **g_visitor.py**
Implementa el visitador principal que recorre l'arbre de sintaxi abstracta i evalua les expressions. Gestiona variables, funcions definides per l'usuari i coordina amb altres mòduls.
- **operations.py**
Defineix totes les operacions bàsiques del llenguatge G, incloent operadors aritmètics, relacionals, i operacions especials com i., concatenació, mida i accés per índex.
- **g_functions.py**
Implementa operacions avançades com el fold (/), composició de funcions, i gestió de broadcasting per operacions binàries seguint les regles de G.
- **vector_utilities.py**
Proporciona utilitats per treballar amb vectors, incloent conversions a arrays NumPy i operacions de concatenació.
- **advanced_operations.py**
Implementa funcionalitats avançades com operadors unaris amb :, l'operador flip ~, i composició de funcions.

### Jocs de proves
**Es troben dins la carpeta /test**
- **test_basic.j**
Proves bàsiques de funcionament
- **test_funcions.j**
Proves de definició i ús de funcions
- **test_OperacionsBooleans.j**
Proves d'operadors relacionals i booleans
- **test_operadors.j**
Proves d'operadors aritmètics i especials
- **test_vector.j**
Proves de manipulació de vectors

## Compilació i Execució
Per compilar el projecte i generar els fitxers necessaris d'ANTLR:
```
make
```

Per executar un programa G:
```
python3 g.py programa.j
```
>On programa.j és un fitxer amb codi font en J.

Per executar els tests **individualment**:
```
make test_basic
make test_funcions
make test_OperacionsBooleans
make test_operadors
make test_vector
```

Per executar **tots els tests** alhora:
```
make all_tests
```
Cada prova:
1. Executa un programa G del directori tests/
2. Redirigeix la sortida a un fitxer .txt
3. Compara la sortida amb l'esperada (fitxer .out)
4. Informa si la prova ha passat (OK) o ha fallat (FAIL)

Per eliminar els fitxers generats per ANTLR i les sortides de les proves:
```
make clean
```

## Gestió d'errors
### L'intèrpret detecta i reporta (tal com es demanava):
- Errors de sintaxi: Problemes en l'estructura del codi
- Variables no definides: Ús de variables o funcions no declarades
- Errors d'operació: Operacions invàlides entre vectors de mides incompatibles

### Limitacions (segons especificació):
- No suporta errors semàntics ni errors de tipus
- No gestiona errors d'execució (com divisions per zero)

## Dependències
- Python 3.10
- ANTLR4 per Python
- NumPy per operacions amb arrays

## Autor
**Roger Bitlloch Galceran**  
roger.bitlloch@estudiantat.upc.edu
Pràctica realitzada per a l'assignatura GEI-LP cursada 2024-2025 Q2.