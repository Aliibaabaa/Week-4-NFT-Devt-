// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Strings.sol";

contract NFTColl is ERC721Enumerable, Ownable {
    using Strings for uint256;
    string _baseTokenURI; //stores the base URI for the token metadata.
    uint256 public _price = 0.01 ether; // stores the price in ether for minting an NFT.
    bool public _paused; //indicates whether the contract is paused or not.  If the contract is paused, no new NFTs can be minted.
    uint256 public maxTokenIds = 10; //stores the maximum number of NFTs that can be minted.
    uint256 public tokenIds; // a counter that keeps track of the number of NFTs that have been minted.

    //modifier onlyWhenNotPaused() is used to restrict certain functions from executing when the contract is in a paused state.
    modifier onlyWhenNotPaused() {
        require(!_paused, "Contract currently paused"); //If the contract is paused, it will throw an error with the message "Contract currently paused".
        _;
    }

    //Implement the constructor that initializes the ERC721 contract with the name "NFTColl" and symbol "NFTCOL" and takes a string parameter called baseURI, and within the constructor, the _baseTokenURI is set to the provided baseURI.
    constructor(string memory baseURI) ERC721("NFTColl", "NFTCOL") {
        _baseTokenURI = baseURI;
    }

    //The mint() function, which is  from the ERC721URIStorage contract, allows users to mint an NFT by paying the specified price.
    function mint() public payable onlyWhenNotPaused {
        require(tokenIds < maxTokenIds, "Exceed maximum NFTColl supply");
        require(msg.value >= _price, "Ether sent is not correct");
        tokenIds += 1;
        _safeMint(msg.sender, tokenIds);
    }

    //The baseURI() function returns the base URI for the token metadata
    function _baseURI() internal view virtual override returns (string memory) {
        return _baseTokenURI;
    }

    //The tokenURI() function returns the specific URI for a given token ID, concatenating the base URI, token ID, and file extension.
    function tokenURI(
        uint256 tokenId
    ) public view virtual override returns (string memory) {
        require(
            _exists(tokenId),
            "ERC721Metadata: URI query for nonexistent token"
        );

        string memory baseURI = _baseURI();
        return
            bytes(baseURI).length > 0
                ? string(abi.encodePacked(baseURI, tokenId.toString(), ".json"))
                : "";
    }

    //The setPaused() function allows the contract owner to pause or unpause the contract.
    function setPaused(bool val) public onlyOwner {
        _paused = val;
    }

    //The withdraw() function allows the contract owner to withdraw the contract's balance.
    function withdraw() public onlyOwner {
        address _owner = owner();
        uint256 amount = address(this).balance;
        (bool sent, ) = _owner.call{value: amount}("");
        require(sent, "Failed to send Ether");
    }

    //The receive() function is called when ether is sent to the contract.
    receive() external payable {}

    //The fallback() function is called when the contract is called without a function name
    fallback() external payable {}
}
