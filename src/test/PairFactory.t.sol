// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.10;

import "ds-test/test.sol";
import "../BondingCurve.sol";
import "../PairFactory.sol";
import "../Exchange.sol";
import "../Hyperobject.sol";

contract PairFactoryTest is DSTest {
    BondingCurve bondingCurve;
    PairFactory pairFactory;
    address exchange;
    address hyperobject;

    function setUp() public {
        bondingCurve = new BondingCurve();
        pairFactory = new PairFactory(address(bondingCurve));
    }

    function testCreate(
        string memory _name,
        string memory _symbol,
        uint256 _reserveRatio,
        uint256 _transactionShare,
        string memory _baseURI
    ) public {
        if (_reserveRatio <= 1000000 && _transactionShare <= 10000 ) {
            (exchange, hyperobject) = pairFactory.create(_name, _symbol, _reserveRatio, 724223089680545, _transactionShare, _baseURI);
            require(exchange != address(0));
            require(hyperobject != address(0));
        }
    }

}