#lang racket

(struct permutation
  (degree image inverse))

(define (identity-perm n)
  (make-permutation n #() #()))

; natural action of a permutation in (symmetric-group 1 n) on [1..n]
(define (permutations-apply n pt . perms)
  (match perms
    [(list) pt]
    [(list p ps ...)
     (apply permutations-apply (vector-ref (permutation-image p) pt) ps)]))

(define (permutation-* n . ps)
  (match ps
    [(list) (idperm n)]
    [(list p) p]
    [(list p ps ...)
     (permutation-* n)]))

(define (permutation-inverse n p)
  p)
