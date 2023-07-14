/** 
 * Create a Hardhat Project and install the required dependencies
       openzeppelin
       dotenv
**/

/**
 * Create a SimpleNFT smart contract inside your contracts folder
 * Import ERC721URIStorage, Ownable, and Counters contracts from Openzeppelin
 **/

/** SimpleNFT Contract should look like: **/
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract SimpleNFT is ERC721URIStorage, Ownable {
    //utilize Counters library
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIdCounter;

    //implement constructor and initialize the ERC721 contract with the name "MySimpleNFT" and symbol "MSN".
    constructor() ERC721("MySimpleNFT", "MSN") {}

    //responsible for minting new NFTs (Non-Fungible Token)
    function safeMint(address to, string memory uri) public onlyOwner {
        uint256 tokenId = _tokenIdCounter.current(); //Retrieve the current tokenId from _tokenIdCounter.
        _tokenIdCounter.increment(); //Increment the _tokenIdCounter to ensure that each new token receives a unique token ID.
        _safeMint(to, tokenId); //Safely mint a new token to the specified to address
        _setTokenURI(tokenId, uri); //set the token's URI
    }
}

/** Set up a Quicknode account and  copy the HTTP Provider link. **/

/** Access your Private Key from your metamask wallet. **/

/** Create a .env file and store the HTTP Provider link from Quicknode and your Private Key**/

/** Modify your deploy.js file. It should look like: **/
        const hre = require("hardhat");
        require("dotenv").config({ path: ".env" });

        async function main() {
        const SimpleNFTContract = await hre.ethers.deployContract("SimpleNFT");

        await SimpleNFTContract.waitForDeployment();
        console.log("SimpleNFT Contract Address:", SimpleNFTContract.target);
        }
        main()
        .then(() => process.exit(0))
        .catch((error) => {
            console.error(error);
            process.exit(1);
        });

/** Modify your hardhat.config.js file. It should look like: **/
        require("@nomicfoundation/hardhat-toolbox");
        require("dotenv").config({ path: ".env" });

        const QUICKNODE_HTTP_URL = process.env.QUICKNODE_HTTP_URL;
        const PRIVATE_KEY = process.env.PRIVATE_KEY;

        module.exports = {
        solidity: "0.8.4",
        networks: {
            mumbai: {
            url: QUICKNODE_HTTP_URL,
            accounts: [PRIVATE_KEY],
            },
        },
        etherscan: {
            apiKey: process.env.API_KEY,
        },
        };

/** Compile, Deploy and Verify. Mint an NFT using polygonscan**/