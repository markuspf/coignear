#lang scribble/doc
@(require scribble/manual
          scribble/basic
          scribble/extract
          (for-label (except-in ffi/unsafe ->)
                     racket
                     math/cgt))

@title[#:tag "top"]{Computational Group Theory in Racket}
@author[(author+email "Markus Pfeiffer" "makx+racket@morphism.de")]

@defmodule[math/cgt]

This package provides implementations of algorithms in computational group theory, currently focusing on permutation groups.
It aims at having clean, simple, and performant implementations of the nearly-linear time library described in Seress' book "Permutation Group Algorithms", and efficient implementations of partition backtrack and extensions..

@local-table-of-contents[]

@include-extracted[math/cgt]

