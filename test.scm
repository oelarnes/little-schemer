(use-modules (srfi srfi-64))

; I don't know how to suppress the unbound variable warning in Atom
(define atom?)
(define lat?)
(define member?)
(define rember)
(define firsts)
(define insertR)
(define insertL)
(define subst)
(define multirember)
(define multiinsertR)
(define multiinsertL)
(define multisubst)
(define add1)
(define sub1)
(define o+)

(load "fns.scm")

; Chapter 1
(test-begin "1. Toys" 23)

; atom?
(test-assert (atom? 'atom))
(test-assert (atom? 'turkey))
(test-assert (atom? 1492))
(test-assert (atom? 'u))
(test-assert (atom? '*abc$))

(test-eq #f (atom? '()))

; car
(test-eq 'a (car '(a b c)))
(test-error (car 'hotdog))
(test-error (car '()))

(define l '(((hotdogs)) (and) (pickle) relish))
(test-eq '((hotdogs)) (car l))
(test-eq '(hotdogs) (car (car l)))

; cdr
(test-eq '(b c) (cdr '(a b c)))
(test-eq '() (cdr '(hamburger)))
(test-error (cdr 'hotdogs))
(test-error (cdr '()))

; cons
(define a 'peanut)
(define l '(butter and jelly))
; not test-eq or test-eqv
(test-equal '(peanut butter and jelly) (cons a l))
(test-equal (cons 'a (car '((b) c d))) '(a b))

; null?
(test-assert (null? (quote ())))
(test-eq #f (null? '(a b c)))

(test-assert (atom? (car '(Harry had a heap of apples))))
(test-eq #f (atom? (car (cdr '(swing (low sweet) cherry oat)))))

; eq
(define a1 'Harry)
(define a2 'Harry)
(test-assert (eq? a1 a2))
(define l '(beans beans we need jelly beans))
(test-assert (eq? (car l) (car (cdr l))))

(test-end "1. Toys")

; Chapter 2
(test-begin "2. Do It, Do It Again, and Again, and Again..." 4)

; lat?
(test-assert (lat? '(Jack Sprat could eat no chicken fat)))
(test-eq #f (lat? '(Jack (Sprat could) eat no chicken fat)))

; member?
(test-assert (member? 'tea '(coffee tea and milk)))
(test-eq #f (member? 'poached '(fried eggs and scrambled eggs)))

(test-end "2. Do It, Do It Again, and Again, and Again...")

; Chapter 3
(test-begin "3. Cons the Magnificent" 14)

; rember
(test-equal '(lamb chops and jelly) (rember 'mint '(lamb chops and mint jelly)))
(test-equal '(lamb chops and flavored mint jelly)
  (rember 'mint '(lamb chops and mint flavored mint jelly)))
(test-equal '(bacon lettuce and tomato)
  (rember 'toast '(bacon lettuce and tomato)))

; firsts
(test-equal '(apple plum grape bean)
  (firsts '(
    (apple peach pumpkin)
    (plum pear cherry)
    (grape raisin pea)
    (bean carrot eggplant))))
(test-equal '() (firsts '()))
(test-equal '((five plums) eleven (no))
  (firsts '(
    ((five plums) four)
    (eleven green oranges)
    ((no) more))))

; insertR
(test-equal '(ice cream with fudge topping for desert)
  (insertR 'topping 'fudge '(ice cream with fudge for desert)))
(test-equal '(a b c d e f g d h)
  (insertR 'e 'd '(a b c d f g d h)))

; test insertL, subst, multirember, multiinsertR, multiinsertL, multisubst
(test-equal '(a c b b) (insertL 'c 'b '(a b b)))
(test-equal '(a c b) (subst 'c 'b '(a b b)))
(test-equal '(a) (multirember 'b '(a b b)))
(test-equal '(a b c b c) (multiinsertR 'c 'b '(a b b)))
(test-equal '(a c b c b) (multiinsertL 'c 'b '(a b b)))
(test-equal '(a c c) (multisubst 'c 'b '(a b b)))

(test-end "3. Cons the Magnificent")

(test-begin "4. Numbers Games")

; add1 sub1
(test-equal 68 (add1 67))
(test-equal 4 (sub1 5))
(test-equal (+ 4 5) (o+ 4 5))
(test-equal (- 10 4) (o- 10 4))
(test-equal 10 (addtup '(1 2 3 4)))

(test-end "4. Numbers Games")
