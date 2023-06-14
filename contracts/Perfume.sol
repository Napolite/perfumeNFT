// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

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

    mapping ( string => PerfumeNFT) name;
    mapping (address => Vendor) vendor;

    uint256 PerfumesMinted = 0;

    modifier  onlyVendor{
        require(vendor[msg.sender].exists == true, "Caller not a vendor");
        _;
    }

    function  mint() external onlyVendor{
        
    }
}