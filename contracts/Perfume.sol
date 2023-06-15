// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/utils/Strings.sol";
import "./helpers/strings.sol";

contract PerfumeNFT {
    event Minted(string name, address owner, string ID);
    event createdVendor(string id, address _address);
    struct Perfume {
        string name;
        string uri;
        uint price;
        address owner;
        string vendorID;
        bool exists;
    }

    struct Vendor {
        bool exists;
        string vendorID;
    }

    Perfume[] private perfumes;

    mapping(string => Perfume) private perfume;
    mapping(address => Vendor) private vendors;
    uint public totalSupply = 0;
    address public owner;

    uint256 PerfumesMinted = 0;

    modifier onlyVendor() {
        require(vendors[msg.sender].exists == true, "Caller not a vendor");
        _;
    }

    modifier onlyOwner() {
        require(
            msg.sender == owner,
            "Only contract owner can call this function"
        );
        _;
    }

    constructor() {
        owner = msg.sender;
    }

    function mint(
        string calldata _name,
        string calldata _uri,
        uint _price
    ) external onlyVendor {
        string memory tStamp = Strings.toString(block.timestamp);
        string memory id = string.concat(
            _name[0:5],
            StringHelpers.substring(tStamp, 0, 3)
        );
        Perfume memory newProduct = Perfume(
            _name,
            _uri,
            _price,
            msg.sender,
            vendors[msg.sender].vendorID,
            true
        );

        perfume[id] = newProduct;

        totalSupply++;

        emit Minted(id, msg.sender, vendors[msg.sender].vendorID);
    }

    function registerVendor(address _vendor) external onlyOwner onlyOwner{
        string memory id = string.concat(StringHelpers.substring( Strings.toHexString(_vendor), 0, 3), 
        StringHelpers.substring(Strings.toString(block.timestamp),0,3));
        Vendor memory nVendor = Vendor(true, id);
        vendors[_vendor] = nVendor; 
        emit createdVendor(id, _vendor);
    }

    function viewPerfume(
        string calldata id
    ) external view returns (Perfume memory) {
        return perfume[id];
    }

    function getSeller(string calldata id) external view returns (string memory) {
        return perfume[id].vendorID;
    }
}
