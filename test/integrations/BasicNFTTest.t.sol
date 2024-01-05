// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

import {Test} from "forge-std/Test.sol";
import {BasicNFT} from "../../src/BasicNFT.sol";
import {DeployBasicNFT} from "../../script/DeployBasicNFT.s.sol";

contract BaicNFTTest is Test {
    BasicNFT public basicNFT;
    address public USER = makeAddr("user");

    string public constant PUG_URI =
        "ipfs://bafybeig37ioir76s7mg5oobetncojcm3c3hxasyd4rvid4jqhy4gkaheg4/?filename=0-PUG.json";

    function setUp() public {
        DeployBasicNFT deployBasicNFT = new DeployBasicNFT();
        basicNFT = deployBasicNFT.run();
    }

    function testNameIsCorrect() public view {
        string memory expectedName = "Canine";
        string memory actualName = basicNFT.name();
        // assertEq(expectedName, actualName);
        assert(
            keccak256(abi.encodePacked(expectedName)) ==
                keccak256(abi.encodePacked(actualName))
        );
    }

    function testCanMintAndHaveABalance() public {
        vm.prank(USER);
        basicNFT.mintNFT(PUG_URI);
        assertEq(basicNFT.balanceOf(USER), 1);
        assertEq(
            keccak256(abi.encodePacked(PUG_URI)),
            keccak256(abi.encodePacked(basicNFT.tokenURI(0)))
        );
    }
}
