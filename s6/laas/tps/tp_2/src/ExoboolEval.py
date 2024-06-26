from ard import Ard


class ExoboolEval(Ard):
    def __init__(self, debug: bool = False) -> None:
        super().__init__()
        self._axiom = self._E
        self._debug = debug

    def _E(self):
        if self._current.type in ("CONSTANT", "IDENT", "OPEN_BRACKET", "NOT"):
            if self._debug:
                print("E -> T Ep", self._current, self._current.index)

            a = self._T()
            b = self._Ep()

            return (a or b)

        else:
            raise SyntaxError("NO_RULE", "E", self._current)

    def _Ep(self):
        if self._current.type in ("OR"):
            if self._debug:
                print("Ep -> T Ep", self._current, self._current.index)

            self._next()
            a = self._T()
            b = self._Ep()

            return (a or b)

        elif self._current.type in ("CLOSE_BRACKET", "EOD"):
            if self._debug:
                print("Ep -> Epsilon", self._current, self._current.index)

            return False

        else:
            raise SyntaxError("NO_RULE", "Ep", self._current)

    def _T(self):
        if self._current.type in ("CONSTANT", "IDENT", "OPEN_BRACKET", "NOT"):
            if self._debug:
                print("T -> F Tp", self._current, self._current.index)

            a = self._F()
            b = self._Tp()

            return (a and b)

        else:
            raise SyntaxError("NO_RULE", "T", self._current)

    def _Tp(self):
        if self._current.type in ("AND"):
            if self._debug:
                print("Tp -> AND F Tp", self._current, self._current.index)

            self._next()
            a = self._F()
            b = self._Tp()

            return (a and b)

        elif self._current.type in ("CLOSE_BRACKET", "OR", "EOD"):
            if self._debug:
                print("Tp -> Epsilon", self._current, self._current.index)

            return True

        else:
            raise SyntaxError("NO_RULE", "Tp", self._current)

    def _F(self):
        match self._current.type:
            case "CONSTANT":
                if self._debug:
                    print("F -> CONSTANT", self._current, self._current.index)

                value = self._current.value
                self._next()

                return value

            case "IDENT":
                if self._debug:
                    print("F -> IDENT", self._current, self._current.index)

                self._next()

                return False

            case "OPEN_BRACKET":
                if self._debug:
                    print("F -> OPEN_BRACKET E CLOSE_BRACKET",
                          self._current, self._current.index)

                self._next()
                a = self._E()
                self._eat("CLOSE_BRACKET")

                return a

            case "NOT":
                if self._debug:
                    print("F -> NOT F", self._current, self._current.index)

                self._next()
                a = self._F()

                return (not a)

            case _:
                raise SyntaxError("NO_RULE", "F", self._current)
