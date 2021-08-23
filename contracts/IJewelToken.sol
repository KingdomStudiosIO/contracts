// SPDX-License-Identifier: MIT

pragma solidity 0.6.12;

interface IJewelToken {
  function DELEGATION_TYPEHASH (  ) external view returns ( bytes32 );
  function DOMAIN_TYPEHASH (  ) external view returns ( bytes32 );
  function addAuthorized ( address _toAdd ) external;
  function allowance ( address owner, address spender ) external view returns ( uint256 );
  function approve ( address spender, uint256 amount ) external returns ( bool );
  function authorized ( address ) external view returns ( bool );
  function balanceOf ( address account ) external view returns ( uint256 );
  function canUnlockAmount ( address _holder ) external view returns ( uint256 );
  function cap (  ) external view returns ( uint256 );
  function capUpdate ( uint256 _newCap ) external;
  function checkpoints ( address, uint32 ) external view returns ( uint32 fromBlock, uint256 votes );
  function circulatingSupply (  ) external view returns ( uint256 );
  function decimals (  ) external view returns ( uint8 );
  function decreaseAllowance ( address spender, uint256 subtractedValue ) external returns ( bool );
  function delegate ( address delegatee ) external;
  function delegateBySig ( address delegatee, uint256 nonce, uint256 expiry, uint8 v, bytes32 r, bytes32 s ) external;
  function delegates ( address delegator ) external view returns ( address );
  function getCurrentVotes ( address account ) external view returns ( uint256 );
  function getPriorVotes ( address account, uint256 blockNumber ) external view returns ( uint256 );
  function increaseAllowance ( address spender, uint256 addedValue ) external returns ( bool );
  function lastUnlockBlock ( address _holder ) external view returns ( uint256 );
  function lock ( address _holder, uint256 _amount ) external;
  function lockFromBlock (  ) external view returns ( uint256 );
  function lockFromUpdate ( uint256 _newLockFrom ) external;
  function lockOf ( address _holder ) external view returns ( uint256 );
  function lockToBlock (  ) external view returns ( uint256 );
  function lockToUpdate ( uint256 _newLockTo ) external;
  function lockedSupply (  ) external view returns ( uint256 );
  function manualMint ( address _to, uint256 _amount ) external;
  function manualMintLimit (  ) external view returns ( uint256 );
  function manualMinted (  ) external view returns ( uint256 );
  function miner (  ) external view returns ( address );
  function mint ( address _to, uint256 _amount ) external;
  function name (  ) external view returns ( string memory );
  function nonces ( address ) external view returns ( uint256 );
  function numCheckpoints ( address ) external view returns ( uint32 );
  function owner (  ) external view returns ( address );
  function removeAuthorized ( address _toRemove ) external;
  function renounceOwnership (  ) external;
  function symbol (  ) external view returns ( string memory );
  function totalBalanceOf ( address _holder ) external view returns ( uint256 );
  function totalLock (  ) external view returns ( uint256 );
  function totalSupply (  ) external view returns ( uint256 );
  function transfer ( address recipient, uint256 amount ) external returns ( bool );
  function transferAll ( address _to ) external;
  function transferFrom ( address sender, address recipient, uint256 amount ) external returns ( bool );
  function transferOwnership ( address newOwner ) external;
  function unlock (  ) external;
  function unlockForUser ( address account, uint256 amount ) external;
  function unlockedSupply (  ) external view returns ( uint256 );
}
