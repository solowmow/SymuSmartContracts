# SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

# ERC20 Interface
interface ERC20:
    def totalSupply() -> uint256: pass
    def balanceOf(account: address) -> uint256: pass
    def transfer(recipient: address, amount: uint256) -> bool: pass
    def allowance(owner: address, spender: address) -> uint256: pass
    def approve(spender: address, amount: uint256) -> bool: pass
    def transferFrom(sender: address, recipient: address, amount: uint256) -> bool: pass
    event Transfer(from: address, to: address, value: uint256)
    event Approval(owner: address, spender: address, value: uint256)

# SymuToken Contract
contract SymuToken(ERC20):
    balances: public(map(address, uint256))
    allowances: public(map(address, map(address, uint256)))
    total_supply: uint256
    name: str
    symbol: str
    decimals: int128
    owner: address

    def __init__(_name: str, _symbol: str, _decimals: int128, initial_supply: uint256):
        self.name = _name
        self.symbol = _symbol
        self.decimals = _decimals
        self.total_supply = initial_supply * 10 ** self.decimals
        self.balances[msg.sender] = self.total_supply
        self.owner = msg.sender

    def totalSupply() -> uint256:
        return self.total_supply

    def balanceOf(account: address) -> uint256:
        return self.balances[account]

    def transfer(recipient: address, amount: uint256) -> bool:
        require(self.balanceOf(msg.sender) >= amount, "Insufficient balance")
        self.balances[msg.sender] -= amount
        self.balances[recipient] += amount
        log Transfer(msg.sender, recipient, amount)
        return True

    # Other ERC20 functions - allowance, approve, transferFrom

    # Additional functions for Token functionalities (if needed)
