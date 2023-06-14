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
        bool exists;
    }

    struct Vendor{
        address vendor;
        bool exists;
    }

    Perfume[] perfumes;

    mapping ( string => Perfume) private perfume;
    mapping (address => Vendor) private vendor;
    uint public totalSupply = 0;
    address owner;

    uint256 PerfumesMinted = 0;

    modifier  onlyVendor{
        require(vendor[msg.sender].exists == true, "Caller not a vendor");
        _;
    }

    modifier onlyOwner{
        require(msg.sender == owner, "Only contract owner can call this function");
        _;
    }

    function  mint(string calldata _name,string calldata _uri,uint _price) external onlyVendor{
        string memory tStamp = Strings.toString(block.timestamp);
        string memory id = string.concat(_name[0:5],tStamp[3:5]);
        Perfume memory newProduct = Perfume(_name, _uri, _price, msg.sender, true);
        perfumes[totalSupply] = newProduct;

        perfume[id] = newProduct;

        totalSupply++;

        emit Minted(_name,msg.sender);
    }

    function registerVendor() external onlyOwner{
        Vendor memory newVendor = Vendor(address, true);
    }
}