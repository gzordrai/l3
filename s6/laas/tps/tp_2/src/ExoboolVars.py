from ExoboolLexer import ExoboolLexer
from ard import Ard


class ExoboolVars(Ard):
    def __init__(self, debug: bool = False) -> None:
        super().__init__()
        self._axiom = self._E
        self._debug: bool = debug
        self.indents: int = 0

    def _E(self) -> int:
        if self._current.type in ("CONSTANT", "IDENT", "OPEN_BRACKET", "NOT"):
            if self._debug:
                print("E -> T Ep", self._current, self._current.index)

            self._T()
            self._Ep()

            # Remise a 0 pour pouvoir tester plusieurs expressions dans la boucles du main
            tmp = self.indents
            self.indents = 0

            return tmp

        else:
            raise SyntaxError("NO_RULE", "E", self._current)

    def _Ep(self) -> None:
        if self._current.type in ("OR"):
            if self._debug:
                print("Ep -> T Ep", self._current, self._current.index)

            self._next()
            self._T()
            self._Ep()

        elif self._current.type in ("CLOSE_BRACKET", "EOD"):
            if self._debug:
                print("Ep -> Epsilon", self._current, self._current.index)

        else:
            raise SyntaxError("NO_RULE", "Ep", self._current)

    def _T(self) -> None:
        if self._current.type in ("CONSTANT", "IDENT", "OPEN_BRACKET", "NOT"):
            if self._debug:
                print("T -> F Tp", self._current, self._current.index)

            self._F()
            self._Tp()

        else:
            raise SyntaxError("NO_RULE", "T", self._current)

    def _Tp(self) -> None:
        if self._current.type in ("AND"):
            if self._debug:
                print("Tp -> AND F Tp", self._current, self._current.index)

            self._next()
            self._F()
            self._Tp()

        elif self._current.type in ("CLOSE_BRACKET", "OR", "EOD"):
            if self._debug:
                print("Tp -> Epsilon", self._current, self._current.index)

        else:
            raise SyntaxError("NO_RULE", "Tp", self._current)

    def _F(self) -> None:
        match self._current.type:
            case "CONSTANT":
                if self._debug:
                    print("F -> CONSTANT", self._current, self._current.index)

                self._next()

            case "IDENT":
                if self._debug:
                    print("F -> IDENT", self._current, self._current.index)

                self.indents += 1
                self._next()

            case "OPEN_BRACKET":
                if self._debug:
                    print("F -> OPEN_BRACKET E CLOSE_BRACKET",
                          self._current, self._current.index)

                self._next()
                self._E()
                self._eat("CLOSE_BRACKET")

            case "NOT":
                if self._debug:
                    print("F -> NOT F", self._current, self._current.index)

                self._next()
                self._F()

            case _:
                raise SyntaxError("NO_RULE", "F", self._current)


if __name__ == "__main__":
    parser: ExoboolVars = ExoboolVars()
    lexer: ExoboolLexer = ExoboolLexer()

    try:
        print(parser.parse("a && b && (TRUE || a || c)", lexer))
    except SyntaxError as e:
        print(e)
