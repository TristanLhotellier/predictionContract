// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "../contracts/Ownable.sol";
import "../contracts/Motd_v2.sol";

/// @title Tests for the Motd_v2 contract
/// @dev Utilizes Forge standard testing framework
/// @notice This contract implements tests for the Motd_v2 contract functionalities
contract Motd_v2Test is Test {
  Motd_v2 motd;

  address admin = address(0x123);
  address modo = address(0x123674748);
  address user = address(0x456);

  string oldMessage = "Hello world";
  string newMessage = "new message";

  /// @notice Setup function to deploy the Motd_v2 contract before each test
  function setUp() external {
    vm.startPrank(admin);
    motd = new Motd_v2(oldMessage); // Deploy Motd_v2 as the admin user
    motd.setModo(modo, true);
    vm.stopPrank();
  }

  /// @notice Test to ensure the admin can successfully set a new message
  function test_setMessage_admin() external {
    vm.prank(admin);
    motd.setMessage(newMessage);
    assertEq(motd.message(), newMessage);
  }

  /// @notice Test to ensure a moderator can successfully set a new message
  function test_setMessage_modo() external {
    vm.prank(modo);
    motd.setMessage(newMessage);
    assertEq(motd.message(), newMessage);
  }

  /// @notice Test to verify that a non-admin or non-moderator user cannot set a new message
  function test_setMessage_user() external {
    vm.prank(user);
    vm.expectRevert();
    motd.setMessage(newMessage);
    assertEq(motd.message(), oldMessage);
  }

  /// @notice Test to ensure an admin can promote a user to admin and then the user can demote himself
  function test_setAdmin_adminPromotesUserToAdminThenUserDemotesHimself() external {
    vm.prank(admin);
    motd.setAdmin(user, true);
    assertTrue(motd.admins(user));

    vm.prank(user);
    motd.setAdmin(user, false);
    assertFalse(motd.admins(user));
  }

  /// @notice Test to verify that a moderator cannot set admin status
  function test_setAdmin_modoRevert() external {
    vm.prank(modo);
    vm.expectRevert();
    motd.setAdmin(modo, true);
    assertFalse(motd.admins(modo));
  }

  /// @notice Test to verify that a regular user cannot set admin status
  function test_setAdmin_userRevert() external {
    vm.prank(user);
    vm.expectRevert();
    motd.setAdmin(user, true);
    assertFalse(motd.admins(user));
  }

  /// @notice Test to ensure an admin can promote a user to moderator
  function test_setModo_adminPromotesUserToModerator() external {
    vm.prank(admin);
    motd.setModo(user, true);
    assertTrue(motd.modos(user));
  }

  /// @notice Test to verify that a moderator cannot set moderator status
  function test_setModo_modoRevert() external {
    vm.prank(modo);
    vm.expectRevert();
    motd.setModo(user, true);
    assertFalse(motd.modos(user));
  }

  /// @notice Test to verify that a regular user cannot set moderator status
  function test_setModo_userRevert() external {
    vm.prank(user);
    vm.expectRevert();
    motd.setModo(user, true);
    assertFalse(motd.modos(user));
  }
}
