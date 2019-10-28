#lang racket/base

(require
  rackunit
  racket/list
  racket/vector
  racket/set
  racket/match
  syntax/parse/define
  (for-syntax racket/base syntax/parse))

(provide permutation
         permutation-degree
         permutations-apply
         permutation-*
         permutation-image
         permutation-inverse
         permutation-identity
         permutation-cycles
         permutation-random)

(struct permutation (image) #:transparent)

(define (permutation-degree perm)
  (vector-length (permutation-image perm)))

#;(define (permutation-apply pt . perms)
  (if (empty? perms)
      pt
      (permutation-apply
       (vector-ref (permutation-image (car perms) pt))
       (cdr perms))))

(define (permutations-apply pt . perms)
  (match perms
    [(list) pt]
    [(list p ps ...)
     (apply permutations-apply (vector-ref (permutation-image p) pt) ps)]))

(define (permutation-* . ps)
  (match ps
    [(list) idperm]
    [(list p ps ...)
  (permutation
   (for/fold [(res (permutation-image (car ps)))]
             [(p (rest ps))]
     (vector-map (lambda (x) (permutations-apply x p)) res)))]))

(define (permutation-identity degree)
  (permutation (list->vector (range degree))))
   
(define (permutation-inverse perm)
  (let* [(im (permutation-image perm))
         (deg (permutation-degree perm))
         (result (make-vector deg))]
    (for [(i (in-range deg))]
      (vector-set! result (vector-ref im i) i))
    (permutation result)))


; TODO: find out whether it's a good idea
;       to use a macro here
#;(define (vector-swap! v i j)
    (let [(tmp (vector-ref v i))]
      (vector-set! v i (vector-ref v j))
      (vector-set! v j tmp)))

(define-syntax (vector-swap! stx)
  (syntax-parse stx
    [(_ v i j)
     #'(let* [(_i i)
              (_j j)
              (tmp (vector-ref v _i))]
         (vector-set! v _i (vector-ref v _j))
         (vector-set! v _j tmp))]))

(define (permutation-random degree)
  (let [(v (build-vector degree (λ(x) x)))]
    (for [(i (in-range degree))]
      (vector-swap! v i (random i degree)))
    (permutation v)))

(define (permutation-orbit/list pnt pnts perm)
  (let [(new (permutations-apply (first pnts) perm))]
    (if (eq? pnt new)
        pnts
        (permutation-orbit/list pnt (cons new pnts) perm)))) 

(define (permutation-collect-cycle pnt perm)
  (define (collect acc)
    (let [(next (permutations-apply (last acc) perm))]
      (if (eq? next pnt)
          acc
          (collect (append acc (list next))))))
  (collect (list pnt)))
  
(define (permutation-cycles perm)
  (let [(v (make-vector (permutation-degree perm) #f))]
    (define (mark-cycle p k)
      (let [(next (permutations-apply p perm))]
        (unless (vector-ref v next)
          (vector-set! v next k)
          (mark-cycle next k))))
    (define (loop k)
      (let [(p (vector-member #f v))]
        (when p
          (mark-cycle p k)
          (loop (add1 k)))))
    (loop 0)
    v))
