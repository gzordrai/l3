from ExoboolLexer import ExoboolLexer
from ExoboolNested import ExoboolNested
from ExoboolPostfix import ExoboolPostfix
from ExoboolVars import ExoboolVars
from ard import Ard
from ExoboolEval import ExoboolEval

if __name__ == "__main__":
    parser: Ard
    lexer = ExoboolLexer()
    inputs: list[str] = []

    print("Exercice 1:")
    parser = ExoboolEval()
    inputs = ["TRUE && TRUE", "TRUE && FALSE", "FALSE && FALSE", "TRUE",
              "FALSE", "FALSE || TRUE", "FALSE || FALSE", "TRUE || TRUE"]

    for input in inputs:
        print(input, "=>", parser.parse(input, lexer))

    print("\nExercice 2.1:")
    parser = ExoboolVars()
    inputs = ["a && b && (TRUE || a || c)", "a && b && (TRUE || a || c) && (TRUE || a || c)",
              "a && b && (TRUE || a || c) && (TRUE || a || c) && (TRUE || a || c)"]

    for input in inputs:
        print(input, "=>", parser.parse(input, lexer))

    print("\nExercice 2.2:")
    parser = ExoboolNested()
    inputs = ["a && b && (TRUE || a || c)", "a && (b && (TRUE || a || c)) && (TRUE || a || c)",
              "TRUE && (a && (b && (TRUE || a || c))) && (TRUE || a || c) && (TRUE || a || c)"]

    for input in inputs:
        print(input, "=>", parser.parse(input, lexer))

    print("\nExercice 3:")
    parser = ExoboolPostfix()
    inputs = ["a && b", "a && b && c", "a || b && c",
              "(a || b) && c", "(a || b) && (c || d)"]

    for input in inputs:
        print(input, "=>", parser.parse(input, lexer))
