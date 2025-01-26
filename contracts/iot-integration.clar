;; IoT Integration Contract

(define-map iot-data
  { device-id: (string-ascii 50), timestamp: uint }
  {
    user: principal,
    energy-value: uint,
    data-type: (string-ascii 20)
  }
)

(define-public (record-iot-data (device-id (string-ascii 50)) (energy-value uint) (data-type (string-ascii 20)))
  (let
    ((timestamp block-height))
    (map-set iot-data
      { device-id: device-id, timestamp: timestamp }
      {
        user: tx-sender,
        energy-value: energy-value,
        data-type: data-type
      }
    )
    (ok true)
  )
)

(define-read-only (get-latest-iot-data (device-id (string-ascii 50)))
  (map-get? iot-data { device-id: device-id, timestamp: block-height })
)

