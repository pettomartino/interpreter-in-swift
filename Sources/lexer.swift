private extension UnicodeScalar {
  func asChar()->Character {
    Character(self)
  }
}

final class Lexer {
  private var position: Int
  private var readPosition: Int
  private var input: [UnicodeScalar]
  private var ch: UnicodeScalar

  init(_ input: String) {
    self.position = 0
    self.readPosition = 0
    self.input = Array(input.unicodeScalars)
    ch = "\0"
    self.readChar()
  }

  func nextToken() -> Token {
    var tok: Token?
    self.skipWhitespace()
    switch self.ch {
    case "=":
      if self.peek() == "=" {
        self.readChar()
        tok = .Equal
      } else {
        tok = .Assign
      }

    case "{": tok = .LSquirly
    case "}": tok = .RSquirly
    case "(": tok = .Lparen
    case ")": tok = .Rparen
    case ",": tok = .Comma
    case ";": tok = .Semicolon
    case "+": tok = .Plus
    case "-": tok = .Dash
    case "!":
      if self.peek() == "=" {
        self.readChar()
        tok = .NotEqual
      } else {
        tok = .Bang
      }

    case ">": tok = .GreaterThan
    case "<": tok = .LessThan
    case "*": tok = .Asterisk
    case "/": tok = .ForwardSlash
    case "\0": tok = .Eof
    case "a"..."z", "A"..."Z", "_":
      let ident = self.readIdent()

      switch ident {
      case "fn": tok = .Function
      case "let": tok = .Let
      case "if": tok = .If
      case "else": tok = .Else
      case "true": tok = .True
      case "false": tok = .False
      case "return": tok = .Return
      default: tok = .Ident(ident)
      }
      return tok!

    case "0"..."9":
      tok = .Int(self.readInt())
      return tok!

    default:
      print("nothing")
    }

    self.readChar()
    return tok!
  }

  private func readChar() {
    if self.readPosition >= self.input.count {
      self.ch = "\0"
    } else {
      self.ch = self.input[self.readPosition]
    }
    self.position = self.readPosition
    self.readPosition += 1
  }

  private func peek() -> UnicodeScalar {
    if self.readPosition >= self.input.count {
      return "\0";
    }
    return self.input[self.readPosition]
  }

  private func skipWhitespace() {
    while self.ch.asChar().isWhitespace {
      self.readChar()
    }
  }

  private func readIdent() -> String {
    let pos = self.position
    while self.ch.asChar().isLetter || self.ch == "_" {
      self.readChar()
    }
    return String.init(String.UnicodeScalarView(self.input[pos..<self.position]))
  }

  private func readInt() -> String {
    let pos = self.position
    while ch.asChar().isNumber {
      self.readChar()
    }
    return String.init(String.UnicodeScalarView(self.input[pos..<self.position]))
  }
}
