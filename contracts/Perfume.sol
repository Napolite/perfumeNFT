// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/utils/Strings.sol";

contract  PerfumeNFT {

    event Minted(string name, string uri, address owner, string tokenID);
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

    Perfume private perfumes[];

    mapping ( string => Perfume) private perfume;
    mapping (address => Vendor) private vendor;
    uint public totalSupply = 0;

    uint256 PerfumesMinted = 0;

    modifier  onlyVendor{
        require(vendor[msg.sender].exists == true, "Caller not a vendor");
        _;
    }

    function  mint(_name, _uri, _price) external onlyVendor{
        string tStamp = Strings.toString(block.timeStamp);
        string id = string.concat(_name[0:5],tStamp[3:5]);
        Perfume newProduct = Perfume(_name, _uri, _price, msg.sender, true);
        perfumes[totalSupply] = newProduct;

        perfume[id] = newProduct;

        totalSupply++;

        emit Minted(_name, _owner)
    }
}