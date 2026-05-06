// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Sidekick {
    /**
     * @dev Relays arbitrary calldata to the hero address.
     * @param hero The address of the target contract.
     * @param data The pre-encoded calldata (selector + arguments).
     */
    function relay(address hero, bytes calldata data) public {
        // We pass the 'data' bytes directly into the call
        (bool success, ) = hero.call(data);

        // Ensure the call was successful
        require(success, "Relay execution failed");
    }
}