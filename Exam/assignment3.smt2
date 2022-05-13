(declare-fun Harmonica (Int) Int)
(declare-fun Lamp (Int) Int)
(declare-fun Mirror (Int) Int)
(declare-fun Sundial (Int) Int)
(declare-fun Table (Int) Int)
(declare-fun Vase (Int) Int)

;This makes sure that on every day exactly 1 item is sold
;The items can have a value of 0 and 1 - this makes sure only 1 has a value of 1
;1 - sold, 0 - not sold
(define-fun SoldLimit ((Day Int)) Bool
    (= (+
    (Harmonica Day)
    (Lamp Day)
    (Mirror Day)
    (Sundial Day)
    (Table Day)
    (Vase Day)
    ) 1)
)

;A groupd function for all the answer limits - makes sure all items in a specific
;day can be only 0 or 1 as well as implements SoldLimit for that day
;Not using boolean because of the easier implementation of SoldLimit
(define-fun AnswerLimit ((Day Int)) Bool
    (and
        (or (= (Harmonica Day) 0) (= (Harmonica Day) 1))
        (or (= (Lamp Day) 0) (= (Lamp Day) 1))
        (or (= (Mirror Day) 0) (= (Mirror Day) 1))
        (or (= (Sundial Day) 0) (= (Sundial Day) 1))
        (or (= (Table Day) 0) (= (Table Day) 1))
        (or (= (Vase Day) 0) (= (Vase Day) 1))
        (SoldLimit Day)     
    )
)
;Functions to get the day when the item was sold
;Else never gets triggered because of other conditions, so it doesn't matter what is in there
(define-fun GetDayForSellingHarmonica () Int
    (ite (= (Harmonica 1) 1) 1 
    (ite (= (Harmonica 2) 1) 2 
    (ite (= (Harmonica 3) 1) 3
    (ite (= (Harmonica 4) 1) 4
    (ite (= (Harmonica 5) 1) 5
    (ite (= (Harmonica 6) 1) 6 6
    ))))))
)

(define-fun GetDayForSellingLamp () Int
    (ite (= (Lamp 1) 1) 1 
    (ite (= (Lamp 2) 1) 2 
    (ite (= (Lamp 3) 1) 3
    (ite (= (Lamp 4) 1) 4
    (ite (= (Lamp 5) 1) 5
    (ite (= (Lamp 6) 1) 6 6
    ))))))
)

(define-fun GetDayForSellingMirror () Int
    (ite (= (Mirror 1) 1) 1 
    (ite (= (Mirror 2) 1) 2 
    (ite (= (Mirror 3) 1) 3
    (ite (= (Mirror 4) 1) 4
    (ite (= (Mirror 5) 1) 5
    (ite (= (Mirror 6) 1) 6 6
    ))))))
)

(define-fun GetDayForSellingSundial () Int
    (ite (= (Sundial 1) 1) 1 
    (ite (= (Sundial 2) 1) 2 
    (ite (= (Sundial 3) 1) 3
    (ite (= (Sundial 4) 1) 4
    (ite (= (Sundial 5) 1) 5
    (ite (= (Sundial 6) 1) 6 6
    ))))))
)

(define-fun GetDayForSellingTable () Int
    (ite (= (Table 1) 1) 1 
    (ite (= (Table 2) 1) 2 
    (ite (= (Table 3) 1) 3
    (ite (= (Table 4) 1) 4
    (ite (= (Table 5) 1) 5
    (ite (= (Table 6) 1) 6 6
    ))))))
)

(define-fun GetDayForSellingVase () Int
    (ite (= (Vase 1) 1) 1 
    (ite (= (Vase 2) 1) 2 
    (ite (= (Vase 3) 1) 3
    (ite (= (Vase 4) 1) 4
    (ite (= (Vase 5) 1) 5
    (ite (= (Vase 6) 1) 6 6
    ))))))
)

(assert 
    (and
        ; limits of answers
        (AnswerLimit 1)
        (AnswerLimit 2)
        (AnswerLimit 3)
        (AnswerLimit 4)
        (AnswerLimit 5)
        (AnswerLimit 6)

        ;Making sure all items get sold - they should sum up to 1, as they have 1 answer as 1 and the rest as 0
        (= (+ (Harmonica 1) (Harmonica 2) (Harmonica 3) (Harmonica 4) (Harmonica 5) (Harmonica 6)) 1)
        (= (+ (Lamp 1) (Lamp 2) (Lamp 3) (Lamp 4) (Lamp 5) (Lamp 6)) 1)
        (= (+ (Mirror 1) (Mirror 2) (Mirror 3) (Mirror 4) (Mirror 5) (Mirror 6)) 1)
        (= (+ (Sundial 1) (Sundial 2) (Sundial 3) (Sundial 4) (Sundial 5) (Sundial 6)) 1)
        (= (+ (Table 1) (Table 2) (Table 3) (Table 4) (Table 5) (Table 6)) 1)
        (= (+ (Vase 1) (Vase 2) (Vase 3) (Vase 4) (Vase 5) (Vase 6)) 1)

        ; additional conditions
        ;The sundial is not auctioned on June 1st.
        (= (Sundial 1) 0) 
        ;If the harmonica is auctioned on an earlier date than the lamp, then the mirror is also
        ;auctioned on an earlier date than the lamp.
        (=>
            (< GetDayForSellingHarmonica GetDayForSellingLamp)
            (< GetDayForSellingMirror GetDayForSellingLamp)
        )
        ;The sundial is auctioned on an earlier date than the mirror and also on an earlier date
        ;than the vase.
        (< GetDayForSellingSundial GetDayForSellingMirror)
        (< GetDayForSellingSundial GetDayForSellingVase)
        ;The table is auctioned on an earlier date than the harmonica or on an earlier date
        ;than the vase, but not both.
        (or
            (< GetDayForSellingTable GetDayForSellingHarmonica)
            (< GetDayForSellingTable GetDayForSellingVase)
        )
        (not (and
            (< GetDayForSellingTable GetDayForSellingHarmonica)
            (< GetDayForSellingTable GetDayForSellingVase)
        ))


        ;Question 1
        ;Answer 1 - works!
        ;(= (Harmonica 1) 1)
        ;(= (Sundial 2) 1)
        ;(= (Table 3) 1)
        ;(= (Mirror 4) 1)
        ;(= (Lamp 5) 1)
        ;(= (Vase 6) 1)
        
        ;Answer 2 - model is not available
        ;(= (Sundial 1) 1)
        ;(= (Lamp 2) 1)
        ;(= (Harmonica 3) 1)
        ;(= (Mirror 4) 1)
        ;(= (Table 5) 1)
        ;(= (Vase 6) 1)

        ;Question 2
        ;Answer 1 - model is not available
        ;(= (Table 2) 1)
        ;(= (Lamp 3) 1)

        ;Answer 2 - correct
        ;(= (Sundial 2) 1)
        ;(= (Vase 3) 1)

        ;Question 3
        ;(> GetDayForSellingTable GetDayForSellingMirror)
        ;(> GetDayForSellingTable GetDayForSellingVase)

        ;Answer 1 - works
        ;(< GetDayForSellingMirror GetDayForSellingVase)

        ;Answer 2 - model is not available
        ;(< GetDayForSellingSundial GetDayForSellingLamp)
      
    )      
)

(check-sat)
(get-model)
(exit)