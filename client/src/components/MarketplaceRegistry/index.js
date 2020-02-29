import React, { Component } from "react";
import getWeb3, { getGanacheWeb3, Web3 } from "../../utils/getWeb3";

import App from "../../App.js";

import { Typography, Grid, TextField } from '@material-ui/core';
import { ThemeProvider } from '@material-ui/styles';
import { theme } from '../../utils/theme';
import { Loader, Button, Card, Input, Heading, Table, Form, Flex, Box, Image, EthAddress } from 'rimble-ui';
import { zeppelinSolidityHotLoaderOptions } from '../../../config/webpack';

import styles from '../../App.module.scss';
//import './App.css';



export default class MarketplaceRegistry extends Component {
  constructor(props) {    
    super(props);

    this.state = {
      /////// Default state
      storageValue: 0,
      web3: null,
      accounts: null,
      route: window.location.pathname.replace("/", "")
    };

    this.getTestData = this.getTestData.bind(this);
    this.mintTo = this.mintTo.bind(this);
    this.tokenURI = this.tokenURI.bind(this);
  }

  getTestData = async () => {
      const { accounts, marketplace_registry, web3 } = this.state;

      let response = await marketplace_registry.methods.testFunc().send({ from: accounts[0] })
      console.log('=== response of testFunc() function ===', response);
  }

  mintTo = async () => {
      const { accounts, nft_ticket, web3 } = this.state;
      const _clubTeam = '0x718E3ea0B8C2911C5e54Cb4b9B2075fdd87B55a7'

      let response = await nft_ticket.methods.mintTo(_clubTeam).send({ from: accounts[0] });
      console.log('=== response of _mintTo() function ===', response);
  }

  tokenURI = async () => {
      const { accounts, nft_ticket, web3 } = this.state;
      const _tokenId = 0

      let response = await nft_ticket.methods.tokenURI(_tokenId).call();
      console.log('=== response of tokenURI() function ===', response);
  }



  //////////////////////////////////// 
  ///// Refresh Values
  ////////////////////////////////////
  refreshValues = (instanceMarketplaceRegistry, instanceNftTicket) => {
    if (instanceMarketplaceRegistry) {
      console.log('refreshValues of instanceMarketplaceRegistry');
    }
    if (instanceNftTicket) {
      console.log('refreshValues of instanceNftTicket');
    }
  }


  //////////////////////////////////// 
  ///// Ganache
  ////////////////////////////////////
  getGanacheAddresses = async () => {
    if (!this.ganacheProvider) {
      this.ganacheProvider = getGanacheWeb3();
    }
    if (this.ganacheProvider) {
      return await this.ganacheProvider.eth.getAccounts();
    }
    return [];
  }

  componentDidMount = async () => {
    const hotLoaderDisabled = zeppelinSolidityHotLoaderOptions.disabled;
 
    let MarketplaceRegistry = {};
    let NftTicket = {};
    try {
      MarketplaceRegistry = require("../../../../build/contracts/MarketplaceRegistry.json");  // Load artifact-file of MarketplaceRegistry
      NftTicket = require("../../../../build/contracts/NftTicket.json");

    } catch (e) {
      console.log(e);
    }

    try {
      const isProd = process.env.NODE_ENV === 'production';
      if (!isProd) {
        // Get network provider and web3 instance.
        const web3 = await getWeb3();
        let ganacheAccounts = [];

        try {
          ganacheAccounts = await this.getGanacheAddresses();
        } catch (e) {
          console.log('Ganache is not running');
        }

        // Use web3 to get the user's accounts.
        const accounts = await web3.eth.getAccounts();
        // Get the contract instance.
        const networkId = await web3.eth.net.getId();
        const networkType = await web3.eth.net.getNetworkType();
        const isMetaMask = web3.currentProvider.isMetaMask;
        let balance = accounts.length > 0 ? await web3.eth.getBalance(accounts[0]): web3.utils.toWei('0');
        balance = web3.utils.fromWei(balance, 'ether');

        let instanceMarketplaceRegistry = null;
        let instanceNftTicket = null;
        let deployedNetwork = null;

        // Create instance of contracts
        if (MarketplaceRegistry.networks) {
          deployedNetwork = MarketplaceRegistry.networks[networkId.toString()];
          if (deployedNetwork) {
            instanceMarketplaceRegistry = new web3.eth.Contract(
              MarketplaceRegistry.abi,
              deployedNetwork && deployedNetwork.address,
            );
            console.log('=== instanceMarketplaceRegistry ===', instanceMarketplaceRegistry);
          }
        }

        if (NftTicket.networks) {
          deployedNetwork = NftTicket.networks[networkId.toString()];
          if (deployedNetwork) {
            instanceNftTicket = new web3.eth.Contract(
              NftTicket.abi,
              deployedNetwork && deployedNetwork.address,
            );
            console.log('=== instanceNftTicket ===', instanceNftTicket);
          }
        }

        if (MarketplaceRegistry, NftTicket) {
          // Set web3, accounts, and contract to the state, and then proceed with an
          // example of interacting with the contract's methods.
          this.setState({ 
            web3, 
            ganacheAccounts, 
            accounts, 
            balance, 
            networkId, 
            networkType, 
            hotLoaderDisabled,
            isMetaMask, 
            marketplace_registry: instanceMarketplaceRegistry,
            nft_ticket: instanceNftTicket
          }, () => {
            this.refreshValues(
              instanceMarketplaceRegistry
            );
            setInterval(() => {
              this.refreshValues(instanceMarketplaceRegistry, instanceNftTicket);
            }, 5000);
          });
        }
        else {
          this.setState({ web3, ganacheAccounts, accounts, balance, networkId, networkType, hotLoaderDisabled, isMetaMask });
        }
      }
    } catch (error) {
      // Catch any errors for any of the above operations.
      alert(
        `Failed to load web3, accounts, or contract. Check console for details.`,
      );
      console.error(error);
    }
  }



  render() {
    return (

      <div className={styles.widgets}>
        <Grid container style={{ marginTop: 32 }}>

          <Grid item xs={12}>

            <Card width={"auto"} 
                  maxWidth={"420px"} 
                  mx={"auto"} 
                  my={5} 
                  p={20} 
                  borderColor={"#E8E8E8"}
            >
              <h4>Marketplace Registry</h4>

              <Image
                alt="random unsplash image"
                borderRadius={8}
                height="100%"
                maxWidth='100%'
                src="https://source.unsplash.com/random/1280x720"
              />

              <Button size={'small'} mt={3} mb={2} onClick={this.getTestData}> Get TestData </Button> <br />

              <Button size={'small'} mt={3} mb={2} onClick={this.mintTo}> Mint To </Button> <br />

              <Button size={'small'} mt={3} mb={2} onClick={this.tokenURI}> Token URI </Button> <br />

            </Card>
          </Grid>

          <Grid item xs={4}>
          </Grid>

          <Grid item xs={4}>
          </Grid>
        </Grid>
      </div>
    );
  }

}
