(declare-const O Int)
(declare-const N Int)
(declare-const E Int)
(declare-const I Int)
(declare-const T Int)
(declare-const W Int)
(declare-const Y Int)
(declare-const G Int)
(declare-const H Int)
(declare-const F Int)

(assert 
    (        
        and
        (>= O 1)
        (>= N 1)
        (>= E 1)
        (>= I 0)
        (>= T 1)
        (>= W 0)
        (>= Y 0)
        (>= G 0)
        (>= H 0)
        (>= F 1)

        (<= O 9)
        (<= N 9)
        (<= E 9)
        (<= I 9)
        (<= T 9)
        (<= W 9)
        (<= Y 9)
        (<= G 9)
        (<= H 9)
        (<= F 9)

        (=(+ E (* 10 N) (* 100 O) ; ONE
        E (* 10 N) (* 100 I) (* 1000 N) ; NINE
        Y (* 10 T) (* N 100) (* E 1000) (* W 10000) (* T 100000) ; TWENTY
        Y (* T 10) (* F 100) (* I 1000) (* F 10000))         ; FIFTY
        (+ Y (* T 10) (* H 100) (* G 1000) (* I 10000) (* E 100000))    ; EIGHTY
        )
    )
)

(check-sat)
(get-model)
(exit)