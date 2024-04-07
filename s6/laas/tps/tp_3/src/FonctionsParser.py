from sly import Parser
from FonctionsLexer import FonctionsLexer


class FonctionsParser(Parser):
    tokens = FonctionsLexer.tokens
    start = 'E'

    def __init__(self) -> None:
        super().__init__()

    @_("CONST")
    def E(self, p):
        return (1, p[0], 0)
        # return 0                   Q4
        # return p[0]                Q3
        # return 1                   Q2
        # return None                Q1

    @_('MONA OUVR E FERM')
    def E(self, p):
        return ((p[2][0]), (p[2][1]*3), (p[2][2]+1))
        # return p[2] + 1            Q4
        # return p[2]*3              Q3
        # return p[2]                Q2
        # return None                Q1

    @_('DIA OUVR E COMMA E FERM')
    def E(self, p):
        return ((p[2][0] + p[4][0]), (p[2][1] + p[4][0]), (max(p[2][2], p[4][2])+1))
        # return max(p[2], p[4])+1   Q4
        # return p[2] + p[4]         Q2
        # return p[2] + p[4]         Q2
        # return None                Q1


if __name__ == "__main__":
    lexer = FonctionsLexer()
    parser = FonctionsParser()

    while True:
        try:
            text = input("fonction > ")
            result = parser.parse(lexer.tokenize(text))
            print(result)
        except EOFError:
            break
