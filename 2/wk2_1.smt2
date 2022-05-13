(declare-const Alex Int)
(declare-const Brook Int)
(declare-const Cody Int)
(declare-const Dusty Int)
(declare-const Erin Int)

(assert
    (and
        (distinct Alex Brook Cody Dusty Erin)

        (> Alex 0)
        (> Brook 0)
        (> Cody 0)
        (> Dusty 0)
        (> Erin 0)

        (ite (> Brook Dusty) (= (+ Erin 9) Dusty) (not(= (+ Erin 9) Dusty)))
        (ite (> Brook Erin) (= (+ Alex 7) Erin) (not(= (+ Alex 7) Erin)))
        (ite (> Brook Alex) (= (* Alex 17) (* Brook 10)) (not(= (* Alex 17) (* Brook 10))))
        (ite (> Cody Brook) (< Erin Cody) (>= Erin Cody))
        (ite (> Dusty Cody) (or (=(- Cody Dusty) 6) (= (- Dusty Cody) 6)) (not(or (=(- Cody Dusty) 6) (= (- Dusty Cody) 6))))
        (ite (> Alex Cody) (= (+ Alex 10) Cody) (not (= (+ Alex 10) Cody)))
        (ite (> Alex Cody) (< Brook Dusty) (>= Brook Dusty))
        (ite (> Cody Brook) (or (= Cody Erin) (= (-(* 2 Dusty) Erin ) Cody)) (not (or (= Cody Erin) (= (-(* 2 Dusty) Erin ) Cody))))
    )
)

(check-sat)
(get-model)
(exit)