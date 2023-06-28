// SPDX-License-Identifier: MIT

/*
    CALL
    - calls another contract in the context of the caller
    - allows the called contract to use the caller's storage, msg.sender, msg.value
    - msg.sender and msg.value are not changed

    A calls B, sends 100 wei
            B calls C, sends 50 wei
    A ----> B ----> C
                    msg.sender = B
                    msg.value = 50
                    execute code on C's state variables
                    use ETH in C

    DELEGATECALL
    A calls B, sends 100 wei
            B delegatecalls C
    A ----> B ----> C
                    msg.sender = A
                    msg.value = 100
                    execute code on B's state variables
                    use ETH in B
*/

pragma solidity 0.8.18;

contract TestDelegatecall {
    uint public num;
    address public sender;
    uint public value;

    function setVars(uint _num) public payable {
        num = _num;
        sender = msg.sender;
        value = msg.value;
    }
}

contract Delegatecall {
    uint public num;
    address public sender;
    uint public value;

    function setVars(address _test, uint _num) external payable {
        // First way
        // _test.delegatecall(abi.encodeWithSignature("setVars(uint256)", _num));

        // Second way
        (bool success, bytes memory data) = _test.delegatecall(
            abi.encodeWithSelector(TestDelegatecall.setVars.selector, _num);
        )
        require(success, "delegatecall failed");
    }
}
