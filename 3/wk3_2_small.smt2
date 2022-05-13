(declare-const A1 Int)
(declare-const A2 Int)
(declare-const A3 Int)
(declare-const A4 Int)

(declare-const B1 Int)
(declare-const B2 Int)
(declare-const B3 Int)
(declare-const B4 Int)

(declare-const C1 Int)
(declare-const C2 Int)
(declare-const C3 Int)
(declare-const C4 Int)

(declare-const D1 Int)
(declare-const D2 Int)
(declare-const D3 Int)
(declare-const D4 Int)

(define-fun AnswerLimit ((Square Int)) Bool
   (or (= Square 1) (= Square 2) (= Square 3) (= Square 4))
)

;returns the biggest of 2 integers
(define-fun MaxOf ((A Int) (B Int)) Int
    (ite (> A B) A B)
)

;returns the biggest of 3 integers
(define-fun MaxOf ((A Int) (B Int) (C Int)) Int
    (ite (> A B) (ite (> A C) A C) (ite (> B C) B C))
)

;returns the amount of bulidings seen by an observer
(define-fun Count ((A Int) (B Int) (C Int) (D Int)) Int
    (+
        1 ;the first buliding is always seen
        (ite (> B A) 1 0)
        (ite (> C (MaxOf A B)) 1 0)
        (ite (> D (MaxOf A B C)) 1 0)        
    )
)

(assert
    (and

        (distinct A1 A2 A3 A4)
        (distinct B1 B2 B3 B4)
        (distinct C1 C2 C3 C4)
        (distinct D1 D2 D3 D4)

        (distinct A1 B1 C1 D1)
        (distinct A2 B2 C2 D2)
        (distinct A3 B3 C3 D3)
        (distinct A4 B4 C4 D4)

        (AnswerLimit A1)
        (AnswerLimit A2)
        (AnswerLimit A3)
        (AnswerLimit A4)
        (AnswerLimit B1)
        (AnswerLimit B2)
        (AnswerLimit B3)
        (AnswerLimit B4)
        (AnswerLimit C1)
        (AnswerLimit C2)
        (AnswerLimit C3)
        (AnswerLimit C4)
        (AnswerLimit D1)
        (AnswerLimit D2)
        (AnswerLimit D3)
        (AnswerLimit D4)

        (= (Count A1 B1 C1 D1) 1)
        (= (Count D1 C1 B1 A1) 2)

        (= (Count A2 B2 C2 D2) 2)
        (= (Count D2 C2 B2 A2) 1)

        (= (Count A3 B3 C3 D3) 3)
        (= (Count D3 C3 B3 A3) 2)

        (= (Count A4 B4 C4 D4) 2)
        (= (Count D4 C4 B4 A4) 3)

        (= (Count A1 A2 A3 A4) 1)
        (= (Count A4 A3 A2 A1) 4)
    )
)

(check-sat)
(get-model)
(exit)