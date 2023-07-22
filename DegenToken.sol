
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "hardhat/console.sol";

contract DegenToken is ERC20, Ownable, ERC20Burnable {

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
        function GameStore() public pure returns(string memory) {
            return "1. Marvel NFT value = 250 \n 2. HulkGamer value = 200 /n 3. GameLegend value = 100";
        }
        function TokenRedemption(uint Item_Id) external payable{
            require(Item_Id<=3,"Invalid selection");
            if(Item_Id ==1){
                require(balanceOf(msg.sender)>=250, "Insufficient Balance");
                approve(msg.sender, 250);
                _burn(msg.sender, 250);
            }
            else if(Item_Id ==2){
                require(balanceOf(msg.sender)>=200, "Insufficient Balance");
                approve(msg.sender, 200);
                _burn(msg.sender, 200);
            }
            else{
                require(balanceOf(msg.sender)>=100, "Insufficient Balance");
                approve(msg.sender, 100);
                _burn(msg.sender, 100);
            }
        }
}
