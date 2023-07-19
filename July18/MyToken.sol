/**
 * NFT Staking additional resources
 * > https://learn.bybit.com/staking/
 * > https://www.binance.com/en/blog/nft/nft-staking-a-quick-guide-on-what-to-know-before-staking-2357189661246193153
 * > https://beincrypto.com/learn/nft-staking/
 * > https://cryptoadventure.com/a-beginners-guide-to-nft-staking/
 * > https://medium.com/marblex/guides-comprehensive-nft-staking-guide-mining-edition-bfca67fe6c0b
 */

/* MyToken smart contract should look like:  */
        // SPDX-License-Identifier: MIT
        pragma solidity ^0.8.0;

        import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
        import "@openzeppelin/contracts/access/Ownable.sol";
        import "@openzeppelin/contracts/token/ERC721/utils/ERC721Holder.sol";
        import "@openzeppelin/contracts/token/ERC721/IERC721.sol";

        contract MyToken is ERC20, Ownable, ERC721Holder {
            IERC721 public nft;
            mapping(uint256 => address) public tokenOwnerOf;
            mapping(uint256 => uint256) public tokenStakedAt;
            uint256 public Emission_rate = (50 * 10 ** decimals()) / 1 days;

            constructor(address _nft) ERC20("MyToken", "MTK") {
                nft = IERC721(_nft);
            }

            function stake(uint256 tokenId) external {
                nft.safeTransferFrom(msg.sender, address(this), tokenId);
                tokenOwnerOf[tokenId] = msg.sender;
                tokenStakedAt[tokenId] = block.timestamp;
            }

            //function to claculate the tokens that the user can claim
            function calculateTokens(uint256 tokenId) public view returns (uint256) {
                uint256 timeElapsed = block.timestamp - tokenStakedAt[tokenId]; //total time duration that has elapsed since the token was staked
                return timeElapsed * Emission_rate; //number of tokens earned based on the time elapsed since the token was staked
            }

            //delete the mapping that was stored
            function unstake(uint256 tokenId) external {
                require(
                    tokenOwnerOf[tokenId] == msg.sender,
                    "Can't unstake this NFT. You are not the owner of this NFT."
                ); //verify if the user is really the owner of the NFT
                _mint(msg.sender, calculateTokens(tokenId)); //mint and assign tokens based on staking duration
                nft.transferFrom(address(this), msg.sender, tokenId); //transfer ownership back to the user
                //delete the mapping that was stored to clear that the token is no longer staked.
                delete tokenOwnerOf[tokenId];
                delete tokenStakedAt[tokenId];
            }
        }

/**
 * ===== ACTIVITY: ======
 * Modify our simple NFT Staking smart contract.
 * Integrate your NFTCollection with MyToken.sol
 *
 */
