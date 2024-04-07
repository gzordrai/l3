from sly import Parser
from sly import Lexer


class MiniLexer(Lexer):
    tokens = {A, B}
    A = 'a'
    B = 'b'

    ignore = ' \t'


class AnBnParser(Parser):
    tokens = MiniLexer.tokens
    start = 's'
    # s -> A s B  :

    @_('A s B')
    def s(self, p):
        return None
    # s -> epsilon  :

    @_('')
    def s(self, p):
        return None


if __name__ == '__main__':
    lexer = MiniLexer()
    parser = AnBnParser()
    while True:
        try:
            text = input('test a^n b^n > ')
            result = parser.parse(lexer.tokenize(text))
            print(result)
        except EOFError:
            break
