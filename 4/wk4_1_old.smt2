(declare-fun Wolf1 (Int) Int)
(declare-fun Wolf2 (Int) Int)
(declare-fun Wolf3 (Int) Int)
(declare-fun Rabbit1 (Int) Int)
(declare-fun Rabbit2 (Int) Int)
(declare-fun Rabbit3 (Int) Int)

(define-fun AnswerLimit ((Animal0 Int) (Animal1 Int) (Animal2 Int) (Animal3 Int) (Animal4 Int)
(Animal5 Int) (Animal6 Int) (Animal7 Int) (Animal8 Int) (Animal9 Int) (Animal10 Int) (Animal11 Int)) Bool
   (and
      (or (= Animal0 1) (= Animal0 2))
      (or (= Animal1 1) (= Animal1 2))
      (or (= Animal2 1) (= Animal2 2))
      (or (= Animal3 1) (= Animal3 2))
      (or (= Animal4 1) (= Animal4 2))
      (or (= Animal5 1) (= Animal5 2))
      (or (= Animal6 1) (= Animal6 2))
      (or (= Animal7 1) (= Animal7 2))
      (or (= Animal8 1) (= Animal8 2))
      (or (= Animal9 1) (= Animal9 2))
      (or (= Animal10 1) (= Animal10 2))
      (or (= Animal11 1) (= Animal11 2)) 
   )
)

(define-fun ChangeLocation ((Animal Int) (AnimalNextTimestamp Int)) Bool
    (ite (= Animal 1) (= AnimalNextTimestamp 2) (= AnimalNextTimestamp 1)) 
)

(define-fun HasChangedLocation ((Animal Int) (AnimalNextTimestamp Int)) Bool
    (or
        (and (= Animal 1) (= AnimalNextTimestamp 2))
        (and (= Animal 2) (= AnimalNextTimestamp 1))
    )
)

(define-fun HowManyChangedLocation ((Timestamp Int)) Int
    (+
        (ite (HasChangedLocation (Wolf1 Timestamp) (Wolf1 (+ Timestamp 1))) 1 0)
        (ite (HasChangedLocation (Wolf2 Timestamp) (Wolf2 (+ Timestamp 1))) 1 0)
        (ite (HasChangedLocation (Wolf3 Timestamp) (Wolf3 (+ Timestamp 1))) 1 0)
        (ite (HasChangedLocation (Rabbit1 Timestamp) (Rabbit1 (+ Timestamp 1))) 1 0)
        (ite (HasChangedLocation (Rabbit2 Timestamp) (Rabbit2 (+ Timestamp 1))) 1 0)
        (ite (HasChangedLocation (Rabbit3 Timestamp) (Rabbit3 (+ Timestamp 1))) 1 0) 
    )
)

(define-fun HowManyChangedLocationLimit ((Timestamp Int)) Bool
    (or
        (= (HowManyChangedLocation Timestamp) 1)
        (= (HowManyChangedLocation Timestamp) 2)
    )
)

(define-fun CountWolves ((Timestamp Int) (Shore Int)) Int
    (+
        (ite (=(Wolf1 Timestamp) Shore) 1 0)
        (ite (=(Wolf2 Timestamp) Shore) 1 0)
        (ite (=(Wolf3 Timestamp) Shore) 1 0)
    )
)

(define-fun CountRabbits ((Timestamp Int) (Shore Int)) Int
    (+
        (ite (=(Rabbit1 Timestamp) Shore) 1 0)
        (ite (=(Rabbit2 Timestamp) Shore) 1 0)
        (ite (=(Rabbit3 Timestamp) Shore) 1 0)
    )
)

(define-fun WolfSheepLimit ((Timestamp Int)) Bool
    (and
        (<= (CountWolves Timestamp 1) (CountRabbits Timestamp 1))
        (<= (CountWolves Timestamp 2) (CountRabbits Timestamp 2))
    )
)

(define-fun CanNotChange ((Animal Int) (AnimalNextTimestamp Int)) Bool
    (= Animal AnimalNextTimestamp)
)

(define-fun SameShoreLimit ((Timestamp Int)) Bool
    (and
        (ite (not (=(Wolf1 Timestamp) (+ (mod Timestamp 2) 1))) (CanNotChange (Wolf1 Timestamp) (Wolf1 (+ Timestamp 1))) true )
        (ite (not (=(Wolf2 Timestamp) (+ (mod Timestamp 2) 1))) (CanNotChange (Wolf2 Timestamp) (Wolf2 (+ Timestamp 1))) true )
        (ite (not (=(Wolf3 Timestamp) (+ (mod Timestamp 2) 1))) (CanNotChange (Wolf3 Timestamp) (Wolf3 (+ Timestamp 1))) true )
        (ite (not (=(Rabbit1 Timestamp) (+ (mod Timestamp 2) 1))) (CanNotChange (Rabbit1 Timestamp) (Rabbit1 (+ Timestamp 1))) true )
        (ite (not (=(Rabbit2 Timestamp) (+ (mod Timestamp 2) 1))) (CanNotChange (Rabbit2 Timestamp) (Rabbit2 (+ Timestamp 1))) true )
        (ite (not (=(Rabbit3 Timestamp) (+ (mod Timestamp 2) 1))) (CanNotChange (Rabbit3 Timestamp) (Rabbit3 (+ Timestamp 1))) true )  
    )
)


(assert
    (and

        ;Answer Limits (1 = First Shore, 2 = Second shore)
        (AnswerLimit (Wolf1 0) (Wolf1 1) (Wolf1 2) (Wolf1 3) (Wolf1 4) (Wolf1 5)
        (Wolf1 6) (Wolf1 7) (Wolf1 8) (Wolf1 9) (Wolf1 10) (Wolf1 11))
        (AnswerLimit (Wolf2 0) (Wolf2 1) (Wolf2 2) (Wolf2 3) (Wolf2 4) (Wolf2 5)
        (Wolf2 6) (Wolf2 7) (Wolf2 8) (Wolf2 9) (Wolf2 10) (Wolf2 11))
        (AnswerLimit (Wolf3 0) (Wolf3 1) (Wolf3 2) (Wolf3 3) (Wolf3 4) (Wolf3 5)
        (Wolf3 6) (Wolf3 7) (Wolf3 8) (Wolf3 9) (Wolf3 10) (Wolf3 11))
        (AnswerLimit (Rabbit1 0) (Rabbit1 1) (Rabbit1 2) (Rabbit1 3) (Rabbit1 4) (Rabbit1 5)
        (Rabbit1 6) (Rabbit1 7) (Rabbit1 8) (Rabbit1 9) (Rabbit1 10) (Rabbit1 11))
        (AnswerLimit (Rabbit2 0) (Rabbit2 1) (Rabbit2 2) (Rabbit2 3) (Rabbit2 4) (Rabbit2 5)
        (Rabbit2 6) (Rabbit2 7) (Rabbit2 8) (Rabbit2 9) (Rabbit2 10) (Rabbit2 11))
        (AnswerLimit (Rabbit3 0) (Rabbit3 1) (Rabbit3 2) (Rabbit3 3) (Rabbit3 4) (Rabbit3 5)
        (Rabbit3 6) (Rabbit3 7) (Rabbit3 8) (Rabbit3 9) (Rabbit3 10) (Rabbit3 11))

        ;Start place
        (= (Wolf1 0) 1)
        (= (Wolf2 0) 1)
        (= (Wolf3 0) 1)
        (= (Rabbit1 0) 1)
        (= (Rabbit2 0) 1)
        (= (Rabbit3 0) 1)

        ;End place
        (= (Wolf1 11) 2)
        (= (Wolf2 11) 2)
        (= (Wolf3 11) 2)
        (= (Rabbit1 11) 2)
        (= (Rabbit2 11) 2)
        (= (Rabbit3 11) 2)

        ;Limits for wolves and rabbits
        (WolfSheepLimit 0)
        (WolfSheepLimit 1)
        (WolfSheepLimit 2)
        (WolfSheepLimit 3)
        (WolfSheepLimit 4)
        (WolfSheepLimit 5)
        (WolfSheepLimit 6)
        (WolfSheepLimit 7)
        (WolfSheepLimit 8)
        (WolfSheepLimit 9)
        (WolfSheepLimit 10)
        (WolfSheepLimit 11)


        ;Same shore limit
        
        (SameShoreLimit 1)
        (SameShoreLimit 2)
        (SameShoreLimit 3)
        (SameShoreLimit 4)
        (SameShoreLimit 5)
        (SameShoreLimit 6)
        (SameShoreLimit 7)
        (SameShoreLimit 8)
        ;(SameShoreLimit 9)
        ;(SameShoreLimit 10)
        ;(SameShoreLimit 11)
        

        ;Change location limits
        (HowManyChangedLocationLimit 0)
        (HowManyChangedLocationLimit 1)
        (HowManyChangedLocationLimit 2)
        (HowManyChangedLocationLimit 3)
        (HowManyChangedLocationLimit 4)
        (HowManyChangedLocationLimit 5)
        (HowManyChangedLocationLimit 6)
        (HowManyChangedLocationLimit 7)
        (HowManyChangedLocationLimit 8)
        (HowManyChangedLocationLimit 9)
        (HowManyChangedLocationLimit 10)
        (HowManyChangedLocationLimit 11)

    )
)

(check-sat)
(get-model)

(exit)