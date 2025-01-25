# DeFi Portfolio Protocol (DPP)

An enterprise-grade automated portfolio management and rebalancing protocol built on the Stacks blockchain.

## Overview

The DeFi Portfolio Protocol (DPP) is a sophisticated smart contract system that enables professional-grade portfolio management with automated rebalancing capabilities. It allows users to create, manage, and rebalance multi-token portfolios with precise percentage-based asset allocation.

## Features

- **Automated Portfolio Management**

  - Create portfolios with up to 10 different tokens
  - Set custom allocation percentages for each asset
  - Automated 24-hour rebalancing checks
  - Real-time portfolio value tracking

- **Security & Access Control**

  - Owner-based access control
  - Comprehensive input validation
  - Protocol-level fee management (0.25%)
  - Protected administrative functions

- **Portfolio Operations**
  - Portfolio creation with multiple assets
  - Custom asset allocation updates
  - Manual and automated rebalancing
  - Portfolio activity tracking

## Technical Specifications

### Constants

- `MAX_TOKENS_PER_PORTFOLIO`: 10 tokens
- `BASIS_POINTS`: 10000 (100% = 10000 basis points)
- `Protocol Fee`: 0.25% (25 basis points)

### Data Structures

#### Portfolios Map

```clarity
{
    owner: principal,
    created-at: uint,
    last-rebalanced: uint,
    total-value: uint,
    active: bool,
    token-count: uint
}
```

#### Portfolio Assets Map

```clarity
{
    target-percentage: uint,
    current-amount: uint,
    token-address: principal
}
```

### Core Functions

#### Portfolio Creation

```clarity
(define-public (create-portfolio (initial-tokens (list 10 principal)) (percentages (list 10 uint)))
```

Creates a new portfolio with specified tokens and their target allocation percentages.

#### Portfolio Rebalancing

```clarity
(define-public (rebalance-portfolio (portfolio-id uint))
```

Triggers a portfolio rebalance, updating asset allocations to match target percentages.

#### Allocation Updates

```clarity
(define-public (update-portfolio-allocation (portfolio-id uint) (token-id uint) (new-percentage uint))
```

Updates the target allocation percentage for a specific token in a portfolio.

### Error Handling

The protocol includes comprehensive error handling for various scenarios:

- Authentication errors (ERR-NOT-AUTHORIZED)
- Portfolio validation (ERR-INVALID-PORTFOLIO)
- Balance checks (ERR-INSUFFICIENT-BALANCE)
- Token validation (ERR-INVALID-TOKEN)
- Percentage validation (ERR-INVALID-PERCENTAGE)
- Data management errors (ERR-LENGTH-MISMATCH)

## Usage Examples

### Creating a Portfolio

```clarity
;; Create a portfolio with two tokens
(create-portfolio
    (list token-a token-b)
    (list u5000 u5000))  ;; 50-50 split
```

### Updating Allocations

```clarity
;; Update token allocation to 60-40
(update-portfolio-allocation
    portfolio-id
    u0  ;; first token
    u6000)  ;; 60%
```

### Rebalancing

```clarity
;; Trigger portfolio rebalancing
(rebalance-portfolio portfolio-id)
```

## Security Considerations

1. **Access Control**

   - Only portfolio owners can modify their portfolios
   - Administrative functions are protected
   - Protocol owner changes require verification

2. **Input Validation**

   - All percentages must be valid (0-10000 basis points)
   - Token addresses are validated
   - Portfolio existence is verified

3. **Balance Protection**
   - Insufficient balance checks
   - Rebalancing threshold controls
   - Transaction failure safeguards

## Protocol Administration

The protocol includes administrative functions for:

- Initializing the protocol
- Updating protocol ownership
- Managing protocol fees

## Development and Testing

### Prerequisites

- Clarity smart contract development environment
- Stacks blockchain node
- Testing framework for Clarity contracts

### Testing Recommendations

1. Test portfolio creation with various token combinations
2. Verify percentage validation and calculations
3. Test rebalancing functionality
4. Validate error handling and security measures
5. Test administrative functions and access control

## Best Practices

1. **Portfolio Management**

   - Regularly monitor portfolio allocations
   - Set appropriate rebalancing thresholds
   - Maintain sufficient balances for rebalancing

2. **Security**

   - Keep private keys secure
   - Verify transaction parameters
   - Monitor portfolio activity

3. **Performance**
   - Optimize token counts for gas efficiency
   - Consider transaction costs during rebalancing
   - Monitor blockchain network conditions

## Contributing

Contributions are welcome! Please follow these steps:

1. Fork the repository
2. Create a feature branch
3. Commit your changes
4. Push to the branch
5. Create a Pull Request

## License

This project is licensed under the MIT License - see the LICENSE file for details.
