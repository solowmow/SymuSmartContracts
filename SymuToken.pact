(define-namespace (symu-token))

(define-schema token-account
  (balance::integer))

(define-constant (initial-balance 1000000))

(define-read (get-balance (account-name::string))
  (at-read token-account { balance } account-name))

(define-read (get-total-supply)
  (ok initial-balance))

(define-read (get-owner)
  (ok "OWNER_PUBLIC_KEY"))

(define-read (get-token-metadata)
  (ok { "name": "SymuToken", "symbol": "SYM", "decimals": 18 }))

(define-private (transfer (from::keyset) (to::string) (amount::integer))
  (with-read
    ;; Check if 'from' has permission to spend
    (get-balance (read-keyset "balance-keyset") (read-msg "from"))
    (get-balance (read-keyset "balance-keyset") (read-msg "to"))
    (enforce-keyset from)
    (enforce (> amount 0) "Amount must be positive")
    (let ((from-bal (get-balance (read-msg "from")))
          (to-bal (get-balance (read-msg "to"))))
      (enforce (>= from-bal amount) "Insufficient balance")
      (insert token-account { balance (- from-bal amount) } (read-msg "from"))
      (insert token-account { balance (+ to-bal amount) } (read-msg "to"))
      (ok "Transfer successful"))))

(define-read (transfer-successful)
  (ok "Transfer successful"))

(define-private (set-owner (new-owner::string))
  (with-read
    (get-owner)
    (enforce-keyset (read-keyset "owner-keyset"))
    (insert token-account { balance initial-balance } new-owner)
    (ok "Owner set successfully")))

(define-read (owner-set-successfully)
  (ok "Owner set successfully"))

(define-read (get-token-account (account::string))
  (at-read token-account { balance } account))
