// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Sidekick {
    function sendAlert(address hero, uint256 enemies, bool armed) public {
        // 1. Encode the signature with the full type names (uint256, not uint)
        // 2. Pass the variables as additional arguments
        bytes memory payload = abi.encodeWithSignature(
            "alert(uint256,bool)", 
            enemies, 
            armed
        );

        // 3. Execute the low-level call
        (bool success, ) = hero.call(payload);

        // 4. Always check the success return value of a low-level call!
        require(success, "Hero alert failed");
    }
}