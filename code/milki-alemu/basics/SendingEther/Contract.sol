// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Contract {
    address public charity;

    constructor(address _charity) {
        charity = _charity;
    }

    receive() external payable {}

    /**
     * @dev Sends all contract funds to the charity and triggers selfdestruct.
     */
    function donate() external {
        // We must cast the 'charity' address to 'payable' 
        // so selfdestruct knows where to send the funds.
        selfdestruct(payable(charity));
    }
}