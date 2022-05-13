(declare-datatypes () ((Boy B1 B2 B3 B4 B5)))
(declare-datatypes () ((Girl GA GB GC GD GE)))

; PREF_BOY: preference (<male-id> <index>) = <female-id>
(declare-fun PREF_BOY (Boy Int) Girl)
(declare-fun PREF_GIRL (Girl Int) Boy)

;this function only returns true when the boy and girl passed as parameters are married (for a model with only stable marriages)
(declare-fun Marriage (Boy Girl) Bool)

(define-fun SetPreferencesBoy ((b Boy) (g1 Girl) (g2 Girl) (g3 Girl) (g4 Girl) (g5 Girl)) Bool
	(and
		(= (PREF_BOY b 1) g1)
		(= (PREF_BOY b 2) g2)
		(= (PREF_BOY b 3) g3)
		(= (PREF_BOY b 4) g4)
		(= (PREF_BOY b 5) g5)
	)
)

(define-fun SetPreferencesGirl ((g Girl) (b1 Boy) (b2 Boy) (b3 Boy) (b4 Boy) (b5 Boy)) Bool
	(and
		(= (PREF_GIRL g 1) b1)
		(= (PREF_GIRL g 2) b2)
		(= (PREF_GIRL g 3) b3)
		(= (PREF_GIRL g 4) b4)
		(= (PREF_GIRL g 5) b5)
	)
)

;this returns the preference as an integer which can be used in equations/inequalities
;it makes it easier to check preference as an int
(define-fun PreferenceBoy ((b Boy) (g Girl)) Int
    (ite (= (PREF_BOY b 1) g) 1 
    (ite (= (PREF_BOY b 2) g) 2
    (ite (= (PREF_BOY b 3) g) 3
    (ite (= (PREF_BOY b 4) g) 4
    (ite (= (PREF_BOY b 5) g) 5 6 ;random else, should never get here
    )))))
)

(define-fun PreferenceGirl ((g Girl) (b Boy)) Int
    (ite (= (PREF_GIRL g 1) b) 1 
    (ite (= (PREF_GIRL g 2) b) 2
    (ite (= (PREF_GIRL g 3) b) 3
    (ite (= (PREF_GIRL g 4) b) 4
    (ite (= (PREF_GIRL g 5) b) 5 6
    )))))
)



(assert 
    (and
	    (SetPreferencesBoy B1 GC GB GE GA GD)
	    (SetPreferencesBoy B2 GA GB GE GC GD)
	    (SetPreferencesBoy B3 GD GC GB GA GE)
	    (SetPreferencesBoy B4 GA GC GD GB GE)
	    (SetPreferencesBoy B5 GA GB GD GE GC)

	    (SetPreferencesGirl GA B3 B5 B2 B1 B4)
	    (SetPreferencesGirl GB B5 B2 B1 B4 B3)
	    (SetPreferencesGirl GC B4 B3 B5 B1 B2)
	    (SetPreferencesGirl GD B1 B2 B3 B4 B5)
    	(SetPreferencesGirl GE B2 B3 B4 B1 B5)

        ;this makes sure that 5 different pairs of boys and girls are married
        (exists ((b1 Boy) (b2 Boy) (b3 Boy) (b4 Boy) (b5 Boy) (g1 Girl) (g2 Girl) (g3 Girl) (g4 Girl) (g5 Girl))
            (and
                (distinct b1 b2 b3 b4 b5)
                (distinct g1 g2 g3 g4 g5)
                (Marriage b1 g1)
                (Marriage b2 g2)
                (Marriage b3 g3)
                (Marriage b4 g4)
                (Marriage b5 g5)
            )
        )
        ;for all combinations of boys and girls
        (forall ((b Boy) (g Girl))
            (=>
                ;A marriage between them implies
                (Marriage b g)
                (and
                    ;For all other girls
                    (forall ((otherGirl Girl))
                        (=>
                            ;If the boy likes the other girl better
                            (< (PreferenceBoy b otherGirl) (PreferenceBoy b g))
                            ;Then the girl must like her husband more than the boy
                            (forall ((otherBoy Boy))
                                (=> 
                                    (Marriage otherBoy otherGirl)
                                    (< (PreferenceGirl otherGirl otherBoy) (PreferenceGirl otherGirl b))
                                )
                            )
                        )
                    )
                    ;For all other boys
                    (forall ((otherBoy Boy))
                        (=>
                            ;If the girl likes the other boy better
                            (< (PreferenceGirl g otherBoy) (PreferenceGirl g b))
                            ;Then the boy must like his wife more than the girl
                            (forall ((otherGirl Girl))
                                (=> 
                                    (Marriage otherBoy otherGirl)
                                    (< (PreferenceBoy otherBoy otherGirl) (PreferenceBoy otherBoy g))
                                )
                            )
                        )
                    )
                )
            )
        )
    )
)

(check-sat)
(get-model)
(exit)