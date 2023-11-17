pub contract SymuToken {

    pub let name: String
    pub let symbol: String
    pub let decimals: UInt8
    pub var totalSupply: UInt256
    pub var owner: Address

    pub resource Token {
        pub var balances: @{Address: UInt256}
        pub var allowances: @{Address: @{Address: UInt256}}

        init() {
            self.balances = {}
            self.allowances = {}
        }

        pub fun balanceOf(account: Address): UInt256 {
            return self.balances[account] ?? 0
        }

        pub fun transfer(recipient: Address, amount: UInt256): Bool {
            if recipient == nil || amount > self.balances[msg.sender] ?? 0 {
                return false
            }

            self.balances[msg.sender]! -= amount
            self.balances[recipient] = (self.balances[recipient] ?? 0) + amount
            return true
        }

        // Other functions will follow similar patterns

    }

    pub init() {
        self.name = "SymuCommunity"
        self.symbol = "SYM"
        self.decimals = 18
        self.totalSupply = 1000000 * (10 ** UInt256(self.decimals))
        self.owner = self.account.address

        let token <- create Token()
        self.account.save(<-token, to: /storage/SymuToken)
    }
}
