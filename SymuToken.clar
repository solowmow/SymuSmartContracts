(contract SymuToken (owner (buff 20))
  (define-public (init)
    (set! (var total-supply) 1000000)
    (set! (var balance-of {sender})) total-supply
    (set-owner! 'owner)
  )

  (define-public (transfer (to principal) (amount uint))
    (assert (<= amount (var balance-of {sender})) "Insufficient balance")
    (set! (var balance-of {sender}) (- (var balance-of {sender}) amount))
    (set! (var balance-of to) (+ (var balance-of to) amount))
    (ok)
  )

  (define-public (allowance (from principal) (to principal))
    (var allowance-amount (at allowance {from} {to}))
    (var remaining-amount (- (var balance-of {from}) allowance-amount))
    (ok remaining-amount)
  )

  (define-public (approve (spender principal) (amount uint))
    (map-set! allowance {sender} spender amount)
    (ok)
  )

  (define-public (transfer-from (from principal) (to principal) (amount uint))
    (var allowed-amount (at allowance {from} {sender}))
    (assert (<= amount allowed-amount) "Amount exceeds allowance")
    (set! (var balance-of from) (- (var balance-of from) amount))
    (set! (var balance-of to) (+ (var balance-of to) amount))
    (set! (var allowance {from} {sender}) (- allowed-amount amount))
    (ok)
  )

  (define-public (balance-of (owner principal))
    (at balance-of owner)
  )

  (define-public (mint (recipient principal) (amount uint))
    (assert (= {sender} (get-owner))
            "Only the owner can mint tokens")
    (set! (var balance-of recipient) (+ (var balance-of recipient) amount))
    (set! (var total-supply) (+ (var total-supply) amount))
    (ok)
  )

  (define-public (burn (amount uint))
    (assert (>= (var balance-of {sender}) amount) "Burn amount exceeds balance")
    (set! (var balance-of {sender}) (- (var balance-of {sender}) amount))
    (set! (var total-supply) (- (var total-supply) amount))
    (ok)
  )

  ;; Access Controls: Owner management
  (define-private (get-owner)
    (at owner)
  )
  
  (define-public (set-owner! (new-owner principal))
    (set! owner new-owner)
    (ok)
  )

  ;; Events and Logging
  (define-event TokenTransfer (from principal) (to principal) (amount uint))
  (define-event Approval (from principal) (spender principal) (amount uint))
  (define-event Mint (to principal) (amount uint))
  (define-event Burn (from principal) (amount uint))
)
