from sly import Lexer

class SimpleLexer(Lexer):
    tokens = { ENTIER, LETTRE, OUVRANTE, FERMANTE }

    ENTIER = r"[0-9]"
    LETTRE = r"[a-zA-Z_]"
    OUVRANTE = r"\("
    FERMANTE = r"\)"

    def ENTIER(self, token):
        token.value = int(token.value)

        return token