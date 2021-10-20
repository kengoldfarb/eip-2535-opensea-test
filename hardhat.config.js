
/* global ethers task */
require('@nomiclabs/hardhat-waffle')

const { deployDiamond } = require('./scripts/deploy.js')

// This is a sample Hardhat task. To learn how to create your own go to
// https://hardhat.org/guides/create-task.html
task('accounts', 'Prints the list of accounts', async () => {
  const accounts = await ethers.getSigners()

  for (const account of accounts) {
    console.log(account.address)
  }
})

task('deploy', 'Prints the list of accounts', async () => {
  const accounts = await ethers.getSigners()

  diamondAddress = await deployDiamond()
})

// You need to export an object to set up your config
// Go to https://hardhat.org/config/ to learn more

/**
 * @type import('hardhat/config').HardhatUserConfig
 */
module.exports = {
  solidity: '0.8.6',
  settings: {
    optimizer: {
      enabled: true,
      runs: 200
    }
  },
  networks: {
    rinkeby: {
			url: `https://rinkeby.infura.io/v3/${process.env.INFURA_PROJECT_ID}`,
			accounts: process.env.TESTNET_MNEMONIC
				? { mnemonic: process.env.TESTNET_MNEMONIC }
				: [process.env.TESTNET_WALLET_PRIVATE_KEY].filter(Boolean)
		}
  }
}
