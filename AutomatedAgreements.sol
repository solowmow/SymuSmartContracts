// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract AutomatedAgreements {
    address public admin;
    mapping(address => bool) public users;
    mapping(address => uint256) public balances;

    event UserAdded(address user);
    event UserRemoved(address user);
    event Deposit(address user, uint256 amount);
    event Withdrawal(address user, uint256 amount);

    modifier onlyAdmin() {
        require(msg.sender == admin, "Only admin can perform this action");
        _;
    }

    modifier onlyUser() {
        require(users[msg.sender], "Only registered users can perform this action");
        _;
    }

    constructor() {
        admin = msg.sender;
        users[msg.sender] = true;
    }

    function addUser(address _user) public onlyAdmin {
        users[_user] = true;
        emit UserAdded(_user);
    }

    function removeUser(address _user) public onlyAdmin {
        require(_user != admin, "Admin cannot be removed");
        users[_user] = false;
        emit UserRemoved(_user);
    }

    function deposit() public payable onlyUser {
        balances[msg.sender] += msg.value;
        emit Deposit(msg.sender, msg.value);
    }

    function withdraw(uint256 _amount) public onlyUser {
        require(_amount <= balances[msg.sender], "Insufficient balance");
        balances[msg.sender] -= _amount;
        payable(msg.sender).transfer(_amount);
        emit Withdrawal(msg.sender, _amount);
    }

    // Add more advanced functionalities or logic as needed
}
