# Course Notes

## Laboratory Assignment: Group Project

Weight: 10%

Deadline: May 06, 2026

## Instructions

1. Register for Alchemy University.
2. Establish a collaborative GitHub repository ensuring that each member makes public contributions.
3. Complete the Learn Solidity course available at https://www.alchemy.com/university/courses/solidity.
4. Within the repository, include:
   - All materials distributed during the course.
   - All codebases developed throughout the course.
   - Screenshots demonstrating course progress completion.
   - Organized resources in designated folders.

Alternative course option: Smart Contract Development with Solidity on Cyfrin Updraft, following the same requirements.

## Chosen Course

Learn Solidity by Alchemy University.

## Smart Contracts Overview

Smart contracts are programs deployed on a blockchain. Users and applications communicate with them by sending transactions or making read-only calls.

At a high level, smart contract execution is handled by the Ethereum Virtual Machine. Solidity code is compiled down into EVM opcodes, and those opcodes determine how the contract behaves.

Gas is calculated deterministically based on the opcodes used. Simple opcodes such as `ADD` or `MUL` have fixed gas costs. More complex opcodes such as `SSTORE` depend on additional factors, including storage changes and possible gas refunds when clearing a storage slot.

## Enum Type

Enums help make Solidity code clearer by replacing unexplained numeric values with named options.

Example: instead of checking whether `player.movement == 0`, an enum can define readable options such as `Directions.Up`, `Directions.Left`, `Directions.Down`, and `Directions.Right`.

This makes the code easier to understand and safer to share across contracts because the named enum values become the agreed structure.

Exercise goal: create an enum named `Foods` with four food values and store them in `food1`, `food2`, `food3`, and `food4`.

## Solidity Functions: Double Overload

Solidity allows function overloading, which means a contract can have multiple functions with the same name as long as their parameter lists are different.

Example: `add(uint x, uint y)` and `add(uint x, uint y, uint z)` can both exist because Solidity chooses the correct function based on the arguments passed.

Solidity functions can also return multiple values by using tuples, such as `returns (uint, uint)`.

Exercise goal: create an overloaded `double` function that accepts two `uint` parameters, doubles both values, and returns both results in the same order.

## Sending Ether: Self Destruct

The EVM has a `SELFDESTRUCT` opcode that can remove a contract's code and send the contract's remaining ether balance to a target address.

In Solidity, `selfdestruct` requires a payable address argument. This is why an address such as `msg.sender` or a stored charity address must be cast with `payable(...)`.

Example idea: after a countdown reaches zero, a contract can call `selfdestruct(payable(msg.sender))`, sending its remaining ether to the final caller.

Exercise goal: update the `donate` function so it destroys the contract and sends the full remaining balance to the charity address.
