# Verse, the hyperexchange protocol

# Overview

The Verse protocol enables every digital object to have an embedded, autonomous exchange. Structurally, this means that every ERC-721 NFT created through Verse is natively backed by an underlying ERC-20 market. Let’s break down how it works.

Through the protocol, a creator deploys a contract `Pair` consisting of an ERC-20 `Exchange` contract and an ERC-721 `Hyperobject` contract. The dynamic price and supply of the ERC-20 token is managed by a bonding curve acting as an AMM. Simply, this means that anyone can `buy` and `sell` the token at any time with instant liquidity, and the contract will programmatically adjust the price based on the circulating supply. Holders of at least 1 atomic unit of the ERC-20 token can then `redeem` their token. Redeeming a token transfers the holder’s ERC-20 to the paired `Hyperobject` contract, which mints a new NFT and transfers it to the redeemer in exchange.


# Hyperobject Pair

The cornerstone of the protocol is the `PairFactory` contract. The `PairFactory` is a factory contract which handles deployment of hyperobject pairs as minimal clone proxies delegating functionality to corresponding logic contracts. Each pair consists of a `Hyperobject` contract (an ERC-721 NFT contract) and an `Exchange` contract (an ERC-20 contract). The `create` function deploys a new pair.

# Hyperobject Contract

Each `Hyperobject` contract deployed is an ERC-721 contract. The `tokenURI`s for each NFT minted through this contract are identical and are set to the `baseURI` passed at construction. Minting functionality of NFTs is managed exclusively by the paired `Exchange` contract.

# Exchange Contract
Each `Exchange` contract deployed is an ERC-20 contract. This contract has a built-in autonomous exchange governing the price and supply of the underlying token through the use of a bonding curve. Anyone can buy and sell tokens from this contract with instant liquidity, meaning that the contract will mint and burn tokens on-demand, respectively. The bonding curve is based on a power function, and so the price of the token increases as supply increases, and the price decreases as supply decreases.

Anyone who owns >= 1 atomic token for this contract can call the `redeem` function. This function makes a call to the paired ERC-721 contract. Upon the token owner calling this function, the contract transfers 1 token from the caller to the paired ERC-721 contract. In exchange, the ERC-721 contract mints and transfers an NFT to the caller. In effect, the redeemed ERC-20 token is now locked in the ERC-721 contract. This has the effect of maintaining some base price level for the NFT, as the redeemed token can never be burned and subsequently decrease the token's price. 

Additionally, upon deployment, the pair creator can specify a `CreatorShare`. The `CreatorShare` represents a royalty fee on each transaction that occurs through the contract. By specifying a share percentage, the creator can be perpetually compensated for trades that happen with the token. 

# Summary + Vision
This new exchange structure produces numerous benefits for both creators and consumers.

**Consumers** now have instant liquidity to buy and sell continuous quantities of the NFT. Those individuals who may have been priced out of participating in a fixed-price NFT can now buy fractions of the underlying ERC-20, while whales can still scoop up larger quantities. Thus, the mechanism enables exchanging all along the price curve and maximizes efficiency in the market.

Additionally, **creators** have complete control in determining how their NFT is priced throughout its lifecycle. The creator can specify the underlying reserve ratio and initial slope of the ERC-20 price curve, fine-tuning how they want their object to be priced as demand rises and falls. In this way, creators can set a practical limit on the NFT’s supply and enforce a level of scarcity.

Perhaps most importantly, Verse enables digital objects to live autonomously, anywhere on the internet, without ever needing to link out to a marketplace. Imagine scrolling on a website, seeing a Verse-created NFT, and being able to exchange it right then and there. It’s like if you were walking down the street, saw a pair of Nike Dunks, and could snap your fingers to put a pair on your feet - rather than having to track down the lowest price, go to the store, and then buy them. Thus, the protocol catalyzes new forms of discovery with the ability for objects to be exchanged where they are consumed.

The scope of digital objects is impossible to comprehend, but one thing is certain. They will fundamentally transform the construction of the internet, affecting our relationships with media, culture, digital infrastructure, identity, and more. **Verse is a hyperexchange: a hyperstructure enabling the autonomous exchange of digital objects and creating a composable, infinite internet.**

