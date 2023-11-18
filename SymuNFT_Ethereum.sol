// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// Interface for the ERC721 standard
interface IERC721 {
    function transferFrom(address _from, address _to, uint256 _tokenId) external;
    function ownerOf(uint256 _tokenId) external view returns (address);
}

// Interface for the SymuBridgeToBTC contract
interface SymuBridgeToBTC {
    function lockAndTransferToBTC(address _receiver, uint256 _tokenId) external;
}

// Interface for the SymuBridgeToTezos contract
interface SymuBridgeToTezos {
    function lockAndTransferToTezos(address _receiver, uint256 _tokenId) external;
}

contract SymuNFT_Ethereum {
    // ERC721 contract address
    address public nftContractAddress;

    // Addresses of bridge contracts
    address public symuBridgeToBTCAddress;
    address public symuBridgeToTezosAddress;

    constructor(address _nftContractAddress, address _symuBridgeToBTCAddress, address _symuBridgeToTezosAddress) {
        nftContractAddress = _nftContractAddress;
        symuBridgeToBTCAddress = _symuBridgeToBTCAddress;
        symuBridgeToTezosAddress = _symuBridgeToTezosAddress;
    }

    // Function to transfer NFT to Bitcoin blockchain
    function transferToBitcoin(address _receiver, uint256 _tokenId) external {
        // Check if the sender owns the NFT
        require(IERC721(nftContractAddress).ownerOf(_tokenId) == msg.sender, "You don't own this NFT");

        // Transfer NFT to the bridge for cross-chain transfer
        IERC721(nftContractAddress).transferFrom(msg.sender, address(this), _tokenId);
        SymuBridgeToBTC(symuBridgeToBTCAddress).lockAndTransferToBTC(_receiver, _tokenId);
    }

    // Function to transfer NFT to Tezos blockchain
    function transferToTezos(address _receiver, uint256 _tokenId) external {
        // Check if the sender owns the NFT
        require(IERC721(nftContractAddress).ownerOf(_tokenId) == msg.sender, "You don't own this NFT");

        // Transfer NFT to the bridge for cross-chain transfer
        IERC721(nftContractAddress).transferFrom(msg.sender, address(this), _tokenId);
        SymuBridgeToTezos(symuBridgeToTezosAddress).lockAndTransferToTezos(_receiver, _tokenId);
    }

    // Other NFT-related functions...
}
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// Interface for the ERC721 standard
interface IERC721 {
    function transferFrom(address _from, address _to, uint256 _tokenId) external;
    function ownerOf(uint256 _tokenId) external view returns (address);
    function balanceOf(address _owner) external view returns (uint256);
    event Transfer(address indexed _from, address indexed _to, uint256 indexed _tokenId);
}

// Interface for the SymuBridgeToBTC contract
interface SymuBridgeToBTC {
    function lockAndTransferToBTC(address _receiver, uint256 _tokenId) external;
}

// Interface for the SymuBridgeToTezos contract
interface SymuBridgeToTezos {
    function lockAndTransferToTezos(address _receiver, uint256 _tokenId) external;
}

contract SymuNFT_Ethereum {
    // ERC721 contract address
    address public nftContractAddress;

    // Addresses of bridge contracts
    address public symuBridgeToBTCAddress;
    address public symuBridgeToTezosAddress;

    constructor(address _nftContractAddress, address _symuBridgeToBTCAddress, address _symuBridgeToTezosAddress) {
        nftContractAddress = _nftContractAddress;
        symuBridgeToBTCAddress = _symuBridgeToBTCAddress;
        symuBridgeToTezosAddress = _symuBridgeToTezosAddress;
    }

    // Function to transfer NFT to Bitcoin blockchain
    function transferToBitcoin(address _receiver, uint256 _tokenId) external {
        // Check if the sender owns the NFT
        require(IERC721(nftContractAddress).ownerOf(_tokenId) == msg.sender, "You don't own this NFT");

        // Transfer NFT to the bridge for cross-chain transfer
        IERC721(nftContractAddress).transferFrom(msg.sender, address(this), _tokenId);
        SymuBridgeToBTC(symuBridgeToBTCAddress).lockAndTransferToBTC(_receiver, _tokenId);
    }

    // Function to transfer NFT to Tezos blockchain
    function transferToTezos(address _receiver, uint256 _tokenId) external {
        // Check if the sender owns the NFT
        require(IERC721(nftContractAddress).ownerOf(_tokenId) == msg.sender, "You don't own this NFT");

        // Transfer NFT to the bridge for cross-chain transfer
        IERC721(nftContractAddress).transferFrom(msg.sender, address(this), _tokenId);
        SymuBridgeToTezos(symuBridgeToTezosAddress).lockAndTransferToTezos(_receiver, _tokenId);
    }

    // Function to check the owner of the NFT
    function checkNFTOwner(uint256 _tokenId) external view returns (address) {
        return IERC721(nftContractAddress).ownerOf(_tokenId);
    }

    // Function to check the balance of NFTs owned by an address
    function checkBalanceOf(address _owner) external view returns (uint256) {
        return IERC721(nftContractAddress).balanceOf(_owner);
    }

    // Function to get the contract address of SymuBridgeToBTC
    function getSymuBridgeToBTCAddress() external view returns (address) {
        return symuBridgeToBTCAddress;
    }

    // Function to get the contract address of SymuBridgeToTezos
    function getSymuBridgeToTezosAddress() external view returns (address) {
        return symuBridgeToTezosAddress;
    }

    // Function to set the address of the NFT contract (only callable by owner)
    function setNFTContractAddress(address _newNFTContractAddress) external {
        require(msg.sender == owner(), "Only owner can update the NFT contract address");
        nftContractAddress = _newNFTContractAddress;
    }

    // Function to set the address of SymuBridgeToBTC (only callable by owner)
    function setSymuBridgeToBTCAddress(address _newBridgeAddress) external {
        require(msg.sender == owner(), "Only owner can update the bridge contract address");
        symuBridgeToBTCAddress = _newBridgeAddress;
    }

    // Function to set the address of SymuBridgeToTezos (only callable by owner)
    function setSymuBridgeToTezosAddress(address _newBridgeAddress) external {
        require(msg.sender == owner(), "Only owner can update the bridge contract address");
        symuBridgeToTezosAddress = _newBridgeAddress;
    }

    // Function to check the owner of the contract
    function owner() internal view returns (address) {
        return address(this);
    }

    // Fallback function to reject Ether sent to the contract
    receive() external payable {
        revert("Contract does not accept Ether");
    }
}
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// Interface for the ERC721 standard
interface IERC721 {
    function transferFrom(address _from, address _to, uint256 _tokenId) external;
    function ownerOf(uint256 _tokenId) external view returns (address);
    function mint(address _to) external returns (uint256);
    function tokenURI(uint256 _tokenId) external view returns (string memory);
}

// Interface for the SymuBridgeToBTC contract
interface SymuBridgeToBTC {
    function lockAndTransferToBTC(address _receiver, uint256 _tokenId) external;
}

// Interface for the SymuBridgeToTezos contract
interface SymuBridgeToTezos {
    function lockAndTransferToTezos(address _receiver, uint256 _tokenId) external;
}

contract SymuNFT_Ethereum {
    address public nftContractAddress;
    address public symuBridgeToBTCAddress;
    address public symuBridgeToTezosAddress;

    constructor(address _nftContractAddress, address _symuBridgeToBTCAddress, address _symuBridgeToTezosAddress) {
        nftContractAddress = _nftContractAddress;
        symuBridgeToBTCAddress = _symuBridgeToBTCAddress;
        symuBridgeToTezosAddress = _symuBridgeToTezosAddress;
    }

    // Mint a new NFT
    function mintNFT(address _to) external returns (uint256) {
        require(msg.sender == _to, "You can only mint NFTs for yourself");
        uint256 newTokenId = IERC721(nftContractAddress).mint(_to);
        return newTokenId;
    }

    // Get token URI for metadata
    function getTokenURI(uint256 _tokenId) external view returns (string memory) {
        return IERC721(nftContractAddress).tokenURI(_tokenId);
    }

    // Check token ownership
    function checkOwnership(uint256 _tokenId) external view returns (bool) {
        return IERC721(nftContractAddress).ownerOf(_tokenId) == msg.sender;
    }

    // Transfer NFT to Bitcoin blockchain
    function transferToBitcoin(address _receiver, uint256 _tokenId) external {
        require(checkOwnership(_tokenId), "You don't own this NFT");

        IERC721(nftContractAddress).transferFrom(msg.sender, address(this), _tokenId);
        SymuBridgeToBTC(symuBridgeToBTCAddress).lockAndTransferToBTC(_receiver, _tokenId);
    }

    // Transfer NFT to Tezos blockchain
    function transferToTezos(address _receiver, uint256 _tokenId) external {
        require(checkOwnership(_tokenId), "You don't own this NFT");

        IERC721(nftContractAddress).transferFrom(msg.sender, address(this), _tokenId);
        SymuBridgeToTezos(symuBridgeToTezosAddress).lockAndTransferToTezos(_receiver, _tokenId);
    }

    // Other NFT-related functions...
}
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// Interface for the ERC721 standard
interface IERC721 {
    function transferFrom(address _from, address _to, uint256 _tokenId) external;
    function ownerOf(uint256 _tokenId) external view returns (address);
    // Add other ERC721 standard functions if needed
}

// Interface for the SymuBridgeToBTC contract
interface SymuBridgeToBTC {
    function lockAndTransferToBTC(address _receiver, uint256 _tokenId) external;
    // Add other functions for BTC bridge if needed
}

// Interface for the SymuBridgeToTezos contract
interface SymuBridgeToTezos {
    function lockAndTransferToTezos(address _receiver, uint256 _tokenId) external;
    // Add other functions for Tezos bridge if needed
}

contract SymuNFT_Ethereum {
    address public owner;

    // ERC721 contract address
    address public nftContractAddress;

    // Addresses of bridge contracts
    address public symuBridgeToBTCAddress;
    address public symuBridgeToTezosAddress;

    constructor(address _nftContractAddress, address _symuBridgeToBTCAddress, address _symuBridgeToTezosAddress) {
        owner = msg.sender;
        nftContractAddress = _nftContractAddress;
        symuBridgeToBTCAddress = _symuBridgeToBTCAddress;
        symuBridgeToTezosAddress = _symuBridgeToTezosAddress;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only contract owner can call this function");
        _;
    }

    // Function to transfer ownership of the contract
    function transferOwnership(address _newOwner) external onlyOwner {
        require(_newOwner != address(0), "Invalid new owner address");
        owner = _newOwner;
    }

    // Function to get the current owner of an NFT
    function getOwnerOfNFT(uint256 _tokenId) external view returns (address) {
        return IERC721(nftContractAddress).ownerOf(_tokenId);
    }

    // Function to transfer NFT to Bitcoin blockchain
    function transferToBitcoin(address _receiver, uint256 _tokenId) external {
        require(IERC721(nftContractAddress).ownerOf(_tokenId) == msg.sender, "You don't own this NFT");

        IERC721(nftContractAddress).transferFrom(msg.sender, address(this), _tokenId);
        SymuBridgeToBTC(symuBridgeToBTCAddress).lockAndTransferToBTC(_receiver, _tokenId);
    }

    // Function to transfer NFT to Tezos blockchain
    function transferToTezos(address _receiver, uint256 _tokenId) external {
        require(IERC721(nftContractAddress).ownerOf(_tokenId) == msg.sender, "You don't own this NFT");

        IERC721(nftContractAddress).transferFrom(msg.sender, address(this), _tokenId);
        SymuBridgeToTezos(symuBridgeToTezosAddress).lockAndTransferToTezos(_receiver, _tokenId);
    }

    // Additional functions can be added for managing the NFT, such as querying metadata, etc.
    // ...
}
