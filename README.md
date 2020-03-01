# Prediction Ticket（For Professional Sports）

***
## 【Introduction of Prediction Ticket（For Professional Sports）】
- This is a dApp of prediction tickets sales platform for club teams and players and audiences of professional sports.
  (For example, club team is like Manchester United Football Club in the Premier League of UK)
- Club teams of professional sports can drive engagement of audiences and increase ticket sales by using Prediction Ticket.
- Prediction Ticket is included the right of prediction of MVP player of today's game.
  - Explanation how prediction ticket work is below.



## 【How prediction ticket work?】 
For example,
1. if audiences buy a prediction ticket of 30DAI, 5DAI of them come as the voting right of prediction of MVP player of today's game.   
  - It mean when audiences buy a prediction ticket of 30DAI, 5DAI of them is staked and pooled automatically via SmartContract)  
  - 1 voting right per 1 ticket)  

2. Before today's game start, audiences predict MVP player of today's game and select them and submit them.

3. After today's game end, audiences who prediction was successful (who is called winner) and players who was choosen as MVP can get reward from staked pool.
  - Player who is the most collected voting become MVP of today's game)  
  - Reward amount is that divide total pooled amount by numbers of winners plus MVP player）  


&nbsp;


***

## 【Setup】
### Setup wallet by using Metamask
1. Add MetaMask to browser (Chrome or FireFox or Opera or Brave)    
https://metamask.io/  


2. Adjust appropriate newwork below 
```
Ropsten Test Network

```

&nbsp;


### Setup backend
1. Deploy contracts to Ropsten Test Network
```
(root directory)

$ npm run migrate:ropsten
```

&nbsp;


### Setup frontend
1. Execute command below in root directory.
```

$ npm run client
```

2. Access to browser by using link 
```
http://127.0.0.1:3000
```

&nbsp;

***


## 【Work flow】

&nbsp;

***

## 【References】
- Documents of AAVE protocol
  - aToken
    https://developers.aave.com/#atokens
  - LendingPool
    https://developers.aave.com/#the-lendingpooladdressesprovider

- Github repos of AAVE protocol
  - aave-protocol
    https://github.com/aave/aave-protocol
  - ethlondon-flash
    https://github.com/aave/ethlondon-flash
