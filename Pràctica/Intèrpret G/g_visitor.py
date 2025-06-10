from gVisitor import gVisitor
import numpy as np
from operations import Operations
from g_functions import GFunctions
from vector_utilities import VectorUtils
from advanced_operations import AdvancedOperations

class GVisitor(gVisitor):
    def __init__(self):
        super().__init__()
        self.variables = {}
        self.operations = Operations().get_operations()
        self.functions = GFunctions()
        self.vector_utils = VectorUtils()
        self.advanced_ops = AdvancedOperations()
        self.advanced_ops.set_vector_utils(self.vector_utils)
    
    # Visita programa principal executant tots els statements
    def visitProgram(self, ctx):
        result = None
        for statement in ctx.statement():
            result = self.visit(statement)
        return result
        
    # Gestiona assignacions (ID = expr) i expressions
    def visitStatement(self, ctx):
        if ctx.ID():
            name = ctx.ID().getText()
            value = self.visit(ctx.expression())
            
            if name == 'main':
                # Processament especial per main
                if name in self.variables and callable(self.variables[name]):
                    expanded_expr = self.expand_function_calls(ctx.expression())
                    result = self.visit(expanded_expr) if expanded_expr != ctx.expression() else value
                    self.variables[name] = result
                    return result
                else:
                    expanded_expr = self.expand_function_calls(ctx.expression())
                    if expanded_expr != ctx.expression():
                        value = self.visit(expanded_expr)
                    self.variables[name] = value
                    return value
            else:
                self.variables[name] = value
                return value
        else:
            # Expressió simple
            expanded_expr = self.expand_function_calls(ctx.expression())
            if expanded_expr != ctx.expression():
                return self.visit(expanded_expr)
            else:
                return self.visit(ctx.expression())
    
    # Expandeix crides de funció (placeholder)
    def expand_function_calls(self, expr_ctx):
        return expr_ctx
    
    # Converteix nombres a arrays numpy, gestionant negatius amb _
    def visitNumber(self, ctx):
        text = ctx.NUMBER().getText()
        if text.startswith('_'):
            return np.array([-int(text[1:])])
        else:
            return np.array([int(text)])
    
    # Resol variables/funcions predefinides
    def visitVariable(self, ctx):
        name = ctx.ID().getText()
        
        if name in self.operations:
            return self.operations[name]
        
        if name in self.variables:
            return self.variables[name]
        
        raise Exception(f"Variable no definida: {name}")
    
    # Gestiona operacions binàries (a op b)
    def visitBinaryOp(self, ctx):
        left_val  = self.visit(ctx.atom())
        right_val = self.visit(ctx.expression())
        op = ctx.operator().getText()

        if op not in self.operations:
            raise Exception(f"Operador no reconegut: {op}")
        operacio = self.operations[op]

        # Cas especial per igualtat amb ]
        if op == '=':
            if callable(right_val) and right_val == self.operations[']']:
                def equals_function(arg):
                    return self.operations['='](left_val, arg)
                return equals_function
            result = self.functions.apply_binary_operation(left_val, right_val, operacio)
            return result

        # Funcions com operands
        if callable(left_val) and not callable(right_val):
            return lambda x: operacio(left_val(x), right_val)

        if not callable(left_val) and callable(right_val):
            return lambda x: operacio(left_val, right_val(x))

        # Operadors especials
        if op == '|':
            return self.functions.apply_mod_operation(left_val, right_val)

        if op == '#':
            return operacio(left_val, right_val)

        return self.functions.apply_binary_operation(left_val, right_val, operacio)

    # Aplica # a una expressió directament
    def visitSizeApply(self, ctx):
        v = self.visit(ctx.expression())
        return self.operations['#'](v)

    # Retorna funció # per aplicar posteriorment
    def visitSizeFunc(self, ctx):
        return lambda arr: self.operations['#'](arr)
    
    # Operador i. per generar seqüències
    def visitIDot(self, ctx):
        return self.operations['i.']

    # Fold com funció (+/) per aplicar després
    def visitFoldFunc(self, ctx):
        raw_op = self.visit(ctx.operator())
        return lambda arr: self.functions.fold(raw_op, arr)

    # Fold aplicat immediatament (+/ v)
    def visitFoldApply(self, ctx):
        raw_op = self.visit(ctx.operator())
        vec = self.visit(ctx.expression())
        return self.functions.fold(raw_op, vec)

    # Operador unari amb : (op: expr)
    def visitUnaryExpr(self, ctx):
        op = ctx.operator().getText()
        if op not in self.operations:
            raise Exception(f"Operador no reconegut en unary: {op}")
        bin_op = self.operations[op]

        operand = self.visit(ctx.expression())

        # Vector/escalar: aplica op(val, val)
        if not callable(operand):
            return self.functions.apply_binary_operation(operand, operand, bin_op)

        # Funció: retorna composició
        return lambda x: bin_op(operand(x), x)
    
    # Composició de funcions (f @: g)
    def visitCompose(self, ctx):
        f = self.visit(ctx.expression(0))
        g = self.visit(ctx.expression(1))
        return self.functions.compose_functions(f, g)

    # Operador flip (~) que inverteix operands
    def visitFlip(self, ctx):
        left_val  = self.visit(ctx.atom())
        right_val = self.visit(ctx.expression())
        op_sym    = ctx.operator().getText()
        if op_sym not in self.operations:
            raise Exception(f"Operador no reconegut en flip: {op_sym}")
        op_func = self.operations[op_sym]

        # Dos valors: op(right, left)
        if not callable(left_val) and not callable(right_val):
            if op_sym == '|':
                return self.functions.apply_mod_operation(right_val, left_val)
            elif op_sym == '#':
                return op_func(right_val, left_val)
            else:
                return self.functions.apply_binary_operation(
                    right_val, left_val, op_func
                )

        # Funció i valor
        if callable(left_val) and not callable(right_val):
            return lambda x: op_func(right_val, left_val(x))

        if not callable(left_val) and callable(right_val):
            return lambda x: op_func(right_val(x), left_val)

        raise RuntimeError("Flip no definit per a dues funcions")

    # Gestiona expressions vectorials (elements separats per espais)
    def visitVectorExpr(self, ctx):
        elements = [self.visit(p) for p in ctx.primary()]
        
        if len(elements) == 1:
            return elements[0]
        elif len(elements) == 2:
            first, second = elements
            if callable(first):
                try:
                    return first(second)
                except:
                    pass
            return self.vector_utils.concatenate(first, second)
        elif len(elements) >= 3:
            first = elements[0]
            # Detecta patró amb i. al mig
            for i in range(1, len(elements) - 1):
                if callable(elements[i]) and elements[i] == self.operations['i.']:
                    before = elements[:i]
                    i_result = elements[i](elements[i+1])
                    remaining = elements[i+2:]
                    new_elements = before + [i_result] + remaining
                    if len(new_elements) == 1:
                        return new_elements[0]
                    elif len(new_elements) == 2 and callable(new_elements[0]):
                        return new_elements[0](new_elements[1])
                    else:
                        result = new_elements[0]
                        for elem in new_elements[1:]:
                            if callable(result):
                                result = result(elem)
                            else:
                                result = self.vector_utils.concatenate(result, elem)
                        return result
            
            # Aplicació/concatenació estàndard
            if callable(first):
                if len(elements[1:]) == 1:
                    return first(elements[1])
                else:
                    arg = elements[1]
                    for elem in elements[2:]:
                        arg = self.vector_utils.concatenate(arg, elem)
                    return first(arg)
            else:
                result = first
                for elem in elements[1:]:
                    result = self.vector_utils.concatenate(result, elem)
                return result
        
        # Cas especial eq0
        if func_name == 'eq0':
            if len(args) == 1:
                return self.operations['='](np.array([0]), args[0])
            else:
                arg = args[0]
                for elem in args[1:]:
                    arg = self.vector_utils.concatenate(arg, elem)
                return self.operations['='](np.array([0]), arg)
        
        if len(args) == 1:
            return func(args[0])
        else:
            arg = args[0]
            for elem in args[1:]:
                arg = self.vector_utils.concatenate(arg, elem)
            return func(arg)
    
    # Funció identitat (])
    def visitIdentity(self, ctx):
        return self.operations[']']
    
    # Expressions entre parèntesis
    def visitParentheses(self, ctx):
        return self.visit(ctx.expression())
    
    # Resol operadors
    def visitOperator(self, ctx):
        symbol = ctx.getText()
        if symbol in self.operations:
            return self.operations[symbol]
        elif symbol in self.variables:
            return self.variables[symbol]
        else:
            raise Exception(f"Operador desconegut: {symbol}")

    # Funció unària sense expressió (operador:)
    def visitUnaryFunc(self, ctx):
        operator = self.visit(ctx.operator())
        
        if not callable(operator):
            if operator in self.operations:
                operator = self.operations[operator]
            else:
                raise Exception(f"Operador no reconegut en funció unària: {operator}")
        
        def unary_function(arg):
            return self.advanced_ops.apply_unary_operator(operator, arg)
        
        unary_function._is_unary_function = True
        unary_function._operator = operator
        
        return unary_function