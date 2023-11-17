# Supply Chain Contract
contract SupplyChain:
    products: public(map(uint256, Product))
    product_count: uint256
    owner: address

    struct Product:
        name: str
        quantity: uint256
        owner: address

    def __init__():
        self.owner = msg.sender
        self.product_count = 0

    def createProduct(name: str, quantity: uint256) -> uint256:
        self.product_count += 1
        self.products[self.product_count] = Product({
            name: name,
            quantity: quantity,
            owner: msg.sender
        })
        return self.product_count

    # Other functions: updateProduct, transferOwnership, getProductDetails, etc.

    # Additional functions for Supply Chain functionalities (if needed)

