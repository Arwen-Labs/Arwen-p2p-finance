import './App.css';
//Imports ethers and web3modal for wallet connect
import {CoinbaseWalletSDK} from "@coinbase/wallet-sdk";
import Web3Modal from "web3modal";
import {ethers} from "ethers";
import {useState} from "react"

// Adding wallet providers (metamask is there by default)
const providerOptions = {
  coinbasewallet:{
    package: CoinbaseWalletSDK,
    options:{
      appName: "WalletConnect Test",
      infuraId: {3: "https://goerli.infura.io/v3/7908b85d96034288a9dcb0c15257c9dc"}
    }
  }

}

function App() {

  //For wallet connect===================================================================
  const [web3Provider, setWeb3Provider] = useState(null);
  
  async function connectWallet() {
    try{
        let web3Modal = new Web3Modal({
            catchProvider: false,
            providerOptions,
        });
        const web3ModalInstance = await web3Modal.connect();
        const web3ModalProvider = new ethers.providers.Web3Provider(web3ModalInstance);
        console.log("Connect")
        if(web3ModalProvider){
          setWeb3Provider(web3ModalProvider);
        }
    }catch(error){
        console.error(error);
    }
  }
  //=====================================================================================
  
  return (
    <div className="App">
      <header className="App-header">
        <h1>Arwen test wallet Connection!</h1>
        {
          web3Provider == null ? (
            //run if null
            <button onClick={connectWallet}>
              Connect Wallet
            </button>
          ) : (
            //run if there
            <div>
              <p>Connected</p>
              <p>Address: {web3Provider.provider.selectedAddress}</p>
            </div>
          )
        }
      </header>
    </div>
  );
}

export default App;
