;https://www.brainzilla.com/logic/zebra/wooden-furniture/

;shirt colors
(declare-const blueshirt Int)
(declare-const greenshirt Int)
(declare-const orangeshirt Int)
(declare-const redshirt Int)
(declare-const yellowshirt Int)

;names
(declare-const Barbara Int)
(declare-const Dana Int)
(declare-const Gina Int)
(declare-const Lori Int)
(declare-const Patricia Int)

;furniture
(declare-const cupboard Int)
(declare-const desk Int)
(declare-const dresser Int)
(declare-const table Int)
(declare-const wardrobe Int)

;prices
(declare-const eighthundred Int)
(declare-const ninehundred Int)
(declare-const thousand Int)
(declare-const thousandhundred Int)
(declare-const thousandtwohundred Int)

;delivery time
(declare-const fivedays Int)
(declare-const tendays Int)
(declare-const fifteendays Int)
(declare-const twentydays Int)
(declare-const twentyfivedays Int)

;age
(declare-const fortyyears Int)
(declare-const fortyfiveyears Int)
(declare-const fiftyyears Int)
(declare-const fiftyfiveyears Int)
(declare-const sixtyyears Int)

(define-fun AnswerLimit ((Customer Int)) Bool
   (or (= Customer 1) (= Customer 2) (= Customer 3) (= Customer 4) (= Customer 5))
)

(define-fun SomewhereBetween ((Customer Int) (LeftCustomer Int) (RightCustomer Int)) Bool
    (and (> Customer LeftCustomer) (< Customer RightCustomer))
)

(define-fun IsNextTo ((Customer Int) (NextCustomer Int)) Bool
    (or (= Customer (+ NextCustomer 1)) (= Customer (- NextCustomer 1)))
)

(assert
    (and

        (distinct blueshirt greenshirt orangeshirt redshirt yellowshirt)
        (distinct Barbara Dana Gina Lori Patricia)
        (distinct cupboard desk table dresser wardrobe)
        (distinct eighthundred ninehundred thousand thousandhundred thousandtwohundred)
        (distinct fivedays tendays fifteendays twentydays twentyfivedays)
        (distinct fortyyears fortyfiveyears fiftyyears fiftyfiveyears sixtyyears)
        
        (AnswerLimit blueshirt)
        (AnswerLimit greenshirt)
        (AnswerLimit orangeshirt)
        (AnswerLimit redshirt)
        (AnswerLimit yellowshirt)

        (AnswerLimit Barbara)
        (AnswerLimit Dana)
        (AnswerLimit Gina)
        (AnswerLimit Lori)
        (AnswerLimit Patricia)

        (AnswerLimit cupboard)
        (AnswerLimit desk)
        (AnswerLimit table)
        (AnswerLimit dresser)
        (AnswerLimit wardrobe)

        (AnswerLimit eighthundred)
        (AnswerLimit ninehundred)
        (AnswerLimit thousand)
        (AnswerLimit thousandhundred)
        (AnswerLimit thousandtwohundred)

        (AnswerLimit fivedays)
        (AnswerLimit tendays)
        (AnswerLimit fifteendays)
        (AnswerLimit twentydays)
        (AnswerLimit twentyfivedays)

        (AnswerLimit fortyyears)
        (AnswerLimit fortyfiveyears)
        (AnswerLimit fiftyyears)
        (AnswerLimit fiftyfiveyears)
        (AnswerLimit sixtyyears)

        ;The customer whose delivery time is 25 days is somewhere between the customer whose delivery time is 20 days and the customer whose delivery time is 10 days, in that order.
        (SomewhereBetween twentyfivedays twentydays tendays)

        ;Lori is next to the youngest woman.
        (IsNextTo fortyyears Lori)

        ;At the fourth position is the 45 years old customer
        (= fortyfiveyears 4)

        ;The customer who bought the most expensive piece of furniture is next to the customer whose delivery will take 5 days.
        (IsNextTo fivedays thousandtwohundred)

        ;The woman wearing the Yellow shirt is somewhere between the woman who bought the $900 piece of furniture and the 40-year-old woman, in that order.
        (SomewhereBetween yellowshirt ninehundred fortyyears)

        ;The customer who purchased the $900 piece of furniture is next to the customer whose delivery time is 20 days.
        (IsNextTo ninehundred twentydays)

        ;The woman wearing the Green shirt is somewhere between the woman who bought the Table and the woman wearing the Red shirt, in that order.
        (SomewhereBetween greenshirt table redshirt)

        ;The woman wearing the Orange shirt is somewhere to the right of the woman wearing the Red shirt.
        (> orangeshirt redshirt)

        ;Dana is somewhere between the customer who bought the Wardrobe and Lori, in that order.
        (SomewhereBetween Dana wardrobe Lori)

        ;The woman wearing the Green shirt is exactly to the left of the woman whose delivery time is 10 days.
        (= tendays (+ greenshirt 1))

        ;Barbara is next to the customer who bought the Wardrobe.
        (IsNextTo Barbara wardrobe)

        ;The woman whose delivery time is 25 days is somewhere between the woman wearing the Yellow shirt and the woman whose delivery time is 5 days, in that order.        
        (SomewhereBetween twentyfivedays yellowshirt fivedays)

        ;The 40 years old customer is next to the customer who purchased the $1100 furniture.
        (IsNextTo fortyyears thousandhundred)

        ;At the first position is the woman who bought the Table.
        (= table 1)

        ;The customer who purchased the $1100 piece of furniture is next to the customer who purchased the $800 piece of furniture.
        (IsNextTo thousandhundred eighthundred)

        ;The Cupboard was bought by the customer that is somewhere between Barbara and the 45 years old customer, in that order.        
        (SomewhereBetween cupboard Barbara fortyfiveyears)

        ;The 40-year-old woman is next to the 45-year-old woman.
        (IsNextTo fortyyears fortyfiveyears)

        ;The oldest customer is wearing the Yellow shirt.
        (= sixtyyears yellowshirt)

        ;Patricia is somewhere between the woman who bought the $900 piece of furniture and the woman whose delivery will take 25 days, in that order.
        (SomewhereBetween Patricia ninehundred twentyfivedays)

        ;The customer that purchased the Dresser is next to the customer wearing the Green shirt.
        (IsNextTo dresser greenshirt)

        ;The 50-year-old woman is next to the woman wearing the Yellow shirt.
        (IsNextTo fiftyyears yellowshirt)
    )
)

(check-sat)
(get-model)
(exit)