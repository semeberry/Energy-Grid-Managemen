;; Energy NFT Contract

(define-non-fungible-token energy-nft uint)

(define-map energy-nft-data
  { token-id: uint }
  {
    owner: principal,
    achievement-type: (string-ascii 50),
    value: uint,
    timestamp: uint
  }
)

(define-data-var nft-id-nonce uint u0)

(define-public (mint-energy-nft (achievement-type (string-ascii 50)) (value uint))
  (let
    ((new-id (+ (var-get nft-id-nonce) u1)))
    (try! (nft-mint? energy-nft new-id tx-sender))
    (map-set energy-nft-data
      { token-id: new-id }
      {
        owner: tx-sender,
        achievement-type: achievement-type,
        value: value,
        timestamp: block-height
      }
    )
    (var-set nft-id-nonce new-id)
    (ok new-id)
  )
)

(define-read-only (get-energy-nft-data (token-id uint))
  (map-get? energy-nft-data { token-id: token-id })
)

