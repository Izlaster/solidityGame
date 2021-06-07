require('mocha');
const { assert } = require('chai');

const MyContract = artifacts.require('MyContract');
const TokenOBT = artifacts.require('TokenPRNHB');


contract('MyContract', (accounts) => {
  let contract;
  let token;
  let iAddress;
  let tAddress;
  const fPlayer = accounts[0];
  const sPlayer = accounts[1];

  before(async () => {
    contract = await MyContract.deployed();
    iAddress = contract.address;
    token = await TokenOBT.deployed();
    tAddress = token.address;
  });

  describe('First publication', () => {
    it('should put all 100000 tokens into 1st account balance', async () => {
      const balance = await token.balanceOf(fPlayer);
      assert.equal(balance.valueOf(), 100000);
    });
  });

  describe('Transfer before game', () => {
    it('should transfer 50000 tokens on the 2nd players account', async () => {
      await token.transfer(sPlayer, 50000);
      const balanceF = await token.balanceOf(fPlayer);
      const balanceS = await token.balanceOf(sPlayer);
      assert.equal(balanceF.valueOf(), 50000);
      assert.equal(balanceS.valueOf(), 50000);
    });
  });

  describe('Approve', () => {
    it('should approve 5000 to games contract', async () => {
      await token.approve(iAddress, 5000);
      await token.approve(iAddress, 5000, { from: sPlayer });
      const allowanceF = await token.allowance(fPlayer, iAddress);
      const allowanceS = await token.allowance(sPlayer, iAddress);
      assert.equal(allowanceF.valueOf(), 5000);
      assert.equal(allowanceS.valueOf(), 5000);
    });
  });

  describe('Gameplay', () => {
    it('should register the players', async () => {
      await contract.RegMe();
      await contract.RegMe({ from: sPlayer });
      const fPlayerNumber = await contract.WhoAmI();
      const sPlayerNumber = await contract.WhoAmI({ from: sPlayer });
      assert.equal(fPlayerNumber, 1);
      assert.equal(sPlayerNumber, 2);
    });
    it('should make a choice', async () => {
      numberF = Math.floor(Math.random() * 10);
      for (let number in numberF) {
        await contract.TryNumber(number);
      }
      numberS = Math.floor(Math.random() * 10);
      for (let number in numberS) {
        await contract.TryNumber(number, { from: sPlayer });
      }
    });
    it('should print right winner', async () => {
      const correctResults = 1;
      contract.GetRez()
      .then((gameResults) => {
        const values = gameResults.value
        assert.equal(values, correctResults[i]);
        });
      });
  });

  describe('Balance check', () => {
    it('checks if the winner got the money and the loser sent them', async () => {
      token.balanceOf(fPlayer).then((balance1) => {
        assert.equal(balance1, 55000);
      });
      token.balanceOf(sPlayer).then((balance2) => {
        assert.equal(balance2, 45000);
      });
    });
  });
});