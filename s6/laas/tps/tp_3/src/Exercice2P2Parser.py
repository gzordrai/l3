from sly import Parser
from ExoboolLexer import ExoboolLexer


class Exercice2Q2Parser(Parser):
    tokens = ExoboolLexer.tokens
    start = 'e'

    # E -> e OR t | t
    @_('e OR t', 't')
    def e(self, p):
        if (len(p) < 2):
            return p[0]
        return p[0] or p[2]

    # T -> t && f | f
    @_('t AND f', 'f')
    def t(self, p):
        # print(len(p))
        if (len(p) < 2):
            return p[0]
        return p[0] and p[2]

    # F -> !F | ( E ) | c | i
    @_('NOT f', 'OPEN_BRACKET e CLOSE_BRACKET', 'CONSTANT', 'IDENT')
    def f(self, p):
        # On commence par un '!'
        if (len(p) == 2):
            return not p[1]
        # On commence par un '('
        if (len(p) == 3):
            return p[1]
        # Gestion de la Constante
        if (p[0] == True or p[0] == False):
            return p[0]
        # Ici on gère lorsque la constante vaut false mais aussi l'ident vaut forcement false (TDM2 Q4)
        return False


if __name__ == '__main__':
    lexer = ExoboolLexer()
    parser = Exercice2Q2Parser()
    while True:
        try:
            text = input("input: ")
            result = parser.parse(lexer.tokenize(text))
            print(result)
        except EOFError:
            break
