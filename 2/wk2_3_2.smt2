(declare-const Q1 String)
(declare-const Q2 String)
(declare-const Q3 String)
(declare-const Q4 String)
(declare-const Q5 String)
(declare-const Q6 String)
(declare-const Q7 String)
(declare-const Q8 String)
(declare-const Q9 String)
(declare-const Q10 String)
(declare-const Q11 String)
(declare-const Q12 String)
(declare-const Q13 String)
(declare-const Q14 String)
(declare-const Q15 String)
(declare-const Q16 String)
(declare-const Q17 String)
(declare-const Q18 String)
(declare-const Q19 String)
(declare-const Q20 String)   

(define-fun AnswerLimit ((Question String)) Bool
   (or (= Question "A") (= Question "B") (= Question "C") (= Question "D") (= Question "E"))
)

(define-fun ToInt ((Question String) (Answer String)) Int
    (ite (= Question Answer) 1 0)
)

(define-fun AllToInt ((Answer String)) Int 
    (+ (ToInt Q1 Answer) (ToInt Q2 Answer) (ToInt Q3 Answer) (ToInt Q4 Answer)
     (ToInt Q5 Answer) (ToInt Q6 Answer) (ToInt Q7 Answer) (ToInt Q8 Answer)
     (ToInt Q9 Answer) (ToInt Q10 Answer) (ToInt Q11 Answer) (ToInt Q12 Answer)
     (ToInt Q13 Answer) (ToInt Q14 Answer) (ToInt Q15 Answer) (ToInt Q16 Answer)
     (ToInt Q17 Answer) (ToInt Q18 Answer) (ToInt Q19 Answer) (ToInt Q20 Answer))
)

(define-fun First10ToInt ((Answer String)) Int 
    (+ (ToInt Q1 Answer) (ToInt Q2 Answer) (ToInt Q3 Answer) (ToInt Q4 Answer)
     (ToInt Q5 Answer) (ToInt Q6 Answer) (ToInt Q7 Answer) (ToInt Q8 Answer)
     (ToInt Q9 Answer) (ToInt Q10 Answer))
)
(define-fun Consonants () Int 
    (+ (AllToInt "B") (AllToInt "C") (AllToInt "D"))
) 

(assert
    (and
        (AnswerLimit Q1)
        (AnswerLimit Q2)
        (AnswerLimit Q3)
        (AnswerLimit Q4)
        (AnswerLimit Q5)
        (AnswerLimit Q6)
        (AnswerLimit Q7)
        (AnswerLimit Q8)
        (AnswerLimit Q9)
        (AnswerLimit Q10)
        (AnswerLimit Q11)
        (AnswerLimit Q12)
        (AnswerLimit Q13)
        (AnswerLimit Q14)
        (AnswerLimit Q15)
        (AnswerLimit Q16)
        (AnswerLimit Q17)
        (AnswerLimit Q18)
        (AnswerLimit Q19)        
        (AnswerLimit Q20) 

        ;Question 1 condition                 
        (ite (= Q1 "B") (= Q1 "A") 
            (ite (= Q2 "B") (= Q1 "B")
                (ite (= Q3 "B") (= Q1 "C") 
                    (ite (= Q4 "B") (= Q1 "D") (= Q1 "E"))
                )
            )
        )

        ;Question 2 condition
        (or
            (and (= Q6 Q7) (= Q2 "A") (distinct Q7 Q8) (distinct Q8 Q9) (distinct Q9 Q10) (distinct Q10 Q11))
            (and (= Q7 Q8) (= Q2 "B") (distinct Q6 Q7) (distinct Q8 Q9) (distinct Q9 Q10) (distinct Q10 Q11))
            (and (= Q8 Q9) (= Q2 "C") (distinct Q7 Q8) (distinct Q6 Q7) (distinct Q9 Q10) (distinct Q10 Q11))
            (and (= Q9 Q10) (= Q2 "D") (distinct Q7 Q8) (distinct Q8 Q9) (distinct Q6 Q7) (distinct Q10 Q11))
            (and (= Q10 Q11) (= Q2 "E") (distinct Q7 Q8) (distinct Q8 Q9) (distinct Q9 Q10) (distinct Q6 Q7))            
        )
        (and (distinct Q1 Q2) (distinct Q2 Q3) (distinct Q3 Q4) (distinct Q4 Q5) (distinct Q5 Q6)
            (distinct Q11 Q12) (distinct Q12 Q13) (distinct Q13 Q14) (distinct Q14 Q15) (distinct Q15 Q16)
            (distinct Q16 Q17) (distinct Q17 Q18) (distinct Q18 Q19) (distinct Q19 Q20))

        ;Question 3 condition
        (or
            (and (= (AllToInt "E") 0) (= Q3 "A"))
            (and (= (AllToInt "E") 1) (= Q3 "B"))
            (and (= (AllToInt "E") 2) (= Q3 "C"))
            (and (= (AllToInt "E") 3) (= Q3 "D"))
            (and (= (AllToInt "E") 4) (= Q3 "E"))
        )

        ;Question 4 condition
        (or
            (and (= (AllToInt "A") 4) (= Q4 "A"))
            (and (= (AllToInt "A") 5) (= Q4 "B"))
            (and (= (AllToInt "A") 6) (= Q4 "C"))
            (and (= (AllToInt "A") 7) (= Q4 "D"))
            (and (= (AllToInt "A") 8) (= Q4 "E"))
        )

        ;Question 5 condition
        (or
            (and (= Q5 "A") (= Q1 "A"))
            (and (= Q5 "B") (= Q2 "B"))
            (and (= Q5 "C") (= Q3 "C"))
            (and (= Q5 "D") (= Q4 "D"))
            (and (= Q5 "E") (= Q5 "E"))
        )

        ;Question 6 condition
        (or
            (and (= Q17 "C") (= Q6 "A"))
            (and (= Q17 "D") (= Q6 "B"))
            (and (= Q17 "E") (= Q6 "C"))
            (and (or (= Q17 "B") (= Q17 "A") (= Q6 "D")))
        )

        ;Question 7 condition
        (or
            (and (= Q8 "E") (= Q7 "A"))
            (and (= Q8 "E") (= Q7 "B"))
            (and (or (= Q8 "E") (= Q8 "A")) (= Q7 "C"))
            (and (or (= Q8 "E") (= Q8 "C")) (= Q7 "D"))
            (and (= Q8 "E") (= Q7 "E"))
        )

        ;Question 8 condition
        (or
            (and (=(+ (AllToInt "A") (AllToInt "E")) 4) (= Q8 "A"))
            (and (=(+ (AllToInt "A") (AllToInt "E")) 5) (= Q8 "B"))
            (and (=(+ (AllToInt "A") (AllToInt "E")) 6) (= Q8 "C"))
            (and (=(+ (AllToInt "A") (AllToInt "E")) 7) (= Q8 "D"))
            (and (=(+ (AllToInt "A") (AllToInt "E")) 8) (= Q8 "E"))
        )

        ;Question 9 condition        
        (ite (= Q10 Q9) (= Q9 "A") 
            (ite (= Q11 Q9) (= Q9 "B")
                (ite (= Q12 Q9) (= Q9 "C") 
                    (ite (= Q13 Q9) (= Q9 "D") (= Q9 "E"))
                )
            )
        )

        ;Question 10 condition
        (or
            (and (= Q16 "D") (= Q10 "A"))
            (and (= Q16 "A") (= Q10 "B"))
            (and (= Q16 "E") (= Q10 "C"))
            (and (= Q16 "B") (= Q10 "D"))
            (and (= Q16 "C") (= Q10 "E"))
        )

        ;Question 11 condition
        (or
            (and (= (First10ToInt "B") 0) (= Q11 "A"))
            (and (= (First10ToInt "B") 1) (= Q11 "B"))
            (and (= (First10ToInt "B") 2) (= Q11 "C"))
            (and (= (First10ToInt "B") 3) (= Q11 "D"))
            (and (= (First10ToInt "B") 4) (= Q11 "E"))
        )

        ;Question 12 condition
        (or
            (and (or (= Consonants 2) (= Consonants 4) (= Consonants 6)
            (= Consonants 8) (= Consonants 10) (= Consonants 12) (= Consonants 14)
            (= Consonants 16) (= Consonants 18) (= Consonants 20)) (= Q12 "A")) ;even

            (and (or (= Consonants 1) (= Consonants 3) (= Consonants 5)
            (= Consonants 7) (= Consonants 9) (= Consonants 11) (= Consonants 13)
            (= Consonants 15) (= Consonants 17) (= Consonants 19)) (= Q12 "B")) ;odd

            (and (or (= Consonants 0) (= Consonants 1) (= Consonants 4)
            (= Consonants 9) (= Consonants 16)) (= Q12 "C")) ;square

            (and (or (= Consonants 2) (= Consonants 3) (= Consonants 5)
            (= Consonants 7) (= Consonants 11) (= Consonants 13) (= Consonants 17)
            (= Consonants 19)) (= Q12 "D")) ;prime

            (and (or (= Consonants 0) (= Consonants 5) (= Consonants 10)
            (= Consonants 15) (= Consonants 20)) (= Q12 "E")) ;div by 5
        )

        ;Question 13 condition
        (or
            (and (= Q9 "A") (= Q13 "A") (not(= Q11 "A")) (not(= Q13 "A")) (not(= Q15 "A")) (not(= Q17 "A")))
            (and (= Q11 "A") (= Q13 "B") (not(= Q9 "A")) (not(= Q13 "A")) (not(= Q15 "A")) (not(= Q17 "A")))
            (and (= Q13 "A") (= Q13 "C") (not(= Q11 "A")) (not(= Q9 "A")) (not(= Q15 "A")) (not(= Q17 "A")))
            (and (= Q15 "A") (= Q13 "D") (not(= Q11 "A")) (not(= Q13 "A")) (not(= Q9 "A")) (not(= Q17 "A")))
            (and (= Q17 "A") (= Q13 "E") (not(= Q11 "A")) (not(= Q13 "A")) (not(= Q15 "A")) (not(= Q9 "A")))
        )

        (not (= Q1 "A"))
        (not (= Q3 "A"))
        (not (= Q5 "A"))
        (not (= Q7 "A"))
        (not (= Q19 "A"))

        ;Question 14 condition
        (or
            (and (= (AllToInt "D") 6) (= Q14 "A"))
            (and (= (AllToInt "D") 7) (= Q14 "B"))
            (and (= (AllToInt "D") 8) (= Q14 "C"))
            (and (= (AllToInt "D") 9) (= Q14 "D"))
            (and (= (AllToInt "D") 10) (= Q14 "E"))
        )

        ;Question 15 condition
        (= Q12 Q15)

        ;Question 16 condition
        (or
            (and (= Q10 "D") (= Q16 "A"))
            (and (= Q10 "C") (= Q16 "B"))
            (and (= Q10 "B") (= Q16 "C"))
            (and (= Q10 "A") (= Q16 "D"))
            (and (= Q10 "E") (= Q16 "E"))
        )

        ;Question 17 condition
        (or
            (and (= Q6 "C") (= Q17 "A"))
            (and (= Q6 "D") (= Q17 "B"))
            (and (= Q6 "E") (= Q17 "C"))
            (and (or (= Q6 "B") (= Q6 "A") (= Q17 "D")))
        )

        ;Question 18 condition
        (ite (= (AllToInt "A") (AllToInt "B")) (= Q18 "A") 
            (ite (= (AllToInt "A") (AllToInt "C")) (= Q18 "B")
                (ite (= (AllToInt "A") (AllToInt "D")) (= Q18 "C") 
                    (ite (= (AllToInt "A") (AllToInt "E")) (= Q18 "D") (= Q18 "E"))
                )
            )
        )

        ;Question 19 condition
        ;derived from context

        ;Question 20 condition
        ;derived from context

        ;uncommenting one of the next lines yields another solution
        ;(not (= Q20 "E"))
        ;(not (= Q20 "A"))

        ;as the creator of this puzzle James Propp says on http://faculty.uml.edu/jpropp/srat-Q.txt:
        ;I should mention that if you don't agree with me about the answer to #20, 
        ;you will get a different solution to the puzzle than the one I had in mind.  
        ;But I should also mention that if you don't agree with me about the answer 
        ;to #20, you are just plain wrong.  :-)
    )
)

(check-sat)
(get-model)
(exit)