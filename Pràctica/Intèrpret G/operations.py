import numpy as np

# Defineix operacions bàsiques de G
class Operations:
    
    # Inicialitza diccionari d'operacions
    def __init__(self):
        self.operations = {
            # Operacions bàsiques
            ']': lambda x: x,                      # Identitat
            'i.': self._i_dot,                     # Seqüència: i. 4 → [0,1,2,3]
            '+': lambda x, y: x + y,               # Suma
            '-': lambda x, y: x - y,               # Resta
            '*': lambda x, y: x * y,               # Multiplicació
            '%': lambda x, y: x // y,              # Divisió entera
            '|': lambda x, y: y % x,               # Mòdul invertit
            '^': lambda x, y: x ** y,              # Potència
            
            # Operadors relacionals
            '>': lambda x, y: x > y,
            '<': lambda x, y: x < y,
            '>=': lambda x, y: x >= y,
            '<=': lambda x, y: x <= y,
            '=': lambda x, y: x == y,
            '<>': lambda x, y: x != y,
            
            # Operacions especials
            ',': self._concatenate,                # Concatenació
            '#': self._size_operation,             # Mida o filtre
            '{': self._access_by_index,            # Accés per índex
        }
    
    # Retorna diccionari d'operacions
    def get_operations(self):
        return self.operations
    
    # Genera seqüència [0, 1, ..., n-1]
    def _i_dot(self, n):
        if isinstance(n, np.ndarray) and n.size == 1:
            return np.arange(n[0])
        return np.arange(n)
    
    # Concatena dos arrays: x , y
    def _concatenate(self, x, y):
        if not isinstance(x, np.ndarray):
            x = np.array([x])
        if not isinstance(y, np.ndarray):
            y = np.array([y])
        return np.concatenate((x, y))
    
    # Unari -> Retorna mida de x.
    # Binari -> filtra y amb màscara x
    def _size_operation(self, x, y=None):
        if y is None:
            # Operació unària: mida
            return x.size if isinstance(x, np.ndarray) else 1
        
        # Operació binària: filtratge
        if not isinstance(x, np.ndarray):
            x = np.array([x])
        if not isinstance(y, np.ndarray):
            y = np.array([y])
        
        if not np.issubdtype(x.dtype, np.integer) and not np.issubdtype(x.dtype, np.bool_):
            raise Exception("La màscara pel filtre ha de ser de booleans o enters")
        
        if np.issubdtype(x.dtype, np.integer):
            x = x.astype(bool)
        
        if x.size != y.size:
            raise Exception(f"La màscara i l'array tenen mides diferents: {x.size} vs {y.size}")
        
        return y[x]

    # Accedeix elements per índex: indices { arr
    def _access_by_index(self, indices, arr):
        if not isinstance(indices, np.ndarray):
            indices = np.array([indices])
        if not isinstance(arr, np.ndarray):
            arr = np.array([arr])
        
        if not np.issubdtype(indices.dtype, np.integer):
            raise Exception("Els índexs han de ser enters")
        
        if np.any(indices < 0) or np.any(indices >= arr.size):
            raise Exception(f"Índexs fora de rang: {indices}, mida: {arr.size}")
        
        return arr[indices]