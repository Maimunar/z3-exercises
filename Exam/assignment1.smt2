(declare-fun Marbles (Int) Int)


(assert 
    (and
        ;must be positive
        (>= (Marbles 1) 0)
        (>= (Marbles 2) 0)
        (>= (Marbles 3) 0)
        (>= (Marbles 4) 0)
        (>= (Marbles 5) 0)

        (= (Marbles 0) 4) ;start value
        ;defining 3 functions at all timestamps
        ;It doesn't need to be an exor - in a case where both would give the same answer, that is still fine logic-wise
        (or
           (= (Marbles 1) (* (Marbles 0) 2))
           (= (Marbles 1) (+ (Marbles 0) 7))
           (= (Marbles 1) (- (Marbles 0) 5))
        )
        (or
           (= (Marbles 2) (* (Marbles 1) 2))
           (= (Marbles 2) (+ (Marbles 1) 7))
           (= (Marbles 2) (- (Marbles 1) 5))
        )
        (or
           (= (Marbles 3) (* (Marbles 2) 2))
           (= (Marbles 3) (+ (Marbles 2) 7))
           (= (Marbles 3) (- (Marbles 2) 5))
        )
        (or
           (= (Marbles 4) (* (Marbles 3) 2))
           (= (Marbles 4) (+ (Marbles 3) 7))
           (= (Marbles 4) (- (Marbles 3) 5))
        )
        (or
           (= (Marbles 5) (* (Marbles 4) 2))
           (= (Marbles 5) (+ (Marbles 4) 7))
           (= (Marbles 5) (- (Marbles 4) 5))
        )                                
        (= (Marbles 5) 5) ;end value
    )      
)

(check-sat)
(get-model)
(exit)