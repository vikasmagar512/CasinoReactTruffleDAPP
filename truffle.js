module.exports = {
  // See <http://truffleframework.com/docs/advanced/configuration>
  // to customize your Truffle configuration!

    networks: {
        development: {
            host: "127.0.0.1",
            port: 7545, //ganache-cli
            // port: 8545, //testrpc
            // port: 9545, //truffle develop
            network_id: "*" // Match any network id
        }
    }
};
