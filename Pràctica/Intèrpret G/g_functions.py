import numpy as np

# Implementa operacions avançades de G: fold, broadcasting i composició
class GFunctions:

    # Aplica fold (/) de dreta a esquerra: a0 op (a1 op (a2 op ...))"""
    def fold(self, operator, arg):
        if not callable(operator):
            raise Exception("L'operador a / ha de ser una funció")
        if not isinstance(arg, np.ndarray):
            raise Exception("Fold només s'aplica a vectors")

        n = arg.size
        if n == 0:
            return 0
            
        # Associatiu per la dreta
        result = arg[-1:]
        for x in arg[-2::-1]:
            x_arr = np.array([x])
            result = operator(x_arr, result)
        return result
    
    # Aplica operació binària amb broadcasting de G
    def apply_binary_operation(self, left, right, operation):
        # Composició funcions
        if callable(left) and callable(right):
            return lambda x: left(right(x))
        elif callable(left):
            return left(right)
        elif callable(right):
            return right(left)
        
        # Converteix a arrays numpy
        if not isinstance(left, np.ndarray):
            left = np.array([left])
        if not isinstance(right, np.ndarray):
            right = np.array([right])

        # Casos especials que no segueixen broadcasting estàndard
        if operation.__code__.co_name in ['_concatenate', '_access_by_index']:
            return operation(left, right)
        
        # Broadcasting de G: escalar amb vector, o vectors de mateixa mida
        if right.size == 1 and left.size > 1:
            return operation(left, right[0])
        elif left.size == 1 and right.size > 1:
            return operation(left[0], right)
        elif left.size == right.size:
            return operation(left, right)
        else:
            raise Exception(f"Error en l'operació: vectors de mida diferent ({left.size} vs {right.size})")
    

    # Aplica mòdul (VA AL REVÉS: a | b -> b % a)
    def apply_mod_operation(self, left, right):
        # Composició funcions
        if callable(left) and callable(right):
            return lambda x: left(right(x))
        elif callable(left):
            return left(right)
        elif callable(right):
            return lambda x: right(x) % left
        
        # Converteix a arrays numpy
        if not isinstance(left, np.ndarray):
            left = np.array([left])
        if not isinstance(right, np.ndarray):
            right = np.array([right])
        
        # Broadcasting amb ordre invertit
        if left.size == 1 and right.size > 1:
            return right % left[0]
        elif right.size == 1 and left.size > 1:
            return np.array([r % right[0] for r in left])
        elif left.size == right.size:
            return right % left
        else:
            raise Exception(f"Error en el mòdul: vectors de mida diferent ({left.size} vs {right.size})")
    
    # Composició de funcions: (f @: g)(x) -> f(g(x))
    def compose_functions(self, f, g):
        if not callable(f) or not callable(g):
            raise Exception("La composició només es pot aplicar a funcions")
        return lambda x: f(g(x))