(declare-const A1First Int)
(declare-const A2First Int)
(declare-const B1First Int)
(declare-const B2First Int)
(declare-const A1Second Int)
(declare-const A2Second Int)
(declare-const B1Second Int)
(declare-const B2Second Int)

; A1First + 0.1 * A1Second
(assert 
    (        
        and
        (<= A1Second 9)
        (<= A2Second 9)
        (<= B1Second 9)
        (<= B2Second 9)
        
        (>= A1Second 0)
        (>= A2Second 0)
        (>= B1Second 0)
        (>= B2Second 0)

        (=(+(* 4 (+ A1First (* A1Second 0.1)))(* 7 (+ A2First (* A2Second 0.1)))) 1)
        (=(+(* 4 (+ B1First (* B1Second 0.1)))(* 7 (+ B2First (* B2Second 0.1)))) 0)
        (=(+(* 2 (+ A1First (* A1Second 0.1)))(* 6 (+ A2First (* A2Second 0.1)))) 0)
        (=(+(* 2 (+ B1First (* B1Second 0.1)))(* 6 (+ B2First (* B2Second 0.1)))) 1)
    )
)

(check-sat)
(get-model)
(exit)