module View.FontData exposing (font, fontSrc, CharInfo)

import Dict exposing (Dict)


type alias CharInfo =
    { x : Float
    , y : Float
    , w : Float
    }


font : Dict String CharInfo
font =
    Dict.fromList
        [ ( "!", CharInfo 0 0 1 )
        , ( "\"", CharInfo 1 0 3 )
        , ( "#", CharInfo 4 0 5 )
        , ( "$", CharInfo 9 0 4 )
        , ( "%", CharInfo 13 0 7 )
        , ( "&", CharInfo 20 0 6 )
        , ( "'", CharInfo 26 0 1 )
        , ( "(", CharInfo 27 0 3 )
        , ( ")", CharInfo 30 0 3 )
        , ( "*", CharInfo 33 0 5 )
        , ( "+", CharInfo 38 0 5 )
        , ( ",", CharInfo 43 0 2 )
        , ( "-", CharInfo 45 0 4 )
        , ( ".", CharInfo 49 0 1 )
        , ( "/", CharInfo 50 0 4 )
        , ( "0", CharInfo 54 0 4 )
        , ( "1", CharInfo 58 0 4 )
        , ( "2", CharInfo 62 0 4 )
        , ( "3", CharInfo 66 0 4 )
        , ( "4", CharInfo 70 0 4 )
        , ( "5", CharInfo 74 0 4 )
        , ( "6", CharInfo 78 0 4 )
        , ( "7", CharInfo 82 0 4 )
        , ( "8", CharInfo 86 0 4 )
        , ( "9", CharInfo 90 0 4 )
        , ( ":", CharInfo 94 0 1 )
        , ( ";", CharInfo 95 0 2 )
        , ( "<", CharInfo 97 0 5 )
        , ( "=", CharInfo 102 0 4 )
        , ( ">", CharInfo 106 0 5 )
        , ( "?", CharInfo 111 0 4 )
        , ( "@", CharInfo 115 0 7 )
        , ( "A", CharInfo 122 0 4 )
        , ( "B", CharInfo 0 11 4 )
        , ( "C", CharInfo 4 11 4 )
        , ( "D", CharInfo 8 11 4 )
        , ( "E", CharInfo 12 11 3 )
        , ( "F", CharInfo 15 11 3 )
        , ( "G", CharInfo 18 11 4 )
        , ( "H", CharInfo 22 11 4 )
        , ( "I", CharInfo 26 11 3 )
        , ( "J", CharInfo 29 11 4 )
        , ( "K", CharInfo 33 11 4 )
        , ( "L", CharInfo 37 11 3 )
        , ( "M", CharInfo 40 11 5 )
        , ( "N", CharInfo 45 11 4 )
        , ( "O", CharInfo 49 11 4 )
        , ( "P", CharInfo 53 11 4 )
        , ( "Q", CharInfo 57 11 4 )
        , ( "R", CharInfo 61 11 4 )
        , ( "S", CharInfo 65 11 4 )
        , ( "T", CharInfo 69 11 5 )
        , ( "U", CharInfo 74 11 4 )
        , ( "V", CharInfo 78 11 4 )
        , ( "W", CharInfo 82 11 7 )
        , ( "X", CharInfo 89 11 5 )
        , ( "Y", CharInfo 94 11 5 )
        , ( "Z", CharInfo 99 11 4 )
        , ( "[", CharInfo 103 11 2 )
        , ( "\\", CharInfo 105 11 4 )
        , ( "]", CharInfo 109 11 2 )
        , ( "^", CharInfo 111 11 3 )
        , ( "_", CharInfo 114 11 4 )
        , ( "a", CharInfo 118 11 3 )
        , ( "b", CharInfo 121 11 3 )
        , ( "c", CharInfo 124 11 3 )
        , ( "d", CharInfo 0 22 3 )
        , ( "e", CharInfo 3 22 3 )
        , ( "f", CharInfo 6 22 4 )
        , ( "ff", CharInfo 10 22 6 )
        , ( "ffi", CharInfo 16 22 6 )
        , ( "fi", CharInfo 22 22 4 )
        , ( "fj", CharInfo 26 22 4 )
        , ( "g", CharInfo 30 22 3 )
        , ( "gj", CharInfo 33 22 5 )
        , ( "h", CharInfo 38 22 3 )
        , ( "i", CharInfo 41 22 1 )
        , ( "j", CharInfo 42 22 3 )
        , ( "jj", CharInfo 45 22 5 )
        , ( "k", CharInfo 50 22 3 )
        , ( "l", CharInfo 53 22 1 )
        , ( "m", CharInfo 54 22 5 )
        , ( "n", CharInfo 59 22 3 )
        , ( "o", CharInfo 62 22 3 )
        , ( "p", CharInfo 65 22 3 )
        , ( "q", CharInfo 68 22 3 )
        , ( "r", CharInfo 71 22 3 )
        , ( "s", CharInfo 74 22 3 )
        , ( "ss", CharInfo 77 22 6 )
        , ( "t", CharInfo 83 22 3 )
        , ( "u", CharInfo 86 22 3 )
        , ( "v", CharInfo 89 22 3 )
        , ( "w", CharInfo 92 22 5 )
        , ( "x", CharInfo 97 22 3 )
        , ( "y", CharInfo 100 22 3 )
        , ( "yj", CharInfo 103 22 5 )
        , ( "z", CharInfo 108 22 3 )
        , ( "{", CharInfo 111 22 3 )
        , ( "|", CharInfo 114 22 1 )
        , ( "}", CharInfo 115 22 3 )
        , ( "~", CharInfo 118 22 4 )
        , ( "×", CharInfo 122 22 5 )
        , ( "⁄", CharInfo 0 33 3 )
        ]


fontSrc : String
fontSrc =
    "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAIAAAABAAQAAAAD6rULSAAAB7ElEQVR4nO2SXUiTYRzFz/PsJV5ki7cvWDBpUZMuohKLEvqwK5NBREZeBBFReFFRsEEQ2UYRXUQQ60oWXdiFsGLOogZF+ZIGBtEHSmwIc5KwbNkrw+a71bPTxVAYRdJFd527c+D/5wfnoM/iuMXvnBc2v0yn79EOtjrQSu7JSf+0qvdANbZHS4fA7qAsXp/AZBiFNTlg9j1btLpIzB4ybO/99q58f650Viv2Hku7ur+23dobXKrtPvNJlJ8Whg0cTTU8X1m3qjPZj9CN1GOev4N1PZtcgbenj4DjLHKuyhDiHEGyRIskWSFtCqJWssaZANzG2mtNgX3D5upos9kcGtD2I/AByJ9ymC/gufsRUkCDHQd0oD4jdo3KRLkpPNMIdRNw24YjIg8seRU2hLq8AZgagpKSwA/d6xAtSJ6wdVGRD2POdBfc7pQrigLE+nkwWwdAygUwHQBwEQBrNMhadHggs9tGt5aTt6t+JgFk8nFLcYykRbKD8sHhgyv8yUe+wZORBl8PMvJJLNY7ERa+49u/AE6+kXYVA1i+E1vUldfSCYgEdKDNi3fqUlBOAswCYnakc/rqBRRQycc/+4sDfEZS9XVQAljmXQDbAQlgauOICQD4ljiHX2vI/rGX3waLn5h//XSRffwP/knwE7Ls8c1/5o/HAAAAAElFTkSuQmCC"
