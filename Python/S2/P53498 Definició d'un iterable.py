class Tree:
    def __init__(self, x):
        self.rt = x
        self.child = []

    def __iter__(self):
        yield self.rt
        queue = self.child
        for actual in queue:
            queue.extend(actual.child)
            yield actual.rt


    def addChild(self, a):
        self.child.append(a)

    def root(self):
        return self.rt

    def ithChild(self, n):
        return self.child[n]

    def num_children(self):
        return len(self.child)