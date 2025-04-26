class Tree:
    def __init__(self, x):
        self.rt = x
        self.child = []
 
    def add_child(self, a):
        self.child.append(a)

    def root(self):
        return self.rt

    def ith_child(self, n):
        return self.child[n]

    def num_children(self):
        return len(self.child)

class Pre(Tree):

    def preorder(self):
        preOrdre = []
        for fill in self.child:
            preOrdre = preOrdre + fill.preorder()
        return [self.rt] + preOrdre