// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Strings.sol";

contract Lootbox is ERC721URIStorage {
    uint public boxPrice = 0.001 ether; //price of a single lootbox
    uint public maxItems = 15; //maximum number of items that can be minted from the lootbox

    mapping(address => uint) public boxes;

    constructor() ERC721("Lootbox", "LBG") {}

    //baseURI() internal view function that returns the base URI for the token metadata
    function _baseURI() internal view virtual override returns (string memory) {
        return "ipfs://____/";
    }

    //tokenURI() public view function that generates the token URI for a specific tokenID
    //append the baseURI with the token ID and ".json"
    function tokenURI(
        uint256 tokenId
    ) public view virtual override returns (string memory) {
        string memory baseURI = _baseURI();
        return
            bytes(baseURI).length > 0
                ? string(
                    abi.encodePacked(
                        baseURI,
                        Strings.toString(tokenId),
                        ".json"
                    )
                )
                : "";
    }

    //buyBox() function allows the users to buy a lootbox by sending the correct amount to the contract
    function buyBox() public payable {
        require(
            msg.value == boxPrice,
            "Send the correct amount to buy a loot box"
        );
        boxes[msg.sender]++;
    }

    //openBox() function allows users to own a box, open it and receive a random item.
    function openBox() public {
        require(boxes[msg.sender] > 0, "You must own a loot box to open one");
        boxes[msg.sender]--;

        uint256 randomTokenId = uint256(
            keccak256(abi.encodePacked(block.timestamp, msg.sender))
        ) % maxItems;
        mintEquipment(tokenURI(randomTokenId), randomTokenId);
    }

    //mintEquipment() function responsible for minting new NFTs wth the given tokenID and assign it to the sender's address.
    //It mints the NFT to the sender's address and set its token URI.
    function mintEquipment(
        string memory _tokenURI,
        uint tokenId
    ) internal returns (uint256) {
        _mint(msg.sender, tokenId);
        _setTokenURI(tokenId, _tokenURI);
        return tokenId;
    }
}

/**
 *  ===== ACTIVITY: ======
 * Generate 20 unique mystery items by connecting personal elements to visual representations. Ensure each item reflects your individual interests, hobbies, or characteristics. (Ex. generate an image of a pixelated dog if you love dogs) Enhance the items' value and storytelling by including descriptive metadata, offering users extra information and context for each item.
 *
 */
