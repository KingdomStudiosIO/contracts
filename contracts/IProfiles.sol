// SPDX-License-Identifier: MIT

pragma solidity ^0.6.12;

interface IProfiles {
  function DEFAULT_ADMIN_ROLE (  ) external view returns ( bytes32 );
  function MODERATOR_ROLE (  ) external view returns ( bytes32 );
  function POINTS_ROLE (  ) external view returns ( bytes32 );
  function addPoints ( address _address, uint256 _points ) external returns ( bool success );
  function addressToIndex ( address ) external view returns ( uint256 );
  function addresses ( uint256 ) external view returns ( address );
  function changeHeroPic ( uint256 profileId, uint256 _heroId ) external returns ( bool success );
  function changeName ( uint256 profileId, string memory _name ) external returns ( bool success );
  function changePic ( uint256 profileId, uint8 _picId ) external returns ( bool success );
  function createProfile ( string memory _name, uint8 _picId ) external returns ( bool success );
  function getAddressByName ( string memory name ) external view returns ( address profileAddress );
  function getProfileByAddress ( address profileAddress ) external view returns ( uint256 _id, address _owner, string memory _name, uint64 _created, uint8 _picId, uint256 _heroId, uint256 _points );
  function getProfileByName ( string memory name ) external view returns ( uint256 _id, address _owner, string memory _name, uint64 _created, uint8 _picId, uint256 _heroId, uint256 _points );
  function getProfileCount (  ) external view returns ( uint256 count );
  function getRoleAdmin ( bytes32 role ) external view returns ( bytes32 );
  function grantRole ( bytes32 role, address account ) external;
  function hasRole ( bytes32 role, address account ) external view returns ( bool );
  function heroesNftContract (  ) external view returns ( address );
  function initialize (  ) external;
  function nameTaken ( string memory name ) external view returns ( bool taken );
  function nameToIndex ( string memory ) external view returns ( uint256 );
  function points ( uint256 ) external view returns ( uint256 );
  function profileExists ( address profileAddress ) external view returns ( bool exists );
  function profiles ( uint256 ) external view returns ( uint256 id, address owner, string memory name, uint64 created, uint8 picId, uint256 heroId, bool set );
  function renounceRole ( bytes32 role, address account ) external;
  function revokeRole ( bytes32 role, address account ) external;
  function setHeroes ( address _address ) external returns ( bool success );
  function setNameLengths ( uint8 _min, uint8 _max ) external returns ( bool success );
  function setPicMax ( uint8 _max ) external returns ( bool success );
  function supportsInterface ( bytes4 interfaceId ) external view returns ( bool );
}
