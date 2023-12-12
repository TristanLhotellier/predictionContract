// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

/// @title A contract for managing messages and roles
/// @dev This contract allows setting a message and managing roles of users
contract Motd_v3 {
  /// @notice Role value for admins
  uint256 public constant ADMIN = 1;
  /// @notice Role value for moderators
  uint256 public constant MODO = 2;

  /// @notice Mapping of addresses to their roles
  /// @dev Stores user roles with bitwise flags
  // 0b000000: no role
  // 0b000001: admin
  // 0b000010: modo
  // 0b000011: admin AND modo
  mapping(address => uint256) public roles;

  /// @notice Current message stored in the contract
  string public message;

  /// @notice Constructor to set the initial message and assign admin role to the message sender
  /// @param initial The initial message to be set
  constructor(string memory initial) {
    message = initial;
    roles[msg.sender] = ADMIN;
  }

  /// @notice Modifier to allow only users with the admin role
  /// @dev Checks if the sender has the admin role
  modifier onlyAdmin() {
    require(roles[msg.sender] & ADMIN != 0, "Only admin");
    _;
  }

  /// @notice Modifier to allow only users with the moderator role
  /// @dev Checks if the sender has the moderator role
  modifier onlyModo() {
    require(roles[msg.sender] & MODO != 0, "Only modo or admin");
    _;
  }

  /// @notice Function to set a new message
  /// @dev Can only be called by a user with the moderator role
  /// @param newMessage The new message to be set
  function setMessage(string memory newMessage) external onlyModo {
    message = newMessage;
  }

  /// @notice Function to set roles for a user
  /// @dev Can only be called by a user with the admin role
  /// @param who The address of the user whose role is being set
  /// @param _roles The roles being assigned to the user
  function setRole(address who, uint256 _roles) external onlyAdmin {
    roles[who] = _roles;
  }
}
