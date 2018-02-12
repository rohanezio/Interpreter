; Interpreter Pt 1 EECS 345
; Group Members: Lee Radics, Zach Perlo, Rohan Krishna
; Case IDs:elr61, zip5, rxr353

(load "simpleParser.scm") ;Load simple parser to enable parser use

;The interpreter function used to parse/interpret the java-like file (.javal)
(define interpret
  (lambda (filename)
    (evaluate filename)
    (M_state (parser filename) S) ; where S is the base state (probably blank list, will determine later)
  )
)

