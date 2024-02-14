from ard import Ard

class SimpleAnalyzer(Ard):
    def __init__(self, debug: bool = False) -> None:
        self._axiom = self._S
        self._debug = debug

    def _S(self) -> None:
        # S -> ERS
        if self._current.type in ("OUVRANTE", "LETTRE"):
            if self._debug:
                print("S -> ERS", self._current, self._current.index)

            self._E()
            self._R()
            self._S()

        # S -> eps
        elif self._current.type in ("FERMANTE", "EOD"):
            if self._debug:
                print("S -> eps", self._current)

        else:
            raise SyntaxError("NO_RULE", "S", self._current)


    def _E(self) -> None:
        # E -> lettre
        if self._current.type in ("LETTRE"):
            if self._debug:
                print("E -> LETTRE", self._current)

            self._next()

        # E -> (S)
        elif self._current.type in ("OUVRANTE"):
            if self._debug:
                print("E -> OUVRANTE S FERMANTE", self._current)

            self._eat("OUVRANTE")
            self._S()
            self._eat("FERMANTE")

        else:
            raise SyntaxError("NO_RULE", "E", self._current)

    def _R(self) -> None:
        # R -> entier
        if self._current.type in ("ENTIER"):
            if self._debug:
                print("R -> ENTIER", self._current)

            self._next()

        # R -> eps
        elif self._current.type in ("LETTRE", "OUVRANTE", "FERMANTE", "EOD"):
            if self._debug:
                print("R -> eps", self._current)

        else:
            raise SyntaxError("NO_RULE", "R", self._current)
