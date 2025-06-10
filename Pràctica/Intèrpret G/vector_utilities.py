import numpy as np

# Utilitats per treballar amb vectors en G
class VectorUtils:
    
    # Converteix valor a array numpy
    def ensure_numpy_array(self, value):
        if not isinstance(value, np.ndarray):
            return np.array([value])
        return value
    
    # Concatena dos arrays
    def concatenate(self, left, right):
        left = self.ensure_numpy_array(left)
        right = self.ensure_numpy_array(right)
        return np.concatenate((left, right))