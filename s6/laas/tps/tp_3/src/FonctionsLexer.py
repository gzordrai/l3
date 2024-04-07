from sly import Lexer


class FonctionsLexer(Lexer):
    tokens = {OUVR, FERM, CONST, MONA, DIA, COMMA}
    CONST = '[1-9](_?[0-9])*|0'  # constante (entier décimal)
    MONA = 'g'     # fonction monadique (1 argument)
    DIA = 'f'      # fonction diadique (2 arguments)
    OUVR = '[(]'
    FERM = '[)]'
    COMMA = ','

    # convert string value to int
    def CONST(self, t):
        t.value = int(t.value)
        return t

    ignore = ' \t'

    @_(r'\n+')
    def ignore_newline(self, t):
        self.lineno += len(t.value)
