import inspect


def singleton(class_):
    instances = {}

    def getinstance(*args, **kwargs):
        if class_ not in instances:
            instances[class_] = class_(*args, **kwargs)
        return instances[class_]
    return getinstance


@singleton
class __EOD():
    def __str__(self):
        return "<EOD>"

    def __init__(self):
        self.type = "EOD"
        self.value = self
        self.index = None


EOD = __EOD()


@singleton
class TrivialLexer():
    class __Token():
        def __init__(self, char, index):
            self.value = char
            self.type = char
            self.index = index

        def __str__(self):
            return f"Token(type='{self.type}',value='{self.value}')"

        def __repr__(self):
            return self.__str__()

    def tokenize(self, string):
        for index, char in enumerate(string):
            yield self.__Token(char, index)


TRIVIAL_LEXER = TrivialLexer()


class ParserException(Exception):
    pass


class SyntaxError(Exception):
    """
        à déclencher à la rencontre d'un erreur de syntaxe
    """

    def __init__(self, etype, variable, current):
        """
            etype : type d'erreur
            variable : variable (de la grammaire) courante lors de la rencontre de l'erreur
            current : token courant lors de la rencontre de l'erreur
        """
        self.type = etype
        self.variable = variable
        self._current = current

    def __str__(self):
        return f"SyntaxError {self.type} for variable {self.variable} (current token : {self._current})"


class Ard ():
    """
        Classe de Base pour Analyseur Récursif Descendant
        Les symboles à analyser sont des caractères lus dans le Reader fourni à l'instanciation.
        Cette classe doit être étendue pour implémenter des méthodes d'analyse adaptées à la grammaire

        @author Bruno.Bogaert (at) univ-lille.fr
    """
    _current = None  # current token (LL(1) look ahead), protégé
    __input = None  # tokens iterator, privé

    def _next(self):  # méthode protégée
        """
            Avance d'une position dans la lecture du texte
            @throws ParserException si on est en fin de texte.
        """
        if (self._current == EOD):
            raise ParserException()
        try:
            self._current = next(self.__input)
        except StopIteration:
            self._current = EOD

    def _eat(self, expected):  # méthode protégée
        """
            Vérifie que le caractère courant correspond au caractère attendu
            puis progresse d'une position dans la lecture du texte.

            expected : str ou ensemble ou liste ou tuple de str

            @throws SyntaxError si la vérification de correspondance échoue
        """
        if (((isinstance(expected, tuple) or isinstance(expected, list) or isinstance(expected, set)) and self._current.type not in expected)
                or self._current.type != expected):
            raise SyntaxError(f"UNEXPECTED_TOKEN (expected {expected})", inspect.stack()[
                              1][3], self._current)
        self._next()

    def parse(self, data, lexer=TRIVIAL_LEXER):
        """
            Réalise l'analyse syntaxique du texte data
            La lecture du texte est effectuée par l'analyseur lexical lexer
            (à défaut de lexer, un analyseur lexical trivial qui transforme chaque caractère en Token est utilisé)
            @throws SyntaxError En cas d'erreur de syntaxe
            @throws ParserException  En cas d'erruer de utilisation du parser.
        """
        # initialise iterator :
        self.__input = iter(lexer.tokenize(data))
        self._current = None
        self._next()

        # parse :
        res = self._axiom()

        # check end of data :
        if (self._current != EOD):
            raise SyntaxError(f"UNEXPECTED_TOKEN (expected {
                              EOD})", "axiom", self._current)
        return res
