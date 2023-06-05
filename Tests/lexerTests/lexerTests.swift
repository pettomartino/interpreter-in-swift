import XCTest
@testable import Interpreter

final class LexerTests: XCTestCase {

    func testNextToken() {
        let lexer = Lexer("=+(){},;")

        let expectedTokens: [Token] = [
            .Assign,
            .Plus,
            .Lparen,
            .Rparen,
            .LSquirly,
            .RSquirly,
            .Comma,
            .Semicolon
        ]

        for expectedToken in expectedTokens {
            let nextToken = lexer.nextToken()
            XCTAssertEqual(nextToken, expectedToken)
        }
    }

    func testLine() {
        let input = "let five = 5;"
        let lexer = Lexer(input)
        let expectedTokens: [Token] = [
            .Let,
            .Ident("five"),
            .Assign,
            .Int("5"),
            .Semicolon
        ]
          for expectedToken in expectedTokens {
            let nextToken = lexer.nextToken()
            XCTAssertEqual(nextToken, expectedToken)
        }
    }

    func testComplete() {
        let input = ###"""
let five = 5;
let ten = 10;
let add = fn(x, y) {
    x + y;
};
let result = add(five, ten);
!-/*5;
5 < 10 > 5;
if (5 < 10) {
return true;
} else {
return false;
}

10 == 10;
10 != 9;
"""###;

        let lexer = Lexer(input)

        let expectedTokens: [Token] = [
            .Let,
            .Ident("five"),
            .Assign,
            .Int("5"),
            .Semicolon,
            .Let,
            .Ident("ten"),
            .Assign,
            .Int("10"),
            .Semicolon,
            .Let,
            .Ident("add"),
            .Assign,
            .Function,
            .Lparen,
            .Ident("x"),
            .Comma,
            .Ident("y"),
            .Rparen,
            .LSquirly,
            .Ident("x"),
            .Plus,
            .Ident("y"),
            .Semicolon,
            .RSquirly,
            .Semicolon,
            .Let,
            .Ident("result"),
            .Assign,
            .Ident("add"),
            .Lparen,
            .Ident("five"),
            .Comma,
            .Ident("ten"),
            .Rparen,
            .Semicolon,


            .Bang,
            .Dash,
            .ForwardSlash,
            .Asterisk,
            .Int("5"),
            .Semicolon,
            .Int("5"),
            .LessThan,
            .Int("10"),
            .GreaterThan,
            .Int("5"),
            .Semicolon,
            .If,
            .Lparen,
            .Int("5"),
            .LessThan,
            .Int("10"),
            .Rparen,
            .LSquirly,
            .Return,
            .True,
            .Semicolon,
            .RSquirly,
            .Else,
            .LSquirly,
            .Return,
            .False,
            .Semicolon,
            .RSquirly,

            .Int("10"),
            .Equal,
            .Int("10"),
            .Semicolon,
            .Int("10"),
            .NotEqual,
            .Int("9"),
            .Semicolon,

            .Eof,
        ]

        for expectedToken in expectedTokens {
            let nextToken = lexer.nextToken()
            XCTAssertEqual(nextToken, expectedToken)
        }
    }
    
    // func testIdentifier() {
    //     let lexer = Lexer("variable")
    //     let expectedToken: Token = .Ident("variable")
    //     let nextToken = lexer.nextToken()
        
    //     XCTAssertEqual(nextToken, expectedToken)
    // }

    // func testNumber() {
    //     let lexer = Lexer("123")
    //     let expectedToken = Token.Int("123")
    //     let nextToken = lexer.nextToken()
        
    //     XCTAssertEqual(nextToken, expectedToken)
    // }
}