import numpy as np

class GFunctions:

    # Implementa l'operació fold (/) aplicant l'operador a tots els elements
    def fold(self, operator, arg):
        if not callable(operator):
            raise Exception("L'operador a / ha de ser una funció")
        
        if isinstance(arg, np.ndarray):
            return np.frompyfunc(operator, 2, 1).reduce(arg)
        else:
            raise Exception("Fold només s'aplica a vectors")

    # Aplica operació binària amb regles de broadcasting de G
    def apply_binary_operation(self, left, right, operation):
        # Composició/aplicació de funcions
        if callable(left) and callable(right):
            return lambda x: left(right(x))
        elif callable(left):
            return left(right)
        elif callable(right):
            return right(left)
        
        # Operacions amb vectors/escalars
        if not isinstance(left, np.ndarray):
            left = np.array([left])
        if not isinstance(right, np.ndarray):
            right = np.array([right])

        # Casos especials
        if operation.__code__.co_name in ['_concatenate', '_access_by_index']:
            return operation(left, right)
        
        # Broadcasting de G
        if right.size == 1 and left.size > 1:
            return operation(left, right[0])
        elif left.size == 1 and right.size > 1:
            return operation(left[0], right)
        elif left.size == right.size:
            return operation(left, right)
        else:
            raise Exception(f" en l'operació, vectors de mida diferent ({left.size} vs {right.size})")
    
    # Aplica mòdul (VA AL REVÉS: a | b -> b % a)
    def apply_mod_operation(self, left, right):
        # Funcions
        if callable(left) and callable(right):
            return lambda x: left(right(x))
        elif callable(left):
            return left(right)
        elif callable(right):
            return lambda x: right(x) % left
        
        # Vectors/escalars amb ordre invertit (G/J)
        if not isinstance(left, np.ndarray):
            left = np.array([left])
        if not isinstance(right, np.ndarray):
            right = np.array([right])
        
        if left.size == 1 and right.size > 1:
            return right % left[0]
        elif right.size == 1 and left.size > 1:
            return np.array([r % right[0] for r in left])
        elif left.size == right.size:
            return right % left
        else:
            raise Exception(f"Error en el mòdul: vectors de mida diferent ({left.size} vs {right.size})")
    
    # Composició de funcions (f @: g)
    def compose_functions(self, f, g):
        if not callable(f) or not callable(g):
            raise Exception("La composició només es pot aplicar a funcions")
        return lambda x: f(g(x))

class AdvancedOperations:
    def __init__(self):
        self.vector_utils = None
    
    def set_vector_utils(self, vector_utils):
        self.vector_utils = vector_utils
    
    # Converteix operador binari en unari duplicant l'argument: op: y == y op y
    def apply_unary_operator(self, operator, arg):
        if not callable(operator):
            raise Exception("L'operador unari ha de ser una funció")

        if isinstance(arg, np.ndarray):
            return np.array([operator(x, x) for x in arg])
        else:
            return operator(arg, arg)