// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;
import {LibDiamond} from '../libraries/LibDiamond.sol';
import {LibMeta} from '../libraries/LibMeta.sol';

struct AppStorage {
	// Token name
    string name;

    // Token symbol
    string symbol;

    // Mapping from token ID to owner address
    mapping(uint256 => address) owners;

    // Mapping owner address to token count
    mapping(address => uint256) balances;

    // Mapping from token ID to approved address
    mapping(uint256 => address) tokenApprovals;

    // Mapping from owner to operator approvals
    mapping(address => mapping(address => bool)) operatorApprovals;

	// Enumerable

	// Mapping from owner to list of owned token IDs
    mapping(address => mapping(uint256 => uint256)) ownedTokens;

    // Mapping from token ID to index of the owner tokens list
    mapping(uint256 => uint256) ownedTokensIndex;

    // Array with all token ids, used for enumeration
    uint256[] allTokens;

    // Mapping from token id to position in the allTokens array
    mapping(uint256 => uint256) allTokensIndex;
}

library LibAppStorage {
	function diamondStorage() internal pure returns (AppStorage storage ds) {
		assembly {
			ds.slot := 0
		}
	}

	function abs(int256 x) internal pure returns (uint256) {
		return uint256(x >= 0 ? x : -x);
	}
}

contract Modifiers {
	AppStorage internal s;
	modifier onlyTokenOwner(uint256 _tokenId) {
		require(
			LibMeta.msgSender() == s.owners[_tokenId],
			'LibAppStorage: Only aavegotchi owner can call this function'
		);
		_;
	}

	modifier onlyContractOwner() {
		LibDiamond.enforceIsContractOwner();
		_;
	}
}
