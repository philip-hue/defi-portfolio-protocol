;; Title: DeFi Portfolio Protocol (DPP)
;; Summary: Enterprise-grade automated portfolio management and rebalancing protocol
;; Description: A sophisticated smart contract system that enables professional-grade
;; portfolio management on the Stacks blockchain. Features include:
;;  - Automated portfolio rebalancing with customizable thresholds
;;  - Multi-token portfolio creation and management
;;  - Precise percentage-based asset allocation
;;  - Comprehensive error handling and validation
;;  - User-specific portfolio tracking
;;  - Protocol-level fee management
;;  - Built-in security measures and access controls

;; Error Codes
;; Authentication and Authorization
(define-constant ERR-NOT-AUTHORIZED (err u100))
(define-constant ERR-PORTFOLIO-EXISTS (err u105))

;; Portfolio Management
(define-constant ERR-INVALID-PORTFOLIO (err u101))
(define-constant ERR-INSUFFICIENT-BALANCE (err u102))
(define-constant ERR-REBALANCE-FAILED (err u104))

;; Token and Asset Management
(define-constant ERR-INVALID-TOKEN (err u103))
(define-constant ERR-INVALID-TOKEN-ID (err u110))
(define-constant ERR-INVALID-PERCENTAGE (err u106))
(define-constant ERR-MAX-TOKENS-EXCEEDED (err u107))

;; Data Management
(define-constant ERR-LENGTH-MISMATCH (err u108))
(define-constant ERR-USER-STORAGE-FAILED (err u109))

;; Protocol Configuration
(define-constant MAX-TOKENS-PER-PORTFOLIO u10)
(define-constant BASIS-POINTS u10000)

;; Protocol State
(define-data-var protocol-owner principal tx-sender)
(define-data-var portfolio-counter uint u0)
(define-data-var protocol-fee uint u25) ;; 0.25% in basis points

;; Data Structures
(define-map Portfolios
    uint ;; portfolio-id
    {
        owner: principal,
        created-at: uint,
        last-rebalanced: uint,
        total-value: uint,
        active: bool,
        token-count: uint
    }
)

(define-map PortfolioAssets
    {portfolio-id: uint, token-id: uint}
    {
        target-percentage: uint,
        current-amount: uint,
        token-address: principal
    }
)

(define-map UserPortfolios
    principal
    (list 20 uint)
)

;; Read-Only Functions

(define-read-only (get-portfolio (portfolio-id uint))
    (map-get? Portfolios portfolio-id)
)

(define-read-only (get-portfolio-asset (portfolio-id uint) (token-id uint))
    (map-get? PortfolioAssets {portfolio-id: portfolio-id, token-id: token-id})
)

(define-read-only (get-user-portfolios (user principal))
    (default-to (list) (map-get? UserPortfolios user))
)

(define-read-only (calculate-rebalance-amounts (portfolio-id uint))
    (let (
        (portfolio (unwrap! (get-portfolio portfolio-id) ERR-INVALID-PORTFOLIO))
        (total-value (get total-value portfolio))
    )
    (ok {
        portfolio-id: portfolio-id,
        total-value: total-value,
        needs-rebalance: (> (- block-height (get last-rebalanced portfolio)) u144) ;; 24 hours in blocks
    }))
)

;; Private Functions

(define-private (validate-token-id (portfolio-id uint) (token-id uint))
    (let (
        (portfolio (unwrap! (get-portfolio portfolio-id) false))
    )
    (and 
        (< token-id MAX-TOKENS-PER-PORTFOLIO)
        (< token-id (get token-count portfolio))
        true
    ))
)

(define-private (validate-percentage (percentage uint))
    (and (>= percentage u0) (<= percentage BASIS-POINTS))
)

(define-private (validate-portfolio-percentages (percentages (list 10 uint)))
    (fold check-percentage-sum percentages true)
)

(define-private (check-percentage-sum (current-percentage uint) (valid bool))
    (and valid (validate-percentage current-percentage))
)