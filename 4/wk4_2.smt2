;we show A and B at different points in time by making them functions, where the parameter is the timestamp
(declare-fun A (Int) Int)
(declare-fun B (Int) Int)

(assert
    (and
        ;we write the 10 iterations of the loop (using a generator simplified that task a lot)
        (ite (> (A 0) (B 0)) (and (= (A 1) (- (A 0) 3)) (= (B 1) (* 2 (B 0)))) (and (= (B 1) (- (B 0) 5)) (= (A 1) (* 2 (A 0)))))
        (ite (> (A 1) (B 1)) (and (= (A 2) (- (A 1) 3)) (= (B 2) (* 2 (B 1)))) (and (= (B 2) (- (B 1) 5)) (= (A 2) (* 2 (A 1)))))
        (ite (> (A 2) (B 2)) (and (= (A 3) (- (A 2) 3)) (= (B 3) (* 2 (B 2)))) (and (= (B 3) (- (B 2) 5)) (= (A 3) (* 2 (A 2)))))
        (ite (> (A 3) (B 3)) (and (= (A 4) (- (A 3) 3)) (= (B 4) (* 2 (B 3)))) (and (= (B 4) (- (B 3) 5)) (= (A 4) (* 2 (A 3)))))
        (ite (> (A 4) (B 4)) (and (= (A 5) (- (A 4) 3)) (= (B 5) (* 2 (B 4)))) (and (= (B 5) (- (B 4) 5)) (= (A 5) (* 2 (A 4)))))
        (ite (> (A 5) (B 5)) (and (= (A 6) (- (A 5) 3)) (= (B 6) (* 2 (B 5)))) (and (= (B 6) (- (B 5) 5)) (= (A 6) (* 2 (A 5)))))
        (ite (> (A 6) (B 6)) (and (= (A 7) (- (A 6) 3)) (= (B 7) (* 2 (B 6)))) (and (= (B 7) (- (B 6) 5)) (= (A 7) (* 2 (A 6)))))
        (ite (> (A 7) (B 7)) (and (= (A 8) (- (A 7) 3)) (= (B 8) (* 2 (B 7)))) (and (= (B 8) (- (B 7) 5)) (= (A 8) (* 2 (A 7)))))
        (ite (> (A 8) (B 8)) (and (= (A 9) (- (A 8) 3)) (= (B 9) (* 2 (B 8)))) (and (= (B 9) (- (B 8) 5)) (= (A 9) (* 2 (A 8)))))
        (ite (> (A 9) (B 9)) (and (= (A 10) (- (A 9) 3)) (= (B 10) (* 2 (B 9)))) (and (= (B 10) (- (B 9) 5)) (= (A 10) (* 2 (A 9)))))

        ;end values required by task
        (= (A 10) 1000)
        (= (B 10) 999)

    )
)

(check-sat)
(get-model)

(exit)