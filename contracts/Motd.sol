// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

import "./Ownable.sol";

/// @title Message of the Day Contract
/// @dev Inherits from Ownable to use ownership functionality
/// @notice This contract allows the owner to set and update a message
contract Motd is Ownable {
  /// @notice The current message stored in the contract
  string public message;

  /// @notice Constructor that sets the initial message and transfers ownership to the message sender
  /// @dev Sets the initial message and calls `_transferOwnership` from Ownable to set the owner
  /// @param initial The initial message to be set
  constructor(string memory initial) {
    _transferOwnership(msg.sender);
    message = initial;
  }

  /// @notice Allows the owner to set a new message
  /// @dev Can only be called by the contract owner due to the `onlyOwner` modifier
  /// @param newMessage The new message to be set
  function setMessage(string memory newMessage) external onlyOwner {
    message = newMessage;
  }
}
