;Student number: 3781488
(declare-const T1Nuzzles Int)
(declare-const T2Nuzzles Int)
(declare-const T3Nuzzles Int)
(declare-const T4Nuzzles Int)
(declare-const T5Nuzzles Int)
(declare-const T6Nuzzles Int)

(declare-const T1Prittles Int)
(declare-const T2Prittles Int)
(declare-const T3Prittles Int)
(declare-const T4Prittles Int)
(declare-const T5Prittles Int)
(declare-const T6Prittles Int)

(declare-const T1Skipples Int)
(declare-const T2Skipples Int)
(declare-const T3Skipples Int)
(declare-const T4Skipples Int)
(declare-const T5Skipples Int)
(declare-const T6Skipples Int)

(declare-const T1Crottles Int)
(declare-const T2Crottles Int)
(declare-const T3Crottles Int)
(declare-const T4Crottles Int)
(declare-const T5Crottles Int)
(declare-const T6Crottles Int)

(declare-const T1Dupples Int)
(declare-const T2Dupples Int)
(declare-const T3Dupples Int)
(declare-const T4Dupples Int)
(declare-const T5Dupples Int)
(declare-const T6Dupples Int)

;this ensures that the trucks have a max load of 8000 kgs and that they always carry something
;and that they don't carry a negative amount of pallets
(define-fun TruckLoadRule ((Nuzzles Int) (Prittles Int) (Skipples Int) (Crottles Int) (Dupples Int)) Bool
    (and
        (<= (+ (* Nuzzles 800) (* Prittles 1300) (* Skipples 1000) (* Crottles 1500) (* Dupples 400)) 8000)
        (>= Nuzzles 0)
        (>= Prittles 0)
        (>= Skipples 0)
        (>= Crottles 0)
        (>= Dupples 0)
    )
)

;these give us the sum of a type of pallete accross all trucks
(define-fun NuzzlesSum () Int
    (+ T1Nuzzles T2Nuzzles T3Nuzzles T4Nuzzles T5Nuzzles T6Nuzzles)
)

(define-fun PrittlesSum () Int
    (+ T1Prittles T2Prittles T3Prittles T4Prittles T5Prittles T6Prittles)
)

(define-fun SkipplesSum () Int
    (+ T1Skipples T2Skipples T3Skipples T4Skipples T5Skipples T6Skipples)
)

(define-fun CrottlesSum () Int
    (+ T1Crottles T2Crottles T3Crottles T4Crottles T5Crottles T6Crottles)
)

(define-fun DupplesSum () Int
    (+ T1Dupples T2Dupples T3Dupples T4Dupples T5Dupples T6Dupples)
)

;the rule from the student number (no prittles and crottles in the same truck)
(define-fun PrittlesCrottlesRule ((Prittles Int) (Crottles Int)) Bool
    (=>
        (> Prittles 0)
        (= Crottles 0)
    )
)

(assert
    (and
        (= NuzzlesSum 4)        
        (= SkipplesSum 8)
        (= CrottlesSum 8)
        (= DupplesSum 12) 

        (TruckLoadRule T1Nuzzles T1Prittles T1Skipples T1Crottles T1Dupples) 
        (TruckLoadRule T2Nuzzles T2Prittles T2Skipples T2Crottles T2Dupples) 
        (TruckLoadRule T3Nuzzles T3Prittles T3Skipples T3Crottles T3Dupples)     
        (TruckLoadRule T4Nuzzles T4Prittles T4Skipples T4Crottles T4Dupples)
        (TruckLoadRule T5Nuzzles T5Prittles T5Skipples T5Crottles T5Dupples)
        (TruckLoadRule T6Nuzzles T6Prittles T6Skipples T6Crottles T6Dupples)

        ;skipples rule (only two trucks can hold skipples)
        (= T3Skipples 0)
        (= T4Skipples 0)
        (= T5Skipples 0)
        (= T6Skipples 0)
        
        ;All trucks can hold only 1 nuzzle
        (< T1Nuzzles 2)
        (< T2Nuzzles 2)
        (< T3Nuzzles 2)
        (< T4Nuzzles 2)
        (< T5Nuzzles 2)
        (< T6Nuzzles 2)

        (PrittlesCrottlesRule T1Prittles T1Crottles)
        (PrittlesCrottlesRule T2Prittles T2Crottles)
        (PrittlesCrottlesRule T3Prittles T3Crottles)
        (PrittlesCrottlesRule T4Prittles T4Crottles)
        (PrittlesCrottlesRule T5Prittles T5Crottles)
        (PrittlesCrottlesRule T6Prittles T6Crottles)
    
    )
)

(maximize PrittlesSum)

(check-sat)
(get-model)

(exit)