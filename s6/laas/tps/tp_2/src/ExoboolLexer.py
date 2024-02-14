from sly import Lexer


class ExoboolLexer(Lexer):
    tokens = {CONSTANT, IDENT, NOT, OR, AND, OPEN_BRACKET, CLOSE_BRACKET}

    ignore = " \t"

    CONSTANT = r"true|True|TRUE|false|False|FALSE"  # case insensitive
    IDENT = r"[A-Za-z](_?[A-Za-z0-9])*"
    NOT = r"!"
    OR = r"\|{2}"
    AND = r"\&{2}"
    OPEN_BRACKET = r"\("
    CLOSE_BRACKET = r"\)"

    def CONSTANT(self, token):
        if token.value.capitalize() == "True":
            token.value = True
        elif token.value.capitalize() == "False":
            token.value = False

        return token

    @_(r"\s+")
    def ignore_spaces(self, token):
        self.lineno += len(token.value)

    @_(r"\n+")
    def ignore_newLine(self, token):
        self.lineno += len(token.value)
