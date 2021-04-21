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

contract CharactorByERC721 is ERC721Impl{
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