// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

import "./Ownable.sol";

/// @title Message of the Day Version 2
/// @dev This contract allows certain roles to set and update a message
/// @notice This contract implements role-based access controls for admins and moderators
contract Motd_v2 {
  /// @notice Mapping to track admin status of addresses
  mapping(address => bool) public admins;
  /// @notice Mapping to track moderator status of addresses
  mapping(address => bool) public modos;

  /// @notice The current message stored in the contract
  string public message;

  /// @notice Constructor to set the initial message and assign admin role to the message sender
  /// @param initial The initial message to be set
  constructor(string memory initial) {
    message = initial;
    admins[msg.sender] = true;
  }

  /// @notice Modifier to allow only users with the admin role
  /// @dev Reverts if the caller is not an admin
  modifier onlyAdmin() {
    require(admins[msg.sender], "Only admin");
    _;
  }

  /// @notice Modifier to allow only users with the moderator role or admin role
  /// @dev Reverts if the caller is neither a moderator nor an admin
  modifier onlyModo() {
    require(modos[msg.sender] || admins[msg.sender], "Only modo or admin");
    _;
  }

  /// @notice Function to set a new message
  /// @dev Can only be called by a user with the moderator or admin role
  /// @param newMessage The new message to be set
  function setMessage(string memory newMessage) external onlyModo {
    message = newMessage;
  }

  /// @notice Function to set or revoke admin status for a user
  /// @dev Can only be called by a user with the admin role
  /// @param who The address of the user whose admin status is being set
  /// @param isAdmin Boolean indicating whether the user should be an admin
  function setAdmin(address who, bool isAdmin) external onlyAdmin {
    admins[who] = isAdmin;
  }

  /// @notice Function to set or revoke moderator status for a user
  /// @dev Can only be called by a user with the admin role
  /// @param who The address of the user whose moderator status is being set
  /// @param isModo Boolean indicating whether the user should be a moderator
  function setModo(address who, bool isModo) external onlyAdmin {
    modos[who] = isModo;
  }
}
