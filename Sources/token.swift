public enum Token: Equatable {
    case Ident(String)
    case Int(String)

    case Illegal,
    Eof,
    Assign,

    Bang,
    Dash,
    ForwardSlash,
    Asterisk,
    Equal,
    NotEqual,
    LessThan,
    GreaterThan,

    Plus,
    Comma,
    Semicolon,
    Lparen,
    Rparen,
    LSquirly,
    RSquirly,

    Function,
    Let,

    If,
    Else,
    Return,
    True,
    False
}
