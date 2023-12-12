// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

/// @title Ownable Contract
/// @dev Provides basic authorization control functions
/// @notice This is an abstract contract that implements ownership control functionalities
abstract contract Ownable {
  /// @dev Stores the address of the owner
  address private _owner;

  /// @notice Custom error for function calls made by any account other than the owner
  error OnlyOwner();

  /// @notice Modifier to restrict function calls to the owner of the contract
  /// @dev Reverts if the caller is not the owner
  modifier onlyOwner() {
    if (msg.sender != _owner) {
      revert OnlyOwner();
    }
    _;
  }

  /// @notice Returns the address of the current owner
  /// @return The address of the owner
  function owner() public view returns (address) {
    return _owner;
  }

  /// @notice Internal function to transfer ownership of the contract to a new address
  /// @dev Can only be called by the current owner
  /// @param newOwner The address to transfer ownership to
  function _transferOwnership(address newOwner) internal {
    _owner = newOwner;
  }

  /// @notice Transfers ownership of the contract to a new account (`newOwner`)
  /// @dev Public function to transfer ownership, can only be called by the current owner
  /// @param newOwner The address to transfer ownership to
  function transferOwnership(address newOwner) public onlyOwner {
    _transferOwnership(newOwner);
  }
}
