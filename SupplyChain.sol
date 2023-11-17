// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SupplyChain {
    // Structure to represent a product in the supply chain
    struct Product {
        uint256 id;
        string name;
        address owner;
        bool isAvailable;
    }

    // Mapping to store products based on their ID
    mapping(uint256 => Product) public products;

    uint256 public productCount;

    event ProductAdded(uint256 id, string name, address owner, bool isAvailable);
    event ProductTransferred(uint256 id, address from, address to);

    // Function to add a new product to the supply chain
    function addProduct(string memory _name) public {
        productCount++;
        products[productCount] = Product(productCount, _name, msg.sender, true);
        emit ProductAdded(productCount, _name, msg.sender, true);
    }

    // Function to transfer ownership of a product
    function transferProduct(uint256 _productId, address _newOwner) public {
        require(products[_productId].isAvailable, "Product is not available");
        require(products[_productId].owner == msg.sender, "You are not the owner");

        products[_productId].owner = _newOwner;
        emit ProductTransferred(_productId, msg.sender, _newOwner);
    }
    
    // Additional functions for supply chain management can be added as needed
}
