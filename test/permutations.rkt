#lang racket

(require math/cgt/permutations
	 rackunit)

(check-eq?
 (permutation-degree (permutation #())) 0)
(check-eq?
 (permutation-degree (permutation #(0 1 2 3))) 4)
(check-equal?
 (let [(p (permutation #(2 0 1)))]
   (permutation-* p (permutation-inverse p)))
 (permutation-identity 3))

(for [(i (in-range 100))]
  (let [(degree (random 1024))]
    (check-eq? degree
               (set-count
                (list->set
                 (vector->list (permutation-image (permutation-random degree))))))))


