(declare-datatypes () (( ROW Row1 Row2 Row3 Row4 Row5)))
(declare-datatypes () (( COLUMN Column1 Column2 Column3 Column4 Column5)))

(define-fun NextRow ((r ROW)) ROW
    (ite (= r Row1) Row2 
    (ite (= r Row2) Row3 
    (ite (= r Row3) Row4 
    (ite (= r Row4) Row5 
                    Row5
    ))))
)

(define-fun PreviousRow ((r ROW)) ROW
    (ite (= r Row5) Row4 
    (ite (= r Row4) Row3 
    (ite (= r Row3) Row2 
    (ite (= r Row2) Row1 
                    Row1
    ))))
)

(define-fun NextColumn ((c COLUMN)) COLUMN
    (ite (= c Column1) Column2 
    (ite (= c Column2) Column3 
    (ite (= c Column3) Column4 
    (ite (= c Column4) Column5 
                       Column5
    ))))
)

(define-fun PreviousColumn ((c COLUMN)) COLUMN
    (ite (= c Column5) Column4 
    (ite (= c Column4) Column3 
    (ite (= c Column3) Column2 
    (ite (= c Column2) Column1 
                       Column1
    ))))
)

;this function is true when there is a piece on the square and false when there isn't one
(declare-fun square (ROW COLUMN) Bool)

(assert
    (and
        ;there needs to exist a set of 5 rows and 5 columns so that 5 pieces can be placed on different squares
        (exists ((r ROW) (r1 ROW) (r2 ROW) (r3 ROW) (r4 ROW) (c COLUMN) (c1 COLUMN) (c2 COLUMN) (c3 COLUMN) (c4 COLUMN))
            (and
                (square r c)
                (square r1 c1)
                (square r2 c2)
                (square r3 c3)
                (square r4 c4)

                ;and they are all different
                (distinct r r1 r2 r3 r4)
                (distinct c c1 c2 c3 c4)
            )
        )
        (forall ((r ROW) (c COLUMN))       
            (=>
                ;if there were to be a piece on the square
                (square r c)                
                (and
                    ;there mustn't be any other pieces on the same column
                    (forall ((column COLUMN))
                        (=>
                            (not (= c column))
                            (not (square r column))
                        )                        
                    )
                    ;or any other pieces on the same row
                    (forall ((row ROW))
                        (=>
                            (not (= r row))
                            (not (square row c))
                        )                        
                    )
                    ;or in any of the 4 neighbouring squares diagonally
                    (not (square (NextRow r) (NextColumn c)))
                    (not (square (PreviousRow r) (PreviousColumn c)))
                    (not (square (NextRow r) (PreviousColumn c)))
                    (not (square (PreviousRow r) (NextColumn c)))
                )
            )
        )       
    )
)

(check-sat)
(get-model)

(exit)