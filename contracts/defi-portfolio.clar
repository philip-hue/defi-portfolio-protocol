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
