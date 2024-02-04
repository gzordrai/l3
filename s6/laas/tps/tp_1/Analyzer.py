from ard import Ard

class Analyzer(Ard):
    def __init__(self, debug: bool = False) -> None:
        self._axiom = self._S
        self._debug = debug

    def _S(self):
        # S -> ERS
        if self._current.type in ("OUVRANTE", "LETTRE"):
            if self._debug:
                print("S -> ERS", self._current, self._current.index)

            a = self._E()
            b = self._R()
            c = self._S()

            return (a * b) + c

        # S -> eps
        elif self._current.type in ("FERMANTE", "EOD"):
            if self._debug:
                print("S -> eps", self._current)

            return ""

        else:
            raise SyntaxError("NO_RULE", "S", self._current)

    def _E(self):
        # E -> lettre
        if self._current.type in ("LETTRE"):
            if self._debug:
                print("E -> LETTRE", self._current)

            value = self._current.value
            self._next()

            return value

        # E -> (S)
        elif self._current.type in ("OUVRANTE"):
            if self._debug:
                print("E -> OUVRANTE S FERMANTE", self._current)

            self._eat("OUVRANTE")
            expr = self._S()
            self._eat("FERMANTE")

            return expr

        else:
            raise SyntaxError("NO_RULE", "E", self._current)

    def _R(self) -> int:
        # R -> entier
        if self._current.type in ("ENTIER"):
            if self._debug:
                print("R -> ENTIER", self._current)

            value = self._current.value
            self._next()

            return value

        # R -> eps
        elif self._current.type in ("LETTRE", "OUVRANTE", "FERMANTE", "EOD"):
            if self._debug:
                print("R -> eps", self._current)

            return 1

        else:
            raise SyntaxError("NO_RULE", "R", self._current)
