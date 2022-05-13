(declare-fun Shore1Rabbits (Int) Int)
(declare-fun Shore1Wolves (Int) Int)
(declare-fun Shore2Rabbits (Int) Int)
(declare-fun Shore2Wolfs (Int) Int)

(define-fun TotalWolfsAtTimestamp ((Timestamp Int)) Int
    (+
        (Shore1Wolves Timestamp)
        (Shore2Wolfs Timestamp)
    )
) 

(define-fun TotalRabbitsAtTimestamp ((Timestamp Int)) Int
    (+
        (Shore1Rabbits Timestamp)
        (Shore2Rabbits Timestamp)
    )
) 

(define-fun AnimalsOnShore1AtTimestamp ((Timestamp Int)) Int
    (+
        (Shore1Wolves Timestamp)
        (Shore1Rabbits Timestamp)
    )
)

(define-fun AnimalsOnShore2AtTimestamp ((Timestamp Int)) Int
    (+
        (Shore2Wolfs Timestamp)
        (Shore2Rabbits Timestamp)
    )
)

(define-fun EatingRule ((Timestamp Int)) Bool
    (and
        (or
            (= (Shore1Rabbits Timestamp) 0)
            (>= (Shore1Rabbits Timestamp) (Shore1Wolves Timestamp))
        )
        (or
            (= (Shore2Rabbits Timestamp) 0)
            (>= (Shore2Rabbits Timestamp) (Shore2Wolfs Timestamp))
        )
    )
)

(define-fun TotalAnimalsRule ((Timestamp Int)) Bool
    (and (= (TotalWolfsAtTimestamp Timestamp) 3) (= (TotalRabbitsAtTimestamp Timestamp) 3))
)

;rules for movement from the first shore to the second
(define-fun Movement12Rule ((Timestamp Int)) Bool
    (and        
        ;ensure that no rabbits moved in the wrong direction
        (>= (Shore1Rabbits Timestamp) (Shore1Rabbits (+ Timestamp 1)))
        ;ensure that no wolves moved in the wrong direction
        (>= (Shore1Wolves Timestamp) (Shore1Wolves (+ Timestamp 1)))
        ;ensure that there was at least 1 animal moved
        (> (AnimalsOnShore1AtTimestamp Timestamp) (AnimalsOnShore1AtTimestamp (+ Timestamp 1)))
        ;ensure that there were no more than 2 animals moved
        (<= (- (AnimalsOnShore1AtTimestamp Timestamp) (AnimalsOnShore1AtTimestamp (+ Timestamp 1))) 2)
        ;ensure that the eating rule is enforced 
        ;(timestamp+1 since at timestamp 0 the animals are predetermined)
        (EatingRule (+ Timestamp 1))
        ;ensure that the total nr of animals is the same (timestamp+1 since at timestamp 0 the animals are predetermined)
        (TotalAnimalsRule (+ Timestamp 1))
    )
)

;rules for movement from the second shore to the first
;same logic as the other direction, just reversed
(define-fun Movement21Rule ((Timestamp Int)) Bool
    (and
        (<= (Shore1Rabbits Timestamp) (Shore1Rabbits (+ Timestamp 1)))
        (<= (Shore1Wolves Timestamp) (Shore1Wolves (+ Timestamp 1)))
        (< (AnimalsOnShore1AtTimestamp Timestamp) (AnimalsOnShore1AtTimestamp (+ Timestamp 1)))
        (>= (- (AnimalsOnShore1AtTimestamp Timestamp) (AnimalsOnShore1AtTimestamp (+ Timestamp 1))) -2)
        ;eating rule and totalanimals rule are the same in both directions
        (EatingRule (+ Timestamp 1))
        (TotalAnimalsRule (+ Timestamp 1))
    )
)


(assert
    (and

        ; beginning and end rules
        (= (Shore1Rabbits 0) 3)
        (= (Shore1Wolves 0) 3)
        (= (Shore2Rabbits 0) 0)
        (= (Shore2Wolfs 0) 0)

        (= (Shore1Rabbits 11) 0)
        (= (Shore1Wolves 11) 0)
        (= (Shore2Rabbits 11) 3)
        (= (Shore2Wolfs 11) 3)

        ;movement rules
        (Movement12Rule 0)
        (Movement21Rule 1)
        (Movement12Rule 2)
        (Movement21Rule 3)
        (Movement12Rule 4)
        (Movement21Rule 5)
        (Movement12Rule 6)
        (Movement21Rule 7)
        (Movement12Rule 8)
        (Movement21Rule 9)
        (Movement12Rule 10)                
    )
)

(check-sat)
(get-model)

(exit)