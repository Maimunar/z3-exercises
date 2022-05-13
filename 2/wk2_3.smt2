(declare-const Q1 String)
(declare-const Q2 String)
(declare-const Q3 String)

(define-fun AnswerLimit ((Question String)) Bool
   (or (= Question "A") (= Question "B") (= Question "C") (= Question "D"))
)
(define-fun ToInt ((Question String) (Answer String)) Int
    (ite (= Question Answer) 1 0)
)
(define-fun AllToInt ((Answer String)) Int 
    (+ (ToInt Q1 Answer) (ToInt Q2 Answer) (ToInt Q3 Answer))
)
(assert
    (and
        (AnswerLimit Q1)
        (AnswerLimit Q2)
        (AnswerLimit Q3)
        (= Q1 Q2) 
        (or 
            (and (= (AllToInt "B") 0) (= Q2 "A") )
            (and (= (AllToInt "B") 1) (= Q2 "B") )
            (and (= (AllToInt "B") 2) (= Q2 "C") )
            (and (= (AllToInt "B") 3) (= Q2 "D") )
        )
        (or
            (and (= (AllToInt "A") 0) (= Q3 "A") )
            (and (= (AllToInt "A") 1) (= Q3 "B") )
            (and (= (AllToInt "A") 2) (= Q3 "C") )
            (and (= (AllToInt "A") 3) (= Q3 "D") )
        )
        
    )
)

(check-sat)
(get-model)
(exit)