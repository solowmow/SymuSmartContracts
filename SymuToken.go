// SPDX-License-Identifier: MIT
package main

import (
    "fmt"
)

type SymuToken struct {
    name     string
    symbol   string
    decimals uint8
    totalSupply uint256
    owner    address
    balances map[address]uint256
    allowances map[address]map[address]uint256
}

type uint256 uint64
type address string

func (token *SymuToken) init() {
    token.name = "SymuCommunity"
    token.symbol = "SYM"
    token.decimals = 18
    token.totalSupply = 1000000 * uint256(10 ** token.decimals)
    token.owner = msg.sender
    token.balances = make(map[address]uint256)
    token.balances[token.owner] = token.totalSupply
    token.allowances = make(map[address]map[address]uint256)
}

func (token *SymuToken) balanceOf(account address) uint256 {
    return token.balances[account]
}

func (token *SymuToken) transfer(recipient address, amount uint256) bool {
    if recipient == nil || amount > token.balances[msg.sender] {
        return false
    }
    token.balances[msg.sender] -= amount
    token.balances[recipient] += amount
    fmt.Println("Transfer:", msg.sender, "->", recipient, "Amount:", amount)
    return true
}

func (token *SymuToken) approve(spender address, amount uint256) bool {
    if token.allowances[msg.sender] == nil {
        token.allowances[msg.sender] = make(map[address]uint256)
    }
    token.allowances[msg.sender][spender] = amount
    fmt.Println("Approval:", msg.sender, "->", spender, "Amount:", amount)
    return true
}

func (token *SymuToken) transferFrom(sender address, recipient address, amount uint256) bool {
    if recipient == nil || amount > token.balances[sender] || amount > token.allowances[sender][msg.sender] {
        return false
    }
    token.balances[sender] -= amount
    token.balances[recipient] += amount
    token.allowances[sender][msg.sender] -= amount
    fmt.Println("Transfer from:", sender, "->", recipient, "Amount:", amount)
    return true
}

func (token *SymuToken) allowance(account address, spender address) uint256 {
    return token.allowances[account][spender]
}

func (token *SymuToken) burn(amount uint256) bool {
    if amount > token.balances[msg.sender] {
        return false
    }
    token.balances[msg.sender] -= amount
    token.totalSupply -= amount
    fmt.Println("Burn:", msg.sender, "Amount:", amount)
    return true
}

func (token *SymuToken) mint(amount uint256) bool {
    if token.totalSupply + amount <= 2**256 - 1 {
        token.balances[token.owner] += amount
        token.totalSupply += amount
        fmt.Println("Mint:", token.owner, "Amount:", amount)
        return true
    }
    return false
}

func main() {
    // Instantiating the contract
    var symuToken SymuToken
    symuToken.init()
}
