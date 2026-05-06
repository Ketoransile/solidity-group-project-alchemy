// SPDX-License-Identifier: MIT
pragma solidity >=0.8.20 <0.9.0;

import "./BaseContracts.sol";

contract Collectible is Ownable, Transferable {
	uint public price;

	function markPrice(uint _price) external onlyOwner {
		price = _price;
	}
}