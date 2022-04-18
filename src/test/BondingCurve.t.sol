// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.10;

import "ds-test/test.sol";
import "../BondingCurve.sol";
import "../PairFactory.sol";
import "../Exchange.sol";
import "../Hyperobject.sol";
import {VM} from "./Utils/VM.sol";

contract BondingCurveTest is DSTest {
    VM vm;
    BondingCurve bondingCurve;
    PairFactory pairFactory;
    Exchange exchange;
    Hyperobject hyperobject;
    address exchangeAddress;
    address cryptomediaAddress;


    function setUp() public {
        // Cheat codes
        vm = VM(0x7109709ECfa91a80626fF3989D68f67F5b1DD12D);

        // Deploy exchange and cryptomedia
        bondingCurve = new BondingCurve();
        // Set user balances
        vm.deal(address(1), 100 ether);
        vm.deal(address(2), 100 ether);
    }
    // make sure exchange can call mint function
    // function test_getInitialPrice() public {
    //     uint256 price = bondingCurve.calculateInitializationPrice(30120, 242424, 724223089680545);
    //     emit log_uint(price);
    // }

    function test_getTokensForEth() public {
        uint256 tokens = bondingCurve.calculatePurchaseReturn(19360000000000000000, 161522353159983588, 242424, 17000000000000000000);
        emit log_uint(tokens);
    }

    function test_getEthForTokens() public {
        uint256 eth = bondingCurve.calculatePurchasePrice(19360000000000000000, 161522353159983588, 242424, 40637716687212255142);
        emit log_uint(eth);
    }

    function test_sellEthForTokens() public {
        uint256 eth = bondingCurve.calculateSaleReturn(19360000000000000000, 161522353159983588, 242424, 13825644997184428275);
        emit log_uint(eth);
    }

    function test_sellTokensForEth() public {
        uint256 tokens = bondingCurve.calculateSalePrice(19360000000000000000, 161522353159983588, 242424, 160599999999999999);
        emit log_uint(tokens);
    }

    receive() external payable {}

}