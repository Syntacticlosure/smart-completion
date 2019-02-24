#lang racket
(require drracket/tool racket/gui framework)
(provide tool@)
(define tool@
  (unit (import drracket:tool^)
        (export drracket:tool-exports^)
        (define phase1 void)
        (define phase2 void)
  (define sc-mixin
    (mixin ((class->interface text%) text:autocomplete<%>) ()
      (super-new)
      (inherit auto-complete get-dc get-text)
      (define (proper-suffix str)
        (match (string->list str)
          [(list) #f]
          [(list a ... (or #\( #\) #\[ #\] #\{ #\} #\space
                           #\newline #\return #\"
                           )) #f]
          [_ #t]))
      (define/augment (after-insert start len)
        (when (and (get-dc) (proper-suffix (get-text start (+ start len))))
        (auto-complete))
        (inner (void) after-insert start len)
      ))
  )
  (drracket:get/extend:extend-definitions-text sc-mixin)
  ))

