;; Energy Payments Contract

(define-fungible-token energy-token)

(define-constant contract-owner tx-sender)

(define-map balances principal uint)

(define-public (mint (amount uint) (recipient principal))
  (begin
    (asserts! (is-eq tx-sender contract-owner) (err u403))
    (ft-mint? energy-token amount recipient)
  )
)

(define-public (transfer (amount uint) (sender principal) (recipient principal))
  (begin
    (asserts! (is-eq tx-sender sender) (err u403))
    (ft-transfer? energy-token amount sender recipient)
  )
)

(define-public (pay-for-energy (amount uint) (recipient principal))
  (transfer amount tx-sender recipient)
)

(define-read-only (get-balance (account principal))
  (ok (ft-get-balance energy-token account))
)

