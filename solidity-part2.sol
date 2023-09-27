// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// Ethan account 0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2
// Mysterious leader 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4

contract IMFaccount {
    // 0xd9145CCE52D386f254917e481eB44e9943F39138 contract address

    address payable Ethan = payable(0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2);
    uint public accountBal;

    function extractFunds(uint amount, address payable operator) public {
        require(operator == Ethan, "Please contact International Monetary Fund");
        accountBal = address(this).balance;
        return Ethan.transfer(amount);

    }
    
    function depositMissionFunds() public payable {

    }

    fallback() external {}
    receive() external payable{}

}



contract IMFwallet {

    address acctOwner; //0x17F6AD8Ef982297579C203069C1DbfFE4348c372
    address payable primaryAgent; // 0x4B20993Bc481177ec7E8f571ceCaE8A9e22C02db
    bool isTemporaryAccount; // true if account will be discarded after the mission
    uint public fundsAvailable;
    string agentFirstName;
    string agentLastName;
    address payable backup; //backup person // 0x1aE0EA34a72D944a8C7603FfB3eC30a6669E454C Ivan

    constructor() {
        acctOwner = msg.sender; 
    }
    
    function updateIntel(address payable newPrimaryAgent, address payable newBackup, bool newAccountStatus, uint newBalance, string memory newFirstName, string memory newLastName) public {
        require(msg.sender == acctOwner, "Please contact International Monetary Fund"); //setter
        primaryAgent = newPrimaryAgent; //Felipe 
        backup = newBackup; 
        isTemporaryAccount = newAccountStatus;
        fundsAvailable = newBalance;
        agentFirstName = newFirstName;
        agentLastName = newLastName;
    }

    function retrieveIntel() view public returns(address, address payable, bool, uint, string memory, string memory) {
        require(msg.sender == acctOwner, "Please contact International Monetary Fund"); //getter
        return (primaryAgent, backup, isTemporaryAccount, fundsAvailable, agentFirstName, agentLastName);
    }

    function fundExtraction(uint amount) public {
        require(msg.sender == primaryAgent || msg.sender == backup, "extraction attempt unauthorized.");
        address payable address_sender = payable(msg.sender);
        address_sender.transfer(amount);

        fundsAvailable = address(this).balance;
    }   

    function receiveOperationalFunds() public payable {
        fundsAvailable = address(this).balance;
    }

    fallback() external {}
    receive() external payable {}
}
