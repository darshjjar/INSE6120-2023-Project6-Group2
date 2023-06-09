pragma solidity >=0.6.0;

import "UnstoppableLender.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract ReceiverUnstoppable {

    UnstoppableLender private pool;
    address private owner;

    constructor(address poolAddress) public {
        pool = UnstoppableLender(poolAddress);
        owner = msg.sender;
    }

    
    function receiveTokens(address tokenAddress, uint256 amount) external {
        require(msg.sender == address(pool), "Sender must be pool");
        
        require(IERC20(tokenAddress).transfer(msg.sender, amount), "Transfer of tokens failed");
    }

    function executeFlashLoan(uint256 amount) external {
        require(msg.sender == owner, "Only owner can execute flash loan");
        pool.flashLoan(amount);
    }
}