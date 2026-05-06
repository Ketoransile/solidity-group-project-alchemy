// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Contract {

    enum Choices { Yes, No }

    struct Vote {
        Choices choice;
        address voter;
    }

    function createVote(Choices value)
        external
        view
        returns (Vote memory)
    {
        return Vote(value, msg.sender);
    }
}