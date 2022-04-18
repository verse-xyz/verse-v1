// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.10;

import "ds-test/test.sol";
import "../BondingCurve.sol";
import "../PairFactory.sol";
import "../Exchange.sol";
import "../Hyperobject.sol";
import {VM} from "./Utils/VM.sol";

contract HyperobjectTest is DSTest {
    VM vm;
    BondingCurve bondingCurve;
    PairFactory pairFactory;
    Exchange exchange;
    Hyperobject hyperobject;
    address exchangeAddress;
    address hyperobjectAddress;


    function setUp() public {
        // Cheat codes
        vm = VM(0x7109709ECfa91a80626fF3989D68f67F5b1DD12D);

        // Deploy exchange and hyperobject
        bondingCurve = new BondingCurve();
        pairFactory = new PairFactory(address(bondingCurve));
        (exchangeAddress, hyperobjectAddress) = pairFactory.create("Verse", "VERSE", 242424, 724223089680545, 0, "verse.xyz");
        exchange = Exchange(exchangeAddress);
        hyperobject = Hyperobject(hyperobjectAddress);
        
        // Set user balances
        vm.deal(address(1), 100 ether);
        vm.deal(address(2), 100 ether);
    }

    // make sure non-factory address cannot call initialize function
    function testFail_Initialize(string memory _name, string memory _symbol, string memory _baseURI, address _exchange) public {
        vm.prank(address(0));
        hyperobject.initialize(_name, _symbol, _baseURI, _exchange);
    }

    // make sure non-exchange address cannot call mint function
    function testFail_Mint(address _recipient) public {
        vm.prank(address(0));
        hyperobject.mint(_recipient);
    }

    // make sure exchange can call mint function
    function test_Mint(address _recipient) public {
        vm.prank(address(exchange));
        if (_recipient != address(0x0000000000000000000000000000000000000000)) {
            hyperobject.mint(_recipient);
        }
        
    }

    // return tokenURI for token ID that exists
    function test_TokenURI() public {
        vm.startPrank(address(1));
        exchange.buy{value: 1 ether}(1);
        exchange.redeem();
        vm.stopPrank();
        hyperobject.tokenURI(1);
    }

    function test_MultipleTokenURI() public {
        vm.startPrank(address(1));
        exchange.buy{value: 1 ether}(1);
        exchange.redeem();
        hyperobject.tokenURI(1);
        exchange.buy{value: 1 ether}(1);
        exchange.redeem();
        hyperobject.tokenURI(2);
        //vm.expectRevert("TOKEN_DOES_NOT_EXIST");
        vm.expectRevert(abi.encodeWithSignature('InvalidTokenId()'));
        hyperobject.tokenURI(3);
    }

    function testFail_TokenURI() public {
        vm.startPrank(address(1));
        exchange.buy{value: 1 ether}(1);
        exchange.redeem();
        vm.stopPrank();
        hyperobject.tokenURI(2);
    }

    receive() external payable {}

}