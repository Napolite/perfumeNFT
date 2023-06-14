// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/utils/Strings.sol";

contract  PerfumeNFT {

    event Minted(string name, address owner);
    struct Perfume {
        string name;
        string uri;
        uint price;
        address owner;
        string vendorID;
        bool exists;
    }

    struct Vendor{
        address vendor;
        bool exists;
        string vendorID;
    }

    Perfume[] perfumes;

    mapping ( string => Perfume) private perfume;
    mapping (address => Vendor) private vendors;
    uint public totalSupply = 0;
    address owner;

    uint256 PerfumesMinted = 0;

    modifier  onlyVendor{
        require(vendors[msg.sender].exists == true, "Caller not a vendor");
        _;
    }

    modifier onlyOwner{
        require(msg.sender == owner, "Only contract owner can call this function");
        _;
    }

    function  mint(string calldata _name,string calldata _uri,uint _price) external onlyVendor{
        string memory id = string.concat(_name[0:5],Strings.toString(block.timestamp)[3:5]);
        Perfume memory newProduct = Perfume(_name, _uri, _price, msg.sender, vendors[msg.sender].vendorID, true);
        perfumes[totalSupply] = newProduct;

        perfume[id] = newProduct;

        totalSupply++;

        emit Minted(_name,msg.sender);
    }

    function registerVendor(address _vendor) external onlyOwner{
        string memory id = string.concat(Strings.toString(address)[0:4],Strings.toString(block.timestamp)[3:5]);
        Vendor memory newVendor = Vendor(_vendor,id, true);
    }

    function viewPerfume(string calldata id) external returns(Perfume memory){
        return perfume[id];
    }
}