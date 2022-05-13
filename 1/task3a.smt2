(declare-const A1 Int)
(declare-const A2 Int)
(declare-const B1 Int)
(declare-const B2 Int)

(assert 
    (        
        and
        (=(+(* 3 A1)(* 1 A2)) 1)
        (=(+(* 3 B1)(* 1 B2)) 0)
        (=(+(* 5 A1)(* 2 A2)) 0)
        (=(+(* 5 B1)(* 2 B2)) 1)
    )
)

(check-sat)
(get-model)
(exit)