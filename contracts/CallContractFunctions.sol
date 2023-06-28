// SPDX-License-Identifier: MIT

pragma solidity 0.8.18;

contract TestCall {
    string public message;
    uint public x;

    event Log(string message);

    fallback() external payable {
        emit Log("Fallback function called");
    }

    function foo(
        string memory _message,
        uint _x
    ) public payable returns (bool, uint) {
        message = _message;
        x = _x;
        return (true, 123);
    }
}

contract Call {
    bytes public data;

    function callFoo(address _test) external payable {
        (bool success, bytes memory _data) = _test.call{value: 111, gas: 5000}(
            abi.encodeWithSignature("foo(string,uint256)", "call foo", 123)
        );
        require(success, "call foo failed");
        data = _data;
    }

    function callDoesNotExist(address _test) external {
        (bool success, bytes memory _data) = _test.call(
            abi.encodeWithSignature("doesNotExist()")
        );
        require(success, "call doesNotExist failed");
        data = _data;
    }
}
