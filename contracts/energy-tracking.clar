;; Energy Tracking Contract

(define-map energy-data
  { user: principal, timestamp: uint }
  {
    production: uint,
    consumption: uint,
    source: (string-ascii 20)
  }
)

(define-public (record-energy (production uint) (consumption uint) (source (string-ascii 20)))
  (let
    ((user tx-sender)
     (timestamp block-height))
    (map-set energy-data
      { user: user, timestamp: timestamp }
      {
        production: production,
        consumption: consumption,
        source: source
      }
    )
    (ok true)
  )
)

(define-read-only (get-energy-data (user principal) (timestamp uint))
  (map-get? energy-data { user: user, timestamp: timestamp })
)

(define-read-only (get-net-energy (user principal) (timestamp uint))
  (match (map-get? energy-data { user: user, timestamp: timestamp })
    data (ok (- (get production data) (get consumption data)))
    (err u404)
  )
)

