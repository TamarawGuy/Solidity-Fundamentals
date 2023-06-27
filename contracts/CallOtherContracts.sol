// SPDX-License-Identifier: MIT

pragma solidity 0.8.18;

contract CallTest {
    function setX(Test _test, uint _x) public {
        // passing the contract as a type
        _test.setX(_x);
    }

    function getX(address _test) public view returns (uint256 x) {
        // passing the contract address
        x = Test(_test).getX();
    }

    function setXAndSendEther(Test _test, uint _x) public payable {
        _test.setXAndReceiveEther{value: msg.value}(_x);
    }

    function getXAndValue(
        address _test
    ) public view returns (uint256 x, uint256 value) {
        (x, value) = Test(_test).getXAndValue();
    }
}

contract Test {
    uint256 public x;
    uint256 public value = 123;

    function setX(uint _x) public {
        x = _x;
    }

    function getX() public view returns (uint) {
        return x;
    }

    function setXAndReceiveEther(uint _x) public payable {
        x = _x;
        value = msg.value;
    }

    function getXAndValue() public view returns (uint, uint) {
        return (x, value);
    }
}
