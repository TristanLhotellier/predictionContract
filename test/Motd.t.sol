// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

pragma solidity ^0.8.0;

// Forge standard testing framework
contract Test {
  function assert(bool condition) internal pure {
    if (!condition) {
      revert("Assertion failed");
    }
  }

  function assertEq(uint256 a, uint256 b) internal pure {
    assert(a == b);
  }

  function assertEq(address a, address b) internal pure {
    assert(a == b);
  }

  function expectRevert(bytes4 selector) internal pure {
    revert("Expected revert");
  }
}
import "../contracts/Ownable.sol";
import "../contracts/Motd.sol";

/// @title Tests for the Motd contract
/// @dev Utilizes Forge standard testing framework
/// @notice This contract implements tests for the Motd contract functionalities
contract MotdTest is Test {
  Motd motd;

  address admin = address(0x123);
  address user = address(0x456);

  /// @notice Setup function to deploy the Motd contract before each test
  function setUp() external {
    vm.prank(admin);
    motd = new Motd("Hello world"); // Deploy Motd as the admin user
  }

  /// @notice Test to ensure only the admin can transfer ownership
  function test_transferOwnership_admin() external {
    assertEq(motd.owner(), admin);

    vm.prank(admin);
    motd.transferOwnership(user);

    assertEq(motd.owner(), user);
  }

  /// @notice Test to verify that a non-admin user cannot transfer ownership
  function test_transferOwnership_user() external {
    vm.prank(user);
    vm.expectRevert(Ownable.OnlyOwner.selector); // Expecting revert with OnlyOwner error
    motd.transferOwnership(user);
  }

  /// @notice Test to ensure the admin can successfully set a new message
  function test_setMessage_admin() external {
    string memory newMessage = "hello 2";
    vm.prank(admin);
    motd.setMessage(newMessage);
    assertEq(motd.message(), newMessage);
  }

  /// @notice Test to verify that a non-admin user cannot set a new message
  function test_setMessage_user() external {
    string memory previousMessage = motd.message();
    string memory newMessage = "hello 2";
    vm.prank(user);
    vm.expectRevert(Ownable.OnlyOwner.selector); // Expecting revert with OnlyOwner error
    motd.setMessage(newMessage);
    assertEq(motd.message(), previousMessage); // Assert that message has not been changed
  }
}
