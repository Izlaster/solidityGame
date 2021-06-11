const HDWalletProvider = require("@truffle/hdwallet-provider");
const mnemonic = "other miracle sadness guide describe token undo impulse invite mass tackle found";

module.exports = {
  // Uncommenting the defaults below 
  // provides for an easier quick-start with Ganache.
  // You can also follow this format for other networks;
  // see <http://truffleframework.com/docs/advanced/configuration>
  // for more details on how to specify configuration options!
  //
  networks: {
    kovan: {
      provider: function() {
        return new HDWalletProvider(mnemonic, "https://kovan.infura.io/v3/a499ee50d1894a6c85a1e49497b93af8")
      },
      network_id: '42',
    },
  },
};
