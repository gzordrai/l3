import ard as ard
from ard import Ard

class ArdExemple1 (Ard) :
        # S -> aSb | cT 
        # T -> cT  | epsilon
    def __init__(self) :
        self._axiom = self._S

    def _S(self) :
        if self._current.type == 'a' : 
            # S -> aSb
            print('S->aSb', self._current,  self._current.index)
            self._next()
            self._S()
            self._eat('b')
        elif self._current.type == 'c' :
            # S -> cT
            print('S->cT', self._current,  self._current.index)
            self._next()
            self._T()
        else :
            raise ard.SyntaxError("NO_RULE","S", self._current);
  
    def _T(self)  :
        if self._current.type == 'c' :
            # T -> cT
            print('T->cT', self._current, self._current.index)
            self._next()
            self._T()
        elif self._current.type in ('b', 'EOD') :
            print('T->epsilon', self._current,  self._current.index)
            # T -> epsilon
            pass
        else :
            raise ard.SyntaxError("NO_RULE","T", self._current);

if __name__ == '__main__' :
    c = ArdExemple1()
    try :
        c.parse('aacbb')
    except ard.SyntaxError as e :
        print (e)