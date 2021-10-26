# Diamond Opensea Test

This repo contains 2 branches that demonstrate an ERC-721 contract implemented using EIP-2535 only works on Opensea if the ERC-721 parts are not in a facet.

Comparison between branches: [https://github.com/kengoldfarb/eip-2535-opensea-test/compare/fix/opensea...fix/opensea-facet](https://github.com/kengoldfarb/eip-2535-opensea-test/compare/fix/opensea...fix/opensea-facet)

## Works on Opensea:

Branch: [fix/opensea](https://github.com/kengoldfarb/eip-2535-opensea-test/tree/fix/opensea)

Opensea Collection: [https://testnets.opensea.io/collection/diamondopenseatest-v3](https://testnets.opensea.io/collection/diamondopenseatest-v3)

Rinkeby Etherscan: [https://rinkeby.etherscan.io/address/0xc4A383d1Fd38EDe98F032759CE7Ed8f3F10c82B0](https://rinkeby.etherscan.io/address/0xc4A383d1Fd38EDe98F032759CE7Ed8f3F10c82B0)

```
╰─$ yarn hardhat deploy --network rinkeby
yarn run v1.22.15
DiamondCutFacet deployed: 0x7aA56375c7ff50B67344Ada96a977B62eE79881c
Diamond deployed: 0xc4A383d1Fd38EDe98F032759CE7Ed8f3F10c82B0
DiamondInit deployed: 0x4149Fcb0A1A6A5ECcB313bF76211f895BB4FA8Df

Deploying facets
DiamondLoupeFacet deployed: 0x745b4d28d17072C20034e8AeF06F1A3FAf9B8ba4

Diamond Cut: [
  {
    facetAddress: '0x745b4d28d17072C20034e8AeF06F1A3FAf9B8ba4',
    action: 0,
    functionSelectors: [
      '0xcdffacc6',
      '0x52ef6b2c',
      '0xadfca15e',
      '0x7a0ed627',
      contract: [Contract],
      remove: [Function: remove],
      get: [Function: get]
    ]
  }
]
Diamond cut tx:  0x77d1cfdf8cedf11098ba902e171ef5f297333ea1492a095c1bb69d93a52aeae9
Completed diamond cut
✨  Done in 65.26s.
```

## Doesn't work on Opensea:

Branch: [fix/opensea-facet](https://github.com/kengoldfarb/eip-2535-opensea-test/tree/fix/opensea-facet)

Rinkeby Etherscan: [https://rinkeby.etherscan.io/address/0xDfAEF8281b4575ef5FcbfCb196Db35f8d19cD4b1](https://rinkeby.etherscan.io/address/0xDfAEF8281b4575ef5FcbfCb196Db35f8d19cD4b1)

```
╰─$ yarn hardhat deploy --network rinkeby
yarn run v1.22.15
DiamondCutFacet deployed: 0x366494606AfD8bE9D7188128EaBeA14ff2723129
Diamond deployed: 0xDfAEF8281b4575ef5FcbfCb196Db35f8d19cD4b1
DiamondInit deployed: 0x3bdebf0F3BC6D1c2885c6E58fF2706Af03829b9b

Deploying facets
DiamondLoupeFacet deployed: 0xdc7dcA1A2F457C83EA2D1cC24Beb6964ea0128e7
ERC721Facet deployed: 0x48d38388b21e85237CCf2016c4848b9f78f51692

Diamond Cut: [
  {
    facetAddress: '0xdc7dcA1A2F457C83EA2D1cC24Beb6964ea0128e7',
    action: 0,
    functionSelectors: [
      '0xcdffacc6',
      '0x52ef6b2c',
      '0xadfca15e',
      '0x7a0ed627',
      contract: [Contract],
      remove: [Function: remove],
      get: [Function: get]
    ]
  },
  {
    facetAddress: '0x48d38388b21e85237CCf2016c4848b9f78f51692',
    action: 0,
    functionSelectors: [
      '0x0f7e5970',
      '0x095ea7b3',
      '0x70a08231',
      '0xd547cfb7',
      '0xe8a3d485',
      '0x0c53c51c',
      '0x081812fc',
      '0x3408e470',
      '0x20379ee5',
      '0x2d0335ab',
      '0x1fe5b457',
      '0xe985e9c5',
      '0x40c10f19',
      '0x755edd17',
      '0x06fdde03',
      '0x8da5cb5b',
      '0x6352211e',
      '0x715018a6',
      '0x42842e0e',
      '0xb88d4fde',
      '0xa22cb465',
      '0x01ffc9a7',
      '0x95d89b41',
      '0x4f6ccce7',
      '0x2f745c59',
      '0xc87b56dd',
      '0x18160ddd',
      '0x23b872dd',
      '0xf2fde38b',
      contract: [Contract],
      remove: [Function: remove],
      get: [Function: get]
    ]
  }
]
Diamond cut tx:  0x87f5f279b50c032c764828735d4ce264a296b6688213c7aa5b4f4643996021b3
Completed diamond cut
✨  Done in 237.83s.
```

## Testing process

Set up your env

```
export INFURA_PROJECT_ID = ...
export TESTNET_WALLET_PRIVATE_KEY = ...
```

* Compile contracts: npx hardhat compile
* Deploy contracts: npx hardhat deploy --network rinkeby
* Open Console: npx hardhat console --network rinkeby
* Console: `let d = await (await ethers.getContractFactory('Diamond')).attach('<Diamond address>')`
* Console: `await d.mint('<Wallet address>', 0)`
* Import collection into Opensea: [https://testnets.opensea.io/get-listed/step-two](https://testnets.opensea.io/get-listed/step-two)


# Original Readme
# Diamond-1-Hardhat Implementation

This is a reference implementation for [EIP-2535 Diamond Standard](https://github.com/ethereum/EIPs/issues/2535). To learn about other implementations go here: https://github.com/mudgen/diamond

**Note:** In this implementation the loupe functions are NOT gas optimized. The `facets`, `facetFunctionSelectors`, `facetAddresses` loupe functions are not meant to be called on-chain and may use too much gas or run out of gas when called in on-chain transactions. In this implementation these functions should be called by off-chain software like websites and Javascript libraries etc., where gas costs do not matter.


## Installation

1. Clone this repo:
```console
git clone git@github.com:mudgen/diamond-1-hardhat.git
```

2. Install NPM packages:
```console
cd diamond-1-hardhat
npm install
```

## Deployment

```console
npx hardhat run scripts/deploy.js
```

### How the scripts/deploy.js script works

1. DiamondCutFacet is deployed.
1. The diamond is deployed, passing as arguments to the diamond constructor the owner address of the diamond and the DiamondCutFacet address. DiamondCutFacet has the `diamondCut` external function which is used to upgrade the diamond to add more functions.
1. The `DiamondInit` contract is deployed. This contains an `init` function which is called on the first diamond upgrade to initialize state of some state variables. Information on how the `diamondCut` function works is here: https://eips.ethereum.org/EIPS/eip-2535#diamond-interface
1. Facets are deployed.
1. The diamond is upgraded. The `diamondCut` function is used to add functions from facets to the diamond. In addition the `diamondCut` function calls the `init` function from the `DiamondInit` contract using `delegatecall` to initialize state variables.

How a diamond is deployed is not part of the EIP-2535 Diamonds standard. This implementation shows a usable example.

## Run tests:
```console
npx hardhat test
```

## Upgrade a diamond

Check the `scripts/deploy.js` and or the `test/diamondTest.js` file for examples of upgrades.

Note that upgrade functionality is optional. It is possible to deploy a diamond that can't be upgraded, which is a 'Single Cut Diamond'.  It is also possible to deploy an upgradeable diamond and at a later date remove its `diamondCut` function so it can't be upgraded any more.

Note that any number of functions from any number of facets can be added/replaced/removed on a diamond in a single transaction. In addition an initialization function can be executed in the same transaction as an upgrade to initialize any state variables required for an upgrade. This 'everything done in a single transaction' capability ensures a diamond maintains a correct and consistent state during upgrades.

## Facet Information

**Note:** In this implementation the loupe functions are NOT gas optimized. The `facets`, `facetFunctionSelectors`, `facetAddresses` loupe functions are not meant to be called on-chain and may use too much gas or run out of gas when called in on-chain transactions. In this implementation these functions should be called by off-chain software like websites and Javascript libraries etc., where gas costs do not matter.

However the `facetAddress` loupe function is gas efficient and can be called in on-chain transactions.

The `contracts/Diamond.sol` file shows an example of implementing a diamond.

The `contracts/facets/DiamondCutFacet.sol` file shows how to implement the `diamondCut` external function.

The `contracts/facets/DiamondLoupeFacet.sol` file shows how to implement the four standard loupe functions.

The `contracts/libraries/LibDiamond.sol` file shows how to implement Diamond Storage and a `diamondCut` internal function.

The `scripts/deploy.js` file shows how to deploy a diamond.

The `test/diamondTest.js` file gives tests for the `diamondCut` function and the Diamond Loupe functions.

## How to Get Started Making Your Diamond

1. Reading and understand [EIP-2535 Diamonds](https://github.com/ethereum/EIPs/issues/2535). If something is unclear let me know!

2. Use a diamond reference implementation. You are at the right place because this is the README for a diamond reference implementation.

This diamond implementation is boilerplate code that makes a diamond compliant with EIP-2535 Diamonds.

Specifically you can copy and use the [DiamondCutFacet.sol](./contracts/facets/DiamondCutFacet.sol) and [DiamondLoupeFacet.sol](./contracts/facets/DiamondLoupeFacet.sol) contracts. They implement the `diamondCut` function and the loupe functions.

The [Diamond.sol](./contracts/Diamond.sol) contract could be used as is, or it could be used as a starting point and customized. This contract is the diamond. Its deployment creates a diamond. It's address is a stable diamond address that does not change.

The [LibDiamond.sol](./contracts/libraries/LibDiamond.sol) library could be used as is. It shows how to implement Diamond Storage. This contract includes contract ownership which you might want to change if you want to implement DAO-based ownership or other form of contract ownership. Go for it. Diamonds can work with any kind of contract ownership strategy. This library contains an internal function version of `diamondCut` that can be used in the constructor of a diamond or other places.

## Calling Diamond Functions

In order to call a function that exists in a diamond you need to use the ABI information of the facet that has the function.

Here is an example that uses web3.js:

```javascript
let myUsefulFacet = new web3.eth.Contract(MyUsefulFacet.abi, diamondAddress);
```

In the code above we create a contract variable so we can call contract functions with it.

In this example we know we will use a diamond because we pass a diamond's address as the second argument. But we are using an ABI from the MyUsefulFacet facet so we can call functions that are defined in that facet. MyUsefulFacet's functions must have been added to the diamond (using diamondCut) in order for the diamond to use the function information provided by the ABI of course.

Similarly you need to use the ABI of a facet in Solidity code in order to call functions from a diamond. Here's an example of Solidity code that calls a function from a diamond:

```solidity
string result = MyUsefulFacet(address(diamondContract)).getResult()
```

## Get Help and Join the Community

If you need help or would like to discuss diamonds then send me a message [on twitter](https://twitter.com/mudgen), or [email me](mailto:nick@perfectabstractions.com). Or join the [EIP-2535 Diamonds Discord server](https://discord.gg/kQewPw2).

## Useful Links
1. [Introduction to the Diamond Standard, EIP-2535 Diamonds](https://eip2535diamonds.substack.com/p/introduction-to-the-diamond-standard)
1. [EIP-2535 Diamonds](https://github.com/ethereum/EIPs/issues/2535)
1. [Understanding Diamonds on Ethereum](https://dev.to/mudgen/understanding-diamonds-on-ethereum-1fb)
1. [Solidity Storage Layout For Proxy Contracts and Diamonds](https://medium.com/1milliondevs/solidity-storage-layout-for-proxy-contracts-and-diamonds-c4f009b6903)
1. [New Storage Layout For Proxy Contracts and Diamonds](https://medium.com/1milliondevs/new-storage-layout-for-proxy-contracts-and-diamonds-98d01d0eadb)
1. [Upgradeable smart contracts using the Diamond Standard](https://hiddentao.com/archives/2020/05/28/upgradeable-smart-contracts-using-diamond-standard)
1. [buidler-deploy supports diamonds](https://github.com/wighawag/buidler-deploy/)

## Author

This example implementation was written by Nick Mudge.

Contact:

- https://twitter.com/mudgen
- nick@perfectabstractions.com

## License

MIT license. See the license file.
Anyone can use or modify this software for their purposes.

