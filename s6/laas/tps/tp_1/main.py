from Analyzer import Analyzer
from SimpleLexer import SimpleLexer
from SimpleAnalyzer import SimpleAnalyzer

if __name__ == "__main__":
    lexer = SimpleLexer()
    analyzer = SimpleAnalyzer()

    print("Simple analyzer:")
    for word in ["aab", "a2b3a2", "a(ba)2", "(a(bc)2)3(ba)2"]:
        print(f"Analyzing {word}")
        analyzer.parse(word, lexer)

    analyzer = Analyzer()

    print("\nAnalyzer:")
    for word in ["ba2", "(ba)2", "(a(bc)2)3(ba)2"]:
        print(f"Analyzing {word} => {analyzer.parse(word, lexer)}")
