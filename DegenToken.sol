
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "hardhat/console.sol";

contract DegenToken is ERC20, Ownable, ERC20Burnable {
    struct Item {
        uint256 value;
        bool exists;
    }
    mapping(string => Item) public redeemItems;
    mapping(address => uint256) public userBalances;

    event ItemAdded(string itemName, uint256 itemValue, address addedBy);
    event ItemRedeemed(string itemName, uint256 itemValue, address redeemedBy);

    constructor() ERC20("Degen", "DGN") {}

        function mint(address to, uint256 amount) public onlyOwner{
            _mint(to, amount);
        }
        function transferTokens(address _reciever, uint amount) external{
            require(balanceOf(msg.sender) >= amount, "you are not owner");
            approve(msg.sender, amount);
            transferFrom(msg.sender, _reciever, amount);
        }
        function checkBalance() external view returns(uint){
           return balanceOf(msg.sender);
        }
        
        function burnTokens(uint amount) external{
            require(balanceOf(msg.sender)>= amount, "You do not have enough Tokens");
            _burn(msg.sender, amount);
        }
        function addItem(string memory itemName, uint256 itemValue) external onlyOwner {
            require(!redeemItems[itemName].exists, "Item already exists");
            redeemItems[itemName] = Item(itemValue, true);
            emit ItemAdded(itemName, itemValue, msg.sender);
        }
        function redeemItem(string memory itemName) external {
            require(redeemItems[itemName].exists, "Item does not exist");
            require(userBalances[msg.sender] >= redeemItems[itemName].value, "Insufficient balance");
            
            uint256 itemValue = redeemItems[itemName].value;
            userBalances[msg.sender] -= itemValue;
            
            emit ItemRedeemed(itemName, itemValue, msg.sender);
        }
        
        function getBalance() external view returns (uint256) {
            return userBalances[msg.sender];
        }
        function addToBalance(uint256 amount) external {
            userBalances[msg.sender] += amount;
        }
        
}
