// SPDX-License-Identifier: MIT
pragma solidity ^0.8.1;

import {AppStorage, LibAppStorage} from '../libraries/LibAppStorage.sol';
import {LibDiamond} from '../libraries/LibDiamond.sol';
import '../interfaces/ERC721Tradable.sol';

contract ERC721Facet is ERC721Tradable {
    constructor() ERC721Tradable('DiamondOpenSeaTest', 'DSEA', 0xF57B2c51dED3A29e6891aba85459d600256Cf317) {}

    function getProxyRegistryAddress() public view returns (address) {
        AppStorage storage s = LibAppStorage.diamondStorage();
        return s.proxyRegistryAddress;
    }

    function baseTokenURI() override public pure returns (string memory) {
        return "https://creatures-api.opensea.io/api/creature/";
    }

    function contractURI() public pure returns (string memory) {
        return "https://creatures-api.opensea.io/contract/opensea-creatures";
    }

    function mint(
		address to,
        uint256 tokenId
	) public {
        super._safeMint(to, tokenId);
    }

    /**
     * @dev See {IERC721Metadata-name}.
     */
    function name() public view virtual override returns (string memory) {
        AppStorage storage s = LibAppStorage.diamondStorage();
        return s.name;
    }

    /**
     * @dev See {IERC721Metadata-symbol}.
     */
    function symbol() public view virtual override returns (string memory) {
        AppStorage storage s = LibAppStorage.diamondStorage();
        return s.symbol;
    }

    function owner() public view override returns (address) {
        return LibDiamond.contractOwner();
    }

    /**
     * Override isApprovedForAll to whitelist user's OpenSea proxy accounts to enable gas-less listings.
     */
    function isApprovedForAll(address _owner, address operator)
        override
        public
        view
        virtual
        returns (bool)
    {
        AppStorage storage s = LibAppStorage.diamondStorage();
        // Whitelist OpenSea proxy contract for easy trading.
        ProxyRegistry proxyRegistry = ProxyRegistry(s.proxyRegistryAddress);
        if (address(proxyRegistry.proxies(_owner)) == operator) {
            return true;
        }

        return super.isApprovedForAll(_owner, operator);
    }
}