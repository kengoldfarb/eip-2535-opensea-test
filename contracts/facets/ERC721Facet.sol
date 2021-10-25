// SPDX-License-Identifier: MIT
pragma solidity ^0.8.1;

import {ERC721} from '@openzeppelin/contracts/token/ERC721/ERC721.sol';
import {ERC721Enumerable} from '@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol';

contract ERC721Facet is ERC721, ERC721Enumerable {
	// AppStorage internal s;

    constructor() ERC721('DiamondOpenSeaTest', 'DSEA') {}

	function _beforeTokenTransfer(address from, address to, uint256 tokenId) internal override(ERC721, ERC721Enumerable) {
        super._beforeTokenTransfer(from, to, tokenId);
    }

    function supportsInterface(bytes4 interfaceId) public view virtual override(ERC721, ERC721Enumerable) returns (bool) {
        return super.supportsInterface(interfaceId);
    }

    function mint(
		address to,
        uint256 tokenId
	) public {
        super._safeMint(to, tokenId);
    }

    function _baseURI() internal view virtual override returns (string memory) {
        return "https://meem.wtf/tokens/";
    }
}