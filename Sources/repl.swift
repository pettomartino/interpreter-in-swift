func initRepl() {
    print("Hello, this is the Monkey programming language!")
    print("Feel free to type in commands")

    while true {
        print(">>", terminator: " ")
        guard let line = readLine() else {
            break;
        }

        let lexer = Lexer(line)
        while case let token = lexer.nextToken(), token != Token.Eof {
            print(token)
        }
    }
}