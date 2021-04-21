* interface

[설명 바로가기](https://blog.naver.com/pjt3591oo/222317130702)

```js
event Transfer(address indexed _from, address indexed _to, uint256 indexed _tokenId);
event Approval(address indexed _owner, address indexed _approved, uint256 indexed _tokenId);
event ApprovalForAll(address indexed _owner, address indexed _operator, bool _approved);

function balanceOf(address _owner) external view returns (uint256);
function ownerOf(uint256 _tokenId) external view returns (address);
function safeTransferFrom(address _from, address _to, uint256 _tokenId, bytes data) external payable;
function safeTransferFrom(address _from, address _to, uint256 _tokenId) external payable;
function transferFrom(address _from, address _to, uint256 _tokenId) external payable;
function approve(address _approved, uint256 _tokenId) external payable;
function setApprovalForAll(address _operator, bool _approved) external;
function getApproved(uint256 _tokenId) external view returns (address);
function isApprovedForAll(address _owner, address _operator) external view returns (bool);
function supportsInterface(bytes4 interfaceID) external view returns (bool);
```

* usage

```js
pragma solidity ^0.5.0;

import 'https://github.com/Exchange-M/NFT-ERC721/blob/master/ERC721.sol';

contract ERC721Impl is ERC721 {
        function _mint(address to, uint256 tokenId) internal {
        require(to != address(0), "ERC721: mint to the zero address");
        require(!_exists(xwtokenId), "ERC721: token already minted");

        _tokenOwner[tokenId] = to;
        _ownedTokensCount[to].increment();

        emit Transfer(address(0), to, tokenId);
    }
}

contract BusinessLogin is ERC721Impl{
    struct Charactor {
        string  name;  // 캐릭터 이름
        uint256 level; // 캐릭터 레벨
    }

    Charactor[] public charactors; // default: [] 
    address public owner;          // 컨트랙트 소유자

    constructor () public {
        owner = msg.sender; 
    }

    modifier isOwner() {
      require(owner == msg.sender);
      _;
    }

    // 캐릭터 생성
    function mint(string memory name, address account) public isOwner {
        uint256 cardId = charactors.length; // 유일한 캐릭터 ID
        charactors.push(Charactor(name, 1));
        _mint(account, cardId); // ERC721 소유권 등록
    }
}
```