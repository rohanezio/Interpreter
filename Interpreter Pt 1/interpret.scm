;#lang racket
; Interpreter Pt 1 EECS 345
; Group Members: Lee Radics, Zach Perlo, Rohan Krishna
; Case IDs:elr61, zip5, rxr353

(load "simpleParser.scm") ;Load simple parser to enable parser use

;The interpreter function used to parse/interpret the java-ish file (.javal)
(define interpret
  (lambda (filename)
    (evaluate (parser filename) '(()()));passes the filename to evaluate/parse program tree
    )
  )
  

;Function to evaluate and step through program tree
(define evaluate
  (lambda (prgm state)
    (cond
      ((and (null? prgm) (eq? state #t)) "true") ;if prgm null and equals state true
      ((and (null? prgm) (eq? state #f)) "false")
      ((null? prgm) state) ;now finally check if prgm is null, then return state
      (else (evaluate (cdr prgm) (MState (car prgm) state))) ;evaluate filename while calling MState on the command
      )                                                      ;if checks are passed 
    )
  )

;Function to return program state after command is run
;Commands: var, =, if, while, return and the state is ((x y ...) (1 2 ...))
(define MState
  (lambda (command state)
    (cond
      ;((eq? state "error") "error") ;return error if the state is error
      ((eq? (operator command) 'var) (declareHelper command state)) ;Variable declaration
      ((eq? (operator command) '=) (assignHelper command state)) ;Assign declaration
      ((eq? (operator command) 'if) (ifHelper command state)) ;if declaration
      ((eq? (operator command) 'while) (whileHelper command state)) ;while declaration
      ((eq? (operator command) 'return) (returnHelper command state)) ;return declaration
      (else (error 'badoperation "Invalid command")) ;standard throw error
      )
    )
  )

(define operator
  (lambda (lis)
    (car lis)
    )
  )

; Function to evaluate integer val of expression
; Example input: (+ a b) and state ((x y ...) (1 2 ...))
(Define MValue
        (lambda (expression state)
          (cond
            ((eq? (operator expression) '+) (+Helper expression state)) ; computing addition
            ((eq? (operator expression) '-) (-Helper expression state)) ; computing subtraction
            ((eq? (operator expression) '*) (*Helper expression state)) ; computing multiplication
            ((eq? (operator expression) '/) (/Helper expression state)) ; computing division
            ((eq? (operator expression) '%) (%Helper expression state)) ; computing mod
            (else (error 'badoperation "Invalid expression")) ;standard throw error
            )
          )
        )

; Function to evaluate truth val of expression
; Example input: (== x y) and state ((x y ...) (1 2 ...))
(Define MBool
        (lambda (expression state)
          (cond
            ((eq? (operator expression) '==) (==Helper expression state)) ; checking equality
            ((eq? (operator expression) '!=) (!=Helper expression state)) ; checking inequality
            ((eq? (operator expression) '>) (>Helper expression state)) ; checking greater than
            ((eq? (operator expression) '<) (<Helper expression state)) ; checking less than
            ((eq? (operator expression) '>=) (>=Helper expression state)) ; checking greater than or equal to
            ((eq? (operator expression) '<=) (<=Helper expression state)) ; checking less than or equal to
            (else (error 'badoperation "Invalid expression")) ;standard throw error
            )
          )
        )

; function to look up a variable to get its value from the state
; Example input: y and state ((x y ...) (1 2 ...)) would return 2
(define lookup
  (lambda (var state)
    (lookup_helper2 (lookup_helper var (car state)) (cdr state))
    )
  )

; returns the index the variable is stored in state
(define lookup_helper
  (lambda (var stateVars)
    (cond
      ((null? stateVars) (error 'badoperation "Variable not defined"))
      ((eq? var (car stateVars)) 1)
      (else (+ 1 (lookup_helper (var (cdr stateVars)))))
      )
    )
  )

; returns value at index x in state
(define lookup_helper2
  (lambda (x stateNums)
    (cond
      ((null? stateNums) (error 'badoperation "Variable not defined"))
      ((AND (eq? x 1) (eq? (car stateNums) ; NULL value for vars )) (error 'badoperation "Variable not initialized"))
      ((eq? x 1) (car stateNums))
      (else (lookup_helper2 (- x 1) (cdr stateNums)))
      )
    )
  )

    
; function to replace a variable's current value
; Example input: y, 5, and state ((x y ...) (1 2 ...)) would return state ((x y ...) (1 5 ...))
(define replaceVar
  (lambda (var newVal state)
    (cons (replace_helper (lookup_helper var (car state)) newVal (cdr state)))
    )
  )

; replaces value at index x with newVal in stateNums (returns stateNums)
(define replace_helper
  (lambda (x newVal stateNums)
    (cond
      ((null? stateNums) (error 'badoperation "Variable not defined"))
      ((eq? x 1) (cons newVal (cdr stateNums)))
      (else (cons (car stateNums) (replace_helper (- x 1) newVal (cdr stateNums))))
      )
    )
  )

;=====================;
;MState Helper Methods
;=====================;

; declare helper
(define declareHelper
  (lambda (command state)
    )
  )

; assign helper
(define assignHelper
  (lambda (command state)
    )
  )

; if helper
(define ifHelper
  (lambda (command state)
    )
  )

; while helper
(define whileHelper
  (lambda (command state)
    )
  )

; return helper
(define returnHelper
  (lambda (command state)
    )
  )

;=====================;
;MValue Helper Methods
;=====================;

; addition helper
(define +Helper
  (lambda (expression state)
    )
  )

; subtraction helper
(define -Helper
  (lambda (expression state)
    )
  )

; multiplication helper
(define *Helper
  (lambda (expression state)
    )
  )

; division helper
(define /Helper
  (lambda (expression state)
    )
  )

; mod helper
(define %Helper
  (lambda (expression state)
    )
  )

;=====================;
;MBool Helper Methods
;=====================;

; equality helper
(define ==Helper
  (lambda (expression state)
    )
  )

; inequality helper
(define !=Helper
  (lambda (expression state)
    )
  )

; greater than helper
(define >Helper
  (lambda (expression state)
    )
  )

; less than helper
(define <Helper
  (lambda (expression state)
    )
  )

; greater than or equal to helper
(define >=Helper
  (lambda (expression state)
    )
  )

; less than or equal to helper
(define <=Helper
  (lambda (expression state)
    )
  )

;======================;
;Other Helper Methods
;======================;