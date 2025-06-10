grammar g;

// Punt d'entrada del programa: una seqüència d'statements seguida del final de l'arxiu
program: statement* EOF;

// Definició dels possibles tipus d'statements
statement
    : ID ASSIGN expression        // Assignació de variables o funcions (inclou main)
    | expression                  // Expressió solta (per avaluació directa)
    ;

// Expressions amb associativitat dreta
expression
    : atom operator FLIP expression    # Flip           // Operador flip
    | atom operator expression         # BinaryOp       // Operació binària estàndar: operand operador operand
    | operator '/' expression          # FoldApply      // Fold aplicat a expressió
    | operator '/'                     # FoldFunc       // Operador fold com a funció
    | '#' expression                   # SizeApply      // Mida d'un vector
    | '#'                              # SizeFunc       // Operador mida com a funció
    | operator ':' expression          # UnaryExpr      // Operador unari aplicat
    | operator ':'                     # UnaryFunc      // Operador unari com a funció
    | atom                             # AtomExpr       // Element atòmic: número, variable, vector, etc.
    | expression COMPOSE expression    # Compose        // Composició de funcions
    ;

// Elements bàsics - sense recursió problemàtica
atom
    : primary (primary)*               # VectorExpr      // Vector d'elements primaris
    ;

// Elements primaris que no causen ambigüitat
primary
    : NUMBER                            # Number         // Números enters
    | ID                                # Variable       // Identificadors
    | IDOT                              # IDot           // Operador i.
    | ']'                               # Identity       // Funció identitat
    | '(' expression ')'                # Parentheses    // Agrupació amb parèntesis
    ;

// Operadors disponibles en G
operator
    : '+' | '-' | '*' | '%' | '|' | '^'
    | '>' | '<' | '>=' | '<=' | '=' | '<>'
    | ',' | '#' | '{'
    | ']' | ID
    ;

// Definició de tokens
ASSIGN: '=:';                                // Operador d'assignació
COMPOSE: '@:';                               // Operador de composició
FLIP: '~';                                   // Operador flip
NUMBER: [0-9]+ | '_' [0-9]+;                 // Enters positius o negatius
ID: [a-zA-Z][a-zA-Z0-9_]*;                   // Identificadors
IDOT: 'i.';                                  // Token específic per 'i.'
WS: [ \t\r\n]+ -> skip;                      // Espais en blanc
COMMENT: 'NB.' ~[\r\n]* -> skip;             // Comentaris