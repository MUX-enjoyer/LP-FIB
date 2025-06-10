import sys
from antlr4 import *
from antlr4.error.ErrorListener import ErrorListener
from gLexer import gLexer
from gParser import gParser
from g_visitor import GVisitor
import numpy as np

# Classe personalitzada per gestionar errors de sintaxi
class GErrorListener(ErrorListener):
    def syntaxError(self, recognizer, offendingSymbol, line, column, msg, e):
        error_msg = f"Error de sintaxi a la línia {line}, columna {column}: {msg}"
        print(error_msg, file=sys.stderr)
        raise Exception(error_msg)


# Funció principal de l'intèrpret G
def main(argv):
    try:
        # Determina si l'entrada ve d'un fitxer o de l'entrada estàndard
        if len(argv) > 1:
            input_stream = FileStream(argv[1])
        else:
            input_stream = InputStream(sys.stdin.read())
        
        # Configura lexer amb gestió d'errors personalitzada
        lexer = gLexer(input_stream)
        lexer.removeErrorListeners()
        lexer.addErrorListener(GErrorListener())
        
        # Configura parser amb gestió d'errors personalitzada
        stream = CommonTokenStream(lexer)
        parser = gParser(stream)
        parser.removeErrorListeners()
        parser.addErrorListener(GErrorListener())
        
        # Genera AST i executa
        tree = parser.program()
        visitor = GVisitor()
        visitor.visit(tree)
        
        # Verifica i executa funció main
        if 'main' not in visitor.variables:
            print("Error: No s'ha trobat la funció 'main'", file=sys.stderr)
            sys.exit(1)
        
        # Formata i mostra resultat
        result = visitor.variables['main']
        if isinstance(result, np.ndarray):
            if np.all(np.equal(np.mod(result, 1), 0)):
                result = result.astype(int)
            print(' '.join(map(str, result)))
        else:
            print(result)
            
        sys.exit(0)
            
    except Exception as e:
        print(f"Error: {e}", file=sys.stderr)
        sys.exit(1)


if __name__ == '__main__':
    main(sys.argv)