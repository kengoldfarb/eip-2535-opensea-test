// SPDX-License-Identifier: MIT
pragma solidity ^0.8.1;

import {AppStorage, LibAppStorage} from '../libraries/LibAppStorage.sol';
import {LibDiamond} from '../libraries/LibDiamond.sol';
import {ERC721} from '@solidstate/contracts/token/ERC721/ERC721.sol';
import {ERC721MetadataStorage} from '@solidstate/contracts/token/ERC721/metadata/ERC721MetadataStorage.sol';

contract ERC721Facet is ERC721 {
    function mint(
		address to,
        uint256 tokenId
	) public {
        super._safeMint(to, tokenId);
    }

    // This implements ERC-165.
    function supportsInterface(bytes4 _interfaceId) external override view returns (bool) {
        LibDiamond.DiamondStorage storage ds = LibDiamond.diamondStorage();
        return ds.supportedInterfaces[_interfaceId];
    }
}