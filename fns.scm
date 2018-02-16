; is x an atom?
(define (atom? x)
  (and (not (null? x))
       (not (pair? x))))

; is ls a list of atoms?
(define (lat? ls)
  (cond
    ((null? ls) #t)
    (else (and
      (atom? (car ls))
      (lat? (cdr ls))))))

; is a a member of lat?
(define (member? a lat)
  (cond
    ((null? lat) #f)
    (else (or
      (eq? a (car lat))
      (member? a (cdr lat))))))

; remove the first appearance of a from lat
(define (rember a lat)
  (cond
    ((null? lat) '())
    ((eq? a (car lat)) (cdr lat))
    (else (cons (car lat) (rember a (cdr lat))))))

; return a list of the first elements of each element of ls
(define (firsts ls)
  (cond
    ((null? ls) '())
    (else
      (cons (car (car ls)) (firsts (cdr ls))))))

; insert new after the first appearance of old
(define (insertR new old lat)
  (cond
    ((null? lat) '())
    ((eq? old (car lat))
      (cons old (cons new (cdr lat))))
    (else
      (cons (car lat) (insertR new old (cdr lat))))))

; insert new before the first appearance of old
(define (insertL new old lat)
  (cond
    ((null? lat) (quote ()))
    ((eq? old (car lat))
      (cons new lat))
    (else
      (cons (car lat) (insertL new old (cdr lat))))))

; substitute the first appearance of old with new in lat
(define (subst new old lat)
  (cond
    ((null? lat) (quote ()))
    ((eq? old (car lat))
      (cons new (cdr lat)))
    (else
      (cons (car lat) (subst new old (cdr lat))))))

; substitute the first appearance of either old1 or old2 with new in lat
(define (subst2 new old1 old2 lat)
  (cond
      ((null? lat) (quote ()))
      ((or
        (eq? (car lat) old1)
        (eq? (car lat) old2)
      ) (cons new (cdr lat)))
      (else
        (cons (car lat) (subst2 new old1 old2 (cdr lat))))))

; remove all instances of el from lat
(define (multirember el lat)
  (cond
      ((null? lat) (quote ()))
      ((eq? (car lat) el) (multirember el (cdr lat)))
      (else
        (cons (car lat) (multirember el (cdr lat))))))

; insert new after each old in lat
(define (multiinsertR new old lat)
  (cond
      ((null? lat) (quote ()))
      ((eq? (car lat) old)
        (cons old (cons new (multiinsertR new old (cdr lat)))))
      (else (cons (car lat) (multiinsertR new old (cdr lat))))))

; insert new before each old in lat
(define (multiinsertL new old lat)
  (cond
    ((null? lat) (quote ()))
    ((eq? (car lat) old)
      (cons new (cons old (multiinsertL new old (cdr lat)))))
    (else (cons (car lat) (multiinsertL new old (cdr lat))))))

; substitute each old with new
(define (multisubst new old lat)
  (cond
    ((null? lat) (quote ()))
    ((eq? (car lat) old)
      (cons new (multisubst new old (cdr lat))))
    (else (cons (car lat) (multisubst new old (cdr lat))))))

(define (add1 n)
  (+ n 1))

(define (sub1 n)
  (- n 1))

; should be better than the book version due to tail call
(define (o+ a b)
  (cond
    ((zero? b) a)
    (else (o+ (add1 a) (sub1 b)))))

; assume a > b
(define (o- a b)
  (cond
    ((zero? b) a)
    (else (o- (sub1 a) (sub1 b)))))

; again with a tail call
(define (addtup tup)
  (define (addtotup a tup)
    (cond
      ((null? tup) a)
      (else (addtotup (+ a (car tup)) (cdr tup)))))
  (addtotup 0 tup))
