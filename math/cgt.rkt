#lang at-exp racket/base


(require scribble/srcdoc
         racket/contract
         (for-doc racket/base
                  scribble/base
                  scribble/manual))


(struct permutation
  (image inverse)
  #:transparent)

; TODO: consistent naming for constructors

; Things that permutations do:
; *, ^, degree, inverse
; orbits (cycles)
; printing
; reading
; serialisation
; extend (to bigger degree)
; restrict (to smaller degree)
; does the notion of a largest moved point make sense?

; collections of permutations: lists, vectors, collection of same degree perms

; need the omega that permutations act on, and subsets
; union-find

; tests

(provide (proc-doc/names
          permutation? (-> any/c boolean?)
          (x) @{Determines if @racket[x] is a permutation.}))